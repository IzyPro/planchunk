# planchunk

Skills that split a large plan into small chunks. Each chunk runs in one fresh session. A short `PLAN.md` keeps the overall goal, so no session loses it.

The skills are plain Markdown. They work in any repo and with any agent that can read files. They always follow the repo's own AGENTS.md and CLAUDE.md.

## Skills

| Skill | Use it to |
|-------|-----------|
| `pc-explore` | Think through an idea before a plan exists |
| `pc-create` | Make a new plan with chunks |
| `pc-convert` | Turn an existing plan into the chunk format |
| `pc-next` | Start a session on the next chunk |
| `pc-verify` | Check the chunk and run the repo's checks |
| `pc-sync` | Update the plan to match the real work (end of every session) |
| `pc-archive` | Close a finished plan and keep lasting decisions |
| `pc-status` | See progress across plans and what to run next |
| `pc-split` | Split a chunk that is too big |
| `pc-expatiate` | Explain a point, risk or open question in depth, with an example scenario, options and a recommendation, so you can decide |
| `pc-orchestrate` | Run a whole plan: one agent per chunk, in parallel by default (sequential if you ask), with check-ins, verification and a decision log (manual, auto or sleep mode) |

Token efficiency mode is on by default in every skill (short replies, light reads, the cheaper model for agents). The advisor is never limited. Say "efficiency off" to turn it off. `pc-orchestrate` asks about it at start-up. `pc-expatiate` keeps its full length. See `core/EFFICIENCY.md`.

Flow: `explore` > `create` (or `convert`) > each session: `next` > work > `verify` > `sync` > `archive`. Use `status` any time. Use `split` when a chunk is too big. Use `orchestrate` to run all chunks without starting each session by hand.

## Install

```
./install.sh --claude      # link into ~/.claude/skills
./install.sh --codex       # link into ~/.codex/skills
```

The script always links this folder to `~/.planchunk`. Skills read `core/FORMAT.md` and `core/RULES.md` from there.
Other tools: see `adapters/`.

## Format

See `core/FORMAT.md`. In short: `plans/<slug>/PLAN.md` plus `plans/<slug>/chunks/NN-name.md`.
