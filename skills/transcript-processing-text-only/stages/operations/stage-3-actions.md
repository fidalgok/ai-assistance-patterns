# Stage 3: Action Items & Next Steps

**Purpose:** Extract explicit tasks and generate suggested follow-ups in a task-ready format.

**When:** After Stage 2 summary is complete.

## Process

1. Extract all explicitly stated action items (things someone committed to doing)
2. Analyze discussion to suggest additional next steps that logically follow
3. Assign ownership where mentioned (or mark TBD)
4. Note timing/deadlines where mentioned
5. Suggest priority based on context

## Prompt Pattern

```
From the structured summary, create two sections:

**Explicit Action Items:** Tasks that were explicitly assigned or agreed upon during the discussion.

**Suggested Next Steps:** Additional actions that logically follow from the discussion, even if not explicitly stated. These are recommendations based on what was discussed.

For each item, provide:
- Task description (clear, actionable)
- Owner (if mentioned, otherwise "TBD")
- Due date/timeline (if mentioned, otherwise leave blank)
- Priority (suggest based on context: High/Medium/Low)
- Type (Explicit or Suggested)

Format as a markdown table:

| Task | Owner | Due | Priority | Type |
|------|-------|-----|----------|------|
| [Clear description of what needs to be done] | [Name/TBD] | [Date if mentioned] | [H/M/L] | Explicit |
| [Another task] | [Name/TBD] | | [H/M/L] | Suggested |

After the table, add any notes about dependencies or sequencing if relevant.
```

## Output

Task-oriented table ready for import into a project tracker or task management system.

## Quality Checks

- [ ] All explicit commitments from the transcript are captured
- [ ] Suggested items are reasonable inferences (not reaching)
- [ ] Task descriptions are actionable (start with a verb)
- [ ] Priority assignments reflect discussion context
- [ ] Explicit vs. Suggested is clearly distinguished
