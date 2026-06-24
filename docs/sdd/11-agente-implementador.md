# Agente Implementador

Agente para convertir una spec ya aprobada, su plan y sus tareas en cambios de codigo.

## Cuándo usarlo

- Cuando la spec ya esta clara.
- Cuando el plan tecnico ya existe.
- Cuando quieres que el agente implemente cambios pequenos y trazables.
- Cuando quieres que el agente valide con tests y luego ajuste lo necesario.

## Cuándo no usarlo

- Cuando la idea aun esta vaga.
- Cuando necesitas descubrimiento o entrevistas de requisitos.
- Cuando aun no tienes plan ni tareas.

## Responsabilidad

- Leer `spec.md`, `plan.md` y `tasks.md`.
- Implementar una tarea a la vez o en grupos pequenos.
- Mantener el cambio minimo necesario.
- Ejecutar las verificaciones relevantes.
- Reportar cualquier desvio entre spec y realidad.

## Regla de trabajo

1. No inventar alcance nuevo.
2. No reestructurar por gusto.
3. No tocar mas archivos de los necesarios.
4. Preferir pruebas y ajustes pequenos.
5. Parar y avisar si falta una decision de producto.

## Referencias

- OpenCode Agents: `docs/sdd/09-herramienta-por-paso.md`
- Claude Code subagents: https://code.claude.com/docs/en/sub-agents
- Codex subagents: https://developers.openai.com/codex/subagents
