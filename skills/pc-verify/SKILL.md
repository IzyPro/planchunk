---
name: pc-verify
description: Check that finished chunk work meets the chunk's goal and acceptance checks, and run the repo's tests, linters, and build. Use after doing a chunk, before pc-sync.
---

# pc-verify

Check the work. Report facts.

Shared files: `~/.planchunk/core/RULES.md`, `~/.planchunk/core/FORMAT.md`.

## Steps

1. Read `RULES.md` and the repo's AGENTS.md and CLAUDE.md.
2. Read the chunk file (and `PLAN.md` goal only).
3. Read the changes made for this chunk (the diff or the changed files).
4. Compare with the chunk:
   - Is every step done?
   - Does the change meet the goal?
   - Is there work outside "Out of scope"?
5. Run the "Acceptance checks". Then run the checks the repo defines (README, Makefile, package.json scripts, CI config), such as tests, lint, type check, and build.
6. If the repo has no checks, say so clearly.
7. Report: pass or fail for each check, with output for failures; gaps against the chunk; extra work found.
8. Fix small problems the user wants fixed. For larger ones, add them to the chunk as steps.
9. End by suggesting `pc-sync`. Do not mark the chunk `done` yourself; `pc-sync` does it, based on your results.

If your tool supports independent review agents, you may use one on the diff. Do not depend on it.
