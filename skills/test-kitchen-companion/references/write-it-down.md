# Write it down

Use this when someone wants to turn a task or concept into written instructions, a Gemini skill, or a notebook, or wants to know where their idea should live.

## One artifact, two homes

The thing participants build is **a written set of instructions**: what the AI's role is, the process it follows, what good looks like, the context it needs, and when it should check back with them. Draft it in a Google Doc so it's easy to edit and reuse.

Those same instructions can live in two places:

- **A Gemini skill**: for your own repeatable workflows. Portable, because skills are an open format other AI tools also read.
- **A notebook** (Gemini Notebook): when other people need to use it, or when it has to stay grounded in specific documents. The same instruction text goes into the notebook's chat customization.

If they built a Gem before, their instructions carry over. Copy them out and treat them as the first draft, or ask in a chat to convert the instructions into a skill; AI tools that support skills generally have a built-in way to do this. If a tool doesn't, point it at the open standard at [agentskills.io](https://agentskills.io/home) and it can take it from there. Gems still work for now, but BC accounts will start losing them as early as June 2027, so build new work as a skill (or a notebook) rather than a Gem.

### Decision guide

| | Process or guided conversation | Grounded in specific content |
|---|---|---|
| **For me** | Skill | Skill, or a personal notebook if the content is large |
| **For others** | Notebook with a small source and strong instructions for now; a skill once sharing is available | Notebook |

Outside the scope of this workshop, a Microsoft Copilot agent is another way to package functionality you need to share.

Things to say plainly:
- Sharing features change. Whether a skill can be shared from their account, and with whom, is something to confirm with the facilitators.
- A notebook doesn't give the creator transcripts or usage data from other people's conversations. If they need to see how students used it, they should know that before they build.
- If a notebook keeps pulling back to its sources or refusing general questions, that's a signal the idea needs a general chat (a skill) more than a source-grounded one.

## The build method: do it once, then write it down

The easiest way to make a skill is not starting from a blank page. It's this:

1. **Pick a task** they actually do, or a conversation they actually want to have.
2. **Do it once with AI**, in conversation. Use a fictional or public example.
3. **Correct it as you go.** "No, shorter." "Ask me before you assume the audience." "Our office never does it that way." Those corrections are their taste and judgment, which is the valuable part.
4. **Ask the AI to write down what you just did** as reusable instructions, keeping the corrections.
5. **Read it and fix it.** Then save it as a skill.

You can run this with them right here: do the task together, then draft the instructions.

## Before starting: four handoff questions

These reach shared context before work starts. Use them, and teach them as a habit the participant can reuse with any AI:

1. "Repeat back what you think we're working on."
2. "Write the plan into a document so we can track progress."
3. "Are we missing anything, or is there a better way to think about this?"
4. "What information, context, or tool access would you need to do this well?"

Question 4 is also how someone finds out what the tool can and can't do.

## What goes in the instructions

Like onboarding a new colleague. Not every piece is needed every time; start with what's essential:

- **Role and goal:** what this is for. "You help undergraduates compare two possible project topics."
- **Process:** the steps, if order matters.
- **Expectations:** tone, format, length, what a good result looks like, and what a bad one looks like.
- **Context:** audience, situation, what the output is used for.
- **When to come back to me:** where the AI should stop and ask, or hand the decision back. Most first drafts leave this out. Ask about it directly.
- **Resources:** how to use any reference files ("Use the rubric in references when giving feedback").

Match specificity to risk. Many valid paths and low stakes: give general direction. One right way or high stakes: be precise.

## Two quality checks

- **The golden rule:** could a new colleague with little context follow these instructions? If they'd be confused, the AI will be too.
- **The edge-case check:** "Where would a competent, well-meaning person have to guess?" Fill those gaps.

## Turning it into a Gemini skill

When they're ready to save it, help them produce the pieces:

- **Name:** lowercase words joined by hyphens, like `project-topic-coach`.
- **Description:** one or two sentences saying what it does and when to use it. Gemini reads this to decide when the skill is relevant, so include the situations and words someone would actually use.
- **Instructions:** the body. Keep it focused; long instructions dilute the important parts.
- **Reference files (optional):** examples, rubrics, or background, as plain text, Markdown, or PDF. Word and Excel files aren't accepted; export to PDF or paste the text. Files are a snapshot; update them by re-uploading.

Two ways to save it in Gemini: paste the pieces into **Customize → Skills → Create → Create manually**, or ask Gemini in a chat to "create a skill from these instructions." For a skill with reference files, they put a `SKILL.md` and a `references` folder in one folder, zip it, and use **Create → Upload**. Facilitators can help with that step.

Offer to draft the name, description, and instructions for them to edit. Make clear the draft is theirs to change, and that it isn't tested until they've tried it.

## Context: more isn't better

Point, don't load. An entire course's worth of materials pasted into the main system prompt or `SKILL.md` can crowd the conversation. Signs: the assistant repeats its introduction, forgets earlier turns, or ignores parts of the instructions. Fixes: separate instructions from content, trim, keep only what changes behavior, and move large documents into a notebook.

Instructions also don't add abilities. Writing "update my spreadsheet" doesn't give the AI access to the spreadsheet. If the task needs a tool, check whether the app actually offers it.
