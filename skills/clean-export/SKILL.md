---
name: clean-export
description: Cleans up a raw conversation export (Claude Code /export markdown OR Claude Desktop session-export folder with JSONL) into readable markdown. Strips chrome, collapses tool calls, preserves the conversation. Use when the user points at an export file or session folder.
argument-hint: <path-to-export-file-or-folder>
metadata:
  version: "1.1.1"
  sharing: public
---

# Clean Export

Produces a clean, readable markdown transcript from a raw export. Two source formats are supported — pick the right flow based on what the argument points to.

## Invocation

```
/clean-export <path>
```

The argument can be:
- A single `.md` file from Claude Code `/export` (terminal) — follow the rules in this file.
- A session-export folder from the Claude Desktop app (contains `metadata.json`, a `<uuid>.jsonl`, and a `logs/` subdir) — use the JSONL flow in [cowork-export.md](cowork-export.md). Do NOT attempt to hand-parse the JSONL; run the bundled `extract_cowork.py` script.
- A `.jsonl` file directly (same flow as above, just pointed one level deeper).

### How to pick the flow

1. If the path is a directory, check for `metadata.json` + `*.jsonl` → cowork flow.
2. If the path ends in `.jsonl` → cowork flow.
3. If the path is a `.md`/`.txt` file → terminal flow (rules below).

---

# Terminal-export flow (Claude Code `/export`)

Takes a raw Claude Code `/export` file and produces a clean, readable markdown version suitable for sharing, archiving, or showcasing.

## What Gets Cleaned

### Terminal Chrome (remove entirely)
- The Claude Code banner/logo block (lines containing `▐▛███▜▌`, `▝▜█████▛▘`, `▘▘ ▝▝`)
- Version info line (e.g., `Claude Code v2.1.81`)
- Working directory line (e.g., `~/Documents/Obsidian Vault`)
- Session timer lines (e.g., `✻ Baked for 1m 41s`)

### Turn Markers (replace with clean headers)
- `❯` prefix on user messages → `## Human` header
- `⏺` prefix on assistant messages → `## Assistant` header
- `⎿` sub-item markers → remove the marker, keep the content with appropriate indentation

### Tool Call Artifacts (collapse or remove)
- Tool call blocks like `Read(filename)`, `Write(filename)`, `Bash(command)` → collapse to a brief note: `*[Read file: filename]* ` or `*[Wrote file: filename]*` or similar
- `(ctrl+o to expand)` annotations → remove
- Line-numbered tool output (e.g., `     1 content`) → remove unless it's meaningful context; use judgment
- `Read N files` summary lines → remove
- Truncated tool output with `… +N lines` → remove
- CLAUDE.md loading notifications (`Loaded 01_Projects/CLAUDE.md`) → remove

### Line Wrapping (rejoin)
- Lines that were hard-wrapped by terminal width (~76-80 chars) should be rejoined into flowing paragraphs
- Preserve intentional line breaks: list items, blank lines between paragraphs, code blocks, headings
- **How to detect hard wraps vs intentional breaks:** A line is likely a hard wrap continuation if:
  - It starts with a lowercase letter or continues mid-sentence
  - The previous line is roughly terminal width and doesn't end with punctuation that closes a thought (`.`, `:`, `?`, `!`)
  - It's indented to the same level as the previous line's content (after stripping the turn marker)
- When in doubt, rejoin. It's easier to add line breaks than remove awkward mid-sentence wraps.

### Box Drawing and Special Characters (convert to markdown)
- Table borders (`┌ ┬ ┐ ├ ┼ ┤ └ ┴ ┘ │ ─`) → standard markdown tables
- Blockquote markers (`▎`) → markdown `>`
- Horizontal rules (`────...`) → markdown `---`

### Whitespace
- Normalize excessive leading whitespace from terminal indentation
- Preserve code block indentation
- Ensure single blank line between sections (no triple+ blank lines)

## Output

### File Naming
- Write the cleaned version alongside the original
- Name: replace the original filename with a `-clean` suffix
  - `Conversation Export.md` → `Conversation Export-clean.md`
  - `my-chat.md` → `my-chat-clean.md`

### Header
Add a brief metadata header at the top of the cleaned file:

```markdown
---
title: [Inferred from conversation topic]
date: [Today's date]
model: [Extracted from the banner if present, e.g., "Claude Opus 4.6"]
---
```

### Structure
The cleaned output should read like a natural conversation transcript:

```markdown
---
title: Learning Design for Law Student AI Bootcamp
date: 2026-03-22
model: Claude Opus 4.6
---

# [Conversation Title]

## Human

[Clean user message text, reflowed]

## Assistant

[Clean assistant response, with markdown formatting preserved]

## Human

[Next user message...]
```

## Workflow

1. **Read** the raw export file
2. **Parse** the conversation into turns, identifying human vs. assistant messages
3. **Clean** each turn by applying all the rules above
4. **Reassemble** into clean markdown
5. **Write** the cleaned file alongside the original
6. **Report** what was done: file path, number of turns, anything notable that was removed or flagged

## Edge Cases

- **Code blocks in assistant responses:** Preserve these exactly — don't rejoin lines inside fenced code blocks
- **Tables in assistant responses:** Convert from box-drawing to markdown pipe tables, preserving content
- **Nested lists:** Preserve list structure and indentation
- **Multiple tool calls in sequence:** Collapse to a single note if they're all reads/setup; preserve if they produced content the user would want to see
- **Images or file references:** Keep references to files that were read or written; these provide context for the conversation
- **Skill/command invocations:** The first `❯ /skill-name args` should be preserved as the opening human turn — it shows what kicked off the conversation

## Judgment Calls

Not everything is mechanical. Use judgment on:

- **How much tool output to keep:** If a tool call's output is referenced in the conversation, summarize what it returned. If it's pure infrastructure (loading CLAUDE.md files), drop it.
- **Long assistant responses with rich formatting:** Preserve the formatting. The goal is clean markdown, not plain text.
- **Conversation metadata vs. noise:** Keep anything that helps a reader understand the flow. Remove anything that's only meaningful in the terminal context.
