# Delivery workflow

## Start an increment

1. Inspect `git status --short --branch`, remotes, the current branch, and the
   repository's documented validation commands.
2. If the repository has no first commit, establish its requested initial
   structure on `main`; an empty repository does not need a ceremonial feature
   branch.
3. Otherwise, start new implementation work from an up-to-date default branch
   only when the worktree is clean. Reuse an existing branch when it clearly
   belongs to the same increment.
4. Name a new branch `<type>/<short-kebab-summary>`, using `feat`, `fix`,
   `refactor`, `docs`, or `chore` as the type.

Do not stash, reset, rebase, or switch away from unrelated dirty work to force
a branch transition. Work around it safely or ask for direction when that is
not possible.

## Work by phase

A phase is a coherent, independently verifiable slice, not one file edit. For
each phase:

1. implement the slice;
2. update its tests and canonical docs;
3. run the narrow checks for the slice, then any repository gate it affects;
4. review the diff and exclude unrelated files;
5. commit with `type(scope): imperative summary`;
6. push the current branch with upstream tracking when needed.

Use additional commits only for genuinely separate phases. Do not create empty
checkpoint commits, and do not claim a push succeeded without checking the
command result.

## Coordinate multiple repositories

Treat each Git repository as an independent delivery lane. Use the same branch
suffix across clean repositories when that makes the shared increment obvious,
but never switch a repository away from unrelated dirty work. If the canonical
notes vault is not itself versioned, synchronize from it and report that source
state instead of inventing a commit.

Before merging any lane, validate every affected repository and push every
completed increment branch. Merge dependency providers and canonical sources
first, application consumers next, and generated website or profile snapshots
last. Re-run the dependent gate after a provider's final commit when its pinned
revision changed.

If one repository cannot push or merge, leave all remaining verified branches
intact and report their names and commits. Do not delete a coordinated branch,
publish only half of a required compatibility change, or move unrelated work
between repositories to manufacture a clean transition.

## Complete the increment

After every requested job is complete:

1. run the full documented validation sequence;
2. confirm canonical docs have been synchronized and the branch is clean;
3. fetch the remote default branch without rewriting history;
4. while still on a clean local default branch, fast-forward it to
   `origin/<default>` with `git merge --ff-only`; stop if it has diverged;
5. use the repository's required pull-request path when branch protection or
   review policy requires it;
6. otherwise merge the completed branch into the local default branch without
   squashing the phase commits, push the default branch, and delete only the
   now-merged increment branch locally and remotely;
7. report the resulting default-branch commit and any remote transition that
   could not be completed.

Never force-push. If the default branch advanced and a clean merge is not
possible, leave the verified branch pushed and report the conflict or required
review instead of guessing.
