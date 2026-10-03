# MamboDocs

<p align="left">
  <img src="https://img.shields.io/badge/Markdown-000000?style=flat-square&logo=markdown&logoColor=white" alt="Markdown" />
  <img src="https://img.shields.io/badge/Standard-Project_Mambo-7a5fff?style=flat-square" alt="Project Mambo standard" />
  <img src="https://img.shields.io/badge/Maintenance-Active-brightgreen?style=flat-square" alt="Maintenance status: active" />
  <img src="https://img.shields.io/github/last-commit/ProjectMambo/MamboDocs?style=flat-square&color=7a5fff" alt="Last commit" />
  <a href="LICENSE"><img src="https://img.shields.io/github/license/ProjectMambo/MamboDocs?style=flat-square&color=orange" alt="MIT License" /></a>
</p>

MamboDocs is the shared repository and documentation standard for Project Mambo. It defines how a Mambo project explains its purpose, starts from a clean clone, exposes commands and APIs, manages versions and dependencies, publishes documentation, and proves that a change is ready to deliver.

## Motivation

Project Mambo spans applications, libraries, terminal tools, websites, assets, personal configuration, and documentation. A contributor should not need to rediscover where the user guide lives, which command validates a change, whether generated files are authoritative, or how compatibility is communicated in every repository.

MamboDocs makes those answers predictable while keeping project-specific machinery optional. Consistency applies to real boundaries; it does not require empty folders, speculative APIs, or the same language everywhere.

## Status

The standard is active and applies to new Project Mambo repositories. Existing repositories can adopt it incrementally when they are reviewed; this repository does not claim that every existing project already conforms.

MamboDocs is documentation-only and is not independently versioned. Its synchronized repository snapshot follows the canonical notes source, and changes are tracked by Git history.

## User stories

- As a user, I can find the supported installation, first-run, update, troubleshooting, and removal paths without reading source code.
- As a contributor, I can prepare a fresh clone, understand the architecture, run the authoritative checks, and submit one reviewable change.
- As a maintainer, I can tell which files are authoritative, generated, public, versioned, and safe to replace.
- As a Project Mambo tool, I can rely on a small set of repository and documentation conventions without guessing project internals.

## Start here

| Goal | Document |
|---|---|
| Define motivation, users, scope, and outcomes | [Product definition](docs/Product%20Definition.md) |
| Start a new Project Mambo repository | [Starting a repository](docs/Starting%20a%20Repository.md) |
| Structure a repository, README, and website docs | [Repository and documentation](docs/Repository%20and%20Documentation.md) |
| Write task-focused help for users | [User guide](docs/User%20Guide.md) |
| Explain setup, architecture, and contribution work | [Developer guide](docs/Developer%20Guide.md) |
| Format commands and build safe repository scripts | [Commands and scripts](docs/Commands%20and%20Scripts.md) |
| Design a CLI, library, HTTP, file, or UI contract | [Interfaces](docs/Interfaces.md) |
| Manage installation, versions, releases, and retirement | [Lifecycle and versioning](docs/Lifecycle.md) |
| Consume another project reproducibly | [Dependencies](docs/Dependencies.md) |
| Validate, commit, push, release, or deploy work | [Validation and delivery](docs/Validation%20and%20Delivery.md) |
| Apply the workflow automatically in Codex | [Codex workflow](docs/Codex%20Workflow.md) |
| Record a justified exception | [Exceptions](docs/Exceptions.md) |
| Browse the published standard | [projectmambo.org/mambodocs/](https://projectmambo.org/mambodocs/) |

## Getting started

For a new repository, copy only the applicable files from [`templates/`](templates/), complete every retained placeholder, and follow the [new-repository checklist](docs/Starting%20a%20Repository.md). Do not copy an empty section merely to appear complete.

To inspect a repository against the objective baseline:

```bash
/path/to/MamboDocs/script/check-repository.sh /path/to/repository
```

The check is advisory by default, which is appropriate during an implementation phase. Use `--strict` in CI or at a delivery gate:

```bash
/path/to/MamboDocs/script/check-repository.sh --strict /path/to/repository
```

## Documentation

The standard is organized as a lifecycle: define the product, create the repository, write user and developer documentation, design public boundaries, manage versions and dependencies, then validate and deliver. The [published MamboDocs hub](https://projectmambo.org/mambodocs/) and the [local documentation hub](docs/index.md) contain the complete standard.

Project documentation is authored once under `notes/Docs/Projects/<Repository>/` and synchronized into the repository. Repository `README.md` and `docs/` are generated snapshots; edit the canonical notes source first, update its `updated` field, then run the sync command documented in [Validation and delivery](docs/Validation%20and%20Delivery.md).

## Project structure

```text
README.md                  synchronized repository entry point
docs/                      synchronized, Wiki-routable standard
codex/plugins/             reusable Codex workflow plugin source
script/check-repository.sh read-only baseline checker
templates/                 copyable project-documentation starters
LICENSE                    MIT licence
```

## Validation

From `notes/`, synchronize the canonical source, then validate the exported repository:

```bash
node Scripts/sync_docs.js --sync MamboDocs
../MamboDocs/script/check-repository.sh --strict ../MamboDocs
git diff --check
```

MamboWiki performs its own content and production-build checks after the synchronized standard is mounted there.

## Development

Standards changes should solve an observed documentation, safety, compatibility, or contributor problem. Update the canonical page and its `updated` metadata, synchronize the complete snapshot, run the checker, and review both source and generated differences. Keep unrelated standards changes in separate Conventional Commits.

When a rule does not apply, use the documented exception process instead of inventing placeholder code or silently ignoring the standard.

## License

Distributed under the MIT License. See **[LICENSE](LICENSE)** for details.
