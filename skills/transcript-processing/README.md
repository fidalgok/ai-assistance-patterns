# Transcript Processing Skill

Transform raw transcripts from meetings, workshops, podcasts, and tutorials into structured, actionable outputs.

## What It Does

- **Detects input format** (text, audio, video, YouTube URL) and converts to text
- **Offers two processing modes:**
  - **Operations** - For meetings and planning sessions → decisions, action items, next steps
  - **Content** - For workshops, talks, and tutorials → frameworks, insights, teachable moments
- **Staged processing** with human-in-the-loop validation at each step

## Important: Assumptions & Environment

These scripts assume a fairly specific setup:

- **macOS** (uses Homebrew, Apple Silicon Metal acceleration)
- **zsh** as your shell
- **Homebrew** already installed
- **Comfort with the terminal**

**If your setup is different, that's fine.** The scripts are starting points, not requirements. Share them with your AI assistant and ask:

> "I want to use this transcript processing workflow, but I'm on [Windows/Linux/different shell]. Can you help me adapt these scripts for my environment?"

Or skip the scripts entirely—if you already have text transcripts, you don't need any of this setup. The skill will work with just the text processing stages.

## Prerequisites (for audio/video/YouTube conversion)

If you're only processing text files (`.txt`, `.md`), skip to [Installation](#installation).

### Install Tools via Homebrew

```bash
brew install yt-dlp ffmpeg whisper-cli
```

| Tool | Purpose |
|------|---------|
| `yt-dlp` | Download YouTube videos and grab auto-generated captions |
| `ffmpeg` | Convert audio/video formats |
| `whisper-cli` | Local speech-to-text using Whisper.cpp |

### Download a Whisper Model

```bash
# Create model directory
mkdir -p ~/.whisper

# Download base English model (~150MB, good starting point)
curl -L -o ~/.whisper/ggml-base.en.bin \
  "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin"
```

**Other model options** (larger = more accurate, slower):

| Model | Size | Notes |
|-------|------|-------|
| `ggml-tiny.en.bin` | ~75MB | Fastest, less accurate |
| `ggml-base.en.bin` | ~150MB | Good balance (default) |
| `ggml-small.en.bin` | ~500MB | Better accuracy |
| `ggml-medium.en.bin` | ~1.5GB | High accuracy |
| `ggml-large-v3-turbo.bin` | ~1.5GB | Best accuracy, multilingual |

Download from: https://huggingface.co/ggerganov/whisper.cpp/tree/main

### Configure Shell Environment (Apple Silicon)

For Metal acceleration on Apple Silicon Macs:

```bash
# Add to ~/.zshrc
echo 'export GGML_METAL_PATH_RESOURCES="$(brew --prefix whisper-cli)/share/whisper-cli"' >> ~/.zshrc
echo 'export WHISPER_MODELS="$HOME/.whisper"' >> ~/.zshrc
source ~/.zshrc
```

### Make Scripts Executable

```bash
chmod +x scripts/*.sh
```

## Installation

```bash
# Copy to Claude Code skills directory
cp -r transcript-processing ~/.claude/skills/
```

Then invoke with `/transcript-processing` in Claude Code.

## If Something Doesn't Work

Don't troubleshoot alone—that's what your AI assistant is for.

Copy the error message and ask:
> "I'm trying to set up this transcript processing skill and got this error: [paste error]. My setup is [describe your machine/OS]. How do I fix this?"

The scripts are intentionally simple so they're easy to adapt. Your AI assistant can help you modify them for your specific environment, or suggest alternatives if something isn't working.

## Usage

1. Point the skill at your source (file path or YouTube URL)
2. It detects the format and converts if needed
3. You'll clarify context and choose a processing mode
4. It works through the appropriate stages
5. You get structured output

See `SKILL.md` for the full workflow details.
