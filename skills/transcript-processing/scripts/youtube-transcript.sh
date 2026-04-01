#!/bin/bash
# youtube-transcript.sh
# Downloads and cleans YouTube transcripts
#
# Usage: ./youtube-transcript.sh [--start HH:MM:SS] [--end HH:MM:SS] <youtube_url> [output_file]
#
# Process:
# 1. Try to grab auto-generated subtitles via yt-dlp
# 2. If time range specified, filter SRT before cleaning
# 3. Clean up timestamps and formatting
# 4. If no subtitles available, download audio and run through local STT
#
# Prerequisites:
#   brew install yt-dlp ffmpeg whisper-cli

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Time normalization ---
# Accepts flexible formats: HH:MM:SS, H:MM:SS, MM:SS, or just seconds
# Sets: TIME_HMS (for ffmpeg) and TIME_SECONDS (for comparison)
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

# --- SRT timestamp filtering ---
# Filters an SRT file to only include blocks within a time range
filter_srt_by_range() {
    local input_file="$1"
    local output_file="$2"
    local start_seconds="${3:-0}"
    local end_seconds="${4:-999999}"

    awk -v start="$start_seconds" -v end="$end_seconds" '
    function srt_to_seconds(ts) {
        # Input: HH:MM:SS,mmm or HH:MM:SS.mmm
        gsub(/,/, ".", ts)
        split(ts, parts, ":")
        return parts[1] * 3600 + parts[2] * 60 + parts[3]
    }
    /^[0-9]+$/ {
        # Sequence number line — buffer it
        seq_num = $0
        next
    }
    /-->/ {
        # Timestamp line — check if block falls in range
        split($0, ts_parts, " --> ")
        block_start = srt_to_seconds(ts_parts[1])
        block_end = srt_to_seconds(ts_parts[2])
        in_range = (block_start >= start && block_start < end) || \
                   (block_end > start && block_end <= end) || \
                   (block_start < start && block_end > start)
        if (in_range) {
            print seq_num
            print $0
        }
        next
    }
    /^[[:space:]]*$/ {
        # Blank line separator
        if (in_range) print ""
        in_range = 0
        next
    }
    {
        # Text line
        if (in_range) print $0
    }
    ' "$input_file" > "$output_file"
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

# --- Positional args ---
YOUTUBE_URL="$1"
OUTPUT_FILE="$2"

if [ -z "$YOUTUBE_URL" ]; then
    echo "Usage: $0 [--start HH:MM:SS] [--end HH:MM:SS] <youtube_url> [output_file]"
    echo ""
    echo "Downloads and cleans YouTube transcript"
    echo ""
    echo "Options:"
    echo "  --start TIME  Start time (e.g., 1:22:00, 82:00, 4920)"
    echo "  --end TIME    End time (e.g., 2:00:00, 120:00, 7200)"
    echo ""
    echo "Process:"
    echo "  1. Tries to grab existing subtitles (manual or auto-generated)"
    echo "  2. If time range specified, filters subtitles to that window"
    echo "  3. Cleans up timestamps and formatting"
    echo "  4. Falls back to audio download + local STT if no subtitles"
    echo ""
    echo "Time formats: HH:MM:SS, MM:SS, or seconds. Either flag can be omitted."
    exit 1
fi

# --- Validate time range ---
if [ -n "$START_TIME" ] && [ -n "$END_TIME" ]; then
    normalize_time "$START_TIME"
    validate_start=$TIME_SECONDS
    normalize_time "$END_TIME"
    validate_end=$TIME_SECONDS
    if [ "$validate_end" -le "$validate_start" ]; then
        echo "Error: --end time ($END_TIME) must be after --start time ($START_TIME)"
        exit 1
    fi
fi

# Check for required tools
if ! command -v yt-dlp &> /dev/null; then
    echo "Error: yt-dlp not found. Install with: brew install yt-dlp"
    exit 1
fi

echo "Fetching transcript for: $YOUTUBE_URL"
if [ -n "$START_TIME" ] || [ -n "$END_TIME" ]; then
    echo "Time range: ${START_TIME:-beginning} to ${END_TIME:-end}"
fi

# Create temp directory
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Try to get video title for output filename
VIDEO_TITLE=$(yt-dlp --get-title "$YOUTUBE_URL" 2>/dev/null | head -1 | tr -cd '[:alnum:] ' | tr ' ' '_' | cut -c1-50)
if [ -z "$VIDEO_TITLE" ]; then
    VIDEO_TITLE="youtube_transcript"
fi

# Set output file if not specified
if [ -z "$OUTPUT_FILE" ]; then
    OUTPUT_FILE="${VIDEO_TITLE}.txt"
fi

echo "Output will be: $OUTPUT_FILE"

# Try manual subtitles first, then auto-generated
SUBS_FOUND=false

echo "Checking for available subtitles..."

# Try manual English subtitles
if yt-dlp --skip-download --write-subs --sub-lang en --convert-subs srt \
    -o "$TEMP_DIR/video" "$YOUTUBE_URL" 2>/dev/null; then
    if [ -f "$TEMP_DIR/video.en.srt" ]; then
        echo "Found manual subtitles"
        SUBS_FOUND=true
        SUB_FILE="$TEMP_DIR/video.en.srt"
    fi
fi

# Try auto-generated if no manual subs
if [ "$SUBS_FOUND" = false ]; then
    if yt-dlp --skip-download --write-auto-subs --sub-lang en --convert-subs srt \
        -o "$TEMP_DIR/video" "$YOUTUBE_URL" 2>/dev/null; then
        if [ -f "$TEMP_DIR/video.en.srt" ]; then
            echo "Found auto-generated captions"
            SUBS_FOUND=true
            SUB_FILE="$TEMP_DIR/video.en.srt"
        fi
    fi
fi

if [ "$SUBS_FOUND" = true ]; then
    # Filter by time range if specified
    if [ -n "$START_TIME" ] || [ -n "$END_TIME" ]; then
        normalize_time "${START_TIME:-0}"
        FILTER_START=$TIME_SECONDS

        if [ -n "$END_TIME" ]; then
            normalize_time "$END_TIME"
            FILTER_END=$TIME_SECONDS
        else
            FILTER_END=999999
        fi

        echo "Filtering subtitles to range: ${START_TIME:-beginning} - ${END_TIME:-end}"
        FILTERED_SRT="$TEMP_DIR/filtered.srt"
        filter_srt_by_range "$SUB_FILE" "$FILTERED_SRT" "$FILTER_START" "$FILTER_END"

        # Check if filtering produced any content
        if [ ! -s "$FILTERED_SRT" ]; then
            echo "Warning: No subtitle content found in the specified time range."
        fi

        SUB_FILE="$FILTERED_SRT"
    fi

    # Clean the subtitle file
    echo "Cleaning transcript..."

    cat "$SUB_FILE" | \
        # Remove numeric line indexes
        grep -v "^[0-9]*$" | \
        # Remove timestamp lines
        grep -v "^[0-9][0-9]:[0-9][0-9]" | \
        grep -v "\-\->" | \
        # Remove VTT headers if present
        grep -v "^WEBVTT" | \
        grep -v "^Kind:" | \
        grep -v "^Language:" | \
        grep -v "^NOTE" | \
        # Remove empty lines
        grep -v "^[[:space:]]*$" | \
        # Remove HTML tags
        sed 's/<[^>]*>//g' | \
        # Remove duplicate consecutive lines
        awk '!seen[$0]++' > "$OUTPUT_FILE"

    echo ""
    echo "Done! Output: $OUTPUT_FILE"
    echo "Character count: $(wc -c < "$OUTPUT_FILE" | tr -d ' ')"
else
    echo "No subtitles available. Downloading audio for local STT..."

    # Check for whisper-cli
    if ! command -v whisper-cli &> /dev/null; then
        echo "Error: whisper-cli not found. Install with: brew install whisper-cli"
        echo "Or manually download subtitles from YouTube."
        exit 1
    fi

    # Download audio only
    yt-dlp -x --audio-format wav --audio-quality 0 \
        -o "$TEMP_DIR/audio.%(ext)s" "$YOUTUBE_URL"

    AUDIO_FILE="$TEMP_DIR/audio.wav"

    if [ ! -f "$AUDIO_FILE" ]; then
        echo "Error: Could not download audio"
        exit 1
    fi

    # Build time-range args for audio-to-text
    AUDIO_ARGS=()
    if [ -n "$START_TIME" ]; then
        AUDIO_ARGS+=(--start "$START_TIME")
    fi
    if [ -n "$END_TIME" ]; then
        AUDIO_ARGS+=(--end "$END_TIME")
    fi

    # Use the audio-to-text script if available, otherwise run whisper directly
    if [ -f "$SCRIPT_DIR/audio-to-text.sh" ]; then
        "$SCRIPT_DIR/audio-to-text.sh" "${AUDIO_ARGS[@]+"${AUDIO_ARGS[@]}"}" "$AUDIO_FILE" "$OUTPUT_FILE"
    else
        # Direct whisper-cli call (with optional trim)
        WHISPER_MODELS="${WHISPER_MODELS:-$HOME/.whisper}"
        MODEL_PATH="$WHISPER_MODELS/ggml-base.en.bin"

        if [ ! -f "$MODEL_PATH" ]; then
            echo "Error: Whisper model not found at $MODEL_PATH"
            exit 1
        fi

        # Build ffmpeg trim args
        FFMPEG_TRIM_ARGS=()
        if [ -n "$START_TIME" ]; then
            normalize_time "$START_TIME"
            START_SECS=$TIME_SECONDS
            FFMPEG_TRIM_ARGS+=(-ss "$TIME_HMS")
        fi
        if [ -n "$END_TIME" ]; then
            normalize_time "$END_TIME"
            END_SECS=$TIME_SECONDS
            if [ -n "$START_TIME" ]; then
                DURATION=$(( END_SECS - START_SECS ))
                FFMPEG_TRIM_ARGS+=(-t "$DURATION")
            else
                FFMPEG_TRIM_ARGS+=(-to "$TIME_HMS")
            fi
        fi

        # Convert for whisper (with optional trim)
        ffmpeg "${FFMPEG_TRIM_ARGS[@]+"${FFMPEG_TRIM_ARGS[@]}"}" \
            -i "$AUDIO_FILE" -ar 16000 -ac 1 -c:a pcm_s16le -y "$TEMP_DIR/whisper_input.wav" 2>/dev/null

        # Transcribe
        OUTPUT_DIR=$(dirname "$OUTPUT_FILE")
        OUTPUT_BASE=$(basename "$OUTPUT_FILE" .txt)
        whisper-cli -m "$MODEL_PATH" --output-txt --output-file "$OUTPUT_DIR/$OUTPUT_BASE" "$TEMP_DIR/whisper_input.wav"

        echo ""
        echo "Done! Output: $OUTPUT_FILE"
    fi
fi
