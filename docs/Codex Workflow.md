---
description: Apply phased delivery, canonical documentation synchronization, and repository checks automatically in Codex.
title: Codex workflow
order: 105
---

::page{layout="docs" width="normal" sidebar=true}

# Codex workflow

MamboDocs includes the `mambo-workflow` Codex plugin. It makes the shared delivery rules available in future Project Mambo tasks and runs a focused documentation guard after file edits.

## What the skill does

For a change request in a Project Mambo repository, the `mambo-project-workflow` skill:

- turns numbered jobs into coherent implementation phases;
- starts or reuses a short-lived increment branch when appropriate;
- validates, creates a Conventional Commit, and pushes each completed phase;
- updates documentation from the canonical notes source;
- merges a completed increment when repository policy permits it; and
- stops safely for conflicts, failed checks, protected branches, missing credentials, or required review.

The workflow preserves unrelated work and never treats automation as permission to force-push, publish a release, bypass protection, discard changes, or delete an unrelated branch.

For a coordinated change across repositories, each repository remains an independent delivery lane. The workflow validates and pushes every lane before merging any of them, then merges providers and canonical sources before consumers and generated website snapshots. A partial remote failure leaves the verified branches available for recovery instead of publishing an incomplete compatibility change.

## What the hook does

After Codex uses a supported file-editing tool, the `PostToolUse` hook examines only the edited paths. A change under `notes/Docs/Projects/<Repository>/` triggers the existing targeted sync command:

```bash
cd ~/ProjectMambo/notes
node Scripts/sync_docs.js --sync <Repository> MamboWiki
```

For edited Project Mambo repositories, it runs the MamboDocs checker in advisory mode and returns useful context to Codex. It warns when a synchronized `README.md` or `docs/` snapshot was edited directly. The hook does not commit, push, merge, or modify source code; those transitions remain explicit skill steps after validation.

## Install and trust

The versioned plugin source lives at `MamboDocs/codex/plugins/mambo-workflow/`. Install it in the personal Codex plugin marketplace so it applies in future tasks, then review and enable its command hook when Codex presents the trust prompt. Hook trust is a user decision because the command runs automatically after matching edits.

After changing the plugin, run its unit tests and both package validators before reinstalling the personal copy. Keep the versioned MamboDocs source authoritative; do not maintain an independent personal variant.

## Verify the repository guard

The repository checker can also be run directly:

```bash
MamboDocs/script/check-repository.sh /path/to/repository
MamboDocs/script/check-repository.sh --strict /path/to/repository
MamboDocs/script/check-repository.sh --self-test
```

Advisory mode is useful during a phase. Strict mode is the delivery gate, and the self-test verifies the checker itself.
