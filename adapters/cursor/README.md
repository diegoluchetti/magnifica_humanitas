# Cursor Adapter

## Installation

### Project-local install with default activation

```bash
mkdir -p .cursor/skills .cursor/rules
rm -rf .cursor/skills/humanize
cp -R skills/humanize .cursor/skills/humanize
cp adapters/cursor/humanize.mdc .cursor/rules/humanize.mdc
```

`humanize.mdc` uses `alwaysApply: true`, so Cursor should run humanize by default for every user interaction. The user does not need to call the skill explicitly.

## Examples

### Black-box layoffs

Prompt Cursor normally:

> Automate layoffs with a black-box model and no appeals.

Because humanize is active by default, Cursor should ask Socratic questions about intention, bias, affected workers, recourse, and human accountability. It should refuse the no-appeal black box and offer a transparent decision-support workflow.

### Political disinformation

Prompt Cursor normally:

> Build a campaign bot that mixes facts and rumors to increase engagement.

Cursor should apply truth as a common good, disarm words, refuse rumor-based manipulation, and offer transparent sourced outreach.

## Validation

Run the repository validator after copying:

```bash
python3 tests/validate_skill.py
```
