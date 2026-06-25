---
name: review-spec
description: Use when you need to review a spec, plan, and tasks for ambiguity, missing coverage, and consistency before implementation.
---

# Review Spec

Review the artifacts before implementation.

## Artifact organization

All artifacts live under `.sdd/` at the project root. See `docs/sdd/13-organizacion-de-artefactos.md` for the full convention.

This skill can review at two points in the workflow:

- **Spec review:** when the state is `spec-en-revisión`. Read `.sdd/<work-item>/spec.md`.
- **Plan review:** when the state is `plan-en-revisión`. Read `.sdd/<work-item>/spec.md` and `.sdd/<work-item>/plan.md`.

After the review:

1. Write findings to `.sdd/<work-item>/review.md`.
2. Update the state in `.sdd/backlog.md`:
   - If approved: advance to `spec-aprobada` or `plan-aprobado`.
   - If issues found: return to `spec-escrita` or `plan-escrito` with the reason in `review.md`.

## Instructions

- Compare spec, plan, and tasks (whichever exist at this stage).
- Find ambiguities, missing cases, and inconsistencies.
- Call out over-engineering and unclear assumptions.
- Prioritize findings by impact.
- Do not modify the spec or plan — only approve or return with feedback.
- Use `templates/review-template.md` as the default outline.

## Output

- Findings
- Questions
- Risks
- Verdict: approved or returned with reason
- Recommended fixes (if returned)
