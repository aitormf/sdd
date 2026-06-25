---
name: plan-to-tasks
description: Use when a technical plan exists and you need a dependency-ordered task breakdown with review checkpoints.
---

# Plan to Tasks

Turn a technical plan into an executable task list.

## Artifact organization

All artifacts live under `.sdd/` at the project root. See `docs/sdd/13-organizacion-de-artefactos.md` for the full convention.

Before starting:

1. Verify the work item exists in `.sdd/backlog.md` with state `plan-aprobado`. If the state is different, stop and report that the plan must be approved before generating tasks.
2. Read the plan from `.sdd/<work-item>/plan.md` and the spec from `.sdd/<work-item>/spec.md`.

When the tasks are ready:

1. Write them to `.sdd/<work-item>/tasks.md`.
2. Update the state in `.sdd/backlog.md` to `tareas-listas`.

## Instructions

- Read the plan and related spec.
- Break work into small, ordered tasks.
- Mark safe parallel work clearly.
- Include file paths or components when known.
- Include verification checkpoints.
- Use markdown checkboxes (`- [ ]`) for each task.
- Use `templates/tasks-template.md` as the default outline.

## Output

- Task breakdown
- Parallel groups
- Checkpoints
- Remaining questions
