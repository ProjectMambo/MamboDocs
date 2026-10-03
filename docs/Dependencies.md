---
description: Select, pin, update, audit, and remove dependencies through explicit provider and consumer boundaries.
title: Dependencies
order: 90
---

::page{layout="docs" width="normal" sidebar=true}

# Dependencies

Dependencies trade owned code for an external compatibility, security, licence, and maintenance commitment. Add one only when it is smaller and safer than the capability Project Mambo would otherwise maintain.

## Selection

Before adding a dependency, record the real capability it provides and check:

- the standard library, platform, or existing dependency does not already cover it;
- its licence is compatible with the repository and intended distribution;
- its maintenance, release, security, and ownership signals are acceptable;
- supported platforms and runtime versions match the project;
- its transitive tree, binary size, build time, and network requirements are proportionate;
- its public types do not need to leak across the project's own boundary;
- removal or replacement remains possible at a clear adapter or package boundary.

Do not add a dependency for one trivial helper, speculative future use, or a development convenience that complicates every consumer.

## Classify dependencies

Keep runtime, build, development, optional, peer, and platform dependencies in the ecosystem's appropriate categories. A dependency needed only to regenerate a committed artifact is a maintainer-time dependency, not automatically a requirement for every user or production build.

Document external system dependencies—databases, services, fonts, operating-system packages, commands, sibling repositories—with the same care as package-manager entries.

## Pinning and locks

Applications, commands, websites, and reproducible tools commit lockfiles and use locked modes in CI. Libraries normally publish supported version ranges while testing against their resolved lockfile according to ecosystem convention.

Prefer a released provider version. An exact Git commit is acceptable during coordinated sibling development when:

- the consumer records the commit in its manifest or CI;
- the provider commit exists remotely before the consumer is delivered;
- lockfiles are committed;
- the temporary relationship and update path are documented;
- provider and consumer checks both run.

Never depend on an unpinned moving branch for a reproducible build. Avoid local `file:` or sibling paths in delivered manifests unless the product is intentionally a workspace and CI proves the complete workspace.

## Provider contract

A provider owns:

- the public command, package, service, file, or asset grammar;
- input validation and domain rules;
- deterministic output for pinned inputs where applicable;
- compatibility, deprecation, and release policy;
- focused tests and documentation for the public boundary.

The provider does not own each consumer's layout, naming, release timing, or semantic mapping.

## Consumer boundary

A consumer depends only on the provider's documented public surface. Put project-specific mapping and generated-file placement behind one consumer-owned adapter or update script. That boundary owns:

- the selected provider version, exact commit, format, and options;
- mapping provider concepts into the consumer's model;
- destination paths and stable consumer-facing names;
- validation that required provider values exist;
- a check showing whether regenerated output differs;
- consumer-specific recovery when the provider fails.

Do not import another repository's internal modules or reach into its unversioned paths. If two projects need the same real library boundary, make that boundary public in the provider rather than copying internals.

## Generated and vendored inputs

Commit generated or vendored input when ordinary builds must remain self-contained, offline-capable, or independent from a maintainer toolchain. Document:

- authoritative source and licence;
- exact provider version or checksum;
- update command and required tools;
- deterministic comparison method;
- which generated files reviewers should inspect;
- whether manual edits are forbidden.

Do not commit caches or build output merely because they are expensive to recreate. Generated files move in the same logical change as their source or provider pin.

## Updates

Dependency updates are reviewable changes, not background noise. For each update:

1. read the direct dependency's release and migration notes;
2. inspect meaningful lockfile and transitive changes;
3. verify licence, platform, runtime, and security implications;
4. regenerate declared outputs;
5. run contract, integration, and production-build checks;
6. update compatibility documentation when behavior changed;
7. deliver providers before consumers.

Group updates only when they form one compatibility unit. Keep unrelated major upgrades separate so failures and rollback remain understandable.

## Security and provenance

Use official registries or verified upstream release sources. Preserve package-manager integrity data and checksums for directly distributed artifacts. CI installation must not execute unreviewed scripts with broader credentials than required.

Run the ecosystem's available advisory audit at an appropriate cadence, but review findings for reachability and actual project impact. Record accepted risk with scope, mitigation, owner, and review condition. Never suppress a finding solely to make a badge pass.

## Licences and attribution

Track direct and bundled dependency licences. Include notices and source offers required by the licences of distributed binaries, fonts, themes, icons, or vendored code. A repository licence does not replace third-party attribution.

## Removal

Remove unused dependencies, feature flags, update scripts, lockfile entries, generated outputs, and documentation together. Run the complete build after removal; an import search alone does not prove a build-time or dynamically loaded dependency is unused.

No generic cross-repository adapter framework is required. One explicit boundary per real dependency is easier to audit and replace.
