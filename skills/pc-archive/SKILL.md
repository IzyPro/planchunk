---
name: pc-archive
description: Close a finished plan. Confirms all chunks are done, moves lasting decisions into plans/KNOWLEDGE.md, and moves the plan to plans/archive/. Use when every chunk of a plan is done.
---

# pc-archive

Close a plan and keep what matters.

Shared files: `~/.planchunk/core/RULES.md`, `~/.planchunk/core/FORMAT.md`, `~/.planchunk/core/templates/KNOWLEDGE.md`.

## Steps

1. Read `RULES.md` and the repo's AGENTS.md and CLAUDE.md.
2. Read `PLAN.md`. Check that every chunk is `done` and the success criteria are met. If not, list what is open and stop. Ask the user whether to archive anyway.
3. Run the final checks (as in `pc-verify`) if they were not run since the last chunk.
4. Collect lasting facts from `PLAN.md` (key decisions) and from handoff notes (gotchas, conventions). Pick only what future work needs.
5. Show the user the entries you plan to add to `plans/KNOWLEDGE.md`. Wait for approval.
6. Add the entries with the date and the plan slug.
7. Move `plans/<slug>/` to `plans/archive/<YYYY-MM-DD>-<slug>/`.
8. Update `plans/README.md`.
9. Report what moved and what was added to KNOWLEDGE.md.

Do not delete anything. Do not commit.
