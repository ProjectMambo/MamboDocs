---
description: Define phased work, authoritative checks, conventional commits, review evidence, and safe push, release, or deploy paths.
title: Validation and delivery
order: 100
---

::page{layout="docs" width="normal" sidebar=true}

# Validation and delivery

Every repository documents one authoritative validation sequence proportional to its risk. Run the smallest focused check while editing and the complete sequence before a phase is committed or delivered. Automation must use the same underlying commands.

## Organize work into phases

Turn a multi-part request into coherent, independently verifiable increments. A typical feature uses:

1. contract and documentation;
2. core behavior;
3. interface or integration;
4. validation and hardening;
5. release or deployment preparation.

Use only the phases the work needs. Each phase has an outcome, affected boundary, acceptance evidence, and one logical Conventional Commit. Do not split work by arbitrary file count, and do not mix unrelated cleanup into a feature phase.

Open a short-lived branch for a new increment when the repository is clean and the work is not already on an appropriate branch. Use a descriptive lowercase branch such as `feat/repository-manager` or `docs/mambo-standard`. Never discard or absorb unrelated work to make branch automation convenient.

## During implementation

- Inspect repository instructions, current status, public callers, and tests before editing.
- Keep user-owned and pre-existing changes intact.
- Run focused checks after the behavior they cover changes.
- Update tests and documentation with the public behavior, not as an afterthought.
- Regenerate outputs only through their declared source command.
- Review the diff for secrets, accidental binaries, debug output, unrelated formatting, and stale files.
- Stop before remote mutation when required authority, credentials, or a product choice is missing.

Automatic commits or pushes never override a failed gate, merge conflict, protected branch, destructive operation, or explicit user instruction.

## Objective repository standard check

MamboDocs provides a read-only baseline checker:

```bash
/path/to/MamboDocs/script/check-repository.sh /path/to/repository
```

The default mode is advisory so it can run after an edit in a work-in-progress tree. It reports missing baseline files, README sections and badges, page metadata, heading problems, duplicate page order, and broken local Markdown links without changing anything.

Use strict mode as a delivery or CI gate:

```bash
/path/to/MamboDocs/script/check-repository.sh --strict /path/to/repository
```

The checker validates objective structure only. It cannot prove that status, user stories, commands, recovery steps, API behavior, or project-specific exceptions are truthful.

## Minimum checks

All repositories run:

```bash
git diff --check
git status --short
```

Add the gates that match the real surface:

| Surface | Required evidence |
|---|---|
| Bash | `bash -n` and a focused behavioral smoke test |
| Python | syntax/import check plus repository tests |
| Rust | `cargo fmt --check`, tests, and Clippy at the documented warning policy |
| TypeScript or Next.js | format/lint, typecheck, content checks, tests, and production build as applicable |
| CLI | help/version smoke tests, invalid input, stdout/stderr, and exit statuses |
| TUI | state-transition tests plus terminal-size and primary-flow smoke checks |
| HTTP service | contract, authorization, validation, failure, migration, and health checks |
| Generated assets | regenerate from pinned inputs and compare reviewed output |
| Documentation | repository checker, sync self-test, link/content validation, and site build |
| Installer or migration | clean install, repeat, conflict, interruption/recovery, and removal boundaries |

Do not claim a gate that does not run. Label unavailable platform or external checks as current limitations and identify where they do run.

## Test quality

Test public behavior and important failures at the lowest useful layer. A non-trivial branch, parser, migration, or destructive operation needs a runnable regression check. Keep fixtures small, deterministic, synthetic, and free of secrets.

Mock at external boundaries, not throughout domain logic. Use real serialization, filesystem, database, or terminal behavior when that is the contract under test and the test remains isolated. Network and time dependencies must be controlled or explicitly separated from the default deterministic gate.

Coverage is diagnostic, not proof. Never add assertions that merely execute lines without checking an outcome.

## Documentation synchronization

Edit canonical docs under `notes/Docs/Projects/<Repository>/` and update each changed page's `updated` metadata. Then run from `notes/`:

```bash
node Scripts/sync_docs.js --sync <Repository>
```

When the Wiki mount or site navigation changes, also synchronize or validate MamboWiki through its documented path. Review the root README and complete `docs/` replacement, including additions and deletions. A no-op sync is acceptable; a hand-edited exported snapshot is not.

## Conventional Commits

Use:

```text
type(scope): concise imperative summary
```

Common types are `feat`, `fix`, `refactor`, `docs`, `test`, `build`, `ci`, `perf`, `style`, `revert`, and `chore`. Use `!` and a `BREAKING CHANGE:` footer for a breaking public contract.

One commit represents one logical phase that passes its applicable checks. Keep required generated output with the source or pin that produced it. Keep unrelated pre-existing work unstaged. Documentation synchronization may be part of the behavior commit when inseparable, or its own `docs:` commit when it updates snapshots across repositories.

Commit messages explain the outcome; they do not claim tests that were not run. Do not create empty checkpoint commits solely to satisfy automation.

## Review and handoff evidence

Before delivery, record:

- the user-visible outcome and current limitations;
- changed public boundaries, data, configuration, dependencies, and generated files;
- exact validation commands and results;
- checks not run and why;
- migration, rollback, deployment, or follow-up requirements;
- any exception and its review condition.

Review the staged diff and repository status immediately before committing. A successful earlier test does not cover edits made afterward.

## Push and merge

Push the phase branch only after its gate passes. Use the repository's configured remote and upstream; do not rewrite a shared branch. Verify remote CI before merging. Resolve conflicts by re-running affected checks, not by assuming the previous results still apply.

Merge at a coherent increment boundary when acceptance criteria pass and documentation describes the resulting state. Delete a merged short-lived branch when it has no ongoing purpose. Do not merge a placeholder into a stable public surface under the label of a completed feature.

Providers are pushed and published before consumers so every advertised version or commit can be resolved. Coordinate branches when a consumer cannot pass until its provider change exists.

## Release and deploy

Release and deployment are explicit remote mutations after ordinary validation. Follow [Lifecycle and versioning](Lifecycle.md) for version agreement, clean-tree checks, release notes, tags, artifacts, and publication verification.

For a configured website, use its single documented deploy command after committing and leaving the worktree clean. Do not manually push and then invoke a deploy command that also pushes unless a second run is intended. Verify the remote workflow and published route.

## CI baseline

CI should start from a clean checkout, use locked dependencies, run the documented strict gates, use least-privilege permissions, and avoid persistent credentials for untrusted code. Cache only reproducible inputs and never let a cache determine correctness. Pin third-party actions to an approved immutable version or commit according to repository policy.

Keep CI understandable: one job per meaningful platform or gate, clear names, and no duplicated hidden validation path. Local and remote results should disagree only where the environment is intentionally different.
