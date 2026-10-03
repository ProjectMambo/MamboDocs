---
description: Complete repository, product, documentation, interface, lifecycle, dependency, and delivery standards for Project Mambo.
title: MamboDocs
order: 20
---

::page{layout="project" width="normal" sidebar=true}

# MamboDocs

MamboDocs is the operating standard for Project Mambo repositories. It gives users, contributors, maintainers, and tools predictable project boundaries while allowing applications, libraries, commands, websites, assets, documentation, and personal configuration to keep only the structure they need.

::button{label="Source repository" href="https://github.com/ProjectMambo/MamboDocs" variant="secondary" external=true}

## Use the standard

For a new project, begin with the product definition and new-repository checklist. For an existing project, use the page matching the boundary being changed and record any applicable exception. The repository checker validates the objective baseline; human review validates truth, safety, and usability.

## Core contract

- Define motivation, users, current scope, non-goals, and maturity before architecture.
- Author documentation once in the notes vault and synchronize complete repository snapshots.
- Make the README, user path, developer setup, public interfaces, lifecycle, and validation route discoverable.
- Keep commands and scripts copyable, deterministic where practical, and safe around user-owned state.
- Treat commands, package exports, routes, configuration, files, and stored data as versioned consumer contracts.
- Pin provider inputs, wrap project-specific dependency mapping in the consumer, and keep ordinary builds self-contained.
- Validate each coherent phase, use Conventional Commits, and separate local changes from remote publication.
- Apply requirements proportionally and record bounded exceptions instead of inventing ceremony.

## Define and document a project

::children{include=["[[Product Definition]]","[[Starting a Repository]]","[[Repository and Documentation]]","[[User Guide]]","[[Developer Guide]]"] view="list" sort="order" direction="asc" show=["title","description"]}

## Design and maintain contracts

::children{include=["[[Commands and Scripts]]","[[Interfaces]]","[[Lifecycle]]","[[Dependencies]]"] view="list" sort="order" direction="asc" show=["title","description"]}

## Validate and govern delivery

::children{include=["[[Validation and Delivery]]","[[Codex Workflow]]","[[Exceptions]]"] view="list" sort="order" direction="asc" show=["title","description"]}

## Source of truth

Canonical pages live under `notes/Docs/Projects/MamboDocs/`. The MamboDocs repository and this published section are synchronized outputs. Standards changes update canonical page metadata, run the sync, and validate the complete result.

## Scope

MamboDocs defines the shared baseline and provides copyable templates plus a small read-only checker. It does not generate application architecture, force a common language, or claim that every existing Project Mambo repository already conforms.
