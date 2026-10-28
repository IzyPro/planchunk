---
name: pc-next
description: Start a work session on the next chunk of a plan. Loads only the plan summary and one chunk, so the session stays small. Use at the start of a fresh session when a planchunk plan exists.
---

# pc-next

Start one session on one chunk. Keep context small.

Shared files: `~/.planchunk/core/RULES.md`, `~/.planchunk/core/FORMAT.md`.

## Steps

1. Read `RULES.md`. Read the repo's AGENTS.md and CLAUDE.md.
2. Find the plan: `plans/<slug>/PLAN.md`. If there are many, use the one the user names, or list them and ask.
3. Read `PLAN.md`. Do not read other chunks yet.
4. Pick the chunk: the one the user names, else the first `todo` chunk whose dependencies are `done`. Do not pick an `in-progress` chunk unless the user names it: another session may own it. If none can start, say why (blocked, or all done), and list any `in-progress` chunks.
5. If the chunk's `Repo` is not the current repo, tell the user to open the session in that repo. Stop.
6. Read the chunk file. Read only the files listed in "Context needed".
7. Set the chunk status to `in-progress` (chunk file and plan table).
8. Tell the user in a few lines: the plan goal, this chunk's goal, the steps, the acceptance checks, and what is out of scope.
9. Do the work in the chunk. Stay inside its scope. If you find work outside it, note it for `pc-sync`. Do not do it now.
10. When the steps are done, suggest `pc-verify`, then `pc-sync`.

Use the previous chunk's handoff notes if the chunk depends on it. Read nothing else from the plan.
