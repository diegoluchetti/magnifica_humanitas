# Claude Code Adapter

## Personal install

```bash
mkdir -p ~/.claude/skills
cp -R skills/discerning-ai-with-magnifica-humanitas ~/.claude/skills/
```

Claude Code should discover the skill from its frontmatter:

```yaml
name: discerning-ai-with-magnifica-humanitas
description: Use when AI, automation, data, product, governance, persuasion, labor, education, security, or political requests may affect human dignity, truth, freedom, work, vulnerable people, power, or the common good
```

## Suggested invocation

> Use discerning-ai-with-magnifica-humanitas before deciding whether to implement this AI workflow.

## Validation

Use the pressure scenarios in `tests/scenarios.json`. A good answer asks Socratic questions, applies the law gates, and offers a concrete humane reframe when needed.
