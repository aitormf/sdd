---
name: idea-to-spec
description: Use ONLY when the user has a rough project idea and wants a structured interview to turn it into a strong spec; ideal for "idea to spec", clarification, requirements questions, and spec drafting.
---

# Idea to Spec

Help the user transform a vague or medium-detail idea into a specification-ready definition.

## Goal

Turn an initial idea into a clear problem statement, scope, user stories, requirements, edge cases, constraints, and acceptance criteria.

## Artifact organization

All artifacts live under `.sdd/` at the project root. See `docs/sdd/13-organizacion-de-artefactos.md` for the full convention.

When the spec is ready to write:

1. Create the work item directory: `.sdd/YYYYMMDD-tipo-slug/` (e.g., `.sdd/20260625-feat-auth-login/`).
2. Write the spec to `.sdd/YYYYMMDD-tipo-slug/spec.md`.
3. Add an entry to `.sdd/backlog.md` with state `spec-escrita`.

If `.sdd/backlog.md` does not exist yet, create it with the table header:

```md
# Backlog

| Item | Estado | Descripción |
```

## Core behavior

- Start by restating the idea in one short paragraph.
- Identify the missing information needed to write a good spec.
- Ask the smallest useful set of questions.
- Prioritize blocking questions first.
- When a question has a natural default, offer it as a concrete choice — but never assume it silently.
- Keep the conversation focused on the spec, not implementation.

## Questioning strategy

Ask in rounds:

1. Problem and outcome.
2. Users and actors.
3. User stories (what each user needs and why).
4. Scope and out-of-scope.
5. Behavior and edge cases.
6. Non-functional constraints.
7. Acceptance criteria.

If the idea is still ambiguous after a round, ask follow-up questions only for the unresolved parts.

## Good questions

- Who is the primary user?
- What exact problem does this solve?
- What is explicitly out of scope?
- What happens when data is missing or invalid?
- What should happen if an external dependency fails?
- How will we know the feature is correct?

## Bad questions

- Questions that repeat information already given.
- Questions about frameworks, libraries, or architecture unless the user explicitly asks for technical planning.
- Questions that are too broad when a narrower one would unblock the spec.

## Handling open questions

Never assume an answer to an open question silently. When a question cannot be resolved from the information given:

1. Present the open question clearly.
2. If you have a reasonable default, offer it as one explicit option — but always give the user the choice to answer differently or to leave it as an open question in the spec.
3. Wait for the user's decision before proceeding.

Concretely, for each unresolved question ask:

> **[Question]**
> Options:
> - A) [Your suggested default if any]
> - B) [Alternative if obvious]
> - C) Leave it as an open question in the spec
> - D) [User provides their own answer]

Only mark a question as resolved when the user explicitly answers or explicitly chooses to leave it open.

## Output format

When responding, structure the output like this:

- `What I understand`
- `Open questions` — list each one with options as described above; never assume
- `Next step`

## Stop condition

Stop asking questions when enough detail exists to draft a spec with:

- objective
- problem statement
- users
- user stories
- scope
- functional requirements
- non-functional requirements
- edge cases
- acceptance criteria

At that point, offer to draft the spec and save it to `.sdd/YYYYMMDD-tipo-slug/spec.md`.

## Reference template

If helpful, align the captured information with `docs/sdd/06-plantilla-de-spec.md`.
