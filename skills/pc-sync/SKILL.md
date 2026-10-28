---
name: pc-sync
description: Update the plan files so they match the real state of the work. Use at the end of a session (or during it) to tick steps, set chunk status, write handoff notes, and log changes. Edits only plan files.
---

# pc-sync

Keep the plan true. Run this at the end of every working session.

Shared files: `~/.planchunk/core/RULES.md`, `~/.planchunk/core/FORMAT.md`.

## Steps

1. Read `RULES.md` and the repo's AGENTS.md and CLAUDE.md.
2. Find the active plan and chunk (the one in progress, or the one the user names). Read `PLAN.md` and that chunk.
3. Compare the chunk with the real work. Use what you did in this session and the repo state (changed files, check results). Do not guess.
4. Update the chunk file:
   - Tick finished steps. Add steps that appeared.
   - Set `Status`. Use `done` only if the acceptance checks ran and passed in this session. If they were not run, use `in-progress` and say so.
   - Write "Handoff notes": what changed, what is left, what the next chunk must know. Keep it short.
5. Update `PLAN.md`:
   - Make the chunk table match the chunk files.
   - Add new decisions (with the reason), open questions, or new chunks found during the work.
   - Add one line to the change log with the date.
6. If a later chunk is now wrong (new facts, changed paths), fix its "Context needed" or flag it.
7. Update `plans/README.md` counts.
8. Report in a few lines: what changed in the plan, the new chunk status, and the next chunk.

Edit only files under `plans/`. Do not edit source code. Do not commit.
