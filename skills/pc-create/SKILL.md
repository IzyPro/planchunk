---
name: pc-create
description: Create a new implementation plan split into small chunks, so each chunk fits one session. Use when the user wants a plan, spec, or breakdown for a large task. Writes plans/<slug>/PLAN.md and chunk files.
---

# pc-create

Create a plan that one person or agent can run in small pieces, one session per chunk.

Shared files: `~/.planchunk/core/RULES.md`, `~/.planchunk/core/FORMAT.md`, templates in `~/.planchunk/core/templates/`.

## Steps

1. Read `RULES.md` and `FORMAT.md`.
2. Read the repo's AGENTS.md and CLAUDE.md. Read `plans/KNOWLEDGE.md` if it exists.
3. Ask the user short questions only if the goal, limits, or success checks are unclear. Read the code that the goal touches.
4. Pick a slug. If `plans/<slug>/` exists, stop and ask.
5. Draft the chunk table (ID, title, repo, depends on, outcome). Check:
   - Each chunk fits one session (5 to 10 steps, a few files).
   - Each chunk leaves the repo working.
   - Dependencies have a valid order.
6. Show the goal and the chunk table to the user. Wait for approval.
7. Write `PLAN.md` and one file per chunk from the templates. In each chunk:
   - List exact files and symbols under "Context needed".
   - Put the repo's real check commands under "Acceptance checks".
   - Add "Out of scope" so the session stays inside the chunk.
8. Create or update `plans/README.md` and, if missing, `plans/KNOWLEDGE.md`.
9. Tell the user: the plan path, the chunk count, and that the next step is `pc-next` in a fresh session.

Do not write source code. Do not commit.
