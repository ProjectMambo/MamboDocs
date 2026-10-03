# Canonical documentation workflow

## Source of truth

Project documentation is authored under:

```text
~/ProjectMambo/notes/Docs/Projects/<Repository>/
```

Update that tree for user-visible behavior, installation, commands, public
APIs, architecture, compatibility, migration, project status, or version
changes. Do not author the same change first in the repository's root
`README.md` or `docs/` snapshot.

Use the MamboDocs standard to choose the relevant page. Keep the README useful
as the short entry point; put detailed user and developer guidance in focused
pages. Update versions in the manifest and canonical notes together when a
change actually changes the released contract.

## Synchronize

After each coherent canonical documentation edit, run:

```bash
cd ~/ProjectMambo/notes
node Scripts/sync_docs.js --sync <Repository> MamboWiki
```

For `MamboWiki`, list it once. For the organization profile, use
`ProjectMambo`; it is a named standalone export. The Mambo post-edit hook also
runs this targeted synchronization when it sees a canonical notes edit, but
the delivery phase remains responsible for checking the result.

Review every generated addition, modification, and deletion. Run the owning
repository's documentation checks and `git diff --check` before committing.
Commit synchronized output in the repository that owns it; do not mix unrelated
repositories into one Git commit.
