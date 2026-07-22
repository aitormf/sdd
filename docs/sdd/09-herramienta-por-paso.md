# Herramienta por paso

Guía práctica para decidir cuándo usar skill, agente o comando en un flujo SDD.

## Resumen corto

- **Skill**: instrucciones reutilizables que se cargan bajo demanda.
- **Agente**: rol especializado con modelo, permisos y herramienta propios.
- **Comando**: envoltorio lanzado por el usuario para una tarea repetitiva.

## Recomendacion por paso

| Paso | Mejor opcion | Por que |
| --- | --- | --- |
| Idea vaga a definicion clara | Skill | Sirve para estandarizar el estilo de entrevista y las preguntas de aclaracion. |
| Escribir la spec | Comando o agente | El comando da un flujo repetible; el agente ayuda si quieres dialogo iterativo y mas contexto. |
| Clarificar huecos | Skill + agente | La skill aporta la guia de preguntas; el agente ejecuta la conversacion y decide el siguiente bloque de preguntas. |
| Plan tecnico | Agente | Requiere analisis, decisiones, lectura de contexto y posible uso de herramientas. |
| Research tecnico | Agente subtask (read-only) | OpenCode tiene agentes especializados para investigacion externa y lectura sin cambios. |
| Generar tareas | Comando o agente | Si el formato es repetible, un comando es suficiente; si necesitas criterio sobre dependencias, mejor agente. |
| Implementar | Agente | Es la etapa que mas se beneficia de permisos, tools y ejecucion de varios pasos. |
| Review y validacion | Agente read-only | Conviene limitar ediciones y centrarlo en analisis, checklist y discrepancias. |
| Aplicar cambios de review | Skill | Cada decision es del humano; la skill guia el proceso pero no aplica nada sin aprobacion explicita. |
| Gestión del flujo | Agente (orquestador) | Lee el backlog, valida transiciones de estado, delega al agente o skill correcto. Ver [13-organizacion-de-artefactos.md](13-organizacion-de-artefactos.md). |

## Regla practica

- Si quieres **consistencia** y **reuso**, usa una **skill**.
- Si quieres **razonamiento con herramientas** y varias acciones, usa un **agente**.
- Si quieres un **atajo invocable** para una tarea concreta, usa un **comando**.

## Skills y agentes disponibles

Estas son las skills y agentes incluidos en el repositorio (se instalan con `scripts/install-sdd.sh`):

| Paso del flujo | Tipo | Nombre |
| --- | --- | --- |
| Constitución del proyecto | Skill | `generate-constitution` |
| Idea → definición clara | Skill | `idea-to-spec` |
| Spec → plan técnico | Skill | `spec-to-plan` |
| Plan → tareas | Skill | `plan-to-tasks` |
| Review de spec, plan y tareas | Skill / Agente | `review-spec` / `spec-reviewer` |
| Aplicar cambios de review | Skill | `apply-review` |
| Plan técnico con análisis | Agente | `spec-planner` |
| Implementación | Agente | `implement` |
| Gestión del flujo y backlog | Agente | `orchestrator` |

## Compatibilidad entre herramientas

Para la estrategia de espejo de skills y agentes entre OpenCode, Claude Code y Codex, ver [10-multi-herramienta.md](10-multi-herramienta.md).


## Referencias

- OpenCode Agent Skills: https://opencode.ai/docs/skills/
- OpenCode Agents: https://opencode.ai/docs/agents/
- OpenCode Commands: https://opencode.ai/docs/commands/
- Spec Kit workflow: https://github.com/github/spec-kit/blob/main/spec-driven.md
- OpenCode intro with plan mode: https://opencode.ai/docs/

## Lectura de las fuentes

- OpenCode define skills como instrucciones reutilizables cargadas bajo demanda.
- OpenCode define agentes como asistentes especializados con modelo, permisos y herramientas.
- OpenCode define comandos como prompts repetibles para tareas concretas.
- Spec Kit formaliza el flujo `constitution -> specify -> clarify -> plan -> tasks -> implement -> validate`.
