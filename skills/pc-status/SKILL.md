---
name: pc-status
description: Show progress across all plans in the repo (or one plan) and what to run next. Use when the user asks where things stand, what is left, or which chunk is next.
---

# pc-status

Give a short, true picture of the plans. Read only. Change nothing.

Shared files: `~/.planchunk/core/RULES.md`, `~/.planchunk/core/FORMAT.md`.

## Steps

1. Read `RULES.md` and the repo's AGENTS.md and CLAUDE.md.
2. List the folders in `plans/` (not `archive/`). If the user names a plan, use only that one.
3. For each plan, read only its `PLAN.md` chunk table. Do not read chunk files, except to check a status that looks wrong.
4. Report per plan: title, chunks done of total, chunks `in-progress`, chunks `blocked` (and why), and the next chunk that can start.
5. Flag problems:
   - The table and a chunk file disagree on status.
   - A chunk is `in-progress` with no recent change log entry.
   - A `todo` chunk depends on a chunk that is not `done`.
   - A chunk's `Repo` is different from the current repo.
6. Suggest the next skill: `pc-next` for the next chunk, `pc-sync` to fix mismatches, `pc-archive` if all chunks are done.

Keep the report short. Do not edit any file.
