#!/bin/bash
# audio-to-text.sh
# Converts audio/video files to text transcripts using local STT (Whisper.cpp)
#
# Usage: ./audio-to-text.sh <input_file> [output_file] [model]
#
# Supported formats: mp3, wav, m4a, mp4, mov, webm
# Output: Plain text transcript
#
# Prerequisites:
#   brew install whisper-cli ffmpeg
#   Download models to ~/.whisper/ (see research-notes.md)

set -e

INPUT_FILE="$1"
OUTPUT_FILE="${2:-${INPUT_FILE%.*}.txt}"
MODEL="${3:-base.en}"

# Model location
WHISPER_MODELS="${WHISPER_MODELS:-$HOME/.whisper}"

if [ -z "$INPUT_FILE" ]; then
    echo "Usage: $0 <input_file> [output_file] [model]"
    echo ""
    echo "Converts audio/video to text transcript using local Whisper.cpp"
    echo ""
    echo "Arguments:"
    echo "  input_file   Audio or video file to transcribe"
    echo "  output_file  Output path (default: input_file.txt)"
    echo "  model        Whisper model: tiny, base.en, small, medium, large-v3-turbo"
    echo "               (default: base.en)"
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

echo "Converting: $INPUT_FILE"
echo "Model: $MODEL"
echo "Output: $OUTPUT_FILE"

# Create temp file for WAV conversion
TEMP_WAV=$(mktemp).wav
trap "rm -f $TEMP_WAV" EXIT

# Convert to Whisper-compatible format (16kHz mono WAV)
echo "Converting to WAV format..."
ffmpeg -i "$INPUT_FILE" -ar 16000 -ac 1 -c:a pcm_s16le -y "$TEMP_WAV" 2>/dev/null

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
