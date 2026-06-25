# De spec a plan, tareas y review

Esta es la parte más operativa del flujo.

## Plan

El plan traduce la spec a decisiones concretas:

- componentes
- módulos
- datos
- contratos
- riesgos
- pruebas

## Tareas

Las tareas deben ser:

- pequeñas
- ordenadas por dependencia
- verificables
- trazables a la spec

## Implementación

Implementa una tarea a la vez o en grupos pequeños. SDD se complementa bien con TDD: los criterios de aceptación de la spec se traducen directamente en tests antes de escribir el código.

1. Toma un criterio de aceptación o un requisito de la spec.
2. Escribe el test que lo verifica (debe fallar).
3. Implementa el código mínimo para que pase.
4. Refactoriza si es necesario.

Esto no es obligatorio, pero sí recomendable: si la spec define el "qué", los tests verifican el "qué" y el código resuelve el "cómo". Los tres quedan alineados.

## Review

La revisión debería comprobar al menos esto:

- cobertura de requisitos
- coherencia entre spec y plan
- coherencia entre plan y tareas
- pruebas relevantes
- casos límite
- deuda técnica introducida

## Flujo recomendado en práctica

Ver el flujo canónico en [02-flujo.md](02-flujo.md). Este documento detalla los pasos 4–8 (Plan, Tareas, Implementación, Validación y Corrección).

## Sobre el término “review”

En SDD, review no suele ser una fase aislada de “mirar el código”. Es mejor tratarla como un control de alineación continuo entre artefactos.
