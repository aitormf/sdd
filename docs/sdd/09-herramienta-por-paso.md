# Herramienta por Paso

Guia practica para decidir cuando usar skill, agente o comando en un flujo SDD.

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

## Regla practica

- Si quieres **consistencia** y **reuso**, usa una **skill**.
- Si quieres **razonamiento con herramientas** y varias acciones, usa un **agente**.
- Si quieres un **atajo invocable** para una tarea concreta, usa un **comando**.

## Mi recomendacion para tu caso

Para tu flujo de SDD yo haria esto:

1. `idea-to-spec` como **skill**.
2. `specify` o `draft-spec` como **comando** que use un agente de entrevista.
3. `plan-spec` como **agente**.
4. `research-spec` como **agente subtask** read-only.
5. `tasks-spec` como **comando** o **agente** si quieres trazabilidad fina.
6. `review-spec` como **agente read-only**.
7. `implement` como **agente** con permisos de escritura.

## Mejor compatibilidad entre OpenCode, Claude Code y Codex

La mejor estrategia no es intentar que una misma carpeta haga cosas distintas en cada herramienta. La mejor estrategia es:

1. Definir el contenido reutilizable como **skills Agent Skills**.
2. Guardar una copia espejo del mismo skill en:
   - `.opencode/skills/<nombre>/SKILL.md`
   - `.claude/skills/<nombre>/SKILL.md`
   - `.agents/skills/<nombre>/SKILL.md`
3. Guardar una copia espejo del agente de implementacion en:
   - `.opencode/agents/<nombre>.md`
   - `.claude/agents/<nombre>.md`
   - `.codex/agents/<nombre>.toml`
4. Usar `AGENTS.md` y `CLAUDE.md` solo como instrucciones de arranque, no como el lugar donde vive la logica de proceso.
5. Usar comandos solo como wrappers finos cuando de verdad quieras una accion invocable por nombre.

## Resultado practico

- OpenCode carga `AGENTS.md`, `CLAUDE.md` y skills desde `.opencode/`, `.claude/` y `.agents/`.
- Claude Code carga skills desde `.claude/skills/` y subagents desde `.claude/agents/`.
- Codex carga skills desde `.agents/skills/` y custom agents desde `.codex/agents/`.
- Por tanto, skills espejados para entrevistas y agentes espejados para implementacion te dan la mayor compatibilidad con el menor cambio de flujo.


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
