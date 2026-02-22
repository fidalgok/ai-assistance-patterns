# Getting Started

This guide helps you understand and adapt these patterns—or build your own from scratch.

## The Core Idea

**Skills and commands are just structured instructions.** They're markdown files that tell an AI assistant how to approach a specific type of task. There's no magic here—if you can describe a workflow to a colleague, you can turn it into a skill or a set of custom instructions.

These patterns should be viewed as starting points. The goal isn't to use them exactly as written—it's to:

1. See how structured AI workflows can work
2. Adapt them for your context
3. Build your own for tasks you repeat

---

## Getting the Files First

Before you can use any of these patterns, you'll need to get the files onto your computer.

**Ask your AI assistant**

Any AI model you collaborate with understands how to do this — but *which tool you're using matters*. If you're chatting on claude.ai or ChatGPT, ask it to walk you through downloading the files step by step. If you're using a tool with file system access (Claude Code, Codex, Claude Desktop), it can just clone the repo for you directly. Either way, this is a great opportunity to practice the kind of collaborative workflow these patterns are all about: use AI as both the vehicle and the guide to get you where you need to go.

**If you're comfortable with Git:**

```bash
git clone https://github.com/fidalgok/ai-assistance-patterns.git
cd ai-assistance-patterns
```

**If you're not familiar with Git (totally fine!):**

1. Go to the [repository page on GitHub](https://github.com/fidalgok/ai-assistance-patterns)
2. Click the green **"Code"** button near the top right of the page
3. Click **"Download ZIP"**
4. Unzip the downloaded file — you'll have a folder with all the patterns inside

Either way, you'll end up with a folder containing all the skills, commands, and custom assistant examples.

---

## Three Ways to Use This Repo

### 1. Use a Pattern As-Is (Quickest)

If one of these patterns fits your needs closely:

```bash
# Copy to your Claude Code installation
cp -r skills/transcript-processing ~/.claude/skills/
cp commands/init-project.md ~/.claude/commands/
```

Then invoke with `/transcript-processing` or `/init-project` in Claude Code.

### 2. Adapt a Pattern for Your Context

If a pattern is close but not quite right:

1. Read through the skill/command to understand its structure
2. Copy it to your local Claude Code directory
3. Modify the instructions to fit your terminology, workflow, and preferences (with an AI model of your choosing of course)
4. Test it, iterate, refine

### 3. Build Your Own Pattern (Most Valuable)

If you have a workflow you repeat—even if nothing here matches—you can create your own skill or command from scratch.

---

## Building Your Own: A Conversation Starter

The best way to build a skill is to have a conversation with an AI assistant about what you're trying to accomplish. Here's a template to get started:

---

**Copy this into a conversation with your AI assistant:**

> I want to create a reusable skill/workflow for [describe your task].
>
> **What I'm trying to accomplish:**
> [Describe the end goal - what does success look like?]
>
> **When I would use this:**
> [What triggers this workflow? A type of file? A recurring meeting? A specific request?]
>
> **The general steps I follow:**
>
> 1. [First thing I do]
> 2. [Then I usually...]
> 3. [Finally I...]
>
> **What makes this tricky or time-consuming:**
> [What's the hard part? What do you wish was automated or structured?]
>
> **Output I want:**
> [What should the final deliverable look like?]
>
> Can you help me turn this into a structured skill that I can reuse?

---

### Example: Creating a "Meeting Prep" Skill

Here's how that template might look filled in:

> I want to create a reusable skill/workflow for **preparing for 1:1 meetings with my team**.
>
> **What I'm trying to accomplish:**
> Have a structured prep doc before each 1:1 that helps me be present and useful.
>
> **When I would use this:**
> Before any recurring 1:1 meeting, usually when I have 10-15 minutes to prep.
>
> **The general steps I follow:**
>
> 1. Review notes from our last 1:1
> 2. Check their recent work (PRs, tickets, messages)
> 3. Note any organizational context they should know about
> 4. Prepare 2-3 questions to ask them
>
> **What makes this tricky or time-consuming:**
> Remembering to check all the sources, synthesizing scattered information quickly.
>
> **Output I want:**
> A one-page prep doc with: context from last time, their recent work summary, things to share, questions to ask.
>
> Can you help me turn this into a structured skill that I can reuse?

From there, the AI assistant can help you draft the skill file, suggest stages, and refine the workflow. If you're using an AI tool worth its weight in salt these days it has the capabilities to help you gather this information as context for the task at hand. The most important thing for you is to have the awareness of what's possible and a willingness to ask an AI model to help you get there.

---

## Understanding the File Structure

### Skills (Multi-Stage Workflows)

Skills are directories with a main `SKILL.md` file and optional supporting files:

```
skills/
└── my-skill/
    ├── SKILL.md              # Main definition (required)
    ├── reference/            # Supporting docs (optional)
    └── stages/               # Stage-specific instructions (optional)
```

The `SKILL.md` file needs YAML frontmatter:

```yaml
---
name: my-skill
description: >
  What this skill does and when to use it.
  Be specific about triggers.
---
# My Skill

[Instructions for the workflow...]
```

### Commands (Single-Purpose Instructions)

Commands are standalone markdown files:

```
commands/
└── my-command.md
```

Simpler than skills—just instructions for a specific task. Good for things that don't need multiple stages.

---

## Installation (Claude Code)

**Skills** go in `~/.claude/skills/`:

```bash
cp -r skills/[skill-name] ~/.claude/skills/
```

**Commands** go in `~/.claude/commands/`:

```bash
cp commands/[command-name].md ~/.claude/commands/
```

Restart Claude Code after adding new skills/commands.

---

## For Non-Technical Users

You don't need to use the command line. Here's the conversational approach:

1. **Download** the skill or command file you're interested in
2. **Share it** with your AI assistant (Claude, ChatGPT, etc.)
3. **Describe** what you want to adapt or accomplish:

> "I found this transcript processing workflow. Can you help me understand what it does? I want something similar but for [my use case]."

The AI can read the file, explain the structure, and help you customize it—even if you're not comfortable editing files directly.

---

## Tips for Building Good Patterns

**Start with what you actually do.** Don't design the ideal workflow—capture the real one first, then improve.

**Keep the main file scannable.** Put details in separate files if the instructions get long.

**Test before documenting.** Run through the workflow a few times before writing extensive docs.

**Iterate.** Your first version won't be perfect. Use it, notice what's missing, improve it. You often do this by starting a conversation with your AI assistant to incorporate your feedback in the commands, skills, and system prompts you're co-developing together.

---

## Troubleshooting

**Skill not showing up?**

- Check: `~/.claude/skills/[skill-name]/SKILL.md` exists
- Directory name should match the `name:` in YAML frontmatter
- Restart Claude Code

**Command not working?**

- Check: `~/.claude/commands/[command-name].md` exists
- Invoke with `/command-name` (no .md extension)

**Scripts or tools failing?**

- Check the skill's README for prerequisites
- Make scripts executable: `chmod +x scripts/*.sh`
- When in doubt, share the error with your AI assistant and ask for help
