---
description: Document fresh-clone setup, architecture, workflows, testing, generated files, and contribution delivery for developers.
title: Developer guide
order: 50
---

::page{layout="docs" width="normal" sidebar=true}

# Developer guide

A developer guide turns a clean clone into a trustworthy change. It explains the repository's boundaries and decisions without duplicating what the package manifest, command help, or source already says clearly.

## Prerequisites

List required tools, supported versions, platform assumptions, and external services. Prefer version files or manifests that development tools can read. Distinguish required dependencies from optional tools used only for release, documentation, or a specific integration.

Never require a global package when the ecosystem supports a locked project dependency. Do not require access to an unpublished sibling checkout for the ordinary build unless the repository is explicitly in a coordinated transition.

## Fresh-clone setup

Give one authoritative, lockfile-aware bootstrap path. It must be safe to run twice and must fail clearly when a required tool is missing. State any network access, user-level installation, container, database, credential, or filesystem mutation before it occurs.

After bootstrap, provide the smallest local run, test, or preview command and its expected result. If setup cannot be fully automated, keep the manual steps few, verifiable, and reversible.

## Repository map

Explain only meaningful top-level paths and ownership boundaries:

- implementation and public entry points;
- tests and fixtures;
- repository automation;
- canonical versus synchronized documentation;
- generated, vendored, cached, and build outputs;
- configuration and migration files;
- deployment or packaging assets.

For each generated path, name its source, update command, review expectation, and whether it is committed. A directory listing without these decisions is not an architecture guide.

## Architecture

Describe the main components, direction of dependencies, data flow, persistence, external systems, and trust boundaries. A compact diagram is useful only when it clarifies relationships that prose cannot.

Keep policy and domain behavior behind a small core boundary. User interfaces, transport adapters, persistence, and integrations should depend on that core rather than define it. Document deliberate exceptions and the pressure that would justify changing the design.

Do not mirror every class or module in prose. Public API reference should be generated or maintained at the public boundary; implementation names can change without forcing a documentation rewrite.

## Local workflow

Document stable tasks with their exact commands:

| Task | Contract |
|---|---|
| Bootstrap | prepare a clean clone reproducibly |
| Run or preview | start the primary development surface |
| Format | apply deterministic formatting only |
| Check | run the complete local delivery gate without publishing |
| Test | run behavioral tests, with focused-test examples if useful |
| Generate | refresh reviewed derived files from declared sources |
| Package or build | create the same artifact automation validates |
| Deploy or release | mutate a remote only after all earlier gates pass |

Reuse the language's native task runner where it is clear. If the repository provides wrappers, they remain thin, documented, and responsible for returning child exit codes.

## Tests and validation

State the authoritative command order and what each gate proves. Include unit, integration, end-to-end, content, snapshot, migration, accessibility, or platform checks only when the project actually has them.

A behavioral change adds the smallest regression check that would fail without it. Tests should cover public behavior and important failure paths rather than implementation trivia. Network-dependent tests must be explicit; default checks should be deterministic where practical.

When a required gate is unavailable locally, say which environment runs it and how the contributor verifies the result. Never document a check that silently skips its main assertion.

## Configuration, secrets, and test data

Document safe example configuration and precedence. Keep real secrets outside the repository and prevent them from appearing in logs or snapshots. Fixtures must be synthetic or explicitly licensed and must not contain personal data.

State how local state is reset without risking unrelated user files. Destructive development commands require a verified, repository-owned target and a clear confirmation or deliberately test-only environment.

## Changing public behavior

Before changing a command, package export, HTTP route, file format, configuration key, schema, or stored data:

1. identify current consumers;
2. define compatibility and migration behavior;
3. update contract tests and public documentation;
4. add a deprecation period when a safe compatibility path exists;
5. select the correct version change;
6. coordinate provider and consumer delivery order.

Use an architecture decision record when the change is difficult to reverse or crosses repository boundaries.

## Documentation workflow

Canonical Project Mambo docs live in the notes vault. Edit `notes/Docs/Projects/<Repository>/`, update the changed page's `updated` metadata, and run the synchronization script after each documentation phase. Treat repository `README.md` and `docs/` as reviewed generated snapshots.

Code and docs that describe one public change ship together. If implementation lands before a public capability is enabled, documentation must say that the capability is unavailable rather than promise the future state.

## Contribution and delivery

Use one short-lived branch per coherent increment and Conventional Commits for independently reviewable phases. Rebase or merge according to the repository's active policy; never rewrite shared remote history without explicit coordination.

Before handoff, run the documented gates, review staged and unstaged changes, confirm no credentials or unrelated files are present, synchronize docs, and summarize validation and remaining limitations. Publishing, deployment, migration, and deletion are separate authorized operations.
