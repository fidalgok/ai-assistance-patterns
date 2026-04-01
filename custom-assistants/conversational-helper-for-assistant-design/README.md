# CHAD: Conversational Helper for Assistant Design

CHAD is an interactive guide that walks you through designing a custom AI assistant — from a rough idea to a working system prompt you can copy and paste into whatever tool you use.

[Try CHAD in Google Gemini](https://gemini.google.com/gem/18o_rNEcwpn5eaUONj7v7tGqaahl63Eti?usp=sharing)

If you can provide custom instructions to an LLM — whether that's a Google Gem, a Custom GPT, a Claude Project, system instructions in an API call, or just pasting text as the first message in a free chat — CHAD can help you get there.

## What CHAD Does

CHAD treats assistant design as a conversation, not a form to fill out. It asks questions, helps you think through what your assistant needs, and drafts a system prompt based on what you share. Then you iterate together until it's right.

**CHAD will:**

- Ask about your use case, audience, and what your assistant needs to know
- Draft a complete system prompt based on your answers
- Revise the prompt with you as many times as you need
- Help you think about scope, tone, and interaction style

**CHAD won't:**

- Build the assistant for you in a specific platform
- Make decisions about your use case — that's your call
- Produce a perfect prompt on the first try (iteration is the point)

## How to Start

You can come in with as much or as little as you want:

### If you have a clear idea:

"I want to build an assistant that helps new employees navigate our onboarding process."

### If you have a vague sense:

"I'm thinking about something that could help with student advising, but I'm not sure what it would actually do."

### If you're starting from scratch:

"I know I want to build a custom assistant but I don't know where to start."

CHAD will meet you where you are and ask the right questions to move forward.

## The Conversation Flow

A typical CHAD session moves through these phases:

```
1. CONTEXT GATHERING
   What's the use case? Who's the audience? What does it need to know?
        ↓
2. PROPOSAL
   CHAD drafts a complete system prompt based on your answers
        ↓
3. FEEDBACK & ITERATION
   You review, suggest changes, and CHAD revises — as many rounds as you need
        ↓
4. FINALIZATION
   You get a polished system prompt ready to use
```

You don't have to follow this rigidly — the conversation adapts to what you need.

## How to Use the Output

When you're happy with the prompt, CHAD will remind you to copy the text inside the `<assistant_proposal>` tags and paste it into your tool of choice:

- **Google Gems** — paste into the custom instructions field
- **Custom GPTs** — paste into the system instructions
- **Claude Projects** — paste into the project instructions
- **API / SDK** — use as the system message
- **Free chat with no custom assistant features** — paste as the first message of a new conversation

It works anywhere you can give an LLM instructions.

## Tips for a Good Session

**Be specific about who this is for.** "Graduate students in my contracts class" gives CHAD much more to work with than "students."

**Think about a real scenario.** "Someone comes to the front desk asking about room reservations" grounds the design in reality.

**Don't overthink your first answer.** CHAD will ask follow-up questions. You don't need to have everything figured out upfront.

**Iterate.** The first draft is a starting point. Push back, ask for changes, try a different direction. That's the process working as intended.

## What's Included

| File | Description |
| --- | --- |
| [system-prompt.md](system-prompt.md) | The system prompt that powers CHAD — copy this into your AI tool to run it yourself |
| [resources/system-prompt-design-faq.md](resources/system-prompt-design-faq.md) | A companion FAQ covering system prompt design principles, testing strategies, and knowledge management |

The FAQ is a useful standalone reference even if you don't use CHAD. It covers questions like "how specific should my prompt be?" and "how do I know when my assistant is good enough?"

## Adapting CHAD for Your Context

CHAD was originally designed for workshop participants learning to build their first custom assistant. But the system prompt is yours to modify:

- **Change the tone** to match your audience (more technical, more casual, more structured)
- **Add domain-specific guidance** if you're always building assistants for a particular field
- **Adjust the phases** if your workflow needs a different structure
- **Add examples** of good system prompts from your own work

The patterns are what matter — take what's useful and make it yours.
