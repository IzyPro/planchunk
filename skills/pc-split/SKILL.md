---
name: pc-split
description: Split a chunk that is too big into two or more smaller chunks and renumber the plan. Use when a chunk will not fit in one session, or when a session is running out of room.
---

# pc-split

Make a chunk smaller without losing work or order.

Shared files: `~/.planchunk/core/RULES.md`, `~/.planchunk/core/FORMAT.md`, `~/.planchunk/core/templates/chunk.md`.

## Steps

1. Read `RULES.md` and the repo's AGENTS.md and CLAUDE.md.
2. Read `PLAN.md` and the chunk to split (the one the user names, else the `in-progress` chunk).
3. Find the split points. Each new chunk must:
   - Have 5 to 10 steps at most and one clear result.
   - Leave the repo working (checks pass).
   - Keep the dependency order.
4. If the chunk is `in-progress`, put the steps already done (`[x]`) in the first new chunk and mark it `done` only if its checks passed. Put the rest in the later chunks.
5. Show the user the new chunk table rows and which steps go where. Wait for approval.
6. Write the new chunk files from the template. Give each one its own context, acceptance checks, and out of scope. Copy the handoff notes to the chunk they belong to.
7. Renumber later chunks if needed. Fix `Depends on`, `Unblocks`, and every link. Do not leave two chunks with the same ID.
8. Update the chunk table in `PLAN.md`. Add a change log line: what was split and why.
9. Tell the user the new chunks and that the next step is `pc-next`.

Do not edit source code. Do not drop steps or notes. Do not commit.
