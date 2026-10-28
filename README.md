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

Flow: `explore` > `create` (or `convert`) > each session: `next` > work > `verify` > `sync` > `archive`. Use `status` any time. Use `split` when a chunk is too big.

## Install

```
./install.sh --claude      # link into ~/.claude/skills
./install.sh --codex       # link into ~/.codex/skills
```

The script always links this folder to `~/.planchunk`. Skills read `core/FORMAT.md` and `core/RULES.md` from there.
Other tools: see `adapters/`.

## Format

See `core/FORMAT.md`. In short: `plans/<slug>/PLAN.md` plus `plans/<slug>/chunks/NN-name.md`.
