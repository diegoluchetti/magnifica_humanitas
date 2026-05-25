# Cursor Adapter

## Project-local install

```bash
mkdir -p .cursor/skills
cp -R skills/discerning-ai-with-magnifica-humanitas .cursor/skills/
```

Then ask Cursor:

> Use the discerning-ai-with-magnifica-humanitas skill for this AI product decision.

## Recommended project rule

Add a short project rule if your repository frequently touches AI, data, automation, persuasion, labor, education, governance, or safety:

```text
When a request may affect human dignity, truth, freedom, work, vulnerable people, political communication, surveillance, or AI governance, use the discerning-ai-with-magnifica-humanitas skill before implementation.
```

## Validation

Run the repository validator after copying:

```bash
python3 tests/validate_skill.py
```
