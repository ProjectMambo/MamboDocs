---
description: Apply the shared standard proportionally and record justified, bounded, reviewable deviations.
title: Exceptions
order: 110
---

::page{layout="docs" width="normal" sidebar=true}

# Exceptions

Consistency means applying the same rule to the same kind of boundary. It does not mean giving every repository identical files, releases, interfaces, or automation.

## Applicability by project type

| Repository type | Usually required | Usually unnecessary |
|---|---|---|
| Documentation | README, project hub, canonical sync, link/content checks | installer, package API, SemVer release |
| Website | user-facing routes, content structure, accessibility, production build, deploy and rollback path | local uninstall, package release when not consumed as a package |
| Library | public API, examples, compatibility policy, tests, package release | end-user installer or TUI guide |
| CLI or application | install, quick start, commands/UI, config/data, recovery, update/remove, versions | HTTP API when none exists |
| Asset or generator | asset licence, source, deterministic generation, format compatibility | runtime service operations |
| Personal configuration | assumptions, preview, conflict handling, apply/unapply, owned paths | general-purpose portability or public package release |
| Experimental prototype | honest status, safe boundary, reproducible demo, limitations | stable compatibility promise or premature release automation |

Omitting an irrelevant surface is conformance, not an exception. Record an exception only when a relevant requirement cannot currently be met.

## Exception record

Put a concise record in the README Status or developer guide containing:

```text
Requirement: <the rule that applies>
Current behavior: <what the repository does now>
Reason: <technical, user, or operational constraint>
Risk: <who or what can be affected>
Mitigation: <the safe path that remains>
Review: <date, release, issue, or condition that reopens the decision>
```

Link evidence or an issue when useful. “Legacy,” “too hard,” or “not implemented” is not a complete reason; explain the actual constraint and user risk.

## Rules that cannot be waived

An exception cannot remove:

- validation of untrusted input at a public or trust boundary;
- confirmation and exact-target checks for destructive actions;
- protection of user-owned files and data;
- credential and personal-data safeguards;
- licence obligations;
- truthful status and limitation documentation;
- accessibility basics for a supported user interface;
- a recovery or explicit irreversible warning for data migration;
- review of remote mutation before publish, deploy, or delete.

If the project cannot meet one of these, the affected capability remains unsupported or unavailable until it can.

## Common proportional choices

These choices normally need no exception record when documented accurately:

- a docs-only repository uses Git history instead of SemVer;
- `npm ci` or `cargo build --locked` is the bootstrap command without a wrapper;
- a website treats deployment as its delivery lifecycle and publishes no package;
- a tiny repository keeps user and developer guidance in the README until either audience needs a separate page;
- a single-purpose generator omits CLI verbs because its argument grammar is already clear;
- committed generated assets keep ordinary builds independent from maintainer tooling;
- an experimental application documents a demo data source and postpones installation or release until a durable path exists.

These choices stop being proportional when a real consumer, safety risk, or repeated maintenance failure needs the omitted boundary.

## Temporary deviations

A temporary deviation has an owner and a review condition. Prefer a concrete trigger—next breaking release, provider publication, migration completion, or linked issue—over a vague future date. Keep the mitigation tested while the exception exists.

When the constraint disappears, remove the exception, obsolete workaround, compatibility alias, and stale documentation in the same logical change.

## MamboDocs self-application

MamboDocs is documentation-only. It has no product installer, public runtime API, package version, or release artifact. It does have a repository checker because that is a concrete enforcement aid for the documented standard; the checker remains a small read-only script rather than a framework.

## Non-goals of the standard

MamboDocs does not require:

- identical languages, frameworks, or package managers;
- empty folders or placeholder scripts;
- a shared abstraction for every cross-repository call;
- CI that performs no meaningful remote check;
- releases for unversioned docs, sites, or personal configuration;
- speculative APIs, plugin systems, or extension points;
- duplicating generated reference material by hand;
- rewriting a working public grammar solely for visual uniformity.

The standard creates predictable answers at real boundaries. It does not reward ceremony.
