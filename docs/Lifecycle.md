---
description: Keep bootstrap, command installation, updates, removal, and releases safe and understandable.
title: Lifecycle
order: 30
---

::page{layout="docs" width="normal" sidebar=true}

# Lifecycle

Lifecycle scripts exist to make a repository reproducible, not to hide what it changes.

## Separate responsibilities

Use distinct entry points when the operations have different risk:

- **bootstrap** installs project dependencies and prepares a fresh clone;
- **install** exposes a command or applies user configuration;
- **update** refreshes reviewed files from a provider API;
- **uninstall** removes only paths owned by that repository;
- **release** validates and publishes a versioned artifact;
- **deploy** validates and publishes one website commit.

A tiny project may need only one of these. Do not create empty companion scripts for symmetry.

## Command installers

An installer for an `mb...` command should:

1. enable strict shell mode;
2. resolve the command source relative to the installer;
3. allow an environment-variable override for the bin directory;
4. create or refresh an owned symbolic link idempotently;
5. refuse to overwrite an unrelated regular file;
6. use `sudo` only when the selected directory is not writable;
7. report the source and installed command path;
8. warn when the bin directory is not on `PATH`.

Never use recursive deletion on a command path. If uninstall is provided, it removes only the expected symlink after verifying its ownership.

## Bootstrap scripts

Bootstrap must name its prerequisites, stop on missing required tools, and remain safe to run twice. Prefer the language's lockfile-aware native command such as `npm ci` or `cargo build --locked` in automation. Do not silently make optional dependencies required.

Personal workstation bootstrap may change live configuration. It must document fixed hardware/user assumptions, show a preview where the underlying tool supports one, warn before adopting existing files, and provide a symmetric unlink or unstow path.

## Releases

Use SemVer tags for distributable packages, binaries, or assets. A release path should complete these steps before mutating a remote:

1. validate the version and required tools;
2. require the intended branch and a clean worktree;
3. run the documented checks and build all assets;
4. show the exact tag and files;
5. require confirmation for publication or deletion;
6. publish in an order that can be retried safely;
7. report any partial remote state precisely.

Sites deploy commits instead of creating package releases. Documentation and personal configuration repositories need no release command unless they begin publishing versioned artifacts.
