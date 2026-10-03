---
name: mambo-project-workflow
description: Deliver change requests in Project Mambo repositories with phased branches, conventional commits, pushes, merges, and canonical documentation sync. Use for builds, fixes, refactors, releases, or multi-job prompts in ProjectMambo repos; do not use for read-only questions.
---

# Mambo Project Workflow

Use this workflow only after verifying that the repository remote belongs to
`ProjectMambo` or that the repository is an uninitialized `Mambo*` project
under the local Project Mambo workspace.

## Shape the work

- Treat numbered requests as jobs. Group dependent work into a phase and keep
  independent jobs as separate phases.
- Use a visible plan for multiple jobs, cross-repository work, or any change
  that needs more than one coherent commit. Keep exactly one phase in progress.
- Inspect the worktree before editing. Preserve unrelated changes and never
  stage, rewrite, or publish them as part of the current request.
- For branch, commit, push, and completion rules, read
  [delivery.md](references/delivery.md).

## Keep documentation canonical

For public behavior, setup, commands, APIs, project structure, or version
changes, update the relevant Project Mambo documentation in the same phase.
Repository `README.md` and `docs/` files are synchronized outputs, not the
authoring source. Read [documentation.md](references/documentation.md) before
changing documentation or a public interface.

## Boundaries

The user's standing Project Mambo preference authorizes ordinary branch
creation, scoped commits, pushes, and completion merges described by this
skill. It does not authorize publishing releases, overwriting remote history,
deleting non-workflow branches, bypassing protection, committing unrelated
work, or resolving a conflict by discarding changes.

Stop the delivery transition and report the exact state when validation fails,
the remote or default branch is ambiguous, credentials are unavailable, a
merge conflicts, required review is pending, or a protected branch rejects the
operation. Continue all safe local implementation and validation work first.
