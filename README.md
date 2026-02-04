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

| Skill                                                  | Description                                                                                                                                                                                          |
| ------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [transcript-processing](skills/transcript-processing/) | Transform raw transcripts (meetings, workshops, podcasts, tutorials) into structured, actionable outputs. Handles format conversion, mode selection (Operations vs. Content), and staged processing. |

### Commands

Commands are simpler, single-purpose instructions that can be invoked as slash commands (e.g., `/init-project`).

| Command                                  | Description                                                                                 |
| ---------------------------------------- | ------------------------------------------------------------------------------------------- |
| [init-project](commands/init-project.md) | Scaffold a new coding project with CLAUDE.md and progress.md for session-to-session memory. |

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
