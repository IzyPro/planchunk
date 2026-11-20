# Token efficiency mode

This mode is **on by default** in every planchunk skill. It cuts token use without cutting the quality of the work.

Tell the user once, in one short line, at the start of the skill: "Token efficiency mode is on. Say 'efficiency off' to turn it off." Do not ask, except in `pc-orchestrate` (it asks at start-up).

## What it does

1. **Short replies.** Give the result first. Do not repeat the user's request. Do not recap work the user can see. Use a list or table only when it is shorter than prose.
2. **Read less.** Search first, then read only the parts you need. Read only the files that "Context needed" names. Do not re-read a file you already read in this session.
3. **Link, do not paste.** Point to a file path or line. Do not copy long text, logs, or diffs. Show only the lines that matter from command output.
4. **Cheaper model for agents.** When you start an agent or session, use the efficient model of the tool (see the table). Do not change the model of the user's own session.
5. **Small briefs.** Give an agent the chunk path, the goal, and the limits. Do not paste the whole plan.
6. **Short reports.** Ask agents to report in a few lines: result, files changed, checks run, deviations.

## What it never does

- It never lowers the advisor. Advisor calls and advisor agents run as before, on their normal model, wherever a skill or the user calls for them. They are outside this mode.
- It never skips a check, a verification step, or a non-negotiable to save tokens.
- It never hides a failure. Failures are reported with the relevant output.

## Efficient model by tool

| Tool | Model for agents in this mode |
|------|-------------------------------|
| Claude | Sonnet 5.5 (`claude-sonnet-5-5`) |
| OpenAI (GPT, Codex) | The smaller, cheaper tier of the current GPT family (for example, a "mini" model) |
| Qwen | A smaller or mid-size Qwen coder model |
| GLM | The lighter GLM tier (for example, an "Air" or "Flash" model) |
| Other | The cheaper mid-tier model that the tool offers |

If the tool cannot choose a model per agent, skip rule 4. Keep the other rules.

## Turning it off

The user can say "efficiency off" at any time. Then ignore this file for the rest of the session, except the "never" rules above. In `pc-orchestrate` the choice is saved in the run file (`plans/<slug>/notes/orchestration.md`), so every agent follows it.
