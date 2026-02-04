---
name: transcript-processing

description: >
  Unified workflow for processing transcripts from meetings, workshops, podcasts, tutorials, and other spoken content.
  Handles multiple input formats (text, audio, video, YouTube URLs) with automatic format detection and conversion.
  Supports two processing modes: Operations (action items, decisions, next steps) and Content (frameworks, insights, teachable moments).
  Use when extracting structured insights from any recorded or transcribed spoken content.
---

# Transcript Processor

A unified skill for transforming raw transcripts into structured, actionable outputs. Handles format conversion, intelligent mode selection, and staged processing with human-in-the-loop validation.

## Quick Start

1. Point me at your source (file path or YouTube URL)
2. I'll detect the format and convert to text if needed
3. We'll clarify context and choose a processing mode
4. I'll work through the appropriate stages
5. You get structured output tailored to your needs

---

## Pre-Flight: Input Detection & Conversion

**Before any processing, I'll determine what we're working with:**

### Supported Input Formats

| Format | Detection | Action |
|--------|-----------|--------|
| `.txt`, `.md` | Text transcript | Proceed directly |
| `.mp3`, `.wav`, `.m4a` | Audio file | Convert via local STT |
| `.mp4`, `.mov`, `.webm` | Video file | Extract audio → STT |
| YouTube URL | Remote video | Grab auto-transcript, fallback to audio download → STT |

### Format Handling

**For text files:** Proceed directly to file size check.

**For audio/video files:** Run the conversion script:
```bash
./scripts/audio-to-text.sh "/path/to/file"
```

**For YouTube URLs:** Run the transcript grabber:
```bash
./scripts/youtube-transcript.sh "https://youtube.com/watch?v=..."
```

These scripts are in the `scripts/` directory. They handle conversion and output a clean text transcript.

---

## File Size Check

**Always verify transcript size before processing:**

```bash
wc -c /path/to/transcript.txt
```

| Size | Approach |
|------|----------|
| < 50,000 chars (~15k words) | Process normally |
| 50,000 - 150,000 chars | Use bash `dd` or `head/tail` to read in sections |
| > 150,000 chars | Split into chunks, process systematically |

**Chunking approach (when needed):**
```bash
# Split into 40,000 character chunks
split -b 40000 transcript.txt chunk_

# Process each chunk, then synthesize
```

If you see `< truncated X characters >` in any output, STOP and switch to chunked processing.

---

## Stage 0: Context & Clarification

**Purpose:** Validate assumptions and gather context before processing.

**Process:**

1. **Scan for format indicators:**
   - Speaker count and roles (host/guest, facilitator/participants, etc.)
   - Content type signals (agenda items → meeting, "let's try this" → workshop, Q&A format → interview)
   - Presence of demos, roleplays, or coaching sessions

2. **Identify ambiguities:**
   - Garbled or inconsistent names
   - Unclear references ("the system," "the project")
   - Missing context that would affect interpretation

3. **Determine processing mode:**
   - **Operations:** Meetings, consultations, planning sessions → focus on decisions, action items, next steps
   - **Content:** Workshops, interviews, tutorials, talks, podcasts → focus on frameworks, insights, teachable moments

4. **Ask clarifying questions** before proceeding:
   - Confirm the content type and purpose
   - Resolve name/reference ambiguities
   - Confirm which stages to include (or use defaults)

**Do not proceed until clarifications are resolved.**

---

## Mode: Operations

For meetings, consultations, and planning sessions where the goal is capturing decisions and driving action.

**Default stages:** 1 → 2 → 3

**Available stages:**
- [Stage 1: Comprehensive Extraction](stages/operations/stage-1-extraction.md)
- [Stage 2: Organized Summary](stages/operations/stage-2-summary.md)
- [Stage 3: Action Items & Next Steps](stages/operations/stage-3-actions.md)
- [Stage 4: Strategic Insights](stages/optional/strategic-insights.md) *(optional)*

---

## Mode: Content

For workshops, interviews, tutorials, talks, and podcasts where the goal is extracting learnings and frameworks.

**Default stages:** 1 → 2 → 3

**Available stages:**
- [Stage 1: Lesson Plan Extraction](stages/content/stage-1-lesson-plan.md)
- [Stage 2: Framework Deep Dives](stages/content/stage-2-frameworks.md)
- [Stage 3: Practical Applications](stages/content/stage-3-applications.md)
- [Stage 4: AI Literacy Connections](stages/optional/ai-literacy.md) *(optional)*

---

## Optional Stages (Either Mode)

These can be added to either processing mode on request:

- [Polished Transcript](stages/optional/polished-transcript.md) - Clean, readable dialogue for archival
- [AI Literacy Connections](stages/optional/ai-literacy.md) - Connect insights to AI fluency frameworks
- [Strategic Insights](stages/optional/strategic-insights.md) - Pattern recognition and recommendations

---

## Output Formats

Final output is assembled based on mode and stages run:

**Operations output structure:**
1. Executive Summary
2. Topics Discussed (with decisions and open questions)
3. Action Items Table
4. Strategic Insights (if included)

**Content output structure:**
1. Executive Summary (The Hook)
2. Key Takeaways (The Curriculum)
3. Framework Deep Dives & Case Studies
4. Practical Applications
5. AI Literacy Connections (if included)

---

## Usage Notes

- **Be thorough:** Use task planning and reference files liberally. Don't constrain output for context concerns.
- **Ask when uncertain:** If mode or stages aren't specified, ask during Stage 0.
- **Iterate freely:** Any stage's output can be refined independently.
- **Demo detection matters:** Flag roleplays, coaching sessions, and live demos in Stage 0—these are often the highest-value segments.
