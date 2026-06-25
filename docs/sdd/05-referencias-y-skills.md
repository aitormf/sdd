# Referencias y skills

## Referencias principales

- GitHub Spec Kit: https://github.com/github/spec-kit
- Documentación de Spec Kit: https://github.github.io/spec-kit/
- Concepto de SDD en Spec Kit: https://github.github.io/spec-kit/concepts/sdd.html
- Guía completa de Spec Kit: https://github.com/github/spec-kit/blob/main/spec-driven.md
- Artículo de Martin Fowler sobre SDD: https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html
- Blog de Microsoft sobre SDD: https://developer.microsoft.com/blog/spec-driven-development-ai-native-engineering

## Otras herramientas del ecosistema SDD

- AWS Kiro: https://kiro.dev/ — IDE con specs formales (EARS), steering files y verificación automática.
- Tessl: https://tessl.io/ — enfoque spec-as-source donde el código se genera completamente desde la spec.
- BMAD Method: framework metodológico con roles definidos (PM, architect, dev).

Para una comparación de filosofías (spec-first, spec-anchored, spec-as-source), ver [Niveles de rigor](01-que-es-sdd.md#niveles-de-rigor).

## Qué dicen las referencias

- GitHub Spec Kit formaliza un flujo con principios, spec, plan, tasks e implementación.
- Microsoft resume el flujo como constitution, specify, clarify, plan, tasks, implement y validate.
- Martin Fowler subraya que el término SDD todavía está en evolución y que hay varias interpretaciones.
- AWS Kiro usa notación EARS y separa la spec en tres archivos (requirements, design, tasks).
- Tessl trata la spec como la única fuente de verdad — el código es un subproducto regenerable.

## Skills que pueden ayudarte

### En Spec Kit

Spec Kit instala skills o comandos según la integración. Los nombres más visibles en la documentación son:

- `speckit-constitution`
- `speckit-specify`
- `speckit-plan`
- `speckit-tasks`
- `speckit-implement`
- `speckit-converge`

Además, la documentación de Spec Kit indica comandos opcionales como `speckit-clarify`, `speckit-analyze` y `speckit-checklist`.

### Skills incluidas

- `idea-to-spec`: ayuda a pasar de una idea concreta a una definición lista para escribir la spec.
- `spec-to-plan`: convierte una spec en un plan técnico.
- `plan-to-tasks`: convierte un plan en tareas ejecutables.
- `review-spec`: revisa spec, plan y tareas antes de implementar.

### Agentes incluidos

- `spec-planner`: redacta el plan técnico.
- `spec-reviewer`: audita spec, plan y tareas.
- `implement`: lleva una spec, plan y tareas aprobadas a código con el mínimo cambio correcto.

### Instalador

- `scripts/install-sdd.sh`: instala skills, agentes y plantillas en un proyecto destino, con adaptadores para cada CLI.

## Recomendación práctica

Si quieres aprender bien, usa esta secuencia:

1. Lee las referencias.
2. Escribe una spec pequeña.
3. Haz clarificaciones.
4. Genera plan y tareas.
5. Revisa si el resultado sigue la spec.
