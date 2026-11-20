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

Skeleton: `templates/PLAN.md`. Keep it under about 150 lines. Keep the headings in this order: Goal, Non-goals, Success criteria, Key decisions, Architecture in brief, Chunks (table), Open questions, Change log.

Chunk table columns: ID, Title, Repo, Depends on, Status, Outcome.
Status values: `todo`, `in-progress`, `blocked`, `done`.
The chunk table and the status line in each chunk file must always agree. The chunk file is the source of truth.

## Chunk file

Skeleton: `templates/chunk.md`. A chunk file must work alone: a session reads `PLAN.md` and this file, and can start.

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
