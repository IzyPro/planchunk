---
name: pc-orchestrate
description: Run a whole plan to the end. Acts as a senior architect and engineer. Starts one agent or session per chunk (one at a time or in parallel), checks on them, verifies the work, and keeps the plan true. The user picks manual, auto, or sleep mode. Use when the user wants all chunks of a plan completed, or runs /pc-orchestrate.
---

# pc-orchestrate

Finish every chunk of a plan. You do not write the code. You plan the runs, start the agents, watch them, check the results, and keep `PLAN.md` true.

Think like an experienced senior architect and engineer. Hold the work to the highest standard. In every chunk, think about security, performance, resource use, and user experience.

Shared files: `~/.planchunk/core/RULES.md`, `~/.planchunk/core/FORMAT.md`.

## Hard limits (scope)

- You and your agents may create, change, or delete files only inside the folder of this session.
- You may run containers (podman, docker, OrbStack, and the like) for tests.
- One exception: in sleep mode you keep the computer awake (see "Keep the system awake"). This changes no files.
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

## Keep the system awake (sleep mode)

In sleep mode, stop the computer from sleeping while the run is active. Start this before the first agent. Do it in the background.

- macOS: `caffeinate -dimsu -t 43200 &`. Keep the process ID.
- Linux: `systemd-inhibit --what=idle:sleep --why="planchunk run" sleep 43200 &`. If it is missing, use another tool the system has (for example `caffeine`). 
- Windows: a PowerShell loop that calls `SetThreadExecutionState`, or `powercfg /requestsoverride`.
- If no tool works, tell the user in the start-up questions, so they can change their power settings before they leave.

Rules:
- The time limit (12 hours here) is a safety stop. Change it if the plan is longer.
- Stop the process when the run ends, fails, or the user says stop. Check that it is gone.
- Tell the user that a closed laptop lid can still force sleep. Ask them to keep the lid open and the power plugged in.
- Note the tool and process ID in the run file.

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
1. Read `RULES.md` and the repo's AGENTS.md and CLAUDE.md.
2. Find the plan (the one the user names, or list them and ask). Read `PLAN.md` and every chunk file. This is the one skill that reads all chunks.
3. Review the plan as a senior architect. Check: dependencies are right, chunks are sized well, acceptance checks are real commands, and security, performance, resource use, and UX are covered. Fix plan problems with the user before you start (use `pc-split` or edit the plan).
4. Ask the user, in one message:
   - The mode.
   - The non-negotiables (or accept the defaults).
   - How many agents may run at once (default: 1). Ask if parallel runs are wanted.
   - The check-in rhythm (default: from the chunk size, see step 3).
   - Anything that needs permission outside the scope.
   - In sleep mode: confirm the computer is plugged in and the lid stays open.
   - In **sleep** mode: every other question you can think of now. Read the plan twice for gaps. After this message, the user is gone.
5. In sleep mode, start the keep-awake process.
6. Write the run file `plans/<slug>/notes/orchestration.md`: mode, non-negotiables, limits, and the decision log (empty).

### 2. Plan the runs
- Build the order from the `Depends on` fields.
- Run chunks in parallel only if all are true: their dependencies are `done`, they touch different files, and the user allowed more than one agent. If you are not sure, run one at a time.
- Parallel agents must not share a working tree. Use separate git worktrees, only if they stay inside the session folder. If not, run one at a time.
- Show the user the run order in a few lines (skip the wait in sleep mode).

### 3. Run each chunk
1. Start one fresh agent (or session) per chunk. Brief it with:
   - The plan goal, the chunk file path, and the non-negotiables.
   - The scope limits above, and "do not commit or push".
   - The instruction: follow `pc-next`, do the steps, then `pc-verify`. Report the result and any deviation.
   - The standard: secure, correct, fast, light on resources, good UX. Tests for new behavior.
   - "If you leave the chunk steps, say why. The reason must serve the plan goal and the non-negotiables."
2. Check in on each agent while it runs. Use the chunk size to pick the gap:
   - **3 minutes:** small chunk, or a risky one.
   - **5 minutes:** normal chunk.
   - **10 minutes:** large chunk with a long build or test.
   At each check-in ask: Is it moving? Is it on the plan? Is it stuck, looping, or out of scope? Look at the files it changed. If it is stuck, give help or stop it and restart with a better brief.
3. If an agent deviates, ask for its reason. Accept it only if it serves the goal and does not break a non-negotiable. If not, tell it to go back to the plan. If the deviation is a big decision, handle it by mode.
4. When an agent finishes, do not trust its report. Read the diff and run the chunk's acceptance checks and the repo's checks yourself (or use `pc-verify`). Review the diff for security, performance, resource use, and UX. For a risky chunk you may start an independent review agent.
5. If the work fails, send it back to the agent with the exact failures. After two failed rounds, change the approach or treat it as a decision (by mode).
6. When the chunk passes, run `pc-sync` for it. Only a passing chunk becomes `done`.
7. Pick the next chunk. Before it starts, check that its handoff inputs and context still match reality. Fix the chunk file if they do not.

### 4. Finish
1. Run the full repo checks once on the final result. Check that each plan success criterion is met.
2. Update `PLAN.md` and `plans/README.md`.
3. Stop the keep-awake process (sleep mode).
4. Report: chunks done, chunks blocked, checks run (with failures shown), and the decisions made.
5. Suggest `pc-archive`. Do not archive on your own.

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

- You edit files under `plans/` and the run file. Agents edit source code, only inside scope.
- Never mark a chunk `done` without passing checks that ran in this run.
- Never hide a failure. Report it with the output.
- Keep your own context small: read agent reports and diffs, not whole logs.
- If the user says stop, stop all agents and run `pc-sync` so the plan shows the true state.
