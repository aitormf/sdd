# Instalador

## Uso

```bash
scripts/install-sdd.sh <directorio-destino> [cli ...]
```

## Qué instala

- `agents/` — agentes SDD (implement, spec-planner, spec-reviewer)
- `skills/` — skills SDD (idea-to-spec, spec-to-plan, plan-to-tasks, review-spec)
- `templates/` — plantillas (spec, plan, tasks, review)

Todo se copia a `.sdd/` en el proyecto destino.

## CLIs soportados

- `claude` — Claude Code
- `agents` — Open Agent Skills (genérico)
- `opencode` — OpenCode
- `codex` — Codex

Si no se especifica ninguno, instala todos.

## Ejemplo

```bash
# Solo Claude Code
scripts/install-sdd.sh ~/mi-proyecto claude

# Claude Code y Codex
scripts/install-sdd.sh ~/mi-proyecto claude codex

# Todos los CLIs
scripts/install-sdd.sh ~/mi-proyecto
```

## Idempotencia

El script se puede ejecutar varias veces sin problemas. Sobreescribe `.sdd/` y regenera los adaptadores.

## Personalización

- `CODEX_MODEL` — modelo de Codex (default: `gpt-5.4`)
- `CODEX_REASONING` — esfuerzo de razonamiento de Codex (default: `high`)
