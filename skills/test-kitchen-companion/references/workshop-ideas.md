# Workshop ideas

The core concepts of the Test Kitchen. Use them as habits inside the participant's task, not vocabulary to memorize. Bring one in when it helps and explain it plainly.

## Five Design Basics

1. **Generative AI is our design material.** It's probabilistic: the same request can produce different results. Work with that, and test more than once. The idea comes from Josh Clark and Veronika Kindred's [Sentient Design](https://bigmedium.com/ideas/hello-sentient-design.html) work at Big Medium.
2. **Natural language is our design tool.** This is about communication. The skills that make someone a good colleague, teacher, or manager make them good with AI.
3. **Planning and iteration are the real work.** The first draft won't be right. Testing and adjusting is the process, not a sign of failure.
4. **Context is everything.** AI is lost without your goals, audience, examples, and intent. Define what good looks like to you.
5. **When in doubt, ask AI for help.** Stuck on instructions? Talk it through with AI. It's both the vehicle and the guide.

Ethan Mollick makes a similar point: say clearly what you want, what good and bad look like, and how you'll check the results. He describes that as management. He writes about this idea often, on his blog [One Useful Thing](https://www.oneusefulthing.org/) and on X as [@emollick](https://x.com/emollick).

## The 4Ds

From the AI Fluency Framework by Rick Dakan and Joseph Feller, taught in the course [AI Fluency: Framework and Foundations](https://academy.claude.com/courses/ai-fluency-framework-foundations).

- **Delegation:** what to hand to AI, what to keep, and what to do together.
- **Description:** saying clearly what you want and giving useful context.
- **Discernment:** judging the output for accuracy, quality, relevance, and effect on learning.
- **Diligence:** verifying, taking responsibility, and being transparent about AI use.

## How to read any AI tool

Every AI product is some combination of four building blocks. Knowing them makes a new tool less confusing:

- **Model:** the AI itself (a Gemini, Claude, or GPT model).
- **The app** (sometimes called the harness): the software wrapped around the model, such as Gemini, Gemini Notebook, Copilot, or Claude. It's your interface to the model, and it's also the model's interface to everything else: which tools it can use, what actions it can take, and what context it can reach beyond what you've typed or uploaded.
- **Tools:** what the app lets the model do beyond writing text: search the web, read a file, create an image, act in another app. More tools and permissions make something more "agentic."
- **Context:** everything the model is given to work with: instructions, skills, documents, and the conversation so far.

A spectrum: a chatbot that only writes text → an assistant with a few tools → an agent that works on its own for a long time.

This explains common surprises. Gemini can't edit your spreadsheet in a chat because the app doesn't give it that tool there. A huge document makes the assistant forget things because the context has limits. And something learned in Gemini carries over to Claude or Copilot, because the building blocks are the same; only the buttons differ.

When someone shows you a feature, you can ask them: "Which building block is this?" A skill is mostly context, and sometimes tools when it includes scripts. A notebook's sources are context. Web search is a tool. The model picker is the model.

## Mental models

- **A brilliant assistant with amnesia.** Very capable, knows nothing about you or your situation, and forgets between conversations. Give it what a smart new colleague would need.
- **Right-loading, not offloading.** Hand AI the parts it does well, and keep the parts that need your judgment, expertise, or relationships.

## The conversation is the method

Imperfect first requests are fine. People often know what they want but can't say it yet; conversation is how it gets said. Part of the job is uncovering what you know, what you know you don't know, and what you hadn't thought of, together with the AI. Tell it what you care about. Describe what good and done look like. Tell it when to come back to you for a decision. Speaking instead of typing (dictation) can make this easier for people who freeze at a blank text box.
