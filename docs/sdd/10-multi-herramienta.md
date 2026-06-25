# Estrategia Multi Herramienta

La mejor forma de trabajar con OpenCode, Claude Code y Codex es separar entre:

- **contenido compartido**
- **adaptadores por herramienta**

## Contenido compartido

Guarda aqui lo que no deberia cambiar entre herramientas:

- guia de SDD
- plantilla de spec
- skill de entrevista `idea-to-spec`
- skill de plan `spec-to-plan`
- skill de tareas `plan-to-tasks`
- skill de review `review-spec`
- agente de implementacion `implement`
- agente de plan `spec-planner`
- agente de review `spec-reviewer`
- reglas de calidad
- ejemplo de flujo

## Adaptadores por herramienta

Mantén solo lo minimo por herramienta:

- `AGENTS.md` para OpenCode y Codex
- `CLAUDE.md` para Claude Code
- skills espejo en:
  - `.opencode/skills/`
  - `.claude/skills/`
  - `.agents/skills/`
- agentes espejo en:
  - `.opencode/agents/`
  - `.claude/agents/`
  - `.codex/agents/`
- instalador en `install-sdd.sh`

## Regla de oro

No pongas la misma logica del proceso en tres formatos distintos.

Ponla una vez como skill reutilizable, y luego repitela solo como envoltorio o referencia de arranque.

## Estructura recomendada

```text
docs/sdd/
  01-que-es-sdd.md
  02-flujo.md
  03-como-escribir-buenas-specs.md
  04-de-spec-a-plan-tareas-y-review.md
  05-referencias-y-skills.md
  06-plantilla-de-spec.md
  07-guia-practica.md
  08-ejemplo-completo.md
  09-herramienta-por-paso.md
  10-multi-herramienta.md
  11-agente-implementador.md
  12-installer.md
  secciones-spec-explicadas.md
  constitucion-guia.md
templates/
  spec-template.md
  plan-template.md
  tasks-template.md
  review-template.md
.opencode/skills/idea-to-spec/SKILL.md
.claude/skills/idea-to-spec/SKILL.md
.agents/skills/idea-to-spec/SKILL.md
.codex/skills/idea-to-spec/SKILL.md
AGENTS.md
CLAUDE.md
```

## Lo que yo haria

Si tuviera que dejarlo listo hoy:

1. Mantendria `idea-to-spec` como skill espejo en las tres rutas.
2. Mantendria `spec-to-plan`, `plan-to-tasks` y `review-spec` como skills espejo en las tres rutas.
3. Mantendria `spec-planner`, `spec-reviewer` e `implement` como agentes espejo en las tres rutas.
4. Haria `AGENTS.md` y `CLAUDE.md` muy cortos, apuntando a `docs/sdd/README.md`.
5. Haria los comandos de cada herramienta solo si realmente aportan ergonomia.
6. Mantendria las decisiones de proceso en la documentacion compartida, no repartidas.

## Ventaja

Esto te permite cambiar de herramienta sin cambiar de metodologia.
