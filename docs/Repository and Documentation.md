---
description: Organize a Project Mambo repository, README, canonical documentation, and website documentation tree.
title: Repository and documentation
order: 30
---

::page{layout="docs" width="normal" sidebar=true}

# Repository and documentation

Each repository must make its purpose, current capabilities, safe starting point, public boundaries, and maintenance state discoverable without source-code archaeology.

## Canonical repository shape

Use only the paths the project needs. These names are the shared default:

```text
README.md              GitHub and clone entry point
LICENSE                complete licence text
docs/                  synchronized detailed documentation
script/                repository-owned lifecycle and update commands
src/                   implementation when conventional for the language
tests/                 checks that do not live beside source
examples/              maintained, runnable examples only
.github/workflows/     CI, release, or deployment automation when used
```

Language-native layouts remain valid. A Rust crate may use `src/` and `tests/`; a Node package may use `packages/`; a dotfiles repository may organize by Stow package; a documentation project may have no implementation tree.

Do not commit empty directories. Every top-level path must have a current owner and purpose. Identify generated, synchronized, vendored, cached, and build paths in the developer guide and ignore or commit them intentionally.

## README contract

Every Project Mambo README uses one H1 followed by a one- or two-sentence current description. Use these H2 sections in this order, omitting only a section that has no meaningful project equivalent:

1. **Motivation** — the user problem and why this repository exists.
2. **Status** — maturity, supported platforms, current limitations, and ownership route.
3. **User stories** — representative supported outcomes, or a link to the product definition.
4. **Getting started** — the shortest successful path from a named starting state.
5. **Usage** or **API** — the stable user or consumer surface when applicable.
6. **Documentation** — links to the project hub, user guide, developer guide, and published Wiki route.
7. **Project structure** — a compact map of meaningful top-level paths.
8. **Validation** — the authoritative local checks in execution order.
9. **Development** — contribution workflow, canonical docs source, and delivery notes.
10. **License** — licence name and exact local link.

Additional sections are welcome when they answer a real reader question. Keep planned work out of current capability lists. A README is an entry point, not the complete manual: move multi-step operation, architecture, exhaustive reference, and troubleshooting into `docs/` and link them.

## Shield badges

Place a small left-aligned badge group directly below the H1. Badges must be factual, accessible, and useful. A typical repository uses:

- primary language or runtime;
- maturity or maintenance status;
- CI status when a real workflow exists;
- latest released version only when releases exist;
- last commit where recency matters;
- licence linked to `LICENSE`.

Use [Shields.io](https://shields.io/) flat-square badges with meaningful `alt` text. Link status badges to the workflow and version badges to releases. Never add passing build, coverage, package, security, or version badges for infrastructure that does not exist.

```html
<p align="left">
  <img src="https://img.shields.io/badge/<technology>-<colour>?style=flat-square" alt="<Technology>" />
  <img src="https://img.shields.io/badge/Maintenance-Active-brightgreen?style=flat-square" alt="Maintenance status: active" />
  <a href="LICENSE"><img src="https://img.shields.io/github/license/ProjectMambo/<Repository>?style=flat-square" alt="Licence" /></a>
</p>
```

Keep badge labels stable across repositories. Do not use badges as a substitute for the Status section.

## Documentation information architecture

Every repository has a canonical `README.md` and `index.md`. Add these pages when the surface requires them:

```text
README.md               repository entry point
index.md                published project hub and child navigation
Product.md              motivation, users, stories, scope, and outcomes
User Guide.md           installation, tasks, configuration, recovery, removal
Developer Guide.md      setup, architecture, workflows, checks, contribution
API.md                  public API reference or links to generated reference
Operations.md           deployment, monitoring, backup, restore, incidents
Security.md             threat boundaries and private reporting route
Decisions/              important architecture decision records
```

Use fewer pages for a small project, but keep user instructions separate from contributor internals once combining them makes either audience scan around irrelevant detail. Reference pages describe facts; guides lead to outcomes; explanations provide context; tutorials teach through a complete path.

## Canonical source and synchronization

Project Mambo authors documentation once in the notes vault:

```text
notes/Docs/Projects/<Repository>/README.md
notes/Docs/Projects/<Repository>/index.md
notes/Docs/Projects/<Repository>/*.md
```

The notes version carries vault metadata such as `created`, `updated`, and `project`. `notes/Scripts/sync_docs.js` strips vault-only metadata and exports the root README plus the complete repository `docs/` snapshot. Never hand-edit synchronized copies first.

For every canonical documentation change:

1. edit the note and update its `updated` value;
2. run `node Scripts/sync_docs.js --sync <Repository>` from `notes/`;
3. review additions, replacements, and deletions in the owner repository;
4. run the owner checks;
5. synchronize or validate MamboWiki when the published mount is affected.

The complete replacement behavior is intentional: renaming or deleting a canonical page removes the stale exported page.

## Page contract

Every routed Markdown page has frontmatter with:

- `title`: unique, reader-facing page name;
- `description`: one sentence that states the page outcome;
- authoring metadata required by the notes vault.

Add a stable integer `order` when the page participates in generated navigation or a collection. A configured site entry at `docs/index.md` may omit it because the root has no sibling position; mounted project indexes keep it when the containing site orders those projects.

Render exactly one H1 that matches the title in meaning. Author that H1 in Markdown unless a MamboSite page layout or hero deliberately generates it from the frontmatter title; never add a source heading that would duplicate the renderer-owned title. Give each page one primary subject. Use H2 and H3 in a logical hierarchy without skipping levels for visual size. The project `index.md` must state the boundary, link the source repository, expose child navigation, and distinguish current behavior from plans.

MamboSite does not infer a useful landing page from a directory alone. Use explicit links or `::children{}` on every hub that owns child pages.

## Website documentation structure

A website repository separates project documentation from site-owned route content:

```text
notes/Docs/Projects/<Repository>/       project README and reusable project docs
notes/Docs/Projects/_sites/<Repository>/ site index and site-only routes
repository/docs/                         synchronized build input
repository/docs/_mounts/                 generated mounted project snapshots
```

The site index declares mounts to canonical project `index.md` files. A mount is a read-only synchronized snapshot; edit its canonical project source, not `_mounts/`. Site-only navigation, landing pages, policy pages, and route composition belong under `_sites/<Repository>/`.

Document route ownership, base path, deployment command, generated directories, and link rules in the website's developer guide. Validate internal links and a production build before deployment. Do not publish two routes as competing sources for the same procedure.

## Writing and formatting

- Use sentence-case headings and plain, direct language.
- Put a blank line after headings and before and after lists, tables, and code fences.
- Use active voice and name the actor for risky operations.
- Define project-specific terms on first use and keep their spelling consistent.
- Use tables for exact mappings and comparisons, not long narrative cells.
- Give code fences an accurate language and keep copyable commands free of prompts.
- Use repository-relative links for repository docs and stable route links for published navigation.
- Give images useful alt text; do not encode essential instructions only in an image.
- Avoid duplicating procedures. Keep one authoritative section and link to it.

## Links and assets

Prefer relative links for files that move together. Percent-encode spaces in Markdown link destinations. Link to source lines only when the target revision is pinned; otherwise link to the stable file or public API.

Store documentation assets beside the canonical docs in an `_assets/` directory when the sync process must preserve them without Markdown transformation. Use compressed, appropriately sized files and record licences for third-party assets. Never commit credentials, private screenshots, or personal data.

## Documentation review

Review documentation as part of the behavior it describes. Check the current interface, commands, filenames, links, metadata, accessibility, and expected output. A stale instruction is a failing contract even if prose lint passes.

The automated repository checker intentionally enforces only objective structure. Human review remains responsible for truthful status, usable examples, complete recovery guidance, and accurate project-specific decisions.
