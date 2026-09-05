---
description: Design stable command-line and library boundaries that other Project Mambo repositories can consume.
title: Interfaces
order: 20
---

::page{layout="docs" width="normal" sidebar=true}

# Interfaces

An interface is public when another repository, automation job, or user depends on it. Keep that surface smaller and more stable than the implementation behind it.

## Command-line interfaces

Installed commands use a short `mb...` name. Prefer:

```text
command <verb> [arguments] [options]
```

A single-purpose generator may omit the verb when its existing grammar is already unambiguous. Do not break a working public grammar merely to make every command look identical.

Public commands should:

- implement `-h` and `--help` without mutation;
- publish `--version` when the command itself has a released version;
- use stable, lowercase verbs and long kebab-case options;
- keep useful short aliases such as `-o` while documenting the long form;
- validate missing values and unsupported choices before writing output;
- write requested result data to stdout or the documented output path;
- write diagnostics to stderr;
- return `0` for success, `2` for usage errors, and a non-zero runtime status for failures;
- remain understandable without colour; honouring `NO_COLOR` is recommended for commands that emit terminal colour;
- replace managed output safely and never recursively delete an unverified path.

Compatibility aliases are part of the public contract. Mark them clearly, test them, and remove them only through a documented breaking change.

## Repository-local commands

A script used only inside its repository can remain a small Bash, Python, Node.js, or package-manager command. Give it help when it accepts choices. It does not need a package, plugin system, or semantic version of its own.

Use `set -euo pipefail` in non-trivial Bash scripts. Resolve paths from the script location rather than the caller's working directory. Pass through exit codes instead of printing success after a failed child command.

## Library APIs

A library package should:

- export a curated surface from its package or crate root;
- own the public input, output, and error types used across the boundary;
- validate filesystem, network, database, and user input at the boundary;
- return errors rather than panic for expected invalid input;
- keep adapters and user interfaces dependent on the core library, never the reverse;
- document persistence, mutation, and compatibility behavior;
- version breaking changes.

Internal modules remain private unless a real consumer needs them. Do not add an abstraction or interface for a single speculative implementation.

## Smallest regression check

Every non-trivial parser, branch, or destructive command change leaves one runnable check that would fail if the behavior regressed. Reuse the repository's current test runner; for a small script, a standard-library smoke test is enough.
