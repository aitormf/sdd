# Flujo recomendado

## Flujo completo

1. **Constitución** — reglas estables del proyecto que aplican a todo cambio: stack, calidad, testing, seguridad, convenciones. Se define una vez por proyecto y se mantiene. No es algo que deba generar la IA: es una decisión humana. Ver [constitucion-guia.md](constitucion-guia.md) para una guía detallada.
2. **Spec** — describe el comportamiento deseado: objetivos, usuarios, casos de uso, restricciones, criterios de aceptación, edge cases.
3. **Clarificación** — resuelve huecos y ambigüedades antes de planificar. Incluye pasar el [checklist de calidad](06-plantilla-de-spec.md#checklist-de-calidad) de la spec. *(Opcional en tareas pequeñas o bien definidas.)*
4. **Plan** — traduce la spec a decisiones técnicas: arquitectura, módulos, modelo de datos, integración, estrategia de pruebas.
5. **Tareas** — convierte el plan en pasos pequeños, ordenados por dependencia y verificables.
6. **Implementación** — codifica siguiendo el orden de las tareas, una a la vez o en grupos pequeños.
7. **Validación** — comprueba si lo entregado cumple la spec. Incluye auditar la coherencia entre spec, plan y tareas para detectar desviaciones.
8. **Corrección** — ajusta las desviaciones encontradas y actualiza los artefactos (spec, plan, tareas) si cambiaron durante la implementación. Actualiza la spec cuando cambia un comportamiento observable, se añade un requisito nuevo, o un caso límite que no estaba contemplado. No la actualices por detalles de implementación o refactors internos que no cambian el qué.

### Pasos opcionales según el tamaño de la tarea

| Tipo de cambio | Pasos que puedes omitir |
|---|---|
| Bug de una línea | Todo salvo implementar y validar |
| Bug complejo | Constitución, plan detallado |
| Feature pequeña | Constitución (si ya existe), clarificación |
| Feature de producción | Ninguno — flujo completo |
| Refactor arquitectural | Ninguno — flujo completo + investigación previa |

La constitución solo se escribe una vez. Si tu proyecto ya la tiene, el flujo empieza en el paso 2.

## Regla práctica

Si no puedes verificar una afirmación en la spec, probablemente está demasiado implícita.

## Flujo mínimo

Para tareas simples donde el flujo completo es desproporcionado:

**Spec → Plan+Tareas → Implementación → Validación**
