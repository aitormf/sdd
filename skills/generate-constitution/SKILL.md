---
name: generate-constitution
description: Use when the user wants to create or update their project's constitution (immutable project rules). Guides them through a structured interview covering stack, testing, security, conventions, process, and dependencies to produce constitution.md.
---

# Generate Constitution

Help the user define the immutable rules of their project through a structured interview.

## Goal

Produce a `constitution.md` that captures the fundamental, rarely-changing decisions of the project: stack, quality, security, conventions, process, and dependencies. The constitution is a human decision — the AI facilitates thinking, not writing.

## Artifact organization

The constitution lives at `.sdd/constitution.md`. If `.sdd/` does not exist, create it.

If the project already has a constitution elsewhere (e.g., `docs/constitution.md`), ask the user whether to migrate it to `.sdd/constitution.md` or keep the existing location and reference it.

## Core behavior

- Start by reading the project to understand its context: look at `package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`, `Gemfile`, `pom.xml`, `.tool-versions`, existing `CLAUDE.md`, `README.md`, or any other project metadata.
- Use what you find to pre-fill suggested answers and reduce the number of questions.
- Present concrete choices, not open-ended questions, whenever possible.
- The user makes the decisions. You can suggest, but never assume.
- If updating an existing constitution, read it first and only ask about gaps or outdated sections.

## Questioning strategy

Ask in rounds, one category at a time. After each round, summarize what was decided before moving on.

### Round 1 — Stack and architecture
- Language and version.
- Framework and why.
- Architecture pattern (monolith, microservices, serverless, etc.).
- Database and why.
- Infrastructure constraints (cloud, on-premise, specific providers).

### Round 2 — Quality and testing
- Expected testing level (unit, integration, e2e).
- TDD or tests after.
- Minimum coverage threshold.
- Testing tools.
- What should never be mocked.

### Round 3 — Security
- Authentication strategy.
- Sensitive data handling.
- Required input validations.
- Compliance requirements (GDPR, HIPAA, etc.).

### Round 4 — Code conventions
- Naming conventions.
- Directory structure.
- Mandatory linter and formatter.
- Preferred patterns.
- Prohibited patterns.

### Round 5 — Process
- Branch naming.
- Commit conventions.
- CI/CD requirements before merge.
- Mandatory review.

### Round 6 — Dependencies
- External dependency policy (free, approval needed, minimal).
- Prohibited libraries.
- Build-vs-buy preference.

## What to skip

- If the project metadata already answers a question clearly (e.g., `pyproject.toml` shows Python 3.12 + FastAPI), confirm it instead of asking.
- If a category is not relevant (e.g., no database in a CLI tool), skip it and note why.
- If updating, skip categories that are already well-defined in the existing constitution.

## Output format

When all rounds are complete, draft the constitution using this structure:

```md
# Constitución — {Project Name}

## Stack
- ...

## Testing
- ...

## Seguridad
- ...

## Convenciones
- ...

## Proceso
- ...

## Dependencias
- ...
```

Present the draft to the user for review before saving. Only save after explicit approval.

## Stop condition

Stop asking questions when every relevant category has a clear decision. Then:

1. Present the full draft.
2. Ask for approval or changes.
3. On approval, write to `.sdd/constitution.md`.
4. If `.sdd/backlog.md` exists, do not modify it — the constitution is not a work item.

## Reference

See `docs/sdd/constitucion-guia.md` for the full guide on what a constitution is and isn't.
