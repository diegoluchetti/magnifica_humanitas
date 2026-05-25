# Contributing

Thank you for considering a contribution to this repository. The skill at
its core enforces a discipline; contributions are held to the same
discipline.

## The Iron Law

> No skill change without a failing test first.

This applies to **every** edit to:

- `skills/magnifica-humanitas/SKILL.md`
- `skills/magnifica-humanitas/references/*.md`
- `.cursor/rules/magnifica-humanitas.mdc`
- `AGENTS.md`

It applies even to "small" changes ("just adding a section,"
"just rewording a paragraph," "just fixing a typo in the rubric"). The
methodology is described in `skills/magnifica-humanitas/tests/README.md`.

## Workflow for a change

1. **Open an issue** describing the problem you observed. Ideally:
   include the RED-baseline transcript that motivated the change.
2. **Branch.** Use a descriptive name (`fix/scenario-04-classification-loophole`).
3. **Add or update a failing test.** Either:
   - Add a new scenario in `skills/magnifica-humanitas/tests/` covering
     the gap, OR
   - Update an existing scenario's pressure-script with the new
     rationalization that broke the skill.
4. **Run the baseline (RED).** Confirm the new test fails without your
   skill change. Record the transcript.
5. **Make the minimal skill change.** Just enough to address the
   specific rationalization or gap surfaced by the test.
6. **Run with the skill change (GREEN).** Confirm the test passes.
   Record the transcript.
7. **Re-run the full suite.** No regressions on the other seven
   scenarios.
8. **Submit a PR.** In the description, include both transcripts and
   the rubric scores.

## Style

- Tone: charitable, clear, frank (§14). The skill instructs the agent
  to refuse humiliating or antagonistic words; the same applies to the
  documentation that teaches it.
- Citations: when invoking the encyclical, cite the section number.
  Quotes must be verbatim and verifiable against the Vatican URL in
  `references/encyclical-excerpts.md`.
- No invented quotes. If a sentence sounds like the encyclical but isn't,
  remove it or label it as paraphrase.

## What is in scope

- Closing rationalization loopholes surfaced by tests.
- Adding new scenarios that cover domains we don't yet stress
  (biometrics, immigration tech, autonomous vehicles, AI in medicine,
  AI in religious life, etc.).
- Improving cross-platform install instructions for Claude Code, Cursor,
  and Codex CLI as those platforms evolve.
- Translations of the skill into other languages.
- Mechanical fixes (broken links, typos in non-quoted prose, file paths).

## What is out of scope

- Diluting the Iron Rule into a "preference."
- Replacing chapter/section citations with paraphrases of "general AI
  ethics."
- Adding domain-specific exceptions ("but for military use we should
  consider…"). The encyclical is unambiguous in Ch. 5; the skill
  inherits that.
- Religious gatekeeping. The skill must remain accessible to
  *"all men and women of goodwill"* (§16).

## Code of conduct

Be the kind of contributor the encyclical describes in §13:

> *"No one can single-handedly bear the weight of the challenges the
> world is facing, just as no one is so weak that they cannot play
> their part."*

Each contributor gets a section of the wall. Build it well, and let
others build theirs.
