#!/bin/bash
# audio-to-text.sh
# Converts audio/video files to text transcripts using local STT (Whisper.cpp)
#
# Usage: ./audio-to-text.sh [--start HH:MM:SS] [--end HH:MM:SS] <input_file> [output_file] [model]
#
# Supported formats: mp3, wav, m4a, mp4, mov, webm
# Output: Plain text transcript
#
# Prerequisites:
#   brew install whisper-cli ffmpeg
#   Download models to ~/.whisper/ (see research-notes.md)

set -e

# --- Time normalization ---
# Accepts flexible formats: HH:MM:SS, H:MM:SS, MM:SS, or just seconds
# Sets: TIME_HMS (for ffmpeg) and TIME_SECONDS (for validation)
normalize_time() {
    local input="$1"
    local h=0 m=0 s=0

    # Count colons to determine format
    local colons="${input//[^:]}"
    local num_colons="${#colons}"

    if [ "$num_colons" -eq 2 ]; then
        IFS=: read -r h m s <<< "$input"
    elif [ "$num_colons" -eq 1 ]; then
        IFS=: read -r m s <<< "$input"
    else
        s="$input"
    fi

    # Remove leading zeros for arithmetic
    h=$((10#${h:-0}))
    m=$((10#${m:-0}))
    s=$((10#${s:-0}))

    TIME_HMS=$(printf "%02d:%02d:%02d" "$h" "$m" "$s")
    TIME_SECONDS=$(( h * 3600 + m * 60 + s ))
}

# --- Parse named flags ---
START_TIME=""
END_TIME=""

while [[ "${1:-}" == --* ]]; do
    case "$1" in
        --start)
            START_TIME="$2"
            shift 2
            ;;
        --end)
            END_TIME="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# --- Positional args (unchanged interface) ---
INPUT_FILE="$1"
OUTPUT_FILE="${2:-${INPUT_FILE%.*}.txt}"
MODEL="${3:-base.en}"

# Model location
WHISPER_MODELS="${WHISPER_MODELS:-$HOME/.whisper}"

if [ -z "$INPUT_FILE" ]; then
    echo "Usage: $0 [--start HH:MM:SS] [--end HH:MM:SS] <input_file> [output_file] [model]"
    echo ""
    echo "Converts audio/video to text transcript using local Whisper.cpp"
    echo ""
    echo "Options:"
    echo "  --start TIME  Start time (e.g., 1:22:00, 82:00, 4920)"
    echo "  --end TIME    End time (e.g., 2:00:00, 120:00, 7200)"
    echo ""
    echo "Arguments:"
    echo "  input_file    Audio or video file to transcribe"
    echo "  output_file   Output path (default: input_file.txt)"
    echo "  model         Whisper model: tiny, base.en, small, medium, large-v3-turbo"
    echo "                (default: base.en)"
    echo ""
    echo "Time formats: HH:MM:SS, MM:SS, or seconds. Either flag can be omitted."
    echo ""
    echo "Models available in: $WHISPER_MODELS"
    exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File not found: $INPUT_FILE"
    exit 1
fi

MODEL_PATH="$WHISPER_MODELS/ggml-${MODEL}.bin"
if [ ! -f "$MODEL_PATH" ]; then
    echo "Error: Model not found: $MODEL_PATH"
    echo ""
    echo "Download models from: https://huggingface.co/ggerganov/whisper.cpp/tree/main"
    echo "Example:"
    echo "  wget -O $WHISPER_MODELS/ggml-base.en.bin \\"
    echo "    https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin"
    exit 1
fi

# Check for required tools
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg not found. Install with: brew install ffmpeg"
    exit 1
fi

if ! command -v whisper-cli &> /dev/null; then
    echo "Error: whisper-cli not found. Install with: brew install whisper-cli"
    exit 1
fi

# --- Validate time range ---
if [ -n "$START_TIME" ] && [ -n "$END_TIME" ]; then
    normalize_time "$START_TIME"
    local_start=$TIME_SECONDS
    normalize_time "$END_TIME"
    local_end=$TIME_SECONDS
    if [ "$local_end" -le "$local_start" ]; then
        echo "Error: --end time ($END_TIME) must be after --start time ($START_TIME)"
        exit 1
    fi
fi

echo "Converting: $INPUT_FILE"
echo "Model: $MODEL"
echo "Output: $OUTPUT_FILE"

# Create temp file for WAV conversion
TEMP_WAV=$(mktemp).wav
trap "rm -f $TEMP_WAV" EXIT

# --- Build ffmpeg trim args ---
FFMPEG_TRIM_ARGS=()

if [ -n "$START_TIME" ]; then
    normalize_time "$START_TIME"
    START_SECS=$TIME_SECONDS
    # -ss before -i = fast input seeking
    FFMPEG_TRIM_ARGS+=(-ss "$TIME_HMS")
    echo "Start time: $TIME_HMS ($START_SECS seconds)"
fi

if [ -n "$END_TIME" ]; then
    normalize_time "$END_TIME"
    END_SECS=$TIME_SECONDS
    if [ -n "$START_TIME" ]; then
        # With -ss before -i, timeline resets — use -t (duration) not -to (absolute)
        DURATION=$(( END_SECS - START_SECS ))
        FFMPEG_TRIM_ARGS+=(-t "$DURATION")
        echo "End time: $TIME_HMS (duration: ${DURATION}s)"
    else
        FFMPEG_TRIM_ARGS+=(-to "$TIME_HMS")
        echo "End time: $TIME_HMS"
    fi
fi

# Convert to Whisper-compatible format (16kHz mono WAV), with optional trim
echo "Converting to WAV format..."
ffmpeg "${FFMPEG_TRIM_ARGS[@]+"${FFMPEG_TRIM_ARGS[@]}"}" \
    -i "$INPUT_FILE" -ar 16000 -ac 1 -c:a pcm_s16le -y "$TEMP_WAV" 2>/dev/null

# Check if trimmed result is essentially empty
WAV_SIZE=$(wc -c < "$TEMP_WAV" | tr -d ' ')
if [ "$WAV_SIZE" -lt 1024 ]; then
    echo "Warning: Output audio is very small (${WAV_SIZE} bytes). The time range may be outside the content."
fi

# Get output directory and base name
OUTPUT_DIR=$(dirname "$OUTPUT_FILE")
OUTPUT_BASE=$(basename "$OUTPUT_FILE" .txt)

# Ensure Metal acceleration is available
export GGML_METAL_PATH_RESOURCES="${GGML_METAL_PATH_RESOURCES:-$(brew --prefix whisper-cli 2>/dev/null)/share/whisper-cli}"

# Transcribe
echo "Transcribing..."
whisper-cli -m "$MODEL_PATH" \
    --output-txt \
    --output-file "$OUTPUT_DIR/$OUTPUT_BASE" \
    "$TEMP_WAV"

echo ""
echo "Done! Output: $OUTPUT_FILE"
echo "Character count: $(wc -c < "$OUTPUT_FILE" | tr -d ' ')"
