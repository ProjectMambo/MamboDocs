---
description: Keep bootstrap, installation, updates, versions, releases, deprecation, and retirement safe and understandable.
title: Lifecycle and versioning
order: 80
---

::page{layout="docs" width="normal" sidebar=true}

# Lifecycle and versioning

Lifecycle operations make a project reproducible from creation through retirement. Each operation must be explicit about prerequisites, owned state, compatibility, remote mutation, and recovery.

## Separate responsibilities

Use distinct entry points when operations have different risks:

- **bootstrap** installs development dependencies and prepares a fresh clone;
- **install** exposes a command, application, service, or user configuration;
- **update** changes an installed project or refreshes reviewed provider input;
- **migrate** changes persistent data or configuration representation;
- **uninstall** removes only integration owned by the project;
- **release** validates and publishes a versioned artifact;
- **deploy** validates and publishes one website or service revision;
- **archive** marks the project unsupported and points users to a successor when available.

A small project may need only one of these. Do not create empty scripts for symmetry, and do not overload a harmless `check` or `build` command with publication.

## Bootstrap

Bootstrap names its prerequisites, stops on missing required tools, uses lockfile-aware native commands, and is safe to run twice. It must state network access, user-level installs, containers, services, credentials, and filesystem mutations before they occur.

Automation should use deterministic modes such as `npm ci` or `cargo build --locked`. Optional tooling must remain optional. A personal workstation bootstrap may change live configuration, but it must preview changes where possible, warn before adopting existing files, and provide a symmetric unapply path.

## Installation

Installation must define:

- supported platforms and architectures;
- artifact source and integrity verification;
- installed commands, files, services, and data locations;
- required privilege and why it is needed;
- behavior when an owned target already exists;
- behavior when an unrelated target conflicts;
- how the installed version is inspected;
- the exact uninstall boundary.

An installer for an `mb...` command resolves its source relative to itself, supports a documented bin-directory override, creates or refreshes an owned link idempotently, refuses to overwrite unrelated files, and warns when the destination is not on `PATH`. Use elevated privilege only for the final operation that needs it.

## Updates and migrations

An update determines the current and target version, checks compatibility and available space where relevant, validates downloads before replacement, preserves user-owned state, and reports partial failure precisely. Prefer atomic replacement with a rollback path.

A data migration is a separate, versioned contract. Back up or export before an irreversible step, record completion transactionally, and test both the supported upgrade path and interruption recovery. Do not claim rollback when the new version writes data an older version cannot understand.

## Uninstall and removal

Uninstall removes only verified paths the project owns. It distinguishes installed program files, user configuration, durable user data, caches, logs, services, credentials, and remote resources. Preserve user data by default and name an explicit separate action for its deletion.

Never recursively delete an unresolved environment variable, home directory, repository root, filesystem root, or path selected only by a glob. Refuse a target whose ownership cannot be proven.

## Version source of truth

A versioned repository must have one authoritative version value. Language manifests, generated constants, documentation, release notes, tags, and package metadata derive from or are validated against it. Do not independently hand-maintain the same version in several files.

Unversioned documentation, websites, and personal configuration use Git history or deployment revisions unless they publish a consumer-facing compatibility contract. “Unversioned” must not be represented by a fake `0.0.0` release.

## Semantic Versioning

Use `MAJOR.MINOR.PATCH` for distributable commands, libraries, applications, APIs, and asset bundles:

- **MAJOR** changes when a supported consumer must change;
- **MINOR** adds backward-compatible behavior;
- **PATCH** fixes behavior without changing the supported contract.

Judge compatibility across every documented surface: command grammar, output, package exports, HTTP routes, error codes, configuration, file formats, stored data, visual component contracts, and platform support. A dependency update alone does not determine the version; its consumer-visible effect does.

Before `1.0.0`, breaking changes still require clear release notes and a minor-version increase. Pre-release identifiers such as `1.2.0-beta.1` are for artifacts meant to be tested before the final release, not a substitute for honest experimental status.

## Changelog

Versioned projects keep a human-readable changelog or equivalent release history. Organize entries by release and user-visible category such as Added, Changed, Deprecated, Removed, Fixed, and Security. Explain impact and migration rather than listing commit subjects.

Maintain an Unreleased section only when the project actually curates it. Git history remains the source for implementation detail; the changelog is the consumer's compatibility record.

## Release gate

A release command completes these checks before remote mutation:

1. validate the version format and ensure it is greater than the latest release;
2. require the intended branch and a clean worktree;
3. verify manifests, lockfiles, generated version files, docs, and changelog agree;
4. run the documented tests, lint, content checks, and production build;
5. build artifacts from the tagged source and record checksums when distributed directly;
6. show the exact tag, packages, files, registry, and release notes;
7. require explicit publication authority;
8. publish in an order that can be retried safely;
9. verify the registry or release result and report partial remote state.

Prefer an annotated Git tag. A GitHub release may begin as an editable draft for final review. Never move a published release tag to different source; issue a new version.

## Cross-repository releases

Publish providers before consumers. A consumer must not advertise a dependency version or commit that is unavailable remotely. When several packages form one compatibility unit, validate and release them through one documented order and state whether their versions move together.

Generated consumer outputs remain in the consumer's commit. Provider and consumer changes may use separate branches and commits, but their release notes must identify the coordination requirement.

## Deployments

Websites and continuously deployed services normally deploy a tested commit rather than create a package release. The deploy command must build the exact revision, identify the target environment, avoid an accidental duplicate deployment, and expose the remote result.

Document rollback, configuration ownership, database migration ordering, cache invalidation, and post-deploy verification when they exist. A successful upload is not a successful deployment until the health or published route is verified.

## Deprecation and retirement

Deprecation names the replacement, migration steps, first deprecated version, and removal version or condition. Keep deprecated behavior tested until removal.

When retiring a project:

- mark the README and repository description as archived;
- stop presenting installation as supported;
- name the final supported version or revision;
- preserve migration or export guidance;
- point to a successor when one exists;
- revoke credentials and disable automation that should no longer mutate remotes;
- archive rather than delete public history unless legal or security needs require removal.

Retirement does not justify deleting user data or abandoning a documented export path.
