# PROJECT_NAME

<!-- Replace every ALL_CAPS placeholder and remove inapplicable badges or sections. -->

<p align="left">
  <img src="https://img.shields.io/badge/TECHNOLOGY-COLOUR?style=flat-square" alt="TECHNOLOGY" />
  <img src="https://img.shields.io/badge/Maintenance-STATUS-COLOUR?style=flat-square" alt="Maintenance status: STATUS" />
  <!-- Keep CI only when OWNER/REPOSITORY has this workflow. -->
  <a href="https://github.com/OWNER/REPOSITORY/actions/workflows/ci.yml"><img src="https://img.shields.io/github/actions/workflow/status/OWNER/REPOSITORY/ci.yml?style=flat-square&label=CI" alt="CI status" /></a>
  <!-- Keep version only when the project publishes releases. -->
  <a href="https://github.com/OWNER/REPOSITORY/releases"><img src="https://img.shields.io/github/v/release/OWNER/REPOSITORY?style=flat-square" alt="Latest release" /></a>
  <img src="https://img.shields.io/github/last-commit/OWNER/REPOSITORY?style=flat-square" alt="Last commit" />
  <a href="LICENSE"><img src="https://img.shields.io/github/license/OWNER/REPOSITORY?style=flat-square" alt="LICENSE_NAME licence" /></a>
</p>

ONE_SENTENCE_DESCRIPTION

## Motivation

Describe the user problem, why it matters, and why this repository is the right boundary.

## Status

| Item | Current support |
|---|---|
| Maturity | Experimental, Active, Stable, Maintenance, or Archived |
| Platforms | SUPPORTED_PLATFORMS |
| Primary surface | CLI, TUI, library, website, service, asset, configuration, or documentation |
| Limitations | CURRENT_LIMITATIONS |

## User stories

- As a SPECIFIC_USER, I can COMPLETE_A_TASK, so that VALUABLE_OUTCOME.

## Getting started

State prerequisites and the starting state, then give the shortest successful path.

```bash
BOOTSTRAP_OR_INSTALL_COMMAND
FIRST_SUCCESSFUL_COMMAND
```

Expected result: DESCRIBE_SUCCESS.

## Usage

Document the stable primary task. Link detailed tasks to the user guide. Rename this section to **API** for a library or service when that is clearer.

```bash
SUPPORTED_COMMAND --long-option VALUE
```

## Documentation

| Goal | Document |
|---|---|
| Understand the project boundary | [Project hub](docs/index.md) |
| Install and use the project | [User guide](docs/User%20Guide.md) |
| Develop and validate changes | [Developer guide](docs/Developer%20Guide.md) |
| Browse published documentation | [projectmambo.org/PROJECT_SLUG/](https://projectmambo.org/PROJECT_SLUG/) |

## Project structure

```text
PATH/        PURPOSE_AND_OWNERSHIP
README.md    repository entry point
LICENSE      licence text
```

Name generated, synchronized, vendored, and ignored output explicitly.

## Validation

Run from the repository root:

```bash
AUTHORITATIVE_CHECK_COMMAND
git diff --check
git status --short
```

## Development

Read the [developer guide](docs/Developer%20Guide.md) for prerequisites, bootstrap, architecture, workflows, generated files, and delivery. Canonical Project Mambo documentation lives under `notes/Docs/Projects/PROJECT_NAME/` and must be synchronized after edits.

Use short-lived branches and Conventional Commits. State the real issue, contribution, and security-reporting routes.

## License

Distributed under the LICENSE_NAME. See **[LICENSE](LICENSE)** for details.
