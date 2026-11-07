# Orientation: the workshop and this skill

Use this when someone wants to know what the Test Kitchen is, how to prepare, or what they just installed.

## What the Test Kitchen is

The BC AI Test Kitchen is a three-session, hands-on lab for the Boston College community, run by Tim Lindgren, Kyle Fidalgo, and Luis Gaitan. Participants bring their own work: teaching, research, advising, administration, student support. The lab is about practice: try something, look at what happened, change it, try again.

The throughline: **package your intent and context so AI can do a task well, repeatedly, for you or for someone else.**

Across the three sessions, the work covers:

- **Building blocks and your idea.** How to read any AI tool, a few durable design ideas, and finding one idea worth trying, with a first guess at where it should live.
- **Write it once, put it where it lives.** Turn the idea into written instructions by talking it through with AI, then put those instructions into a Gemini skill or a notebook.
- **Test it and decide what's next.** Test the prototype, revise it, and decide what kind of commitment it is: just for you, for colleagues, for students, or something bigger.

For dates and workshop communications, see the [AI Test Kitchen page](https://cdil.bc.edu/resources/emerging-technologies/engaging-with-ai/ai-test-kitchen/). Don't guess them.

## Honest state of the tools

AI tools change a lot. Features get renamed, moved, or switched off, and the same feature can behave differently on different account types. That is normal right now, not a sign the participant did something wrong. What the workshop teaches holds up through those changes: saying clearly what you want, giving useful context, deciding when a human needs to step in, testing, and organizing your workspace.

If something on their screen doesn't match what they expected, that's useful information, and a chance to practice a skill that outlasts any one feature: take a screenshot and share it in the chat, or ask the AI to look up the latest release notes or announcement about the feature, then ask how to word a request so the feature triggers reliably. If it still doesn't work, mention it to the facilitators.

## Before the workshop

Nothing is required before the first session, and they don't need a finished idea. If they want to warm up, suggest one short conversation about their work, noticing one moment where it helped and one where it missed. Jotting down one task they do over and over is a good start too.

## What they just installed

If someone asks what a skill is or how this one works, explain it through what they did. Keep it concrete:

- **A skill is a saved set of written instructions**, plus any reference files, that Gemini uses for a particular kind of task. This one is entirely plain language. Skills can also include scripts for steps that need to run the same way every time, but many don't need them.
- **The name and description** tell Gemini when the skill is relevant. That's how Gemini can pick it up automatically, or they can call it by typing `@` or `/` in a Gemini chat (it depends on their version) and choosing it. (Some other tools use `$`.)
- **The instructions** (in `SKILL.md`) are the same kind of text you'd put in a Gem's instructions box or a custom GPT's instructions. Role, process, expectations, context.
- **The reference files** (the `references` folder) are knowledge the skill reads only when it needs it. This keeps the main instructions short. Each one is a snapshot: to update a file, they re-upload the whole skill.

Then connect it to the building blocks from the workshop:

| Building block | In this setup |
|---|---|
| **Model** | The Gemini model selected in the chat |
| **The app** | The Gemini app: your interface to the conversation, and the model's interface to tools, actions, and context beyond what you've typed or uploaded |
| **Tools** | What the app lets the model do, such as search, read uploaded files, or use connected apps. This skill adds no tools. |
| **Context** | This skill's instructions and reference files, plus everything said in the conversation |

The invitation: "You can open this skill on the Skills page and read every line. Nothing here is magic. You could change it, and during the workshop you'll write one of your own."

## Questions to ask facilitators, not this skill

- Whether their account type has a feature they don't see
- Sharing a skill or notebook with students or colleagues, and what's approved
- Anything about data, privacy, or institutional policy for a real deployment
