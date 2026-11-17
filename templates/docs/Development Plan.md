---
created: YYYY-MM-DD
updated: YYYY-MM-DD
description: Dependency-ordered stages, exit gates, risks, and milestones for PROJECT_NAME.
title: Development plan
order: 15
---

::page{layout="docs" width="normal" sidebar=true}

# Development plan

State the current implementation or maintenance state and the evidence used to review it. Distinguish existing behavior from planned behavior.

## Target outcome

Describe the smallest coherent supported state this plan delivers. Name the primary user or consumer journey and the repositories, services, stored data, or trust boundaries involved.

## Scope and deferrals

List the capabilities included in the target milestone. List nearby work deliberately deferred and the evidence that would justify adding it.

## Stage 0: Contracts and prerequisites

Record decisions that must be stable before implementation, including data ownership, public interfaces, compatibility, security, privacy, accessibility, migration, and recovery rules.

Exit gate: define observable evidence that lets the next stage begin.

## Stage 1: Smallest complete path

Deliver one end-to-end outcome through every required layer, interface, test, fixture, configuration, and documentation surface. Name the exact boundaries affected and failure behavior.

Exit gate: define the complete successful and failed journey.

## Later stages

Add dependency-ordered stages for the remaining product, safety, migration, performance, packaging, and release work. Each stage states its outcome, prerequisites, affected surfaces, risks, focused checks, exit gate, and deliberate exclusions.

## Validation

List the narrow checks, full repository gate, representative fixtures, compatibility or migration coverage, accessibility or performance checks, and final end-to-end journey.

## Milestones and risks

Map stages to meaningful delivery outcomes without inventing calendar dates. Record assumptions that would materially change the architecture or sequence.
