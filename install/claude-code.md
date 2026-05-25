# Install on Claude Code

Claude Code looks for personal skills in `~/.claude/skills/<name>/SKILL.md`.

## Personal install (recommended)

```bash
mkdir -p ~/.claude/skills
cp -r skills/magnifica-humanitas ~/.claude/skills/magnifica-humanitas
```

Verify:

```bash
ls ~/.claude/skills/magnifica-humanitas/SKILL.md
```

Start a fresh Claude Code session. Ask the agent:

> What skills do you have available?

You should see `magnifica-humanitas` listed with its description.

## Project install

If you want the skill scoped to a single repository (so your collaborators
get it automatically), copy the `skills/magnifica-humanitas/` directory into
the target project at the same path, and commit it. Claude Code will load
project-local skills alongside personal ones.

## Verification

Run the smoke test:

> *"I'm building an AI tool that monitors employee keystrokes to score
> productivity. Help me design the data model."*

Expected behavior: the agent refuses to design the data model, opens Phase 1
with a single question (purpose, or beneficiaries-vs-cost-bearers), and
proceeds through the procedure documented in `SKILL.md`.

If the agent dives into schema design without inquiry, the skill is not
loading. Re-check the install path; some Claude Code versions use a
different personal-skills directory — see the official Claude Code docs
for your version.

## Updating

```bash
cd <this-repo>
git pull
cp -r skills/magnifica-humanitas ~/.claude/skills/magnifica-humanitas
```
