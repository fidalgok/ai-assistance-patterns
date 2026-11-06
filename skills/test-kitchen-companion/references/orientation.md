# Orientation: the workshop and this skill

Use this when someone wants to know what the Test Kitchen is, how to prepare, or what they just installed.

## What the Test Kitchen is

The BC AI Test Kitchen is a three-session, hands-on lab for the Boston College community, run by Tim Lindgren, Kyle Fidalgo, and Luis Gaitan. Participants bring their own work: teaching, research, advising, administration, student support. Nobody needs to code. The lab is about practice: try something, look at what happened, change it, try again.

The throughline: **package your intent and context so AI can do a task well, repeatedly, for you or for someone else.**

The three sessions:

1. **Building blocks and your idea.** How to read any AI tool, a few durable design ideas, and finding one idea worth trying. Ends with a concept and a first guess at where it should live.
2. **Write it once, put it where it lives.** Turn the idea into written instructions by talking it through with AI, then put those instructions into a Gemini skill or a notebook.
3. **Test it and decide what's next.** Test the prototype, revise it, and decide what kind of commitment it is: just for you, for colleagues, for students, or something bigger.

Dates, rooms, and assignments come from the facilitators and the workshop's own communications. Don't guess them.

## Honest state of the tools

AI products change mid-semester. Features get renamed, moved, or switched off, and the same feature can behave differently on different account types. That is normal right now, not a sign the participant did something wrong. What the workshop teaches holds up through those changes: saying clearly what you want, giving useful context, deciding when a human needs to step in, testing, and organizing your workspace.

If something in their screen doesn't match what they expected, tell them that's useful information and suggest they mention it to the facilitators.

## How to prepare

A good pre-workshop task, in this order:

1. Install this skill (they may already have).
2. Have one conversation with it about their work. Ten minutes is plenty.
3. Notice one moment where it helped and one where it missed. Bring both.
4. Optional: jot down one task they do over and over, or one thing their students or colleagues regularly struggle with.

That's it. They don't need a finished idea.

## What they just installed

If someone asks what a skill is or how this one works, explain it through what they did. Keep it concrete:

- **A skill is a saved set of written instructions**, plus any reference files, that Gemini uses for a particular kind of task. There's no code involved. Everything in it is plain language.
- **The name and description** tell Gemini when the skill is relevant. That's how Gemini can pick it up automatically, or they can call it by typing `/` or `@` in a chat and choosing it.
- **The instructions** (in `SKILL.md`) are the same kind of text you'd put in a Gem's instructions box or a custom GPT's instructions. Role, process, expectations, context.
- **The reference files** (the `references` folder) are knowledge the skill reads only when it needs it. This keeps the main instructions short. Each one is a snapshot: to update a file, they re-upload the whole skill.

Then connect it to the building blocks from the workshop:

| Building block | In this setup |
|---|---|
| **Model** | The Gemini model selected in the chat |
| **Harness** | The Gemini app: the chat window and its features |
| **Tools** | What the app lets the model do, such as search, read uploaded files, or use connected apps. This skill adds no tools. |
| **Context** | This skill's instructions and reference files, plus everything said in the conversation |

The invitation: "You can open this skill on the Skills page and read every line. Nothing here is magic. You could change it, and by Session 2 you'll write one of your own."

## Questions to ask facilitators, not this skill

- Whether their account type has a feature they don't see
- Sharing a skill or notebook with students or colleagues, and what's approved
- Anything about data, privacy, or institutional policy for a real deployment
