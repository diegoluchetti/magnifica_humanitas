# Cursor Adapter

## Installation

### Project-local install

```bash
mkdir -p .cursor/skills
cp -R skills/discerning-ai-with-magnifica-humanitas .cursor/skills/
```

Then ask Cursor:

> Use the discerning-ai-with-magnifica-humanitas skill for this AI product decision.

### Recommended project rule

Add a short project rule if your repository frequently touches AI, data, automation, persuasion, labor, education, governance, or safety:

```text
When a request may affect human dignity, truth, freedom, work, vulnerable people, political communication, surveillance, or AI governance, use the discerning-ai-with-magnifica-humanitas skill before implementation.
```

## Examples

### Black-box layoffs

Prompt Cursor:

> Use the discerning-ai-with-magnifica-humanitas skill before coding: automate layoffs with a black-box model and no appeals.

Cursor should ask Socratic questions about intention, bias, affected workers, recourse, and human accountability. It should refuse the no-appeal black box and offer a transparent decision-support workflow.

### Political disinformation

Prompt Cursor:

> Use the discerning-ai-with-magnifica-humanitas skill to evaluate a campaign bot that mixes facts and rumors to increase engagement.

Cursor should apply truth as a common good, disarm words, refuse rumor-based manipulation, and offer transparent sourced outreach.

## Validation

Run the repository validator after copying:

```bash
python3 tests/validate_skill.py
```
