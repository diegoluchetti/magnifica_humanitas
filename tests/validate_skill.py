#!/usr/bin/env python3
"""Validate the Magnifica Humanitas skill repository.

This script intentionally uses only the Python standard library so it can run in
fresh Codex, Claude Code, and Cursor environments.
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SOURCE_URL = "https://www.vatican.va/content/leo-xiv/en/encyclicals/documents/20260515-magnifica-humanitas.html"
SKILL = ROOT / "skills" / "discerning-ai-with-magnifica-humanitas" / "SKILL.md"
SKILL_LAW = ROOT / "skills" / "discerning-ai-with-magnifica-humanitas" / "magnifica-humanitas-law.md"
LAW = ROOT / "docs" / "magnifica-humanitas-law.md"
VALIDATION = ROOT / "docs" / "validation.md"
README = ROOT / "README.md"
SCENARIOS = ROOT / "tests" / "scenarios.json"


def read(path: Path) -> str:
    if not path.exists():
        raise AssertionError(f"Missing required file: {path.relative_to(ROOT)}")
    return path.read_text(encoding="utf-8")


def assert_contains(text: str, needle: str, label: str) -> None:
    if needle.lower() not in text.lower():
        raise AssertionError(f"{label} must mention: {needle}")


def assert_regex(text: str, pattern: str, label: str) -> None:
    if not re.search(pattern, text, re.IGNORECASE | re.MULTILINE):
        raise AssertionError(f"{label} must match /{pattern}/")


def validate_skill() -> None:
    text = read(SKILL)
    assert_regex(text, r"^---\nname:\s*discerning-ai-with-magnifica-humanitas\n", "skill frontmatter")
    assert_regex(text, r"description:\s*Use when", "skill description")
    assert len(re.search(r"^---\n(.*?)\n---", text, re.DOTALL).group(1)) <= 1024

    for phrase in [
        SOURCE_URL,
        "Socratic",
        "bias",
        "intention",
        "LAW",
        "human dignity",
        "common good",
        "subsidiarity",
        "solidarity",
        "truth",
        "work",
        "freedom",
        "Babel",
        "Nehemiah",
        "Recourse",
        "recourse",
        "human responsibility",
    ]:
        assert_contains(text, phrase, "skill")

    for paragraph in ["§10", "§71", "§102", "§105", "§137", "§164", "§197"]:
        assert_contains(text, paragraph, "installed skill")

    assert_regex(text, r"ask.*question", "skill")
    assert_regex(text, r"do not.*replace.*moral", "skill")
    assert_regex(text, r"refuse|decline|cannot help", "skill")
    assert_regex(text, r"reframe|redirect|offer", "skill")
    assert_regex(text, r"\|\s*Recourse\s*\|", "skill law table")


def validate_law() -> None:
    text = read(LAW)
    installed = read(SKILL_LAW)
    assert_contains(text, SOURCE_URL, "law summary")
    assert_contains(installed, SOURCE_URL, "installed law summary")
    for paragraph in ["4", "10", "14", "15", "71", "85", "102", "105", "137", "164", "197"]:
        assert_contains(text, f"§{paragraph}", "law summary")
        assert_contains(installed, f"§{paragraph}", "installed law summary")
    for principle in [
        "Human person at the center",
        "Truth is a common good",
        "No opaque delegation",
        "Prefer the way of Nehemiah",
        "Disarm words",
    ]:
        assert_contains(text, principle, "law summary")
        assert_contains(installed, principle, "installed law summary")


def validate_scenarios() -> None:
    scenarios = json.loads(read(SCENARIOS))
    skill_text = read(SKILL).lower()
    if len(scenarios) < 5:
        raise AssertionError("tests/scenarios.json must define at least five pressure scenarios")
    required = {"id", "prompt", "expected_questions", "must_apply", "must_not_do"}
    for scenario in scenarios:
        missing = required.difference(scenario)
        if missing:
            raise AssertionError(f"Scenario {scenario.get('id', '<unknown>')} missing {sorted(missing)}")
        if len(scenario["expected_questions"]) < 2:
            raise AssertionError(f"Scenario {scenario['id']} needs at least two Socratic questions")
        if not scenario["must_apply"]:
            raise AssertionError(f"Scenario {scenario['id']} must name applicable principles")
        if not scenario["must_not_do"]:
            raise AssertionError(f"Scenario {scenario['id']} must name prohibited behavior")
        for principle in scenario["must_apply"]:
            if principle.lower() not in skill_text:
                raise AssertionError(
                    f"Scenario {scenario['id']} applies '{principle}', but SKILL.md does not mention it"
                )


def validate_repo_docs() -> None:
    validation = read(VALIDATION)
    readme = read(README)
    assert_contains(readme, SOURCE_URL, "README")
    assert_contains(validation, "behavioral", "validation plan")
    for path in [
        ROOT / "adapters" / "cursor" / "README.md",
        ROOT / "adapters" / "claude-code" / "README.md",
        ROOT / "adapters" / "codex" / "README.md",
        ROOT / "CONTRIBUTING.md",
        ROOT / "tests" / "evaluate_response.py",
        ROOT / "LICENSE",
    ]:
        read(path)


def main() -> int:
    checks = [validate_skill, validate_law, validate_scenarios, validate_repo_docs]
    failures: list[str] = []
    for check in checks:
        try:
            check()
        except Exception as exc:  # noqa: BLE001 - test runner reports all failures.
            failures.append(f"{check.__name__}: {exc}")
    if failures:
        print("Validation failed:")
        for failure in failures:
            print(f"- {failure}")
        return 1
    print("Validation passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
