#!/bin/bash
# youtube-transcript.sh
# Downloads and cleans YouTube transcripts
#
# Usage: ./youtube-transcript.sh <youtube_url> [output_file]
#
# Process:
# 1. Try to grab auto-generated subtitles via yt-dlp
# 2. Clean up timestamps and formatting
# 3. If no subtitles available, download audio and run through local STT
#
# Prerequisites:
#   brew install yt-dlp ffmpeg whisper-cli

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
YOUTUBE_URL="$1"
OUTPUT_FILE="$2"

if [ -z "$YOUTUBE_URL" ]; then
    echo "Usage: $0 <youtube_url> [output_file]"
    echo ""
    echo "Downloads and cleans YouTube transcript"
    echo ""
    echo "Process:"
    echo "  1. Tries to grab existing subtitles (manual or auto-generated)"
    echo "  2. Cleans up timestamps and formatting"
    echo "  3. Falls back to audio download + local STT if no subtitles"
    exit 1
fi

# Check for required tools
if ! command -v yt-dlp &> /dev/null; then
    echo "Error: yt-dlp not found. Install with: brew install yt-dlp"
    exit 1
fi

echo "Fetching transcript for: $YOUTUBE_URL"

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

    # Use the audio-to-text script if available, otherwise run whisper directly
    if [ -f "$SCRIPT_DIR/audio-to-text.sh" ]; then
        "$SCRIPT_DIR/audio-to-text.sh" "$AUDIO_FILE" "$OUTPUT_FILE"
    else
        # Direct whisper-cli call
        WHISPER_MODELS="${WHISPER_MODELS:-$HOME/.whisper}"
        MODEL_PATH="$WHISPER_MODELS/ggml-base.en.bin"

        if [ ! -f "$MODEL_PATH" ]; then
            echo "Error: Whisper model not found at $MODEL_PATH"
            exit 1
        fi

        # Convert for whisper
        ffmpeg -i "$AUDIO_FILE" -ar 16000 -ac 1 -c:a pcm_s16le -y "$TEMP_DIR/whisper_input.wav" 2>/dev/null

        # Transcribe
        OUTPUT_DIR=$(dirname "$OUTPUT_FILE")
        OUTPUT_BASE=$(basename "$OUTPUT_FILE" .txt)
        whisper-cli -m "$MODEL_PATH" --output-txt --output-file "$OUTPUT_DIR/$OUTPUT_BASE" "$TEMP_DIR/whisper_input.wav"

        echo ""
        echo "Done! Output: $OUTPUT_FILE"
    fi
fi
