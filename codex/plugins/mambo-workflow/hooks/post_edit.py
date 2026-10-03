#!/usr/bin/env python3
"""Synchronize canonical docs and provide advisory feedback after file edits."""

from __future__ import annotations

import json
import os
from pathlib import Path
import re
import subprocess
import sys
from typing import Any


PATCH_PATH = re.compile(r"^\*\*\* (?:Add|Update|Delete) File: (.+)$", re.MULTILINE)
PATH_KEYS = {"file", "file_path", "path"}


def strings_for_paths(value: Any, key: str | None = None) -> list[str]:
    if isinstance(value, dict):
        found: list[str] = []
        for child_key, child in value.items():
            found.extend(strings_for_paths(child, str(child_key)))
        return found
    if isinstance(value, list):
        found = []
        for child in value:
            found.extend(strings_for_paths(child, key))
        return found
    if isinstance(value, str):
        if key in PATH_KEYS:
            return [value]
        return PATCH_PATH.findall(value)
    return []


def absolute_paths(payload: dict[str, Any]) -> list[Path]:
    cwd = Path(payload.get("cwd") or os.getcwd()).resolve()
    paths = []
    for raw in strings_for_paths(payload.get("tool_input", {})):
        cleaned = raw.strip().strip('"\'')
        candidate = Path(cleaned).expanduser()
        paths.append((candidate if candidate.is_absolute() else cwd / candidate).resolve())
    return sorted(set(paths))


def repository_for(path: Path) -> Path | None:
    candidate = path if path.is_dir() else path.parent
    result = subprocess.run(
        ["git", "-C", str(candidate), "rev-parse", "--show-toplevel"],
        capture_output=True,
        text=True,
        check=False,
    )
    if result.returncode != 0:
        return None
    return Path(result.stdout.strip()).resolve()


def is_mambo_repository(repository: Path, mambo_root: Path) -> bool:
    try:
        repository.relative_to(mambo_root)
    except ValueError:
        return False
    remote = subprocess.run(
        ["git", "-C", str(repository), "remote", "get-url", "origin"],
        capture_output=True,
        text=True,
        check=False,
    )
    if remote.returncode == 0:
        return "ProjectMambo/" in remote.stdout
    if not repository.name.startswith("Mambo"):
        return False
    head = subprocess.run(
        ["git", "-C", str(repository), "rev-parse", "--verify", "HEAD"],
        capture_output=True,
        text=True,
        check=False,
    )
    return head.returncode != 0


def canonical_projects(paths: list[Path], mambo_root: Path) -> set[str]:
    projects_root = mambo_root / "notes" / "Docs" / "Projects"
    projects: set[str] = set()
    for path in paths:
        try:
            parts = path.relative_to(projects_root).parts
        except ValueError:
            continue
        if not parts:
            continue
        if parts[0] == "_sites" and len(parts) > 1:
            projects.add(parts[1])
        elif not parts[0].startswith("_"):
            projects.add(parts[0])
    return projects


def sync_selection(projects: set[str]) -> list[str]:
    names = sorted(projects)
    needs_wiki = "MamboWiki" not in projects and any(
        name != "ProjectMambo" for name in projects
    )
    if needs_wiki:
        names.append("MamboWiki")
    return names


def run(command: list[str], cwd: Path) -> tuple[int, str]:
    try:
        result = subprocess.run(
            command,
            cwd=cwd,
            capture_output=True,
            text=True,
            check=False,
            timeout=110,
        )
    except subprocess.TimeoutExpired:
        return 124, f"timed out: {' '.join(command)}"
    except OSError as error:
        return 127, str(error)
    output = "\n".join(part.strip() for part in (result.stdout, result.stderr) if part.strip())
    return result.returncode, output[-4000:]


def main() -> int:
    try:
        payload = json.load(sys.stdin)
    except (json.JSONDecodeError, OSError):
        return 0

    mambo_root = Path(os.environ.get("MAMBO_ROOT", Path.home() / "ProjectMambo")).resolve()
    paths = absolute_paths(payload)
    messages: list[str] = []

    projects = canonical_projects(paths, mambo_root)
    if projects:
        sync_names = sync_selection(projects)
        code, output = run(
            ["node", "Scripts/sync_docs.js", "--sync", *sync_names],
            mambo_root / "notes",
        )
        if code == 0:
            messages.append(f"Canonical docs synchronized for: {', '.join(sync_names)}.")
        else:
            messages.append(f"Documentation sync failed; resolve before delivery.\n{output}")

    repositories = {
        repository
        for path in paths
        if (repository := repository_for(path)) is not None
        and is_mambo_repository(repository, mambo_root)
        and repository != mambo_root / "notes"
    }
    checker = mambo_root / "MamboDocs" / "script" / "check-repository.sh"
    for repository in sorted(repositories):
        direct_docs = [
            path
            for path in paths
            if path == repository / "README.md"
            or repository / "docs" in path.parents
        ]
        if direct_docs:
            messages.append(
                f"{repository.name} documentation snapshots were edited directly. "
                f"Move the source change to notes/Docs/Projects/{repository.name}/ and synchronize it."
            )
        if checker.is_file():
            code, output = run([str(checker), str(repository)], repository)
            if code != 0:
                messages.append(
                    f"{repository.name} is not yet consistent with MamboDocs. "
                    f"Treat this as in-progress feedback and resolve it before the phase commit.\n{output}"
                )

    if messages:
        print(
            json.dumps(
                {
                    "hookSpecificOutput": {
                        "hookEventName": "PostToolUse",
                        "additionalContext": "\n\n".join(messages),
                    }
                }
            )
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
