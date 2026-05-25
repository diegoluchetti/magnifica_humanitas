# Validation report: `guiding-with-magnifica-humanitas`

## Automated checks

| Check | Command | Passing condition |
|-------|---------|-------------------|
| Frontmatter shape | `bash scripts/validate-skill.sh` | YAML `name` / `description`; `description` begins with `Use when`; frontmatter body ≤ 1024 chars; Vatican URL present |
| Required sections | same script | Markers: Socratic protocol, Red flags, Rationalizations, `lex orientativa` |
| Reference link | same script | Checklist links Vatican URL |
| Scenario corpus | same script | At least one `tests/scenarios/*.md` |

## Behavioral validation (human or LLM-as-judge)

See `tests/README.md`. **RED baseline** (model without skill) should commonly exhibit: solutionism, “neutral AI,” skipped stakeholder analysis, no Babel/Nehemiah frame. **GREEN** (with skill) should exhibit ordered phases A–D, checklist scoring, three-path decision, micro-commitment.

## Manual editorial checks

- [ ] Encyclical claims that are non-obvious are either quoted from Vatican text or clearly marked as summary.
- [ ] No promise that an AI assistant replaces pastors, lawyers, or clinicians.
- [ ] Tone matches MH: frank, non-humiliating, neither hype nor panic.

## Definition of done for releases

1. `bash scripts/validate-skill.sh` exits 0 on CI.
2. At least **two** scenario files updated for any material skill edit.
3. Maintainer re-runs **one** full behavioral transcript test and archives the log in issue/PR (optional but recommended).
