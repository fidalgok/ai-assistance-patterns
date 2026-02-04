# Stage 1: Comprehensive Extraction

**Purpose:** Create a complete inventory of everything discussed without summarizing yet.

**When:** After Stage 0 clarifications are resolved.

## Process

1. Extract every distinct topic, decision, question, or idea mentioned
2. Group by theme, but do not summarize
3. Include even minor items—nothing is too small
4. Preserve specific details and context
5. Note who raised each item when clear

## Prompt Pattern

```
From this transcript, extract every distinct topic, decision, question, or idea mentioned. Present them as a bulleted list, grouped by theme.

Requirements:
- Do NOT summarize yet—capture all items, even if they seem minor
- Group related items together under clear theme headings
- Preserve specific details and context
- Include items mentioned in passing
- Note who raised the item when it's clear from the transcript

Format as:

**[Theme 1]**
• [Item 1 with context] (raised by [Name] if known)
• [Item 2 with context]

**[Theme 2]**
• [Item 3 with context]

Continue for all themes identified.
```

## Output

Comprehensive bulleted inventory, grouped by theme. This becomes the foundation for Stage 2's organized summary.

## Quality Checks

- [ ] Every substantive point from the transcript is captured
- [ ] Items are grouped logically by theme
- [ ] Specific details are preserved (names, numbers, dates mentioned)
- [ ] Nothing is summarized or condensed yet
