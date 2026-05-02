#!/usr/bin/env -S uv run --quiet --script
# /// script
# requires-python = ">=3.10"
# dependencies = []
# ///
"""Clean a Claude Desktop session-export folder (JSONL + metadata.json) into readable markdown.

Usage:
    uv run extract_cowork.py <path-to-session-folder-or-jsonl> [--include-thinking] [--include-tool-results] [-o OUT]
"""
import argparse
import json
import re
import sys
from datetime import datetime
from pathlib import Path

SKIP_TOP_TYPES = {"queue-operation", "last-prompt"}
SKIP_ATTACHMENT_SUBTYPES = {
    "deferred_tools_delta",
    "skill_listing",
    "todo_reminder",
    "dynamic_skill",
    "queued_command",
}

SCHEDULED_TASK_RE = re.compile(
    r"^\s*<scheduled-task[^>]*>(.*?)</scheduled-task>\s*$", re.DOTALL
)


def load_metadata(folder: Path) -> dict:
    meta = folder / "metadata.json"
    if meta.exists():
        try:
            return json.loads(meta.read_text())
        except json.JSONDecodeError:
            return {}
    return {}


def unwrap_scheduled_task(text: str) -> tuple[str, bool]:
    m = SCHEDULED_TASK_RE.match(text)
    if m:
        return m.group(1).strip(), True
    return text, False


def _truncate(s: str, limit: int = 120) -> str:
    s = s.replace("\n", " ").strip()
    return s if len(s) <= limit else s[: limit - 3] + "..."


def summarize_tool_input(inp) -> str:
    if not isinstance(inp, dict) or not inp:
        return ""
    preferred_keys = (
        "command", "file_path", "path", "pattern", "query", "url",
        "prompt", "description", "subject", "thread_id", "label",
    )
    for key in preferred_keys:
        if key in inp:
            return f"{key}={_truncate(str(inp[key]))!r}"
    key = next(iter(inp))
    return f"{key}={_truncate(str(inp[key]))!r}"


def summarize_tool_result(content) -> str:
    if isinstance(content, list):
        parts = []
        for c in content:
            if isinstance(c, dict) and c.get("type") == "text":
                parts.append(c.get("text", ""))
            elif isinstance(c, str):
                parts.append(c)
        content = "\n".join(parts)
    if not isinstance(content, str):
        return ""
    content = content.strip()
    if not content:
        return "(no output)"
    first_line = content.split("\n", 1)[0].strip()
    total_lines = content.count("\n") + 1
    out = _truncate(first_line)
    if total_lines > 1:
        out += f" [+{total_lines - 1} more lines]"
    return out


def parse_events(jsonl_path: Path) -> list[dict]:
    events = []
    with jsonl_path.open() as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                events.append(json.loads(line))
            except json.JSONDecodeError:
                continue
    return events


def build_markdown(events, include_thinking=False, include_tool_results=False):
    """Return (body_markdown, stats_dict)."""
    out: list[str] = []
    tool_names: dict[str, str] = {}  # tool_use_id -> tool name
    last_section = None

    stats = {"user": 0, "assistant_text": 0, "tool_use": 0, "thinking": 0, "scheduled": 0}

    def set_section(name: str):
        nonlocal last_section
        if last_section != name:
            out.append(f"\n## {name}\n")
            last_section = name

    for ev in events:
        t = ev.get("type")
        if t in SKIP_TOP_TYPES:
            continue
        if t == "attachment":
            sub = (ev.get("attachment") or {}).get("type")
            if sub in SKIP_ATTACHMENT_SUBTYPES:
                continue
            continue  # unknown attachment type — drop quietly

        msg = ev.get("message") or {}
        content = msg.get("content")

        if t == "user":
            if isinstance(content, str):
                text, is_scheduled = unwrap_scheduled_task(content)
                if is_scheduled:
                    stats["scheduled"] += 1
                    set_section("Scheduled Task")
                    out.append(
                        "*This session was triggered by a scheduled task. "
                        "The task definition has been preserved below:*\n"
                    )
                    # Pick a fence longer than any fence already inside the text.
                    max_inner = max(
                        (len(m.group(0)) for m in re.finditer(r"^`{3,}", text, re.M)),
                        default=2,
                    )
                    fence = "`" * max(3, max_inner + 1)
                    out.append(fence)
                    out.append(text)
                    out.append(fence + "\n")
                else:
                    stats["user"] += 1
                    set_section("Human")
                    out.append(text.strip() + "\n")
            elif isinstance(content, list):
                text_parts = []
                tool_results = []
                for c in content:
                    if not isinstance(c, dict):
                        continue
                    ctype = c.get("type")
                    if ctype == "text":
                        text_parts.append(c.get("text", ""))
                    elif ctype == "tool_result":
                        tool_results.append(c)
                if text_parts:
                    stats["user"] += 1
                    set_section("Human")
                    out.append("\n".join(p.strip() for p in text_parts) + "\n")
                if include_tool_results and tool_results:
                    set_section("Assistant")  # tool results belong with prior assistant turn
                    for tr in tool_results:
                        name = tool_names.get(tr.get("tool_use_id", ""), "tool")
                        summary = summarize_tool_result(tr.get("content", ""))
                        out.append(f"> *[{name} result: {summary}]*")
                    out.append("")

        elif t == "assistant":
            if not isinstance(content, list):
                continue
            for c in content:
                if not isinstance(c, dict):
                    continue
                ctype = c.get("type")
                if ctype == "text":
                    stats["assistant_text"] += 1
                    set_section("Assistant")
                    out.append(c.get("text", "").strip() + "\n")
                elif ctype == "thinking":
                    stats["thinking"] += 1
                    if include_thinking:
                        set_section("Assistant")
                        thinking_text = c.get("thinking", "").strip()
                        quoted = "\n".join(
                            "> " + ln if ln else ">"
                            for ln in thinking_text.splitlines()
                        )
                        out.append(
                            "<details>\n<summary>💭 Thinking</summary>\n\n"
                            f"{quoted}\n\n</details>\n"
                        )
                elif ctype == "tool_use":
                    stats["tool_use"] += 1
                    name = c.get("name", "tool")
                    tool_id = c.get("id", "")
                    if tool_id:
                        tool_names[tool_id] = name
                    set_section("Assistant")
                    inp_summary = summarize_tool_input(c.get("input", {}))
                    out.append(f"*[{name}({inp_summary})]*\n")

    # Collapse runs of blank lines
    joined = "\n".join(out)
    joined = re.sub(r"\n{3,}", "\n\n", joined)
    return joined, stats


def main() -> int:
    p = argparse.ArgumentParser(
        description="Clean a Claude Desktop session export to readable markdown."
    )
    p.add_argument(
        "path",
        help="Path to the session folder (containing metadata.json + .jsonl) or the .jsonl file itself.",
    )
    p.add_argument(
        "--include-thinking",
        action="store_true",
        help="Preserve assistant thinking blocks (as collapsible <details> sections).",
    )
    p.add_argument(
        "--include-tool-results",
        action="store_true",
        help="Include one-line summaries of tool results (truncated).",
    )
    p.add_argument(
        "--output", "-o",
        help="Output markdown path. Default: <jsonl-stem>-clean.md alongside the .jsonl.",
    )
    args = p.parse_args()

    target = Path(args.path).expanduser().resolve()
    if target.is_dir():
        folder = target
        jsonls = sorted(folder.glob("*.jsonl"))
        if not jsonls:
            print(f"error: no .jsonl file found in {folder}", file=sys.stderr)
            return 2
        if len(jsonls) > 1:
            print(
                f"warning: multiple .jsonl files; using {jsonls[0].name}",
                file=sys.stderr,
            )
        jsonl_path = jsonls[0]
    elif target.suffix == ".jsonl" and target.exists():
        jsonl_path = target
        folder = target.parent
    else:
        print(
            f"error: expected a session folder or .jsonl file, got: {target}",
            file=sys.stderr,
        )
        return 2

    meta = load_metadata(folder)
    events = parse_events(jsonl_path)

    body, stats = build_markdown(
        events,
        include_thinking=args.include_thinking,
        include_tool_results=args.include_tool_results,
    )

    title = meta.get("title") or jsonl_path.stem
    model = meta.get("model", "")
    created_ms = meta.get("createdAt")
    if created_ms:
        date_str = datetime.fromtimestamp(created_ms / 1000).strftime("%Y-%m-%d")
    else:
        date_str = datetime.now().strftime("%Y-%m-%d")

    header = ["---", f"title: {title}", f"date: {date_str}"]
    if model:
        header.append(f"model: {model}")
    header.append("---\n")

    stats_line = (
        f"> **Session stats:** {stats['user']} human message(s), "
        f"{stats['assistant_text']} assistant response(s), "
        f"{stats['tool_use']} tool call(s), "
        f"{stats['thinking']} thinking trace(s)"
    )
    if stats["scheduled"]:
        stats_line += f", {stats['scheduled']} scheduled-task prompt(s)"
    stats_line += ".\n"

    doc = (
        "\n".join(header)
        + f"\n# {title}\n\n"
        + stats_line
        + body
        + "\n"
    )

    if args.output:
        out_path = Path(args.output).expanduser().resolve()
    else:
        out_path = jsonl_path.with_name(jsonl_path.stem + "-clean.md")

    out_path.write_text(doc)

    print(f"Wrote {out_path}")
    print(
        f"  stats: {stats['user']} human / {stats['assistant_text']} assistant "
        f"/ {stats['tool_use']} tool calls / {stats['thinking']} thinking "
        f"/ {stats['scheduled']} scheduled-task"
    )
    if stats["scheduled"] and stats["user"] == 0:
        print(
            "  note: this looks like a scheduled-task run with no interactive "
            "human turns — transcript is mostly tool calls and the final report."
        )
    return 0


if __name__ == "__main__":
    sys.exit(main())
