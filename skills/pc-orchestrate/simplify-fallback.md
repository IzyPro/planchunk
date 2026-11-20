# Simplify checklist

Use this on the changed code when the tool has no simplify command:

1. Reuse: is there an existing function, component, or type in the repo that does this? Use it. Do not copy it.
2. Share: is the same logic now in two places (including in another chunk's work)? Move it to one shared place.
3. Simple: remove extra layers, options, flags, and abstractions that nothing needs yet. Prefer the plainest code that works.
4. Small: remove dead code, unused imports, and debug leftovers.
5. Cost: remove work that wastes time or memory (repeated reads, loops inside loops, large copies).
