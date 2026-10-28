# Shared rules

Every planchunk skill follows these rules.

1. **Read project rules first.** Before you do anything else, read the AGENTS.md and CLAUDE.md in the repo root (and in the folder you work in). Also follow any global instructions your tool loads. These rules win over the skill's defaults.
2. **Write plain.** Use short, simple sentences (ASD-STE100 style). Say what and why first. Avoid jargon.
3. **Keep code comments rare.** Add a comment only for a non-obvious reason. One line.
4. **Save tokens.** Read `PLAN.md` and one chunk file. Do not read the other chunks unless the task needs them. Link to long material. Do not paste it.
5. **Do not invent.** Take file paths and commands from the repo. If the repo has no tests or checks, say so. Do not skip the step silently.
6. **Edit only what the skill owns.** Plan skills edit files in `plans/`. Only the user's own work session edits source code.
7. **Do not commit or push** unless the user asks.
8. **Report facts.** If a check fails or a step was skipped, say so with the output.
9. **Format.** All plan files follow `FORMAT.md` in this folder.
