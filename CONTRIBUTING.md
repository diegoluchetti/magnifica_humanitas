# Contributing

Thank you for helping improve this skill.

## Principles

- Keep the human person at the center.
- Prefer concise guidance that agents can actually follow.
- Add or update pressure scenarios for every behavioral change.
- Cite *Magnifica Humanitas* by paragraph number when adding a new law gate.
- Do not copy large portions of the encyclical into this repository; summarize and link to the Vatican source.

## Development loop

1. Add or update a scenario in `tests/scenarios.json`.
2. Update `skills/discerning-ai-with-magnifica-humanitas/SKILL.md` or docs.
3. Run:

```bash
python3 tests/validate_skill.py
```

4. Manually test at least one scenario in an agent with the skill loaded.

## Style

- Be firm without humiliation.
- Use "refuse and reframe" for harmful requests.
- Make safeguards concrete: governance, auditability, recourse, participation, and human accountability.
