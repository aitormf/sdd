---
name: spec-to-plan
description: Use when a spec is ready and you need a technical plan, architecture, data model, risks, and implementation choices.
---

# Spec to Plan

Turn an approved spec into a practical technical plan.

## Artifact organization

All artifacts live under `.sdd/` at the project root. See `docs/sdd/13-organizacion-de-artefactos.md` for the full convention.

Before starting:

1. Verify the work item exists in `.sdd/backlog.md` with state `spec-aprobada`. If the state is different, stop and report that the spec must be approved before planning.
2. Read the spec from `.sdd/<work-item>/spec.md`.

When the plan is ready:

1. Write it to `.sdd/<work-item>/plan.md`.
2. Update the state in `.sdd/backlog.md` to `plan-escrito`.

## Instructions

- Read the spec first.
- Identify open questions and assumptions.
- Produce a technical plan that stays aligned with the spec.
- Keep implementation choices minimal unless the spec requires complexity.
- Separate product intent from technical decisions.
- Use `templates/plan-template.md` as the default outline.

## Output

- What I understand
- Open questions
- Plan draft
- Next step
