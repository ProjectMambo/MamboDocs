---
description: Write task-focused user documentation from installation through daily use, recovery, updates, and removal.
title: User guide
order: 40
---

::page{layout="docs" width="normal" sidebar=true}

# User guide

A user guide helps someone complete a supported task safely. Organize it around user goals, not source modules, internal milestones, or a tour of every option.

## Required coverage

For a user-facing project, document the applicable parts in this order:

1. supported platforms, maturity, and prerequisites;
2. installation or access;
3. the smallest successful first run;
4. common tasks and examples;
5. configuration and data locations;
6. output, errors, and recovery;
7. update and compatibility behavior;
8. uninstall, unapply, or account/data removal;
9. troubleshooting and support route.

A library replaces installation and daily-use sections with dependency setup and a minimal integration. A website may need no install section but still documents navigation, supported browsers, accessibility, privacy, and recovery from user-facing errors.

## Quick start

The first-run path must begin from a named state such as a fresh clone, a released binary, or the deployed site. Include prerequisites before the first command. State the working directory, use copyable commands, and describe the expected result immediately afterward.

Do not hide required setup in a later troubleshooting section. Do not use machine-specific absolute paths, unpublished sibling repositories, or credentials in a public quick start.

## Task pages

Give each page one clear outcome. A useful task page contains:

- when and why to use the task;
- prerequisites and data that may change;
- the command or interaction;
- the success result;
- common failures and safe recovery;
- a link to related reference material.

Use numbered steps when order matters. Use a table for exact option or field mappings. Keep conceptual explanations before or after the procedure so they do not interrupt a copyable path.

## Commands and examples

Follow the formatting contract in [Commands and scripts](Commands%20and%20Scripts.md). Examples must use non-secret, obviously replaceable values and supported syntax. Label placeholders consistently, explain destructive effects before the command, and never show an unsafe shortcut as the primary path.

When output matters, show a short representative result in a separate `text`, `json`, or other accurate code fence. Do not combine shell prompts, commands, and output in a block intended for copying.

## Configuration and data

Document every supported configuration source and its precedence: command options, environment variables, project files, user files, and defaults. For each setting, give its name, type, default, valid range, effect, and whether changing it requires restart or migration.

State where the application stores caches, logs, credentials, configuration, and durable user data. Distinguish files owned by the application from user-authored or imported files. Say what update and removal operations preserve.

## Errors and recovery

Write errors for the user who must act on them. The guide should map stable errors or failure categories to:

- what failed;
- whether anything changed;
- the likely cause;
- the next safe action;
- where diagnostic details can be found.

For interrupted installs, updates, migrations, remote writes, and deletion, document whether the operation is atomic, resumable, or safely repeatable. Never tell users to recursively delete an ambiguous directory as a routine fix.

## Updates and migration

State whether updates are automatic or explicit, where versions are shown, which compatibility policy applies, and how breaking changes are announced. Give ordered migration and rollback steps for any release that changes stored data, configuration, or a public file format.

If rollback is not supported, say so before the migration and require an appropriate backup or export path.

## Removal

Removal instructions list exactly what is removed and what remains. Verify ownership before deleting managed paths. User data, configuration, caches, installed commands, services, and remote resources are separate categories and must not be silently treated as one.

## Accessibility and language

- Use descriptive headings, link labels, and alt text.
- Do not rely on colour, cursor shape, animation, or iconography alone.
- Explain keyboard operation for interactive interfaces.
- Keep terminal examples understandable without colour and honour `NO_COLOR` where supported.
- Use direct language and define project-specific terms on first use.
- Avoid screenshots as the sole source of instructions or values.

## Documentation check

Before delivery, follow the guide from its stated starting state. Verify commands, links, filenames, option names, screenshots, and expected results against the current build. A guide that describes a planned or older interface is a product bug, not harmless prose drift.
