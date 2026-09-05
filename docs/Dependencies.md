---
description: Consume another Project Mambo repository through a thin, pinned, consumer-owned boundary.
title: Dependencies
order: 40
---

::page{layout="docs" width="normal" sidebar=true}

# Dependencies

Project Mambo repositories should share capabilities through documented commands or packages, not by reaching into another repository's internal paths.

## Provider contract

A provider owns:

- the public command or package grammar;
- input validation and domain rules;
- deterministic output for pinned inputs;
- compatibility notes and release/version policy;
- focused tests for the public boundary.

The provider does not own each consumer's file layout or semantic mapping.

## Consumer wrapper

Each consumer puts calls to a provider behind one repo-local update script. That wrapper owns:

- the provider version, exact commit, palette, format, or other selected input;
- mapping provider names into the consumer's model;
- destination paths and stable consumer-facing filenames;
- validation that all required provider values exist;
- a check showing whether regenerated output differs.

Application builds consume committed results and remain self-contained. Provider checkouts and toolchains are maintainer-time update dependencies unless the build genuinely requires live generation.

## Pinning

Prefer a released provider version. During sibling-repository development, an exact Git commit is acceptable when:

- the consumer records it in CI or an update manifest;
- package lockfiles are committed;
- docs call out the transitional sibling layout;
- provider and consumer checks run before delivery.

Never depend on an unpinned branch for reproducible CI.

## Current dependency map

| Consumer | Provider | Boundary |
|---|---|---|
| MamboDot | MamboColour | `mbcolor` command through the MamboDot update wrapper |
| MamboFolio | MamboSite | `mbsite`, four npm packages, and their bundled Project Mambo theme at one compatible revision |
| MamboSite | MamboColour | palette generation through the MamboSite theme update wrapper |
| MamboSite | MamboFont | WOFF2 compilation through the MamboSite theme update wrapper |
| MamboWiki | MamboSite | `mbsite`, four npm packages, and their bundled Project Mambo theme at one pinned revision |
| MamboWiki | all project docs | synchronized, committed content snapshot |

MamboDot intentionally does not consume MamboFont during daily setup. A locally installed font may still be referenced by desktop configuration, but rebuilding it is outside the dotfiles update path.

## Update order

1. Change and validate the provider.
2. Select a release or exact provider commit.
3. Run the consumer-owned wrapper and review generated differences.
4. Update manifests, locks, and CI pins together where applicable.
5. Run provider and consumer checks.
6. Update canonical docs and synchronize the owner plus MamboWiki.
7. Commit per repository and publish providers before consumers.

No generic cross-repository adapter framework is needed. One explicit wrapper per real dependency is the stable boundary.
