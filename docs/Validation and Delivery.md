---
description: Define authoritative checks, conventional commit boundaries, and the correct push, release, or deploy path.
title: Validation and delivery
order: 50
---

::page{layout="docs" width="normal" sidebar=true}

# Validation and delivery

Every repository documents one authoritative validation sequence proportional to its risk. Run it before committing; automation should use the same commands when CI exists.

## Minimum checks

All repositories run:

```bash
git diff --check
git status --short
```

Add the language-native gates that apply:

| Surface | Typical gates |
|---|---|
| Bash | `bash -n` and a focused smoke test |
| Python | syntax/CLI smoke tests and repository tests |
| Rust | `cargo fmt --check`, tests, and Clippy at the repository's warning policy |
| TypeScript/Next.js | lint, typecheck, content validation, and a production build |
| Generated assets | regenerate into a temporary directory and compare reviewed outputs |
| Documentation | sync self-tests, link/frontmatter checks, and MamboWiki content validation |

Do not claim a gate that the current repository cannot run. Record missing CI or unavailable external tooling as a current limitation.

## Commit boundaries

Use Conventional Commits:

```text
type(scope): concise imperative summary
```

Common types are `feat`, `fix`, `refactor`, `docs`, `test`, `build`, `ci`, and `chore`. One commit should represent one logical, independently reviewable change. Keep generated outputs with the source change that produced them when they are required for that change; keep unrelated pre-existing work separate.

Documentation synchronization is normally its own `docs:` commit because it replaces complete snapshots across repositories.

## Push and deploy

For an ordinary repository:

```bash
git push origin <branch>
```

For a configured MamboSite website, commit first and leave the worktree clean, then run:

```bash
npm run deploy
```

`mbsite deploy` performs the build and either pushes the ahead commit or dispatches the configured workflow. Do not manually push and then deploy unless a second workflow run is intended. Verify the GitHub Actions and Pages result after the command returns.

Push providers before consumers so remote history never advertises a consumer pin that cannot be resolved. MamboSite's Rust compiler and four npm packages move as one compatibility unit; update MamboFolio and MamboWiki pins only after the selected provider commit exists remotely.

## Documentation synchronization

After editing canonical project docs:

```bash
cd ~/ProjectMambo/notes
node Scripts/sync_docs.js --sync <Owner> MamboWiki
```

Review `README.md` and the complete `docs/` replacement, stage additions and deletions, rerun checks, and commit only when the diff is non-empty.
