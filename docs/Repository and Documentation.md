---
description: Organize a Project Mambo repository, README, canonical docs, and Wiki project hub.
title: Repository and documentation
order: 10
---

::page{layout="docs" width="normal" sidebar=true}

# Repository and documentation

Each repository should make its current purpose, supported surface, safe starting point, and maintenance state discoverable without requiring source-code archaeology.

## Repository shape

Use only the directories the project needs. These names are the shared default, not mandatory empty scaffolding:

```text
README.md             repository entry point
docs/                 detailed and Wiki-routable documentation
script/               repo-local lifecycle and update commands
src/ or language tree implementation
tests/                checks that do not fit beside source
.github/workflows/    automation when the repository has CI or deployment
LICENSE               repository licence
```

Generated and synchronized paths must be identified in the README and ignored or committed intentionally. Never make readers guess whether a file is source, cache, build output, or a reviewed generated input.

## README contract

A Project Mambo README should contain, when applicable:

1. One H1 with the repository name and a short, current description.
2. Factual technology and maintenance badges with accessible alt text.
3. A **Start here** table linking to the primary task, detailed docs, and the repository's Wiki route.
4. Current capabilities and explicit limitations. Separate implemented behavior from plans.
5. Setup or first-run commands that work from a fresh clone.
6. The stable command or public package surface.
7. A compact repository layout.
8. The authoritative local validation sequence.
9. Issue/contribution expectations and the exact licence link.

Omit sections that have no meaning for the repository. A font asset repository does not need an HTTP API section; a documentation repository does not need an installer.

## Canonical documentation

Project Mambo authors canonical docs in the notes vault:

```text
notes/Docs/Projects/<Repository>/README.md
notes/Docs/Projects/<Repository>/index.md
notes/Docs/Projects/<Repository>/*.md
```

`notes/Scripts/sync_docs.js` exports the README and complete `docs/` tree. Repository copies are derived snapshots and must not be edited first. After any canonical change, synchronize both the owning repository and MamboWiki because the Wiki mounts that same source tree.

## Wiki page contract

Every routed Markdown page has:

- `title` and a one-sentence `description` in frontmatter;
- a stable `order` when it appears in a collection;
- one H1;
- one clear subject rather than a duplicate README;
- working local links and explicit labels for external links.

Each project's `index.md` is its `/project-slug/` hub. It states the project boundary, links its GitHub source, lists child documents, and distinguishes current status from planned work. MamboSite does not automatically display children, so the hub must use explicit links or `::children{}`.

## Style

- Use sentence-case headings and plain language.
- Put a blank line after headings and before lists or code fences.
- Prefer short tables for exact mappings and prose for decisions.
- Use repository-relative links in canonical READMEs and Wiki-safe links in routed docs.
- Do not copy the same operating procedure into several pages; keep one authoritative section and link to it.
