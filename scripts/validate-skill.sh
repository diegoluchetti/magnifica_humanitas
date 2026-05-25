#!/usr/bin/env bash
# Static validation for the Magnifica Humanitas skill.
#
# This script does NOT run subagent pressure tests (those are inherently
# manual or harness-specific; see skills/magnifica-humanitas/tests/README.md).
# It verifies that the skill files are well-formed and internally consistent.
#
# Usage:  ./scripts/validate-skill.sh
# Exit 0 on success; non-zero on the first failure.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_DIR="$ROOT/skills/magnifica-humanitas"
SKILL_MD="$SKILL_DIR/SKILL.md"

fail() { echo "FAIL: $*" >&2; exit 1; }
ok()   { echo "  ok   $*"; }

echo "Validating skill at $SKILL_DIR"

# 1. Required files exist
required=(
  "$SKILL_MD"
  "$SKILL_DIR/references/twelve-laws.md"
  "$SKILL_DIR/references/socratic-questions.md"
  "$SKILL_DIR/references/encyclical-excerpts.md"
  "$SKILL_DIR/references/examples.md"
  "$SKILL_DIR/tests/README.md"
  "$SKILL_DIR/tests/evaluation-rubric.md"
  "$SKILL_DIR/tests/baseline-vs-with-skill.md"
  "$ROOT/.cursor/rules/magnifica-humanitas.mdc"
  "$ROOT/AGENTS.md"
  "$ROOT/install/claude-code.md"
  "$ROOT/install/cursor.md"
  "$ROOT/install/codex.md"
  "$ROOT/LICENSE"
  "$ROOT/README.md"
  "$ROOT/CONTRIBUTING.md"
)
for f in "${required[@]}"; do
  [ -f "$f" ] || fail "missing file: $f"
done
ok "all required files present"

# 2. Eight test scenarios present
scenarios=(
  "scenario-01-engagement-maximization.md"
  "scenario-02-mass-layoff-rollout.md"
  "scenario-03-companion-app.md"
  "scenario-04-predictive-policing.md"
  "scenario-05-creative-displacement.md"
  "scenario-06-edtech-tutor.md"
  "scenario-07-pure-infra.md"
  "scenario-08-autonomous-weapon.md"
)
for s in "${scenarios[@]}"; do
  [ -f "$SKILL_DIR/tests/$s" ] || fail "missing test scenario: $s"
done
ok "all 8 test scenarios present"

# 3. SKILL.md has valid YAML frontmatter with required fields
head -n 1 "$SKILL_MD" | grep -q '^---$' || fail "SKILL.md missing YAML frontmatter delimiter"
grep -q '^name: magnifica-humanitas$' "$SKILL_MD" || fail "SKILL.md missing or wrong 'name' field"
grep -q '^description: Use when' "$SKILL_MD" || fail "SKILL.md 'description' must start with 'Use when'"
ok "SKILL.md frontmatter valid"

# 4. Name follows the spec (letters, numbers, hyphens only)
name_line=$(grep '^name:' "$SKILL_MD" | head -n 1 | sed 's/^name: *//')
echo "$name_line" | grep -Eq '^[a-z0-9-]+$' || fail "skill name '$name_line' must be lowercase letters/numbers/hyphens only"
ok "skill name '$name_line' matches spec"

# 5. YAML frontmatter under 1024 chars
frontmatter_size=$(awk '/^---$/{c++; next} c==1{print}' "$SKILL_MD" | wc -c)
if [ "$frontmatter_size" -gt 1024 ]; then
  fail "frontmatter is $frontmatter_size chars, exceeds 1024-char limit"
fi
ok "frontmatter is $frontmatter_size / 1024 chars"

# 6. Twelve laws are all named in twelve-laws.md
for n in 1 2 3 4 5 6 7 8 9 10 11 12; do
  grep -q "^## L${n} " "$SKILL_DIR/references/twelve-laws.md" \
    || fail "twelve-laws.md missing section for L${n}"
done
ok "all 12 laws documented"

# 7. All twelve laws are referenced in SKILL.md
for n in 1 2 3 4 5 6 7 8 9 10 11 12; do
  grep -q "L${n}" "$SKILL_MD" || fail "SKILL.md does not reference L${n}"
done
ok "SKILL.md references L1–L12"

# 8. Four named verdicts present in SKILL.md
for v in "Rebuilding Jerusalem" "Walls in need of repair" "Architects of Babel" "Tower destined for ruin"; do
  grep -q "$v" "$SKILL_MD" || fail "SKILL.md missing verdict: $v"
done
ok "all four verdicts named"

# 9. Iron Rule present
grep -qi "Iron Rule" "$SKILL_MD" || fail "SKILL.md missing the Iron Rule"
ok "Iron Rule present"

# 10. Six required Socratic axes present in question bank
for axis in "Purpose" "Beneficiaries" "anthropology" "excluded" "unmeasured" "Babel motive"; do
  grep -qi "$axis" "$SKILL_DIR/references/socratic-questions.md" \
    || fail "socratic-questions.md missing axis: $axis"
done
ok "all 6 Socratic axes present in question bank"

# 11. Encyclical URL present in excerpts file
grep -q "20260515-magnifica-humanitas.html" "$SKILL_DIR/references/encyclical-excerpts.md" \
  || fail "encyclical-excerpts.md missing source URL"
ok "encyclical source URL cited"

# 12. SKILL.md word count sanity (should be substantial but not absurd)
wc=$(wc -w < "$SKILL_MD")
if [ "$wc" -lt 800 ];   then fail "SKILL.md only $wc words; likely too thin"; fi
if [ "$wc" -gt 5000 ];  then fail "SKILL.md $wc words; likely too bloated for discovery"; fi
ok "SKILL.md word count: $wc (acceptable range 800–5000)"

# 13. Cursor rule wrapper has frontmatter
head -n 1 "$ROOT/.cursor/rules/magnifica-humanitas.mdc" | grep -q '^---$' \
  || fail ".cursor/rules/magnifica-humanitas.mdc missing YAML frontmatter"
ok "Cursor rule frontmatter valid"

# 14. AGENTS.md points at the skill path
grep -q "skills/magnifica-humanitas/SKILL.md" "$ROOT/AGENTS.md" \
  || fail "AGENTS.md does not reference skill path"
ok "AGENTS.md references skill path"

echo
echo "ALL STATIC CHECKS PASSED"
echo
echo "Next step: run the subagent pressure tests as described in"
echo "  $SKILL_DIR/tests/README.md"
