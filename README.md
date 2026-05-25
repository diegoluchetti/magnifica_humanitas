# Magnifica Humanitas skill for AI assistants

Portable **agent skill** that applies Pope Leo XIV’s encyclical [*Magnifica Humanitas*](https://www.vatican.va/content/leo-xiv/en/encyclicals/documents/20260515-magnifica-humanitas.html) as an **orienting law** for engineering and governance choices around artificial intelligence—using a **Socratic** sequence to surface bias and intention, then guiding decisions against a concise checklist grounded in the text.

This repository is tooling and summary; it **does not** replace the Vatican document, pastors, or professional advisors.

## Contents

| Path | Purpose |
|------|---------|
| `skills/guiding-with-magnifica-humanitas/SKILL.md` | Skill entrypoint (load this into your agent) |
| `skills/guiding-with-magnifica-humanitas/references/mh-discernment-checklist.md` | Operational criteria mapped to encyclical themes |
| `scripts/validate-skill.sh` | Structural validation (frontmatter, links, scenarios) |
| `tests/scenarios/` | Behavioral pressure scenarios + pass/fail rubrics |
| `docs/install-*.md` | Cursor, Claude Code, Codex install notes |
| `VALIDATION.md` | What “validated” means here |

## Quick start

```bash
git clone <your-fork-or-this-repo>.git
cd magnifica_humanitas
bash scripts/validate-skill.sh
```

Then follow **`docs/install-cursor.md`**, **`docs/install-claude-code.md`**, or **`docs/install-codex.md`**.

## Why this exists

Emerging AI systems embed power, narrative, and non-neutral values. *Magnifica Humanitas* names the fork between **Babel** (uniformity, pride, efficiency without communion) and **Nehemiah** (shared responsibility, subsidiarity, rebuilding relationships). The skill makes that fork **actionable** in product and research conversations.

## Tests

- **Structural:** `bash scripts/validate-skill.sh` (also runs in GitHub Actions).
- **Behavioral:** see `tests/README.md` and `tests/scenarios/*.md` for RED/GREEN expectations; use human review or an **LLM-as-judge** with the rubric in `tests/evaluator-rubric.md`.

## License

The skill text and scripts are licensed under **MIT** (`LICENSE`). Magisterial documents remain under their respective publishers; link and cite the Vatican source when quoting.

## Contributing

See `CONTRIBUTING.md`.
