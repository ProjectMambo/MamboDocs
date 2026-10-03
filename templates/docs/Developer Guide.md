---
created: YYYY-MM-DD
updated: YYYY-MM-DD
project: "[[Docs/Projects/PROJECT_NAME/_info|PROJECT_NAME]]"
description: Set up, understand, validate, and deliver changes to PROJECT_NAME.
title: Developer guide
order: 30
---

::page{layout="docs" width="normal" sidebar=true}

# Developer guide

## Prerequisites

List supported tool versions, platforms, optional tooling, and external services.

## Fresh-clone setup

```bash
LOCKFILE_AWARE_BOOTSTRAP_COMMAND
LOCAL_RUN_OR_PREVIEW_COMMAND
```

State expected results and any filesystem, network, container, service, or credential effects.

## Repository map

| Path | Ownership and purpose |
|---|---|
| `PATH/` | SOURCE_GENERATED_VENDORED_OR_BUILD_ROLE |

## Architecture

Describe components, dependency direction, data flow, persistence, integrations, and trust boundaries.

## Local workflow

| Task | Command |
|---|---|
| Run or preview | `COMMAND` |
| Format | `COMMAND` |
| Test | `COMMAND` |
| Check | `COMMAND` |
| Build | `COMMAND` |

## Generated files

For each generated path, name the authoritative source, update command, review expectation, and commit policy.

## Testing and validation

Give the authoritative command order, expected external checks, and limitations.

## Public changes and versions

Explain compatibility, migrations, deprecation, version source, and release or deployment path.

## Documentation workflow

Edit `notes/Docs/Projects/PROJECT_NAME/`, update page metadata, then run:

```bash
cd /path/to/ProjectMambo/notes
node Scripts/sync_docs.js --sync PROJECT_NAME
```

## Contribution and delivery

State branch, Conventional Commit, review, issue, security, merge, and remote-publication expectations.
