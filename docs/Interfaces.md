---
description: Design stable command-line, terminal UI, library, service, file, and configuration boundaries.
title: Interfaces and API design
order: 70
---

::page{layout="docs" width="normal" sidebar=true}

# Interfaces and API design

An interface is public when a user, another repository, stored data, automation, or a deployed client depends on it. Keep that surface smaller and more stable than the implementation behind it.

## Design from user outcomes

Start with supported user stories and examples. Define inputs, outputs, errors, side effects, recovery, and compatibility before internal types. Use one name for one concept across commands, code, files, UI labels, and documentation.

A public boundary must be:

- documented from the consumer's point of view;
- validated at entry;
- explicit about mutation, persistence, network access, and ownership;
- deterministic for the same pinned inputs where the domain allows it;
- covered by focused contract or end-to-end checks;
- versioned or deployed under a documented compatibility policy.

Do not expose an internal module, table, filesystem layout, or transport detail merely because it is easy to export.

## Command-line interfaces

Installed commands use a short `mb...` name and normally follow:

```text
command <verb> [arguments] [options]
```

A single-purpose command may omit the verb when its grammar is unambiguous. Public commands must:

- implement `-h` and `--help` without mutation;
- implement `--version` when the command has a released version;
- use stable lowercase verbs and long kebab-case options;
- document defaults and keep required input visibly required;
- reject missing, conflicting, unknown, and unsupported values before mutation;
- separate result output from diagnostics;
- return documented exit statuses;
- work without colour and honour `NO_COLOR` when colour is emitted;
- support non-interactive use or clearly declare that interaction is required;
- validate every delete or overwrite target.

Compatibility aliases remain part of the public contract until removed through the documented deprecation and versioning process. See [Commands and scripts](Commands%20and%20Scripts.md) for formatting and implementation rules.

## Terminal user interfaces

A TUI is not a private wrapper around a library; its navigation, key bindings, state transitions, and persistence are user-visible contracts. A Project Mambo TUI should:

- show the current location, selection, loading state, errors, and available primary actions;
- provide an always-discoverable help view with the active key bindings;
- use conventional navigation and offer a clear way back or out;
- confirm destructive actions and name the exact target;
- remain usable after terminal resize and at the documented minimum dimensions;
- preserve focus and selection predictably after refresh;
- never rely on colour alone for status or selection;
- keep business rules outside rendering and input-handling modules;
- make long operations cancellable or visibly in progress;
- test state transitions independently from terminal rendering where practical.

Use shared MamboUI components when they exist, but keep domain behavior and project-specific workflows in the consuming application.

## Library APIs

A library exports a curated surface from its package or crate root. It owns the public input, output, and error types crossing that boundary. Public APIs should:

- make invalid states difficult to represent where it improves clarity;
- validate filesystem, network, database, and user input at the boundary;
- return typed or structured errors for expected failure instead of panicking;
- avoid leaking dependency-specific types unless that dependency is deliberately part of the contract;
- keep core policy independent from UI, transport, and storage adapters;
- document concurrency, ordering, persistence, performance, and thread-safety expectations where relevant;
- include minimal examples that compile or execute in validation;
- version breaking semantic changes, not only signature changes.

Internal modules remain private until a real consumer needs them. Do not add an interface or extensibility layer for one speculative implementation.

## HTTP and service APIs

Use resource-oriented nouns for stable domain objects and HTTP methods for standard actions. Add action endpoints only when the operation does not map honestly to resource creation, retrieval, replacement, update, or deletion.

Every endpoint contract defines:

- method, path, authentication, authorization, and idempotency behavior;
- request fields, types, validation, size limits, and defaults;
- success status, response schema, and relevant headers;
- structured error status, code, message, and safe details;
- pagination, filtering, ordering, and consistency rules for collections;
- rate, timeout, retry, and partial-failure behavior where applicable;
- compatibility and deprecation policy.

Use standard HTTP status semantics. Do not return `200` for a failed operation or expose stack traces and secrets. Mutation endpoints that clients may retry should accept an idempotency mechanism or have naturally idempotent semantics.

Use one predictable error envelope, for example:

```json
{
  "error": {
    "code": "repository_not_found",
    "message": "The requested repository is not installed.",
    "details": {}
  }
}
```

Publish an OpenAPI description when an HTTP API has external or cross-repository consumers. Generate reference material from it when useful, but keep task guidance and compatibility decisions in authored documentation.

## Configuration and environment

Configuration is a public interface. Name keys consistently, document precedence and defaults, validate the complete configuration before starting a mutation, and return errors that identify the source and invalid field without exposing secret values.

Prefer a stable structured format already used by the runtime. Version a configuration schema when consumers or migrations need it. Environment variables are best for deployment-specific values and secret references, not deeply nested application policy.

Changing a default can be breaking even when the key name remains unchanged. Renaming or removing a key requires a migration or deprecation path.

## Files, generated output, and schemas

A file consumed outside its writer is an API. Document encoding, schema, required fields, ordering guarantees, path ownership, atomicity, and compatibility. Use explicit schema versions when stored or exchanged data must survive independent releases.

Write managed output to a temporary sibling, validate it, then replace the destination atomically where the platform supports it. Preserve user-owned files and metadata unless the contract explicitly transfers ownership. Deterministic generators must avoid timestamps, absolute paths, random ordering, and environment-dependent output unless those values are declared inputs.

## Persistence and migrations

Persistent data outlives an implementation. Document the storage boundary, backup/export path, migration trigger, rollback limits, and recovery after interruption. Migrations must be ordered, repeatable or transactionally recorded, and tested against representative prior versions.

Never silently downgrade or discard unknown newer data. Before an irreversible migration, verify prerequisites and require an appropriate backup or export. Treat schema and semantic data changes as public compatibility changes.

## Errors and observability

Errors should be actionable and stable enough for their audience. Human-facing messages state what failed and the next safe action. Machine-facing errors use stable codes and structured fields. Logs add diagnostic context without duplicating secrets, credentials, personal data, or full sensitive payloads.

Do not turn expected invalid input into a crash. Do not swallow a partial failure and print success. If a multi-step remote operation cannot be atomic, report completed and pending state precisely.

## Compatibility and deprecation

Classify changes from the consumer's perspective:

| Change | Typical compatibility |
|---|---|
| Add optional field, command, or method | Backward-compatible when defaults preserve behavior |
| Tighten validation or change a default | Potentially breaking |
| Rename or remove a field, option, route, export, or key | Breaking |
| Change output ordering, error codes, file paths, or stored semantics | Breaking when consumers rely on it |
| Fix behavior that contradicted the documented contract | Usually a fix; call out affected reliance |

A deprecation names the replacement, begins in a released version, remains visible in docs and runtime feedback where practical, and gives consumers a defined removal version or condition. Coordinate cross-repository consumers before removal.

## Security and privacy

Authenticate before authorizing, validate untrusted input at the boundary, use least privilege, and avoid exposing internal identifiers or paths without a user need. Document trust boundaries and sensitive data retention. Security controls, accessibility basics, and protection of user-owned data cannot be waived as formatting preferences.

## Smallest regression check

Every non-trivial parser, branch, migration, and destructive command change leaves one runnable check that would fail if its public behavior regressed. Reuse the repository's current test runner; for a small script, a standard-library smoke test is enough.
