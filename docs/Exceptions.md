---
description: Apply the shared standard without inventing irrelevant interfaces or hiding repository-specific risk.
title: Exceptions
order: 60
---

::page{layout="docs" width="normal" sidebar=true}

# Exceptions

Consistency means using the same rule for the same kind of boundary. It does not mean giving every repository the same files.

| Repository type | Explicit exception |
|---|---|
| MamboDocs | No CLI, bootstrap, install, package version, or release is needed. |
| MamboDot | Fixed workstation paths and live mutations are legitimate; preview, adoption warnings, dependency checks, and symmetric unstow remain required. |
| MamboFinance | The current TUI is demo-backed; no installation or release contract is required until the durable application path is implemented. |
| MamboFolio and MamboWiki | `npm ci` is bootstrap. Deployment is the release operation; no install or uninstall script is required. |
| MamboColour and MamboFont | Generated artifacts may be committed when the repository declares them. Public command compatibility and safe symlink installation apply. |
| MamboSite | The compiler and four npm packages are one compatibility unit. Sites may temporarily use sibling `file:` dependencies only with an exact CI provider commit. |
| MamboWiki | `docs/_mounts/` is a committed synchronized input snapshot. Generated TypeScript, managed assets, `.next/`, and `out/` remain untracked. |

## Recording a deviation

When a project cannot meet a relevant rule:

1. state the current behavior in its README or operating guide;
2. explain the user or data risk, not merely that the work is unfinished;
3. preserve a safe manual validation path;
4. add the smallest fix when a real consumer or failure requires it.

Do not weaken trust-boundary validation, destructive-action confirmation, accessibility basics, or safeguards against overwriting user-owned files.

## Non-goals

MamboDocs does not require:

- a shared script framework;
- a generator for README files;
- identical languages or package managers;
- CI for a repository that has no meaningful remote automation yet;
- releases for sites, docs, or personal configuration;
- speculative APIs for future consumers.
