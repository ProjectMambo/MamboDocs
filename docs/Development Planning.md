---
description: Write and maintain an executable, dependency-ordered development plan for every Project Mambo repository.
title: Development planning
order: 25
---

::page{layout="docs" width="normal" sidebar=true}

# Development planning

Every Project Mambo repository must maintain a canonical Development Plan page. The plan turns the product boundary into an executable delivery sequence: it explains what must be built, in which order, what each stage changes, and what evidence allows work to advance.

A development plan is not a feature wish list, issue tracker, or calendar promise. It must be detailed enough that a contributor can select the next coherent slice without rediscovering the architecture, data ownership, public surfaces, safety boundaries, and release conditions.

## Required location

Author the plan at:

~~~text
notes/Docs/Projects/<Repository>/Development Plan.md
~~~

Synchronization normally publishes it as `docs/Development Plan.md`. A website whose repository-root docs are site-owned may publish its canonical project plan at `docs/_mounts/<repository-slug>/Development Plan.md` through the existing self-mount convention. Link the published plan from the repository README and expose it exactly once through the project's visible child navigation; do not create a duplicate site-owned route.

The plan is required even when implementation is complete. A stable or maintenance-only repository may use a shorter plan covering compatibility, dependency updates, security/correctness work, release gates, and retirement conditions. An archived repository records preservation, replacement, and final shutdown work. Do not invent future features to make a quiet project appear active.

## Required content

Every plan must state:

1. **Current state** — what exists now, what is still planned, and what evidence was inspected.
2. **Target outcome** — the smallest coherent supported product or maintenance state.
3. **Scope and deferrals** — version or milestone scope plus explicit non-goals.
4. **Architecture and ownership** — important layers, data ownership, trust boundaries, and cross-repository responsibilities.
5. **Dependency-ordered stages** — coherent slices in the order they can safely be delivered.
6. **Stage reach** — affected domain logic, storage or files, public interfaces, human interfaces, automation or AI tools, tests, fixtures, configuration, and documentation.
7. **Exit gates** — observable acceptance criteria, including failure and recovery behavior.
8. **Data and compatibility** — migrations, backup, rollback or recovery, versioning, and destructive-change treatment where relevant.
9. **Security and privacy** — credentials, personal or user-owned data, authorization, logging, and untrusted-input boundaries where relevant.
10. **Validation strategy** — narrow checks, full gates, representative fixtures, performance or accessibility checks, and end-to-end journeys.
11. **Release or delivery milestones** — meaningful outcomes, not arbitrary percentage labels.
12. **Known risks and triggers** — assumptions that would materially change the plan and the evidence that would justify deferred complexity.

Use project-specific detail. An application plan names its screens, commands or tools, persistence model, migration path, and user journeys. A library plan names its public API slices, compatibility gates, and consumers. A website plan names routes, content sources, build/deploy stages, and rollback. An asset repository names source inputs, generation, validation, review, and publication.

## Stage contract

Each stage must identify:

- the outcome delivered at the end of the stage;
- the prerequisite stages or external decisions;
- the minimum implementation and documentation touched;
- user data, compatibility, security, or accessibility risks introduced;
- the focused checks and exit gate;
- nearby work deliberately left out.

Prefer vertical stages that reach every required boundary. For an application domain action, that normally means the shared domain or use-case layer, persistence, human interface, typed AI tool interface, tests, fixtures, and documentation. Do not postpone all failure handling, migration work, tools, or recovery to an unspecified final phase.

Infrastructure-only stages are valid when they prove an actual prerequisite, such as durable migrations or an end-to-end protocol spike. They must end in tested behavior and must not create empty frameworks for later work.

## Level of detail

Choose enough detail to expose sequencing and risk without pre-writing the implementation.

Include exact names when they are already public or when consistency prevents ambiguity: screens, tables, commands, tools, routes, stored concepts, issue codes, and validation gates. Describe unresolved implementation choices as bounded decisions with the stage that will prove them. Do not select speculative dependencies, abstraction layers, or extension systems solely to make the plan appear complete.

Avoid calendar dates unless an external deadline is real and owned. Use milestone names, dependency order, and exit gates. An estimate is not an acceptance criterion.

## Keep the plan current

Update the plan in the same coherent change when work:

- changes the selected architecture or trust boundary;
- adds, removes, combines, or reorders a stage;
- changes a stored-data or migration contract;
- changes a public interface or cross-repository dependency;
- exposes a new safety, privacy, accessibility, or recovery requirement;
- completes a milestone or invalidates a documented assumption.

Mark completed stages with evidence or revise the current-state section; do not leave planned behavior presented as unfinished after it ships. Keep detailed task churn in issues or branches and retain the plan as the stable dependency and acceptance map.

## Review checklist

Before accepting a plan, verify that:

- another contributor can identify the next safe stage;
- current behavior is distinct from planned behavior;
- every public or user-visible surface is represented;
- persistent data has migration, backup, and recovery treatment;
- destructive and untrusted-input paths have explicit safeguards;
- stages include failure behavior and tests rather than happy paths only;
- cross-repository work identifies provider-before-consumer order;
- deferred features have a reason or evidence trigger;
- the final milestone proves a complete user or consumer journey;
- the README and project hub link the synchronized page.

The repository checker verifies that the published plan file exists. Human review remains responsible for whether the content is truthful, detailed, current, and proportional to the project.
