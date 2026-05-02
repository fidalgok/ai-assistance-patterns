# Cowork / Desktop session export flow

Claude Desktop exports a scheduled-task or interactive session as a folder like:

```
session-export-<timestamp>/
├── metadata.json              # title, model, createdAt, cwd, etc.
├── <uuid>.jsonl               # the conversation event stream — what we care about
└── logs/                      # ~80MB of desktop-app debug logs — IGNORE
```

The JSONL is **not** a flat chat — it's a structured event stream. Each line is one of:

| Type | Meaning | Keep? |
|---|---|---|
| `queue-operation` | Internal enqueue/dequeue ticks | Drop |
| `last-prompt` | Prompt-tracking metadata | Drop |
| `attachment` (subtype `deferred_tools_delta`, `skill_listing`, `todo_reminder`, `dynamic_skill`, `queued_command`) | Tool/skill registration chrome | Drop |
| `user` with string content | A human message — or a `<scheduled-task>…</scheduled-task>` wrapper for scheduled runs | **Keep** |
| `user` with list content containing `tool_result` blocks | The tool's output, paired with a prior `tool_use` | Collapse to a brief note (opt-in) |
| `assistant` blocks: `text` | Model's reply | **Keep** |
| `assistant` blocks: `thinking` | Chain-of-thought | Keep only if `--include-thinking` |
| `assistant` blocks: `tool_use` | Tool invocation (Bash, WebSearch, mcp__gmail__*, etc.) | Collapse to `*[name(arg-summary)]*` |

## How to run the skill for this format

Use the bundled script via UV. No venv needed — it's stdlib only.

```bash
uv run extract_cowork.py <path-to-folder-or-jsonl>
```

### Flags

- `--include-thinking` — wrap assistant thinking blocks in collapsible `<details>` sections. Off by default. Turn on for teaching/learning posts where the reasoning trace is the point.
- `--include-tool-results` — add a one-line summary for each tool result (truncated to ~120 chars + total line count). Off by default — the transcript reads better without them, and the tool-call notes already tell the reader what happened.
- `--output <path>` / `-o <path>` — override output path. Default: `<jsonl-stem>-clean.md` alongside the JSONL inside the session folder.

### What you get

A markdown file with:

- Frontmatter (`title`, `date`, `model`) pulled from `metadata.json`.
- A one-line session-stats blockquote (user count / assistant text / tool calls / thinking traces) — useful for spotting that a "session" was actually a mostly-automated scheduled run with little human input.
- `## Scheduled Task` section if the opening user message was a `<scheduled-task>` wrapper (the wrapper content is preserved inside a fenced block so you can still see the task definition).
- `## Human` / `## Assistant` sections for real turns.
- Tool calls as inline italics: `*[Bash(command='ls -la …')]*`, `*[mcp__gmail__gmail_search(query='AI newer_than:1d')]*`, etc.

## Workflow

1. Confirm the target looks like a session folder (`metadata.json` + `*.jsonl`) or a `.jsonl` file.
2. Run `extract_cowork.py` with the appropriate flags. Ask the user whether to include thinking traces if they haven't said — it's the one flag worth surfacing, since teaching/blog use cases often want them on.
3. Report back: output path, session stats, anything notable (e.g., "this was a scheduled run with no human interaction — the transcript is mostly tool calls").

## Judgment calls specific to this format

- **Scheduled tasks with no human turns:** These produce a transcript that's almost entirely tool calls and a final assistant report. Flag this to the user — sometimes they just want the final report extracted, not the whole run.
- **Massive tool-result payloads** (e.g., a Gmail search that returned 50 threads): The script already truncates to one line + `[+N more lines]`. Don't try to preserve the full payload — it's noise for narrative purposes.
- **Repeated similar tool calls** (10 `WebFetch` calls in a row): The script emits one line per call. If the transcript feels cluttered after running, offer to do a second pass that groups consecutive same-tool calls into a single note.
- **`logs/` directory:** Never read, never include. It's desktop-app debug noise.
