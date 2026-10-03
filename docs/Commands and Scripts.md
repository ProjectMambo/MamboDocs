---
description: Format documented commands consistently and build small, safe, automation-friendly repository scripts.
title: Commands and scripts
order: 60
---

::page{layout="docs" width="normal" sidebar=true}

# Commands and scripts

Commands are part of the user and contributor interface. They must be copyable, explicit about context, safe around user-owned data, and consistent between local documentation and automation.

## Formatting commands in documentation

Use a fenced block with the language that matches what the reader should execute:

```bash
cargo test --locked
```

Follow these rules:

- state the working directory before a command when it is not the repository root;
- keep shell prompts and expected output out of copyable `bash` blocks;
- use one logical operation per block unless order is the point of the example;
- put placeholders in angle brackets, such as `<branch>` or `<version>`, and explain them nearby;
- prefer long option names in documentation; show short aliases only when they improve repeated interactive use;
- quote paths and values that may contain whitespace;
- show multiline commands only when the split improves readability;
- explain mutations, network access, privileges, and destructive effects before the command;
- show a short expected result after the command when success is not obvious.

Do not publish commands containing real usernames, home paths, credentials, private hosts, branch assumptions, or shell expansions that could erase an unresolved path.

## Command names

Installed Project Mambo commands use a short lowercase `mb...` name. Public subcommands and long options use lowercase kebab-case:

```text
mbtool <verb> [arguments] [options]
```

Repository scripts use descriptive kebab-case filenames under `script/`, such as `check-repository.sh` or `update-theme.sh`. Use the ecosystem's conventional task surface, such as package scripts or Cargo commands, when it already makes the operation clear. Do not add a wrapper that only renames one obvious native command.

Use consistent task meanings:

| Name | Meaning |
|---|---|
| `bootstrap` | prepare a clean clone |
| `dev` or `run` | start the local primary surface |
| `format` | apply deterministic formatting |
| `check` | run the complete non-publishing quality gate |
| `test` | run behavioral tests |
| `build` | create distributable or deployable output |
| `update-*` | refresh one declared generated or vendored input |
| `install` / `uninstall` | add or remove owned local integration |
| `release` | validate and publish a versioned artifact |
| `deploy` | validate and publish a website or service revision |

Do not make `check`, `build`, or a default test command mutate a remote.

## Script contract

Every non-trivial script must:

- resolve repository paths from its own location instead of the caller's current directory;
- validate required tools, arguments, and source paths before mutation;
- use strict error handling and preserve failed child exit codes;
- quote variable expansions and avoid ambiguous globs for destructive targets;
- print the operation and exact owned target at a useful level of detail;
- remain safe to rerun or document why repetition is impossible;
- write temporary work to a safely created temporary directory and clean it on exit;
- stop without claiming success after a partial failure;
- implement `-h` or `--help` when it accepts choices;
- keep credentials out of arguments and logs.

For Bash, use `set -euo pipefail` in non-trivial scripts and a cleanup trap when temporary state exists. Prefer Python's standard library or the project's existing runtime when parsing structured data would make shell brittle. Do not add a runtime solely to avoid a few clear shell commands.

## Inputs and configuration

Use this precedence unless the project documents a stronger domain convention:

1. explicit command options;
2. environment variables intended for automation;
3. project configuration;
4. user configuration;
5. documented defaults.

Environment-variable names are uppercase and project-prefixed when they are public. Never repurpose common system variables such as `HOME`. Reject unknown options and invalid values before writing output.

## Output and exit status

Public and automation-facing commands follow this contract:

- requested result data goes to stdout or the documented output path;
- diagnostics and progress go to stderr when stdout is machine-readable;
- success returns `0`;
- command-line usage errors return `2`;
- other failures return a stable non-zero status where consumers need to distinguish them;
- `--help` and `--version` return successfully without mutation;
- colour is never the only signal, and terminal colour should honour `NO_COLOR`.

Human-readable output should name what changed and where. Machine-readable output needs an explicit format option and a versioned schema if another repository consumes it.

## Destructive and privileged operations

Validate the exact target before delete, overwrite, reset, migration, or remote mutation. Refuse broad roots, unresolved variables, and paths outside the declared owner boundary. Prefer atomic replacement or a recoverable move. Show a preview when several user-visible files will change.

Use elevated privileges only for the smallest command that needs them and only after selecting and validating the target. An installer must not run its complete build or download path as root.

Interactive confirmation is required for an unexpected destructive operation. Automation may use an explicit `--yes` or equivalent only when the caller has already named the exact target; absence of a terminal must never imply consent.

## Dry runs and idempotence

Provide `--dry-run` when an operation changes multiple user-owned paths, remote state, or data that is difficult to restore. A dry run performs validation and reports the same planned targets without mutation.

Bootstrap, install, update, synchronization, and uninstall should be idempotent. Repetition either makes no change or converges to the same declared state. If an operation is intentionally one-way, document backup, detection, and recovery before exposing it.

## Automation

Automation calls the same repository-owned commands documented for maintainers. Keep non-interactive behavior explicit, pin inputs, and make logs sufficient to identify a failed phase without exposing secrets. Time-dependent, network-dependent, and platform-specific behavior must be visible in the command contract rather than hidden behind a generic success message.
