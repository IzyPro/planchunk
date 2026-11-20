# Claude Code

Run `./install.sh --claude`. This links each `skills/pc-*` folder into `~/.claude/skills`.
Use a skill by name, for example `/pc-create`, or ask for it in plain words.

Token efficiency mode is on by default. Agents started by `pc-orchestrate` use Sonnet 5.5 (`claude-sonnet-5-5`). The advisor is not affected. See `core/EFFICIENCY.md`.
