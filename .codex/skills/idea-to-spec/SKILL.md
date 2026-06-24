---
name: idea-to-spec
description: Use ONLY when the user has a rough project idea and wants a structured interview to turn it into a strong spec; ideal for "idea to spec", clarification, requirements questions, and spec drafting.
---

# Idea to Spec

Help the user transform a vague or medium-detail idea into a specification-ready definition.

## Goal

Turn an initial idea into a clear problem statement, scope, user stories, requirements, edge cases, constraints, and acceptance criteria.

## Core behavior

- Start by restating the idea in one short paragraph.
- Identify the missing information needed to write a good spec.
- Ask the smallest useful set of questions.
- Prioritize blocking questions first.
- Prefer concrete choices over open-ended questions when possible.
- Keep the conversation focused on the spec, not implementation.

## Questioning strategy

Ask in rounds:

1. Problem and outcome.
2. Users and actors.
3. Scope and out-of-scope.
4. Behavior and edge cases.
5. Non-functional constraints.
6. Acceptance criteria.

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

## Output format

When responding, structure the output like this:

- `What I understand`
- `Open questions`
- `Suggested assumptions` if needed
- `Next step`

## Stop condition

Stop asking questions when enough detail exists to draft a spec with:

- objective
- users
- scope
- functional requirements
- non-functional requirements
- edge cases
- acceptance criteria

At that point, offer to draft the spec or generate a spec template.

## Reference template

If helpful, align the captured information with `templates/spec-template.md`.
