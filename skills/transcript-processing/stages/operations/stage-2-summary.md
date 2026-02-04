# Stage 2: Organized Summary by Topic

**Purpose:** Transform the raw extraction into structured meeting minutes with full detail.

**When:** After Stage 1 inventory is complete.

## Process

For each major topic from Stage 1:

1. Identify who raised it
2. Detail what was said (not just high-level summary—capture the substance)
3. Note any decisions or agreements reached
4. Flag unresolved questions or open items
5. Maintain narrative flow while preserving detail

## Prompt Pattern

```
Reorganize the extracted items into a structured summary. For each major topic:

(a) Who raised it
(b) What was said—include specific points made, not just high-level summary
(c) Any decisions or agreements reached
(d) Unresolved questions or open items

Format as:

## [Topic 1]
**Raised by:** [Name]
**Discussion:** [Detailed account of what was discussed, preserving key points and nuance]
**Decisions:** [Any agreements or conclusions reached]
**Open questions:** [Anything left unresolved]

---

## [Topic 2]
[Continue same format]

Repeat for each major topic identified in Stage 1.
```

## Output

Detailed meeting minutes organized by topic. This document should be suitable for archival—someone who wasn't at the meeting should understand what happened.

## Quality Checks

- [ ] Every theme from Stage 1 is addressed
- [ ] Discussion sections capture substance, not just "they talked about X"
- [ ] Decisions are clearly stated
- [ ] Open questions are explicitly flagged
- [ ] Attribution is included where known
