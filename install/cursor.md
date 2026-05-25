# Install on Cursor

Cursor supports two relevant mechanisms:

1. **Project Rules** (`.cursor/rules/*.mdc`) — auto-loaded for the workspace
   the file lives in. This repo ships
   `.cursor/rules/magnifica-humanitas.mdc` which acts as a trigger pointing
   the agent at the full skill in `skills/magnifica-humanitas/`.
2. **Skills directory** — the same `skills/magnifica-humanitas/` directory
   is loadable by Cursor's plugin/skills mechanism. Place it where your
   Cursor version expects.

## Project install (recommended)

Clone or copy this repo into your project, or vendor the two pieces:

```bash
# Inside your target project:
mkdir -p .cursor/rules skills
cp -r <this-repo>/.cursor/rules/magnifica-humanitas.mdc .cursor/rules/
cp -r <this-repo>/skills/magnifica-humanitas skills/
```

Commit both. Open the project in Cursor. The rule is auto-discovered;
because it is set `alwaysApply: false`, Cursor will surface it when the
description matches the current task.

## Personal install (every project)

To get the skill on every Cursor project on your machine, vendor the
`skills/magnifica-humanitas/` directory into your global Cursor skills
location. As of this writing Cursor reads from
`~/.cursor/plugins/cache/cursor-public/.../skills/` for the public skill
cache; the safest portable path is to clone this repository and add a
symlink:

```bash
git clone https://github.com/diegoluchetti/magnifica_humanitas \
    ~/code/magnifica_humanitas

ln -s ~/code/magnifica_humanitas/skills/magnifica-humanitas \
    ~/.cursor/skills/magnifica-humanitas    # adjust to your Cursor version
```

Then add a global Cursor rule (User Settings → Rules for AI) that says:

> When the user's request involves AI/ML/data systems that touch human
> beings, follow the skill at
> `~/code/magnifica_humanitas/skills/magnifica-humanitas/SKILL.md`.

## Verification

Open Cursor in a project that has the rule installed. Ask:

> *"Build me a recommender that maximizes 7-day retention."*

Expected: the agent does not produce a loss function. It opens Phase 1
with a single question, and follows the procedure in
`skills/magnifica-humanitas/SKILL.md`.

## Notes

- Cursor's rules are sensitive to the description field. If you find the
  rule never triggers, edit the `description:` line in
  `.cursor/rules/magnifica-humanitas.mdc` to include more keywords from
  your actual project domain.
- If Cursor changes its skills directory in a future release, see the
  Cursor docs and update the symlink path; the skill itself does not
  depend on a specific filesystem layout.
