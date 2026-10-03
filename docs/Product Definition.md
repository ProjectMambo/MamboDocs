---
description: Define a Project Mambo repository by its problem, users, scope, outcomes, and current maturity.
title: Product definition
order: 10
---

::page{layout="docs" width="normal" sidebar=true}

# Product definition

A repository starts with a reason to exist, not a directory tree. Record the problem, intended users, supported outcomes, and boundaries before choosing architecture or tooling. Keep this definition current as the project matures.

## Standard language

MamboDocs uses these terms deliberately:

- **must** is required for safety, compatibility, or cross-project consistency;
- **should** is the default and needs a recorded reason when omitted;
- **may** is optional and should be added only for a real use case.

An exception never turns a safety requirement into a suggestion.

## Product brief

Every project README must answer these questions in plain language:

1. What problem does the project solve?
2. Who is it for?
3. What can a user do today?
4. What is explicitly unsupported or unfinished?
5. How does it relate to the rest of Project Mambo?

For a small asset or documentation repository, a few paragraphs are enough. A product with multiple workflows should keep a dedicated product page covering motivation, audiences, user stories, scope, success criteria, and constraints.

## Motivation

Describe the user problem and why this repository is the right boundary for solving it. Avoid circular statements such as “this project exists to provide this project.” Name the current friction, the intended improvement, and any reason the capability belongs in Project Mambo rather than an upstream dependency.

Motivation explains why the project should exist. It is not a feature list or a history of implementation choices.

## Users and user stories

Identify distinct users, including operators, maintainers, other repositories, and automation when they depend on the project. Write stories in an outcome-oriented form:

```text
As a <specific user>, I can <complete a task>, so that <valuable outcome>.
```

Each active story should have observable acceptance criteria. Describe behavior rather than an internal class, framework, or database choice. Prefer a few real stories over an exhaustive speculative backlog.

Include failure and recovery stories where user data, remote state, money, credentials, installation, or deletion are involved. For example, a package manager needs stories for an unavailable network, an interrupted update, and removal that preserves user-owned files.

## Scope and non-goals

List the smallest coherent set of supported capabilities. Then state nearby work that is intentionally out of scope. Non-goals prevent the README, public API, and implementation from implying commitments the project does not make.

Separate these categories:

| Category | Meaning |
|---|---|
| Supported | Implemented, documented, and covered by the validation contract |
| Experimental | Usable for feedback, but compatibility may change |
| Planned | Direction only; not available to users |
| Non-goal | Deliberately outside this repository's responsibility |

Never present planned behavior as current behavior.

## Outcomes and constraints

Use outcomes that can be observed without inventing vanity metrics. Examples include completing a fresh installation from the guide, reproducing a generated asset from pinned inputs, recovering safely from an interrupted operation, or building a site from a clean clone.

Record constraints that materially shape the design: supported operating systems, offline expectations, accessibility, performance ceilings, hardware assumptions, privacy, licences, and compatibility commitments. Do not turn unmeasured preferences into requirements.

## Maturity and ownership

Use one current maturity label in the README:

| Status | Contract |
|---|---|
| Experimental | The direction and interface can change; do not imply production stability |
| Active | Supported for documented use cases; changes follow the compatibility policy |
| Stable | Public behavior is deliberately conservative and release-managed |
| Maintenance | Security and correctness fixes only; no expected feature growth |
| Archived | Read-only and unsupported; point users to an alternative when one exists |

Name the owning Project Mambo team or maintainer route without publishing private contact details. State how users report bugs and, where relevant, security issues.

## Decisions and roadmap

Keep the README focused on current behavior. Track planned work in issues or a short roadmap with no implied delivery date. Record decisions that are difficult to reverse, affect more than one repository, or change a public contract in a small architecture decision record containing context, decision, consequences, and status.

Delete obsolete plans and superseded decisions or mark them clearly. Historical text must never obscure the current supported path.
