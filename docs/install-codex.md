# Install in OpenAI Codex / Codex-style agents

Codex and similar CLIs differ by distribution; the portable approach:

1. Vendor this repository as a submodule or subtree, or copy `skills/guiding-with-magnifica-humanitas/`.
2. Add an **AGENTS.md** (or your tool’s equivalent) rule: when triggers in the skill `description` match, prepend `skills/guiding-with-magnifica-humanitas/SKILL.md` to the agent context for that task.
3. Keep `references/mh-discernment-checklist.md` on the path so relative links from `SKILL.md` resolve.

Canonical text:  
https://www.vatican.va/content/leo-xiv/en/encyclicals/documents/20260515-magnifica-humanitas.html
