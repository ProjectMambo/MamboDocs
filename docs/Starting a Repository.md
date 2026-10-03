---
description: Start a Project Mambo repository with a clear purpose, safe baseline, remote, documentation, and validation contract.
title: Starting a repository
order: 20
---

::page{layout="docs" width="normal" sidebar=true}

# Starting a repository

Create a repository only when the work has an independent lifecycle, public boundary, or ownership reason. A module that always ships with one application normally belongs in that application's repository.

## Before creating it

Write the product brief first. Confirm:

- a real user, problem, and supported outcome;
- why the capability should not remain in an existing repository;
- the project type and public surface;
- the expected installation, deployment, or consumption path;
- the initial maintainer and maturity status;
- data, credential, licence, and destructive-operation risks.

Do not choose a framework, persistence layer, plugin system, or release pipeline until a current requirement needs it.

## Name and identity

Project repositories use a clear `Mambo<Name>` name and the `ProjectMambo/Mambo<Name>` GitHub path. Use the same spelling and capitalisation in the H1, repository description, documentation metadata, package descriptions, and published project list. Installed commands use the shorter `mb...` convention described in [Interfaces](Interfaces.md); package names follow their ecosystem when a registry imposes different rules.

Give the repository a one-sentence GitHub description that says what it does, not how it is implemented. Add only factual topics and badges.

## Choose the project shape

| Type | Typical public boundary | Lifecycle |
|---|---|---|
| Application | command, TUI, GUI, or service | install/update/remove or deploy |
| Command-line tool | `mb...` command | install/update/remove and SemVer releases |
| Library | package or crate exports | SemVer package releases |
| Website | routes and deployed pages | local build and commit deployment |
| Asset | documented files or generator | versioned asset release when consumed externally |
| Personal configuration | bootstrap/stow commands | preview/apply/unapply; often unversioned |
| Documentation | Markdown and published routes | synchronize and deploy; usually unversioned |

A repository may have more than one real boundary, but it should still have one primary type and one obvious starting path.

## Create the baseline

Start on `main`, configure the existing remote, and add only applicable files:

```text
README.md              required repository entry point
LICENSE                required licence text
docs/index.md          required published project hub
docs/User Guide.md     user-facing tasks when the project has end users
docs/Developer Guide.md contributor setup and architecture for code projects
script/                repository-owned automation when commands are needed
src/                   implementation when the language uses a source tree
tests/                 tests that do not live beside source
.github/workflows/     checks or deployment only when remote automation exists
```

Language manifests, lockfiles, and ignore rules belong in the first increment when the implementation needs them. Commit lockfiles for applications and executable tools. For libraries, follow the ecosystem's reproducibility policy and document the choice.

Do not create empty `src/`, `tests/`, `script/`, `examples/`, or workflow directories for symmetry.

## Establish documentation

Create the canonical source under:

```text
notes/Docs/Projects/<Repository>/README.md
notes/Docs/Projects/<Repository>/index.md
notes/Docs/Projects/<Repository>/User Guide.md
notes/Docs/Projects/<Repository>/Developer Guide.md
```

Add only the detailed pages the project needs. Register the repository with the notes synchronization script before treating repository copies as generated. Author in notes, update the page's `updated` value, synchronize, and review the complete output.

The initial README must include shield badges, motivation, status, getting started, documentation, project structure, validation, development, and licence sections. Add current user stories or link the product definition.

## Establish safety and ownership

- Select a licence before accepting reusable code or assets.
- Ignore credentials, environment files, build output, editor state, and operating-system debris before the first local run.
- Provide `.env.example` only for documented, non-secret variable names and safe example values.
- Keep secrets out of Git, command examples, screenshots, fixtures, and logs.
- Document where persistent user data lives and who owns generated files.
- Add a security-reporting route before exposing a network service or handling sensitive data.

Do not add a broad contributor covenant, governance framework, or support process that nobody will operate. State the real route and maturity honestly.

## Establish the developer contract

From a clean clone, a contributor must be able to identify:

1. required tools and supported versions;
2. the lockfile-aware bootstrap command;
3. the local run or preview command;
4. the authoritative validation command sequence;
5. generated files and how to refresh them;
6. the public boundary and compatibility policy;
7. the delivery path.

Use the ecosystem's existing task runner or package scripts before introducing another wrapper. If several commands form one required gate, provide one repository-owned `check` entry point and document what it runs.

## First increments

Open a focused branch for each coherent increment. A practical sequence is:

1. product definition and documentation baseline;
2. smallest end-to-end user path;
3. validation and failure behavior;
4. installation, release, or deployment only when the user path works.

Use Conventional Commits, keep generated output with the source that produced it, and merge only after the branch's acceptance criteria and documented checks pass. Do not publish a package, installer, or stable compatibility promise for a placeholder implementation.

## Ready checklist

A new repository is ready for ordinary development when:

- its purpose, users, status, scope, and non-goals are explicit;
- README badges and links are valid;
- the canonical docs source synchronizes cleanly;
- a fresh-clone setup path is documented and tested;
- public names and interfaces are deliberate;
- the validation sequence succeeds or every missing gate is labelled as a current limitation;
- licence, secret handling, generated files, and user-owned data are unambiguous;
- the remote, default branch, and first branch are configured without unrelated history.
