# Transcript Processing Skill (Text-Only)

Transform raw transcripts from meetings, workshops, podcasts, and tutorials into structured, actionable outputs.

This is the **text-only variant** of the [full transcript-processing skill](../transcript-processing/). Same processing engine, same staged workflow—just without the audio/video conversion scripts.

## When to Use This Version

Use this version if:

- You're working in **claude.ai** (web) or another environment without local CLI tools
- You **already have text transcripts** and don't need audio/video conversion
- You want a **simpler setup** with no prerequisites

Use the [full version](../transcript-processing/) if:

- You're using **Claude Code** or **Claude Desktop** with terminal access
- You want to process **audio files, video files, or YouTube URLs** directly
- You have (or are willing to install) ffmpeg, whisper-cli, and yt-dlp

## Prerequisites

None. This version works with any Claude interface that supports skills.

## Installation

### For Claude Code

```bash
cp -r transcript-processing-text-only ~/.claude/skills/
```

### For claude.ai (Web)

Upload the skill as a project knowledge file, or zip and upload the directory.

### For Claude Desktop

Add the skill directory to your Claude Desktop skills configuration.

## Usage

1. Paste or upload your text transcript
2. The skill clarifies context and helps you choose a processing mode
3. It works through the appropriate stages
4. You get structured output

### Processing Modes

- **Operations** - For meetings, consultations, planning sessions. Produces decisions, action items, next steps.
- **Content** - For workshops, talks, tutorials, podcasts. Produces frameworks, insights, teachable moments.

### Preparing Your Transcript

If your source is audio or video, transcribe it first using your preferred tool:

- **YouTube** - Click "Show transcript" under a video's description, copy the text
- **Zoom** - Download the transcript from your recording
- **Microsoft Teams** - Export the meeting transcript
- **Otter.ai, Rev, Descript** - Export as text
- **Other** - Any tool that produces a text transcript will work

Then paste or upload the resulting text.

See `SKILL.md` for the full workflow details.
