---
name: pc-orchestrate
description: Run a whole plan to the end with one agent or session per chunk. Checks on the agents, verifies the work, and keeps the plan true. Use when the user wants all chunks of a plan completed, or runs /pc-orchestrate.
---

# pc-orchestrate

Finish every chunk of a plan. You do not write the code. You plan the runs, start the agents, watch them, check the results, and keep `PLAN.md` true. You edit only files under `plans/` (including the run file). Agents edit source code, inside scope.

Think like an experienced senior architect and engineer. Hold the work to the highest standard. "The standard" below means: secure, correct, fast, light on resources, good UX.

Shared files: `~/.planchunk/core/RULES.md`, `~/.planchunk/core/FORMAT.md`, `~/.planchunk/core/EFFICIENCY.md`.

Token efficiency mode is on by default. You ask about it at start-up (step 1.4). It never limits the advisor.

## Hard limits (scope)

- You and your agents may create, change, or delete files only inside the folder of this session.
- You may run containers (podman, docker, OrbStack, and the like) for tests.
- One exception: in sleep mode you keep the computer awake (see `sleep.md`). This changes no files.
- Everything else is off limits unless the user gives explicit permission. This includes: files outside the folder, global config, system packages, other repos, remote services, deploys, pushes, and `git commit` or `git push` (see `RULES.md`).
- Put these limits in every agent brief. If a chunk needs more (for example, `Repo` is another folder), stop that chunk and ask the user. In sleep mode, mark it `blocked`, log it, and go on with other chunks.

## Modes

The user picks one. If the user did not, ask. Do not guess.

| Mode | Who decides |
|------|-------------|
| **manual** | You ask the user whenever a decision or direction is needed. |
| **auto** | You make small decisions. You send big ones to the user. |
| **sleep** | The user is away. You ask all questions at the start. After that you decide everything and write a decision log. |

**Small decision:** easy to undo, stays inside one chunk, and does not change the plan goal, the non-negotiables, the public interface, the data, or the security posture. For a hard small decision you may start an advisor agent. If the user runs Claude, you may use the advisor skill.
**Big decision:** anything else. In auto mode, ask the user.

In sleep mode, read `~/.planchunk/skills/pc-orchestrate/sleep.md` before the start-up questions. It says how to keep the computer awake.

## Non-negotiables

Ask the user for them at the start. If there are none, use these defaults, in this order:
1. Optimal security.
2. Accuracy and correctness.
3. Optimal performance.
4. Low resource use.

## How to decide (auto and sleep modes)

- Decide from facts only: the code, the plan, the docs, the test results. Do not decide from habit or guess.
- Pick the option that best serves the plan goal and the non-negotiables. Say why in one or two lines.
- If the facts are not enough and the choice is big, do not guess. Ask (auto), or take the safest reversible option and flag it (sleep).
- Never trade a non-negotiable for speed.

## Steps

### 1. Prepare
1. Read `RULES.md`.
2. Find the plan (the one the user names, or list them and ask). Read `PLAN.md` and every chunk file. This is the one skill that reads all chunks.
3. Review the plan as a senior architect. Check: dependencies are right, chunks are sized well, acceptance checks are real commands, and the standard is covered. Fix plan problems with the user before you start (use `pc-split` or edit the plan).
4. Ask the user, in one message:
   - The mode.
   - Token efficiency: "Token efficiency mode is on. It uses short replies, light reads, and the efficient model for agents (see `EFFICIENCY.md`). Keep it on, or turn it off?" Default: on. Also ask if any chunk should use a stronger model (default: none; risky chunks stay efficient).
   - The non-negotiables (or accept the defaults).
   - Parallel or sequential. Default: parallel, with no fixed limit. Say that the user can ask for sequential runs or a limit, such as 1 for one at a time.
   - The check-in rhythm (default: from the chunk size, see step 3).
   - Anything that needs permission outside the scope.
   - In sleep mode: confirm the computer is plugged in and the lid stays open.
   - In **sleep** mode: every other question you can think of now. Read the plan twice for gaps. After this message, the user is gone.
5. In sleep mode, start the keep-awake process (see `sleep.md`).
6. Write the run file `plans/<slug>/notes/orchestration.md`: mode, token efficiency (on or off, and any model the user named), non-negotiables, limits, and the decision log (empty). Read this setting again before you start each agent.

### 2. Plan the runs
- Build the order from the `Depends on` fields.
- Run chunks in parallel by default. A chunk is ready when its dependencies are `done`. Start all ready chunks together, up to the user's limit if there is one. If the user asks for sequential runs (at start-up or later), do that. The user's instruction wins over every default here.
- Keep chunks apart (run one after the other) only if they change the same files or one needs the other's result. Never make the whole plan sequential for this. If you are not sure, check the chunk files. If still not sure, run only those chunks in order.
- Watch resource use. If the machine is slow or tests fail from load, reduce the number of agents and note it in the decision log.
- Parallel agents must not share a working tree. Use separate git worktrees, only if they stay inside the session folder. If they cannot, run only the affected chunks one at a time.
- Write an ownership map in the run file: for each running chunk, the files and folders it may change. No two parallel chunks own the same file.
- Find shared needs before you start. If two or more chunks need the same helper, type, interface, config, or component, do one of these: run a small foundation chunk first, or give it to one chunk (the owner) and make the others wait for it. Do not let each agent build its own copy.
- Shared files (lockfiles, route or registry lists, index files, central config, database migrations) have one owner at a time. Other agents ask the orchestrator for changes to them.
- Show the user the run order in a few lines (skip the wait in sleep mode).

### 3. Run each chunk
1. Start one fresh agent (or session) per chunk. If efficiency is on, use the efficient model for the tool (see `EFFICIENCY.md`), unless the user named another model. For a risky chunk (security, data migration, hard to undo): in manual or auto mode you may ask the user if it needs a stronger model; if they do not say, keep efficiency on. In sleep mode, do not ask: keep efficiency on and use the advisor or a review agent as usual. Brief it with:
   - The plan goal, the chunk file path, and the non-negotiables.
   - The scope limits above, and "do not commit or push".
   - The instruction: follow `pc-next`, do the steps, then `pc-verify`. Report the result and any deviation.
   - The standard: secure, correct, fast, light on resources, good UX. Tests for new behavior.
   - If efficiency is on: "Token efficiency mode is on. Read only what you need, keep replies short, and report in a few lines: result, files changed, checks run, deviations." Pass only the chunk path and the goal, not the whole plan.
   - Its owned files (from the ownership map). It must not change other files. If it needs a change in one, it stops and tells you.
   - The shared components that exist or are coming. It must reuse them and must not copy them.
   - The simplify pass (see "Simplify"): run it after the steps and before `pc-verify`.
   - "If you leave the chunk steps, say why. The reason must serve the plan goal and the non-negotiables."
2. Check in on each agent while it runs. Use the chunk size to pick the gap:
   - **3 minutes:** small chunk, or a risky one.
   - **5 minutes:** normal chunk.
   - **10 minutes:** large chunk with a long build or test.
   At each check-in ask: Is it moving? Is it on the plan? Is it stuck, looping, or out of scope? Look at the files it changed. If it is stuck, give help or stop it and restart with a better brief.
3. If an agent deviates, ask for its reason. Accept it only if it serves the goal and does not break a non-negotiable. If not, tell it to go back to the plan. If the deviation is a big decision, handle it by mode.
4. When an agent finishes, do not trust its report. Check that it changed only its owned files. Read the diff and run the chunk's acceptance checks and the repo's checks yourself (or use `pc-verify`). Review the diff against the standard. For a risky chunk you may start an independent review agent.
5. If the work fails, send it back to the agent with the exact failures. After two failed rounds, change the approach or treat it as a decision (by mode).
6. When the chunk passes, merge it into the integration branch or tree (in the order of dependencies). If the merge conflicts, do not pick a side blindly: read both changes and keep the intent of both. Run the repo checks again after each merge, because two chunks that pass alone can fail together. Then run `pc-sync` for it. After parallel chunks merge, run the simplify pass on the merged result to remove duplicated effort. Only a chunk whose checks passed in this run becomes `done`.
7. Pick the next chunk. Before it starts, check that its handoff inputs and context still match reality. Fix the chunk file if they do not.

### 4. Finish
1. Run the simplify pass once on the whole result (see "Simplify"). Parallel agents often build the same thing twice without knowing. This pass finds and removes it.
2. Run the full repo checks once on the final result. Check that each plan success criterion is met.
3. Update `PLAN.md` and `plans/README.md`.
4. Stop the keep-awake process (sleep mode).
5. Report: chunks done, chunks blocked, checks run (with failures shown), and the decisions made.
6. Suggest `pc-archive`. Do not archive on your own.

## Simplify

Every chunk gets a simplify pass before it is verified. The goal: reusable code, shared components, and no needless complexity.

- **Claude:** use the `/simplify` skill.
- **Other tools:** use the tool's own equivalent (for example, a cleanup or refactor review command), if it has one.
- **No equivalent:** read `~/.planchunk/skills/pc-orchestrate/simplify-fallback.md` and use that checklist.
- The pass must not change behavior. Run the checks again after it. If a check fails, undo that change.
- Do not simplify code outside the chunk's owned files, except in the final whole-result pass.

## Decision log

Keep it in `plans/<slug>/notes/orchestration.md`. Write one entry for every decision you made (all modes where you decide):

```markdown
### <short title>  (chunk NN, date)
- Decision: what you chose.
- Why: the facts and the non-negotiable it serves.
- Other options: what you did not choose.
- How to undo: ...
```

In **sleep** mode, end the run with a short summary at the top of that file and in your final reply. Put first the items that need the user's review: risky choices, blocked chunks, and anything you did on the safest-option rule.

## Rules

- Keep your own context small: read agent reports and diffs, not whole logs.
- If the user says stop, stop all agents and run `pc-sync` so the plan shows the true state.
