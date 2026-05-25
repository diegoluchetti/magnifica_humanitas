#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL="$ROOT/skills/guiding-with-magnifica-humanitas/SKILL.md"
CHECKLIST="$ROOT/skills/guiding-with-magnifica-humanitas/references/mh-discernment-checklist.md"

fail() { echo "error: $*" >&2; exit 1; }

[[ -f "$SKILL" ]] || fail "missing $SKILL"
[[ -f "$CHECKLIST" ]] || fail "missing $CHECKLIST"

python3 - "$SKILL" <<'PY'
import re, sys
path = sys.argv[1]
text = open(path, encoding="utf-8").read()
if not text.startswith("---"):
    sys.exit("error: SKILL.md must begin with --- frontmatter")
m = re.match(r"^---\n(.*?)\n---\n", text, re.S)
if not m:
    sys.exit("error: could not parse YAML frontmatter (opening/closing ---)")
fm = m.group(1)
if len(fm) > 1024:
    sys.exit(f"error: frontmatter body exceeds 1024 chars (got {len(fm)})")
name = None
desc = None
for line in fm.splitlines():
    if line.startswith("name:"):
        name = line.split(":", 1)[1].strip()
    if line.startswith("description:"):
        desc = line.split(":", 1)[1].strip()
if not name or not re.fullmatch(r"[a-z0-9-]+", name):
    sys.exit("error: name must match [a-z0-9-]+")
if len(name) > 64:
    sys.exit("error: name longer than 64 chars")
if not desc or not desc.startswith("Use when"):
    sys.exit("error: description must start with 'Use when'")
PY

for needle in "Socratic protocol" "Red flags" "Rationalizations" "lex orientativa"; do
  grep -q "$needle" "$SKILL" || fail "SKILL.md missing section or phrase: $needle"
done

grep -q 'vatican.va/content/leo-xiv' "$SKILL" || fail "must link official Vatican URL in SKILL.md"
grep -q 'vatican.va/content/leo-xiv' "$CHECKLIST" || fail "must link official Vatican URL in checklist"

sc=( "$ROOT"/tests/scenarios/*.md )
[[ -e "${sc[0]}" ]] || fail "no tests/scenarios/*.md"

echo "OK: skill structure and references validated."
echo "  SKILL: $SKILL"
echo "  scenarios: ${#sc[@]} file(s)"
