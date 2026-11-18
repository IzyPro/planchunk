## Planning with planchunk

Plans live in `plans/<slug>/` (see `~/.planchunk/core/FORMAT.md`).
When the user asks to explore, create, convert, sync, continue, verify, archive, split, check the status of a plan, explain an open point or decision in depth, or run a whole plan,
read and follow the matching file in `~/.planchunk/skills/`:
`pc-explore`, `pc-create`, `pc-convert`, `pc-sync`, `pc-next`, `pc-verify`, `pc-archive`, `pc-status`, `pc-split`, and `pc-expatiate` (explain a point so the user can decide; it changes no files), and `pc-orchestrate` (run all chunks with agents; the user picks manual, auto, or sleep mode).
Work on one chunk per session. Run `pc-sync` at the end of the session.
