---
description: Current maintenance stages and exit gates for evolving the MamboDocs standard, checker, templates, and workflow plugin.
title: Development plan
order: 120
---

::page{layout="docs" width="normal" sidebar=true}

# Development plan

MamboDocs is an active documentation standard with a small read-only checker, copyable templates, and a reusable Codex workflow plugin. Its development work preserves consistency between the written standard and those enforcement aids without turning the repository into a general project generator.

## Current state

The canonical standard is authored in the Project Mambo notes workspace and synchronized into MamboDocs and MamboWiki. The repository checker validates objective structure, templates provide starting documents, and the workflow plugin describes branch, delivery, and canonical synchronization behavior. MamboDocs is documentation-only, unversioned, and has no runtime service or package release.

## Target maintenance state

Every requirement has one clear canonical explanation, objective rules have focused checker coverage, templates reflect the current minimum, and workflow automation never contradicts the documented delivery process. A clean synchronization and complete repository gate must prove each change before it reaches main.

MamboDocs does not aim to generate application architectures, replace project-specific judgment, enforce subjective prose quality mechanically, or force identical files on different repository types.

## Stage 1: Maintain the written standard

Start each change from an observed documentation, safety, compatibility, or contributor problem. Update the smallest applicable canonical page, examples, navigation, README map, and exception guidance. Separate current requirements from future ideas and state applicability by project type.

Exit gate: the rule is unambiguous, proportional, linked from the appropriate entry point, and does not conflict with another standard page.

## Stage 2: Align objective enforcement

When a rule is objective and broadly applicable, update the read-only repository checker and its embedded self-test. Keep subjective truth, architecture quality, and prose review with humans. A new check must identify the exact file and remediation without modifying the inspected repository.

Exit gate: shell syntax, checker self-test, strict self-check, and relevant positive and negative fixtures pass.

## Stage 3: Align templates and workflow guidance

Update only the templates affected by the standard change. Preserve placeholders that force a deliberate project-specific choice and do not add empty directories or speculative APIs. If the delivery or canonical-source contract changes, update the workflow skill and hook tests in the same phase.

Exit gate: a maintainer can copy the affected template, replace its placeholders, and satisfy the checker without discovering a contradictory instruction.

## Stage 4: Synchronize and publish

Synchronize canonical MamboDocs pages into the repository and MamboWiki mount, review every generated addition, modification, and deletion, then run both repositories' documented gates. Deliver the canonical provider before generated consumers and stop on conflicts or failed checks.

Exit gate: MamboDocs and MamboWiki are clean on their default branches at the intended commits, published navigation exposes every routed child once, and no generated snapshot differs from the canonical source.

## Validation and risks

The complete gate is the documented sync, shell syntax check, checker self-test, workflow-hook unit tests, strict repository check, and diff validation. MamboWiki then performs its own content and production-build checks.

The main risks are a written rule drifting from the checker or templates, an objective check accidentally enforcing a subjective preference, and generated mounts being committed without their canonical source. The mitigation is provider-first review, focused self-tests, human applicability review, and complete sync-diff inspection.

Future complexity requires evidence. Add a generator, schema, versioned release, or larger policy engine only when repeated maintenance failures cannot be solved by the current Markdown, templates, and small checker.
