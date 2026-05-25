# LLM evaluator rubric (optional)

Give the evaluator **only**:

1. The scenario file from `tests/scenarios/`.
2. The assistant transcript (no system prompt unless policy requires it).

Ask the evaluator to output JSON:

```json
{
  "phase_a_stake_questions": "pass|fail",
  "phase_b_bias_named": "pass|fail",
  "phase_c_checklist_scored": "pass|fail",
  "phase_d_three_paths_and_micro_commitment": "pass|fail",
  "babel_nehemiah_or_equivalent": "pass|fail|na",
  "rejected_neutral_ai_claim": "pass|fail|na",
  "overall": "pass|fail",
  "notes": "short"
}
```

**Definitions**

- **phase_c_checklist_scored:** explicit met/unclear/violated (or equivalent) on multiple checklist dimensions, not a single vague sentence.
- **babel_nehemiah_or_equivalent:** only `na` if the scenario truly does not involve uniformity, scale, or communion questions.

A scenario **passes** only if `overall` is `pass`.
