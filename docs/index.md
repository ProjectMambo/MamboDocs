---
description: Shared repository, documentation, interface, dependency, and delivery standards for Project Mambo.
title: MamboDocs
order: 20
---

::page{layout="project" width="normal" sidebar=true}

# MamboDocs

MamboDocs is the operating standard for Project Mambo repositories. It keeps documentation consistent while allowing sites, libraries, command-line tools, applications, assets, and personal configuration to retain the structure they actually need.

::button{label="Source code" href="https://github.com/ProjectMambo/MamboDocs" variant="secondary" external=true}

## Standard

- Author documentation once and synchronize complete repository snapshots.
- Treat commands and package exports as public contracts.
- Wrap cross-project calls in one consumer-owned update script.
- Pin provider inputs and keep ordinary builds self-contained.
- Make lifecycle scripts safe, idempotent, and clear about mutations.
- Record checks, conventional commit boundaries, and the correct push or deploy path.

## Documentation

::children{view="list" sort="order" direction="asc" show=["title","description"]}

## Scope

MamboDocs is documentation only. It does not introduce a shared framework or force code into a repository that does not need it.
