# Spec-Driven Development

Guía práctica en español para aprender y aplicar Spec-Driven Development (SDD).

## Qué cubre

- Qué es SDD y qué no es.
- Flujo recomendado de trabajo.
- Cómo escribir buenas specs.
- Cómo pasar de spec a plan, tareas, implementación y revisión.
- Referencias externas y skills útiles.

## Orden recomendado de lectura

1. `docs/sdd/01-que-es-sdd.md`
2. `docs/sdd/02-flujo.md`
3. `docs/sdd/03-como-escribir-buenas-specs.md`
4. `docs/sdd/04-de-spec-a-plan-tareas-y-review.md`
5. `docs/sdd/05-referencias-y-skills.md`
6. `docs/sdd/06-plantilla-de-spec.md`
7. `docs/sdd/07-guia-practica.md`
8. `docs/sdd/08-ejemplo-completo.md`
9. `docs/sdd/09-herramienta-por-paso.md`
10. `docs/sdd/10-multi-herramienta.md`
11. `docs/sdd/11-agente-implementador.md`
12. `docs/sdd/12-installer.md`
13. `docs/sdd/13-organizacion-de-artefactos.md`

## Otros recursos del repositorio
- [`templates/`](../../templates/) — plantillas operativas para [spec](../../templates/spec-template.md), [plan](../../templates/plan-template.md), [tareas](../../templates/tasks-template.md) y [review](../../templates/review-template.md). Son las que usan las skills y el agente implementador.
- [`docs/cercanias-madrid/`](../cercanias-madrid/) — ejemplo completo de SDD aplicado a un proyecto real (clarificaciones, spec, plan y tareas).
- [`secciones-spec-explicadas.md`](secciones-spec-explicadas.md) — guía detallada de cada sección de la plantilla de spec.
- [`constitucion-guia.md`](constitucion-guia.md) — guía para escribir la constitución del proyecto.
- [`13-organizacion-de-artefactos.md`](13-organizacion-de-artefactos.md) — dónde guardar los artefactos, ciclo de vida, control de acceso y agente orquestador.
## Convención de nombres de artefactos
Al aplicar SDD en un proyecto, los artefactos generados deben llamarse:
- `spec.md` — la especificación de la funcionalidad.
- `plan.md` — el plan técnico derivado de la spec.
- `tasks.md` — las tareas derivadas del plan.
- `review.md` — el resultado de la revisión.
Las plantillas en `templates/` llevan el sufijo `-template` para distinguirlas de los artefactos generados.
## Idea central
En SDD la spec es la fuente de verdad compartida. El código, los tests, el plan y las tareas deben derivar de esa spec, no al revés.
