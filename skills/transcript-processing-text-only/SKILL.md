---
name: transcript-processing

description: >
  Unified workflow for processing transcripts from meetings, workshops, podcasts, tutorials, and other spoken content.
  Accepts text transcripts via paste or file upload.
  Supports two processing modes: Operations (action items, decisions, next steps) and Content (frameworks, insights, teachable moments).
  Use when extracting structured insights from any recorded or transcribed spoken content.
---

# Transcript Processor

A unified skill for transforming raw transcripts into structured, actionable outputs. Supports intelligent mode selection and staged processing with human-in-the-loop validation.

## Quick Start

1. Paste or upload your text transcript
2. We'll clarify context and choose a processing mode
3. I'll work through the appropriate stages
4. You get structured output tailored to your needs

---

## Pre-Flight: Input Preparation

**Before any processing, make sure the transcript is in text form.**

### Supported Inputs

| Format | Action |
|--------|--------|
| Pasted text | Proceed directly |
| Uploaded `.txt`, `.md` file | Read file and proceed |

### Preparing Your Transcript

If your source is audio or video, transcribe it first using your preferred tool (e.g., Otter.ai, YouTube's "Show transcript" feature, Microsoft Teams transcription, Zoom transcript export, etc.) and then paste or upload the resulting text.

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
