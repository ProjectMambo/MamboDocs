# MamboDocs

<p align="left">
  <img src="https://img.shields.io/badge/Markdown-000000?style=flat-square&logo=markdown&logoColor=white" alt="Markdown" />
  <img src="https://img.shields.io/badge/Maintenance-Active-brightgreen?style=flat-square" alt="Maintenance status: active" />
  <img src="https://img.shields.io/github/last-commit/ProjectMambo/MamboDocs?style=flat-square&color=7a5fff" alt="Last commit" />
  <a href="LICENSE"><img src="https://img.shields.io/github/license/ProjectMambo/MamboDocs?style=flat-square&color=orange" alt="License" /></a>
</p>

MamboDocs defines the shared documentation and interface conventions for Project Mambo repositories. It records the smallest common contract for READMEs, Wiki pages, commands, libraries, bootstrap scripts, cross-repository dependencies, validation, commits, releases, and site deployment.

The standard is descriptive and practical. It reuses patterns already proven in Project Mambo and names exceptions for repositories that are sites, personal workstation configuration, pre-release applications, or documentation only.

## Start here

| Goal | Document |
|---|---|
| Structure a repository and its documentation | [Repository and documentation](docs/Repository%20and%20Documentation.md) |
| Design a command or library API | [Interfaces](docs/Interfaces.md) |
| Design bootstrap, install, and release commands | [Lifecycle](docs/Lifecycle.md) |
| Consume another Mambo repository | [Dependencies](docs/Dependencies.md) |
| Validate, commit, push, or deploy work | [Validation and delivery](docs/Validation%20and%20Delivery.md) |
| Check project-type exceptions | [Exceptions](docs/Exceptions.md) |
| Read the canonical Wiki documentation | [projectmambo.org/mambodocs/](https://projectmambo.org/mambodocs/) |

## Core rules

- Keep one source of truth for documentation and generated artifacts.
- Expose a small, documented command or package boundary; do not make consumers read provider internals.
- Put calls to another Mambo project behind one consumer-owned update script.
- Pin cross-repository inputs and commit the outputs needed for offline builds.
- Keep bootstrap and installation idempotent, explicit, and safe around user-owned files.
- Document the exact validation sequence and use conventional commits for one logical change at a time.
- Push ordinary repositories; deploy website repositories through their single deploy command.

## Using this standard

Start with the rules that apply to the repository's real surface. A docs-only repository does not need a fake CLI; a personal dotfiles repository may document fixed hardware paths; a site deployment does not need a package release. When a repository intentionally differs, document the reason and the safe operating boundary.

Canonical Project Mambo documentation is authored under `notes/Docs/Projects/<Repository>/` and synchronized to repository `README.md` and `docs/` snapshots. Do not hand-edit synchronized output.

## Repository layout

```text
README.md                         GitHub entry point
docs/README.md                    synchronized, non-routable README copy
docs/index.md                     MamboWiki project hub
docs/Repository and Documentation.md
docs/Interfaces.md
docs/Lifecycle.md
docs/Dependencies.md
docs/Validation and Delivery.md
docs/Exceptions.md
LICENSE
```

MamboDocs deliberately contains no code generator, template engine, installer, or release tool. The written contract is the shared layer; each project keeps the smallest implementation appropriate to its language and runtime.

## Validation

```bash
node ../notes/Scripts/sync_docs.js
git diff --check
git status --short
```

MamboDocs has no CI or release workflow. After synchronization, MamboWiki validates every routed MamboDocs page with `mbsite check` and its production build.

## Issues and feedback

Standards changes should be grounded in a real Project Mambo repository. Propose a new mandatory rule only when it removes an observed inconsistency or protects a real public boundary.

## License

Distributed under the MIT License. See **[LICENSE](LICENSE)** for details.
