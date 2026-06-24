# Referencias y skills

## Referencias principales

- GitHub Spec Kit: https://github.com/github/spec-kit
- Documentación de Spec Kit: https://github.github.io/spec-kit/
- Concepto de SDD en Spec Kit: https://github.github.io/spec-kit/concepts/sdd.html
- Guía completa de Spec Kit: https://github.com/github/spec-kit/blob/main/spec-driven.md
- Artículo de Martin Fowler sobre SDD: https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html
- Blog de Microsoft sobre SDD: https://developer.microsoft.com/blog/spec-driven-development-ai-native-engineering

## Qué dicen esas referencias

- GitHub Spec Kit formaliza un flujo con principios, spec, plan, tasks e implementación.
- Microsoft resume el flujo como constitution, specify, clarify, plan, tasks, implement y validate.
- Martin Fowler subraya que el término SDD todavía está en evolución y que hay varias interpretaciones.

## Skills que pueden ayudarte

### En esta workspace

- `customize-opencode`: no es una skill de SDD. Sirve para configurar opencode, no para aprender ni ejecutar SDD.

### En Spec Kit

Spec Kit instala skills o comandos según la integración. Los nombres más visibles en la documentación son:

- `speckit-constitution`
- `speckit-specify`
- `speckit-plan`
- `speckit-tasks`
- `speckit-implement`
- `speckit-converge`

Además, la documentación de Spec Kit indica comandos opcionales como `speckit-clarify`, `speckit-analyze` y `speckit-checklist`.

### Skill creada en esta workspace

- `idea-to-spec`: ayuda a pasar de una idea concreta a una definición lista para escribir la spec.
- La misma skill está espejada en `.opencode/skills/`, `.claude/skills/` y `.agents/skills/` para máxima compatibilidad.
- `spec-to-plan`: convierte una spec en un plan técnico.
- `plan-to-tasks`: convierte un plan en tareas ejecutables.
- `review-spec`: revisa spec, plan y tareas antes de implementar.

### Agente creado en esta workspace

- `spec-planner`: redacta el plan técnico.
- `spec-reviewer`: audita spec, plan y tareas.
- `implement`: lleva una spec, plan y tareas aprobadas a código con el mínimo cambio correcto.
- La misma definición está espejada para OpenCode, Claude Code y Codex.

### Instalador

- `install-sdd.sh`: copia el pack a un directorio destino.

## Recomendación práctica

Si quieres aprender bien, usa esta secuencia:

1. Lee las referencias.
2. Escribe una spec pequeña.
3. Haz clarificaciones.
4. Genera plan y tareas.
5. Revisa si el resultado sigue la spec.
