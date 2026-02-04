You are helping scaffold a new coding project with a standardized CLAUDE.md and progress.md structure. This creates a shared memory system for working on the project across sessions.

## Step 1: Gather Project Information

Ask the user for the following information ONE question at a time, using the AskUserQuestion tool:

1. **Project name** - What should this project be called?
2. **Purpose** - What does this project do? (1-2 sentences)
3. **Tech stack** - What technologies will be used? (e.g., React Router 7, Convex, Tailwind)

## Step 2: Create CLAUDE.md

Create a `CLAUDE.md` file in the current directory with this structure (fill in the gathered information):

```markdown
# CLAUDE.md - Project Guidelines & Memory

## Project Overview

**Name:** [PROJECT_NAME]
**Purpose:** [PURPOSE]

---

## Claude Workflow Checklist

**IMPORTANT: Follow this workflow for every coding session.**

### Before Starting Work
- [ ] Read `progress.md` for context on recent work and patterns
- [ ] Check this file's Implementation Status for current phase
- [ ] Check for any planning files in `~/.claude/plans/` related to current task

### While Working
- [ ] Use task tracking (TaskCreate/TaskUpdate) for multi-step work
- [ ] Follow patterns documented in `progress.md` Codebase Patterns section

### Before Committing
- [ ] Run type checking to verify no type errors
- [ ] Check if edited files have learnings worth preserving
- [ ] Update Implementation Status checkboxes below if phase items completed

### After Committing
- [ ] Append entry to `progress.md` with:
  - What was implemented
  - Files changed
  - Learnings for future iterations (patterns, gotchas, context)
  - Commit hash
- [ ] Update Codebase Patterns in `progress.md` if reusable pattern discovered
- [ ] Update "Last updated" date at bottom of this file

---

## Current Implementation Status

### Phase 1 - Foundation
- [ ] Project scaffolded
- [ ] Core dependencies installed
- [ ] Basic project structure in place

### Phase 2 - Core Features
- [ ] [Define as you go]

### Future Enhancements
- [ ] [Add as identified]

---

## Technology Stack

| Technology | Version | Notes |
|------------|---------|-------|
[FILL_STACK_TABLE]

---

## Project Structure

```
project-root/
├── CLAUDE.md          # This file - project memory
├── progress.md        # Implementation log & learnings
├── [fill as project grows]
```

---

## Key Files to Understand

| File | Purpose |
|------|---------|
| `progress.md` | Implementation log, learnings, patterns (read before working) |
| [Add as project develops] | |

---

## Commands Reference

```bash
# Development
npm run dev           # Start dev server

# Building
npm run build         # Production build

# Type checking
npm run typecheck     # Run TypeScript compiler
```

---

## Next Session Checklist

When resuming this project:

1. **Read `progress.md`** - Check Codebase Patterns and recent implementation log
2. Review this file's Implementation Status for current phase
3. Run the dev server
4. Check any research docs if needed

---

_Last updated: [TODAY'S_DATE]_
```

## Step 3: Create progress.md

Create a `progress.md` file in the current directory:

```markdown
# Progress Log

This file tracks implementation progress and captures learnings for future sessions.

## Codebase Patterns

_Document reusable patterns as they emerge during development._

### [Pattern Category]
- Pattern description
- Example usage
- When to apply

---

## Implementation Log

### [DATE] - Session Title

**What was implemented:**
-

**Files changed:**
-

**Learnings:**
-

**Commit:** `[hash]`

---
```

## Step 4: Ask About Portfolio Tracking (Optional)

After creating the files, ask the user:

"Would you like to create a portfolio-level note to track this project's status, learnings, and professional development? This is separate from the day-to-day progress.md and lives in your personal knowledge system."

Options:
- Yes - I'll tell you where to create it
- No - skip portfolio tracking

If yes, ask where they'd like the portfolio note created, then use this template:

```markdown
# Project: [PROJECT_NAME]

## Overview
- **Location:** [CURRENT_DIRECTORY]
- **Stack:** [STACK]
- **Purpose:** [PURPOSE]
- **Status:** Phase 1 - Foundation

## Key Learnings
[Periodically extracted from progress.md - patterns worth remembering]

## Professional Development
Skills demonstrated, challenges overcome, technologies mastered
- [Fill as project progresses]

## Log
Brief dated entries for significant milestones

### [DATE]
Project initialized with CLAUDE.md workflow
```

## Step 5: Confirm Completion

Let the user know the scaffolding is complete and remind them:
- Read CLAUDE.md for the workflow checklist
- Update progress.md after each session
- The portfolio note (if created) is for high-level tracking, not day-to-day details
