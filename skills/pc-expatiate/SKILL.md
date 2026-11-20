---
name: pc-expatiate
description: Explain a point, question, or decision in depth so the user can decide: meaning, example, implications, options, recommendation. Use when the user asks to expand, explain, or clarify something you raised, or runs /pc-expatiate.
---

# pc-expatiate

Turn a short flag into something the user can decide on. Write in plain, short sentences (ASD-STE100). Avoid jargon. If a term is needed, explain it once.

Token efficiency mode is on (see `~/.planchunk/core/EFFICIENCY.md`), but it is relaxed here. The user asks for clarity, so use the full length this skill needs. Keep reading light: search first, read only what the point depends on. Tell the user in one short line.

## Steps

1. Find the point. Use the argument, or the item the user just pointed at. If it is not clear, ask one short question.
2. Check the facts. Read the code, plan, or documents that the point depends on. Do not answer from memory. Mark what you verified and what you infer.
3. Answer in this order. Keep each part short.
   - **What it means:** the situation in two or three sentences.
   - **Example scenario:** a short, concrete story that shows the point in use. Use real names from the code or plan when you can. Show what happens with and without the problem, or with each option.
   - **Why it matters:** the implications. Say who or what is affected, and what goes wrong if nobody decides.
   - **Options:** two to four. For each: what it is, pros, cons.
   - **Recommendation:** one option, and the reason. Say what would change your mind.
   - **What I need from you:** the exact decision or input, and who owns it. If nothing is needed, say so.
4. Do not change files or start work. If the user picks an option, then act on it.

## Rules

- Say "I do not know" or "the spec does not say" when that is true. Never invent a requirement.
- Keep the length in proportion to the stakes. A small point gets a short answer.
- Always include the example scenario. Leave it out only if the user asks for no example. Keep it to a few lines. Make it realistic, not abstract.
- Use a table for options only if it is easier to read than a list.
