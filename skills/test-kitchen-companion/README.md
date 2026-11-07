# Test Kitchen Companion

A companion skill for the [BC AI Test Kitchen](https://cdil.bc.edu/resources/emerging-technologies/engaging-with-ai/ai-test-kitchen/), a three-session, hands-on workshop at Boston College run by Tim Lindgren, Kyle Fidalgo, and Luis Gaitan. It was built and tested in Gemini. The Gemini Notebook version of the workshop companion was adapted from it.

## Who it's for

Workshop participants: faculty, staff, and students, most of them not technical. They install it before the first session, have a short conversation with it about their own work, and use it through the workshop to find an idea, write it down as instructions or a skill, and test it.

It's also a worked example for anyone building a skill of their own. Installing it and reading its files is part of the lesson: a skill is a folder of plain-language instructions, and nothing in it is hidden.

## What's inside

- `SKILL.md`: the main instructions. It sets the companion's role and working style, routes each person to the right workshop stage, and holds the guardrails.
- `references/`: six files the companion reads only when a conversation needs them.
  - `orientation.md`: what the workshop is, how to prepare, and what a skill is
  - `find-an-idea.md`: finding an idea worth prototyping (adapted from [IDA](../../custom-assistants/idea-discovery-assistant/))
  - `write-it-down.md`: turning a task into instructions and deciding whether it belongs in a skill or a notebook
  - `test-it.md`: testing and revising a prototype
  - `workshop-ideas.md`: the workshop's core concepts
  - `off-menu.md`: optional chef personas, turned on by typing `--offmenu`

## Install it in Gemini

1. Get the `test-kitchen-companion` folder from this repo (see [Getting the Files](../../README.md#getting-the-files)) and zip it. `SKILL.md` needs to be at the top level of the folder.
2. Sign in at [gemini.google.com](https://gemini.google.com). In the left sidebar, click **More**, then **Customize**, then the **Skills** tab.
3. Click **Create**, then **Upload**, and choose the zip. You can also choose or drag in the unzipped folder.
4. Gemini shows the name, description, and instructions before saving. Click **Create**. The skill appears under **Active**.
5. To use it, type **@** in a chat and choose **test-kitchen-companion**. Gemini can also pick it up on its own when a message sounds like workshop work.

If you don't see **Customize** or a **Skills** tab, your account may not have skills turned on. You can paste the contents of `SKILL.md` into a regular chat instead; you'll lose the reference files but keep most of the behavior.

Skills on the BC account we tested were private, with no option to share them. Reference files are a snapshot; to update one, use **Replace skill** and upload the whole folder again.

## Building your own

The skill follows the [Agent Skills](https://agentskills.io/home) format, so other tools that read skills can load it too, though it has only been tested in Gemini. If you want to build your own, the [Agent Skills specification](https://agentskills.io/specification) and Anthropic's [skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) are good references.
