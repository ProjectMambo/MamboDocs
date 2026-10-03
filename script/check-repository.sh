#!/bin/sh
set -eu

python3 - "$@" <<'PY'
from __future__ import annotations

import re
import sys
import tempfile
from pathlib import Path
from urllib.parse import unquote


REQUIRED_SECTIONS = (
    "motivation",
    "status",
    "user stories",
    "getting started",
    "documentation",
    "project structure",
    "validation",
    "development",
    "license",
)


def usage(stream=sys.stdout) -> None:
    print(
        "usage: check-repository.sh [--strict] [repository]\n"
        "       check-repository.sh --self-test\n\n"
        "Checks a repository without modifying it. The repository defaults to the\n"
        "current directory. Findings are advisory unless --strict is supplied.",
        file=stream,
    )


def parse_arguments(arguments: list[str]) -> tuple[Path, bool, bool]:
    strict = False
    self_test = False
    repository: str | None = None
    positional_only = False

    for argument in arguments:
        if not positional_only and argument == "--":
            positional_only = True
        elif not positional_only and argument in ("-h", "--help"):
            usage()
            raise SystemExit(0)
        elif not positional_only and argument == "--strict":
            strict = True
        elif not positional_only and argument == "--self-test":
            self_test = True
        elif not positional_only and argument.startswith("-"):
            print(f"unknown option: {argument}", file=sys.stderr)
            usage(sys.stderr)
            raise SystemExit(2)
        elif repository is None:
            repository = argument
        else:
            print("only one repository path may be supplied", file=sys.stderr)
            usage(sys.stderr)
            raise SystemExit(2)

    if self_test and repository is not None:
        print("--self-test does not accept a repository path", file=sys.stderr)
        raise SystemExit(2)
    return Path(repository or ".").resolve(), strict, self_test


def visible_markdown(content: str) -> str:
    lines: list[str] = []
    fence: str | None = None
    for line in content.splitlines():
        marker = re.match(r"^\s*(```+|~~~+)", line)
        if marker:
            token = marker.group(1)[0]
            fence = None if fence == token else token if fence is None else fence
            continue
        if fence is None:
            lines.append(line)
    return "\n".join(lines)


def headings(content: str, level: int) -> list[str]:
    pattern = re.compile(rf"^{'#' * level}\s+(.+?)\s*#*\s*$", re.MULTILINE)
    return [match.group(1).strip() for match in pattern.finditer(visible_markdown(content))]


def plain_heading(value: str) -> str:
    value = re.sub(r"\[([^]]+)]\([^)]*\)", r"\1", value)
    value = re.sub(r"[`*_~]", "", value)
    return re.sub(r"\s+", " ", value).strip().casefold()


def frontmatter(content: str) -> dict[str, str] | None:
    lines = content.lstrip("\ufeff").splitlines()
    if not lines or lines[0] != "---":
        return None
    try:
        end = lines.index("---", 1)
    except ValueError:
        return {}

    values: dict[str, str] = {}
    for line in lines[1:end]:
        match = re.match(r"^([A-Za-z0-9_-]+)\s*:\s*(.*?)\s*$", line)
        if match:
            values[match.group(1)] = match.group(2).strip().strip('"\'')
    return values


def markdown_destinations(content: str) -> set[str]:
    visible = visible_markdown(content)
    destinations = {
        match.group(1).strip()
        for match in re.finditer(r"!?\[[^]]*]\(([^)]*)\)", visible)
    }
    destinations.update(
        match.group(2).strip()
        for match in re.finditer(
            r"\b(?:href|src)\s*=\s*([\"'])(.*?)\1", visible, re.IGNORECASE
        )
    )
    return destinations


def local_target(destination: str) -> str | None:
    destination = destination.strip()
    if destination.startswith("<") and destination.endswith(">"):
        destination = destination[1:-1]
    else:
        destination = destination.split(maxsplit=1)[0]

    if (
        not destination
        or destination.startswith(("#", "/", "//", "?"))
        or re.match(r"^[A-Za-z][A-Za-z0-9+.-]*:", destination)
    ):
        return None
    path = destination.split("#", 1)[0].split("?", 1)[0]
    return unquote(path) or None


def inspect_repository(repository: Path) -> list[tuple[str, str]]:
    findings: list[tuple[str, str]] = []

    def add(path: str | Path, message: str) -> None:
        findings.append((str(path), message))

    def read(relative: str | Path) -> str | None:
        path = repository / relative
        if not path.is_file():
            add(relative, "missing required file")
            return None
        try:
            return path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            add(relative, "must be UTF-8 text")
            return None

    if not repository.is_dir():
        return [(str(repository), "repository path is not a directory")]

    readme = read("README.md")
    read("LICENSE")
    index = read("docs/index.md")

    if readme is not None:
        h1 = headings(readme, 1)
        if len(h1) != 1:
            add("README.md", f"expected exactly one H1, found {len(h1)}")

        h2_sequence = [plain_heading(value) for value in headings(readme, 2)]
        h2 = set(h2_sequence)
        for required in REQUIRED_SECTIONS:
            if required not in h2:
                add("README.md", f"missing H2 section: {required.title()}")
        present_positions = [h2_sequence.index(name) for name in REQUIRED_SECTIONS if name in h2]
        if present_positions != sorted(present_positions):
            add("README.md", "standard H2 sections are out of order")

        shield_markdown = re.search(
            r"!\[[^]]+\]\(https://img\.shields\.io/", readme, re.IGNORECASE
        )
        shield_html = any(
            "shields.io/" in tag and re.search(r"\balt\s*=\s*[\"'][^\"']+[\"']", tag, re.IGNORECASE)
            for tag in re.findall(r"<img\b[^>]*>", readme, re.IGNORECASE)
        )
        if not shield_markdown and not shield_html:
            add("README.md", "missing a Shields.io badge with accessible alt text")

        if not re.search(r"\[[^]]*licen[cs]e[^]]*]\([^)]*LICENSE[^)]*\)", readme, re.IGNORECASE) \
                and not re.search(r"href=[\"'][^\"']*LICENSE[^\"']*[\"']", readme, re.IGNORECASE):
            add("README.md", "missing a link to LICENSE")

    markdown_files: list[Path] = []
    docs = repository / "docs"
    if docs.is_dir():
        markdown_files = sorted(
            (path for path in docs.rglob("*.md") if path.is_file()),
            key=lambda path: path.relative_to(repository).as_posix().casefold(),
        )
    elif index is None:
        markdown_files = []

    orders: dict[tuple[Path, int], list[Path]] = {}
    for path in markdown_files:
        relative = path.relative_to(repository)
        try:
            content = path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            add(relative, "must be UTF-8 text")
            continue

        page_h1 = headings(content, 1)
        if len(page_h1) != 1:
            add(relative, f"expected exactly one H1, found {len(page_h1)}")

        if path.name.casefold() != "readme.md":
            metadata = frontmatter(content)
            if metadata is None:
                add(relative, "missing YAML frontmatter")
            elif metadata == {}:
                add(relative, "unclosed or empty YAML frontmatter")
            else:
                for field in ("title", "description", "order"):
                    if not metadata.get(field):
                        add(relative, f"missing frontmatter field: {field}")
                if metadata.get("order"):
                    try:
                        order = int(metadata["order"])
                    except ValueError:
                        add(relative, "frontmatter order must be an integer")
                    else:
                        # A directory index is ordered in its parent's project
                        # collection, not in the collection of its own pages.
                        if path.name.casefold() != "index.md":
                            orders.setdefault((path.parent, order), []).append(path)
                if metadata.get("title") and len(page_h1) == 1:
                    if plain_heading(metadata["title"]) != plain_heading(page_h1[0]):
                        add(relative, "frontmatter title and H1 do not match")

    for (_, order), paths in orders.items():
        if len(paths) > 1:
            names = ", ".join(path.relative_to(repository).as_posix() for path in paths)
            for path in paths:
                add(path.relative_to(repository), f"duplicate sibling order {order}: {names}")

    files_to_check = ([repository / "README.md"] if readme is not None else []) + markdown_files
    root = repository.resolve()
    for path in files_to_check:
        try:
            content = path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            continue
        relative = path.relative_to(repository)
        for destination in sorted(markdown_destinations(content)):
            if not destination.strip():
                add(relative, "empty Markdown link destination")
                continue
            target = local_target(destination)
            if target is None:
                continue
            resolved = (path.parent / target).resolve()
            try:
                resolved.relative_to(root)
            except ValueError:
                add(relative, f"local link escapes repository: {destination}")
                continue
            if not resolved.exists():
                add(relative, f"broken local link: {destination}")

    return sorted(set(findings), key=lambda item: (item[0].casefold(), item[1].casefold()))


def run_self_test() -> None:
    with tempfile.TemporaryDirectory(prefix="mambodocs-check-") as temporary:
        repository = Path(temporary)
        (repository / "docs").mkdir()
        (repository / "LICENSE").write_text("test licence\n", encoding="utf-8")
        sections = "\n".join(f"## {name.title()}\n\nContent.\n" for name in REQUIRED_SECTIONS)
        (repository / "README.md").write_text(
            "# Example\n\n"
            "![Status](https://img.shields.io/badge/status-active-green)\n\n"
            f"{sections}\n[Docs](docs/index.md) [License](LICENSE)\n",
            encoding="utf-8",
        )
        (repository / "docs" / "index.md").write_text(
            "---\ntitle: Example\ndescription: Example documentation.\norder: 10\n---\n\n"
            "# Example\n",
            encoding="utf-8",
        )
        assert inspect_repository(repository) == []

        with (repository / "README.md").open("a", encoding="utf-8") as handle:
            handle.write("\n[Missing](docs/missing.md) [Empty]()\n")
        findings = inspect_repository(repository)
        assert any("broken local link" in message for _, message in findings)
        assert any("empty Markdown link" in message for _, message in findings)
    print("check-repository self-test passed")


def main() -> int:
    repository, strict, self_test = parse_arguments(sys.argv[1:])
    if self_test:
        run_self_test()
        return 0

    if not repository.is_dir():
        print(f"repository path is not a directory: {repository}", file=sys.stderr)
        return 2

    findings = inspect_repository(repository)
    for path, message in findings:
        print(f"{path}: {message}")

    if findings:
        mode = "FAIL" if strict else "ADVISORY"
        print(f"{mode}: {len(findings)} MamboDocs finding(s) in {repository}")
        return 1 if strict else 0

    print(f"PASS: repository meets the automated MamboDocs baseline: {repository}")
    return 0


raise SystemExit(main())
PY
