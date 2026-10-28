# Plan format

Plans live in the repo that owns the goal.

```
plans/
  README.md                 index of active and archived plans (one line each)
  KNOWLEDGE.md              project brain: lasting decisions, conventions, gotchas
  <slug>/
    PLAN.md                 plan brain. Every session reads this first.
    chunks/
      01-<name>.md          one chunk = one session
      02-<name>.md
    notes/                  optional long research. Link to it. Do not paste it.
  archive/
    <YYYY-MM-DD>-<slug>/
```

`<slug>` is lowercase words joined by hyphens, for example `add-webhook-retries`.
Chunk files use two digits, then a short name.

## PLAN.md

Keep it under about 150 lines. Use these headings in this order.

```markdown
# <Plan title>

## Goal
One short paragraph. What we build and why.

## Non-goals
- What we will not do.

## Success criteria
- Checks that show the goal is met.

## Key decisions
- <Decision>. Reason: <why>.

## Architecture in brief
A few lines. Link to notes/ for more.

## Chunks
| ID | Title | Repo | Depends on | Status | Outcome |
|----|-------|------|------------|--------|---------|
| 01 | ...   | .    | -          | todo   | One line result |

## Open questions
- ...

## Change log
- YYYY-MM-DD: what changed in the plan, and why.
```

Status values: `todo`, `in-progress`, `blocked`, `done`.
The chunk table and the status line in each chunk file must always agree. The chunk file is the source of truth.

## Chunk file

A chunk file must work alone. A session reads `PLAN.md` and this file, and can start.

```markdown
# Chunk 01: <title>

- Plan: ../PLAN.md
- Status: todo
- Repo: <repo name or path where the work happens>
- Depends on: none
- Unblocks: 02

## Goal
1 to 3 lines. What this chunk does and how it serves the plan goal.

## Context needed
- `path/to/file.ext`: why it matters (symbol names if useful)
- Facts the session needs, in short form.

## Steps
- [ ] Step one
- [ ] Step two

## Acceptance checks
- `<exact command from the repo>`: expected result
- Behaviour that must be true.

## Out of scope
- Things the session must not do now.

## Handoff notes
Filled in at the end of the session. What changed, what is left, what the next chunk must know.
```

## Chunk size rule

One chunk must fit in one session. Aim for 5 to 10 steps, a few files, and one clear result.
If a chunk is larger, split it. If a chunk is trivial, merge it with a neighbour.
Order chunks so that each one leaves the repo in a working state (checks pass).

## Cross-repo plans

Put `PLAN.md` in the repo that owns the goal. Each chunk names its repo in the `Repo` field.
When a session starts, tell the user which repo to open.

## plans/KNOWLEDGE.md

Small and curated. Only lasting facts: decisions, conventions, gotchas that apply beyond one plan.
Each entry has a date and a source plan. Archive moves entries here.

## plans/README.md

One line per plan: `- [slug](slug/PLAN.md): status, N of M chunks done`.
