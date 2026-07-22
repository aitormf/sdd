---
name: apply-review
description: Use when a review has returned a work item and the user wants to apply the suggested changes. Every decision is made by the human; the skill never assumes or applies anything without explicit approval.
---

# Apply Review

Help the user work through review findings and apply only the changes they explicitly approve.

## Artifact organization

All artifacts live under `.sdd/` at the project root. See `docs/sdd/13-organizacion-de-artefactos.md` for the full convention.

## Scope

This skill covers:
- Reading and presenting the findings from `review.md`.
- Collecting the human's decision on each finding.
- Applying only the approved changes to the artifact(s) under review (`spec.md`, `plan.md`, or `tasks.md`).
- After decisions are finalized, checking specs in `spec-escrita` state for impact and proposing targeted updates — with human approval before any write.

Out of scope: anything not directly derived from the review findings. Do not refactor, rewrite, or improve content beyond what a finding explicitly addresses.

## Core rule

**Never assume, infer, or apply a change without an explicit human decision.** If a finding is ambiguous, ask for clarification before presenting options. Never bundle decisions — treat each finding independently.

## Step 1 — Present findings

1. Identify the work item (ask the user if not clear from context).
2. Read `.sdd/<work-item>/review.md`.
3. List every finding, numbered, in priority order (blockers first).
4. For each finding present:
   - **Finding [N]**: what the reviewer flagged.
   - **Suggested fix** (from the review, if any).
   - **Options**:
     - A) Apply the suggested fix as-is.
     - B) Apply a modified fix (user specifies).
     - C) Dismiss — explain why and keep as-is.
     - D) Defer — mark for later, do not apply now.

Wait for the user to respond to **all** findings before proceeding.

## Step 2 — Confirm decisions

After the user has responded to every finding, present a summary:

```
Decisions summary
─────────────────
[N] <short title> → <decision: apply / modified / dismissed / deferred>
...
```

Ask: "Do you confirm these decisions before I apply them?"

Do not proceed until the user confirms.

## Step 3 — Apply approved changes

Apply only the changes the user confirmed (apply or modified). Write to the artifact(s) under review. Do not touch anything else.

Update `.sdd/backlog.md`:
- If all blockers are resolved: advance state (e.g. `spec-escrita` → `spec-en-revisión`, or `plan-escrito` → `plan-en-revisión`).
- If blockers remain deferred or dismissed with open risk: leave state as-is and note in `review.md`.

## Step 4 — Check specs in `spec-escrita`

After the changes are applied, check whether any decision taken in Step 2 could affect other specs currently in `spec-escrita` state.

1. Read `.sdd/backlog.md` and collect all items with state `spec-escrita`.
2. For each, read its `spec.md` and reason whether any confirmed decision introduces a conflict, dependency change, or invalidated assumption.
3. For each spec that *may* be affected:
   - Show the user: which spec, which section, and specifically what might need updating.
   - Ask: "Does this decision affect this spec? Should I propose a change?"
   - **Wait for explicit yes/no before proposing anything.**
4. For each spec where the user says yes:
   - Draft only the minimal targeted change (the section and the exact lines to update).
   - Show the diff to the user and ask: "Do you approve this change?"
   - **Apply only after explicit approval.**
5. For specs where the user says no or defers: leave untouched.

Only the sections directly impacted by the decisions are candidates for change. Do not improve, expand, or reformat anything else in those specs.

## What never changes without human approval

- Which findings to apply.
- How to apply a modified fix.
- Whether a spec in `spec-escrita` is affected.
- The exact wording of any spec update.
- State transitions in `backlog.md`.

If at any point the right action is unclear, stop and ask.
