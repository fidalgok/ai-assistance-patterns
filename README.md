# AI Assistance Patterns

A collection of reusable skills, commands, and workflows for working with AI coding assistants like Claude Code, Codex, and similar tools.

## Philosophy

These are patterns I've developed and find useful in my own work. **You will most likely need to adapt them for your own use case.**

The best way to work with AI tools is to have a conversation about what you're trying to accomplish. Rather than copying these files verbatim, I'd suggest:

1. **Point your AI assistant to this repo** and describe what you're trying to do
2. **Have a conversation** about which patterns might help and how to adapt them
3. **Customize for your context**—your workflows, your preferences, your comfort level with technology

This approach works whether you're deeply technical or just getting started with AI tools.

---

## What's Here

### Skills

Skills are reusable workflows that AI assistants can invoke. They typically involve multiple stages and produce structured output.

| Skill                                                                      | Description                                                                                                                                                                                                        |
| -------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [transcript-processing](skills/transcript-processing/)                     | **Full version.** Transform raw transcripts into structured, actionable outputs. Includes scripts for audio/video conversion (ffmpeg, Whisper, yt-dlp). Best for Claude Code or environments with terminal access. |
| [transcript-processing-text-only](skills/transcript-processing-text-only/) | **Text-only version.** Same processing engine, no audio/video scripts. Works in claude.ai (web), Claude Desktop, or any environment. Just paste or upload a text transcript.                                       |

### Custom Assistants

Real-world system prompts for custom AI assistants, shared openly so you can study the patterns and adapt them. See [custom-assistants/](custom-assistants/) for the full overview.

| Assistant                                                                     | Context                  | Description                                                                                                           |
| ----------------------------------------------------------------------------- | ------------------------ | --------------------------------------------------------------------------------------------------------------------- |
| [IDA - Idea Discovery Assistant](custom-assistants/idea-discovery-assistant/) | AI Test Kitchen workshop | A brainstorming partner that helps participants develop concepts for custom AI assistants through guided questioning. |

### Commands

Commands are simpler, single-purpose instructions that can be invoked as slash commands (e.g., `/init-project`).

> **Note:** In Claude Code, [custom slash commands have been merged into skills](https://code.claude.com/docs/en/skills). A file at `.claude/commands/review.md` and a skill at `.claude/skills/review/SKILL.md` both create `/review` and work the same way. Your existing `.claude/commands/` files keep working. Skills add optional features like supporting file directories and frontmatter to control invocation behavior. Other tools may handle this differently.

| Command                                  | Description                                                                                 |
| ---------------------------------------- | ------------------------------------------------------------------------------------------- |
| [init-project](commands/init-project.md) | Scaffold a new coding project with CLAUDE.md and progress.md for session-to-session memory. |

---

## Getting the Files

### Option 1: Download as a ZIP (No Git Required)

If you're not familiar with Git, you can download everything as a ZIP file:

1. Go to the [repository page on GitHub](https://github.com/fidalgok/ai-assistance-patterns)
2. Click the green **"Code"** button near the top right
3. Click **"Download ZIP"**
4. Unzip the downloaded file — you'll have a folder with everything in it

From there you can browse the files, copy what you need, or share individual files with your AI assistant.

### Option 2: Clone with Git

If you're comfortable with the terminal:

```bash
git clone https://github.com/fidalgok/ai-assistance-patterns.git
cd ai-assistance-patterns
```

This gives you a local copy you can update later with `git pull` when new patterns are added.

### Option 3: Ask Your AI Assistant

Any AI model you collaborate with understands how to do this — but *which tool you're using matters*. If you're chatting on claude.ai or ChatGPT, ask it to walk you through downloading the files step by step. If you're using a tool with file system access (Claude Code, Codex, Claude Desktop), it can just clone the repo for you directly. Either way, this is a great opportunity to practice the kind of collaborative workflow these patterns are all about: use AI as both the vehicle and the guide to get you where you need to go.

---

## Installation

### For Claude Code

**Skills** go in `~/.claude/skills/`:

```bash
# Copy a skill directory
cp -r skills/transcript-processing ~/.claude/skills/
```

**Commands** go in `~/.claude/commands/`:

```bash
# Copy a command file
cp commands/init-project.md ~/.claude/commands/
```

**Note:** Some skills have additional setup requirements (external tools, models, etc.). Check the README in each skill's directory for specifics.

### For Other Tools

The patterns here are written for Claude Code but the concepts translate. Point your AI assistant to the relevant files and ask it to help you adapt them for your tool of choice.

---

## Adapting These Patterns

These files aren't meant to be used as-is. They reflect my workflows, my terminology, and my preferences. When adapting:

- **Read through the skill/command first** to understand what it's doing
- **Identify what's specific to my context** (file paths, terminology, specific frameworks)
- **Talk to your AI assistant** about how to modify it for your needs
- **Start simple** and add complexity as you learn what's useful

The goal is to develop your own patterns that work for you, not to adopt mine wholesale.

---

## Further Learning

If you want to learn more about how to implement skills in your tool of choice or if you want to learn more about best practices for authoring and using skills I suggest looking through the following resources. All of the resources below have a handy "copy page" button or something similar at the top of the page that you can use to bring into your chat assistant of choice to learn more. And, importantly, help you adapt the information to your own context and comfort level.

- [Anthropic's Skills Best Practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) - Even though it's developer focused, this is great for anyone learning how to communicate and collaborate well with AI models.
- [Claude Code Skills Documentation](https://code.claude.com/docs/en/skills)
- [Claude Desktop Skills](https://support.claude.com/en/articles/12512180-using-skills-in-claude)
- [OpenAI Codex Skills](https://developers.openai.com/codex/skills/)
- [Gemini Agent Skills](https://geminicli.com/docs/cli/skills/)
- [Agent Skills Open Standard](https://agentskills.io/home)

---

## Contributing

If you've built something useful on top of these patterns, I'd love to hear about it. Open an issue or PR to share what you've learned.

---

## License

MIT - Use these however you'd like.
