# Codex and other agents

Any agent that can read files can use the skills.

## Tools with a skills folder (SKILL.md format)

Run `./install.sh --codex` to link into `~/.codex/skills`. Check your tool's docs for the folder name.
If the folder differs, link `skills/pc-*` there by hand.

## Tools without skills

Add `AGENTS.snippet.md` to the repo's (or your global) AGENTS.md. Then ask the agent: "follow ~/.planchunk/skills/pc-next/SKILL.md".
