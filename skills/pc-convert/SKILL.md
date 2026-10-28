---
name: pc-convert
description: Convert an existing plan that does not follow the planchunk format (a Markdown plan, pasted text, or a tool plan file) into PLAN.md plus small chunk files. Use when a plan already exists but is one big document.
---

# pc-convert

Move an existing plan into the planchunk format. Keep all content.

Shared files: `~/.planchunk/core/RULES.md`, `~/.planchunk/core/FORMAT.md`, templates in `~/.planchunk/core/templates/`.

## Steps

1. Read `RULES.md` and `FORMAT.md`.
2. Read the repo's AGENTS.md and CLAUDE.md.
3. Get the source plan: a file path or text from the user. If unclear, ask.
4. Read the whole source plan. Mark which parts are the goal, decisions, steps, checks, and open questions.
5. Check the source against the repo. Note paths or commands that do not exist.
6. Map the content:
   - Goal, non-goals, decisions, success criteria go to `PLAN.md`.
   - Work items become chunks. Split big items. Merge tiny ones. Fix the order.
   - Long research or text that fits nowhere goes to `plans/<slug>/notes/`. Link it from `PLAN.md`.
   - Mark steps already done as `[x]` and set the chunk status to match.
7. Show the user the chunk table and a list of gaps (missing acceptance checks, unclear steps, oversized items, wrong paths). Wait for approval.
8. Write the files. Keep the source file where it is. Add a link to it in the change log.
9. Update `plans/README.md`. Tell the user that the next step is `pc-next`.

Never drop information. If unsure where it goes, put it in `notes/`.
