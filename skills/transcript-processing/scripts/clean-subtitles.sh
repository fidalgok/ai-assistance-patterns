#!/bin/bash
# clean-subtitles.sh
# Cleans up VTT/SRT subtitle files to plain text
#
# Usage: ./clean-subtitles.sh <subtitle_file> [output_file]
#
# Removes:
# - Timestamps (00:00:00.000 --> 00:00:05.000)
# - VTT headers (WEBVTT, Kind:, Language:)
# - Positioning tags (<c>, </c>, align:, position:)
# - Duplicate lines (YouTube often repeats text)
# - Empty lines and extra whitespace
#
# Output: Clean plain text transcript

set -e

INPUT_FILE="$1"
OUTPUT_FILE="${2:-${INPUT_FILE%.*}_clean.txt}"

if [ -z "$INPUT_FILE" ]; then
    echo "Usage: $0 <subtitle_file> [output_file]"
    echo ""
    echo "Cleans VTT/SRT subtitle files to plain text"
    echo ""
    echo "Removes timestamps, metadata, formatting tags, and duplicate lines."
    exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File not found: $INPUT_FILE"
    exit 1
fi

echo "Cleaning: $INPUT_FILE"
echo "Output: $OUTPUT_FILE"

# Clean the subtitle file
cat "$INPUT_FILE" | \
    # Remove VTT/SRT metadata headers
    grep -v "^WEBVTT" | \
    grep -v "^Kind:" | \
    grep -v "^Language:" | \
    grep -v "^NOTE" | \
    # Remove numeric line indexes (SRT format)
    grep -v "^[0-9]*$" | \
    # Remove timestamp lines (both VTT and SRT formats)
    grep -v "^[0-9][0-9]:[0-9][0-9]" | \
    grep -v "\-\->" | \
    # Remove lines that are just whitespace
    grep -v "^[[:space:]]*$" | \
    # Remove HTML/formatting tags
    sed 's/<[^>]*>//g' | \
    # Remove common HTML entities
    sed 's/&nbsp;/ /g' | \
    sed 's/&amp;/\&/g' | \
    sed 's/&lt;/</g' | \
    sed 's/&gt;/>/g' | \
    sed "s/&#39;/'/g" | \
    sed 's/&quot;/"/g' | \
    # Remove duplicate consecutive lines
    awk '!seen[$0]++' | \
    # Trim leading/trailing whitespace from each line
    sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | \
    # Remove any resulting empty lines
    grep -v "^$" > "$OUTPUT_FILE"

echo ""
echo "Cleaned transcript saved to: $OUTPUT_FILE"
echo "Character count: $(wc -c < "$OUTPUT_FILE" | tr -d ' ')"
echo "Line count: $(wc -l < "$OUTPUT_FILE" | tr -d ' ')"
