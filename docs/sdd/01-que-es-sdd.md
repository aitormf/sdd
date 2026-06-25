# Qué es SDD

Spec-Driven Development es un enfoque en el que primero se define qué se quiere construir y por qué, y después se deriva el plan técnico, las tareas y la implementación.

## Resumen corto

- Primero se aclara la intención del producto.
- Después se escribe una spec con requisitos, escenarios y criterios de aceptación.
- Luego se traduce a un plan técnico.
- Después se divide en tareas ejecutables.
- Finalmente se implementa y se valida contra la spec.

## Lo importante

SDD no es solo “escribir más documentación”.

La idea es reducir ambigüedad antes de programar y mantener un artefacto vivo que permita revisar si el resultado sigue alineado con la intención original.

## Niveles de rigor
No todo el mundo aplica SDD igual. Hay tres niveles según el papel que juega la spec en el proyecto:
| Nivel | La spec... | El código... | Ejemplo |
| **Spec-first** | Se escribe antes de codificar | Es el artefacto principal. La spec se descarta o queda obsoleta tras implementar. | Usar una spec como prompt detallado para un prototipo rápido. |
| **Spec-anchored** | Coexiste con el código como referencia viva | Se mantiene manualmente. La spec se actualiza cuando hay cambios relevantes. | Un equipo que mantiene specs junto al código para onboarding y revisiones. |
| **Spec-as-source** | Es la única fuente de verdad | Se genera automáticamente desde la spec y se puede regenerar en cualquier momento. | [Tessl](https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html), donde el código es un subproducto de la spec. |
**Esta documentación enseña el nivel spec-anchored:** la spec se escribe antes, guía la implementación, y se mantiene viva como referencia. El código no se genera automáticamente desde ella, pero ambos deben estar alineados. Si la implementación revela que la spec estaba incompleta, se actualiza la spec (ver paso 8 del [flujo](02-flujo.md)).
La mayoría de equipos reales operan entre spec-first y spec-anchored. Spec-as-source es el más ambicioso pero también el menos probado a escala.
## Lo que suele confundirse

- Spec no es prompt largo.
- Plan no es la spec.
- Tareas no son requisitos.
- Review no es solo mirar código: también es comprobar trazabilidad con la spec.

## Cuándo sirve mejor

- Features medianas o grandes.
- Cambios con varios casos límite.
- Trabajo con varios agentes o varias personas.
- Sistemas donde importa mucho la trazabilidad y la validación.

## Cuándo NO usar SDD (o usar solo el flujo mínimo)

- **Exploración y prototipos.** Si no sabes qué construir, especificar prematuramente te frena. Mejor explorar primero y escribir la spec cuando tengas claro el rumbo. Si tienes una idea vaga pero no sabes por dónde empezar, la skill `idea-to-spec` te guía con una entrevista estructurada para descubrir qué te falta antes de escribir la spec.
- **Bugs triviales.** Un fix de una línea no necesita spec. Arréglalo, valida y sigue.
- **Requisitos muy inestables.** Si las prioridades cambian cada semana, la spec queda obsoleta antes de implementarse. En ese caso, usa el [flujo mínimo](02-flujo.md#flujo-mínimo) y no inviertas en artefactos que van a cambiar.
- **Overhead desproporcionado.** El proceso completo para una tarea de 30 minutos es contraproducente. Ajusta el nivel de proceso al tamaño del cambio (ver [pasos opcionales](02-flujo.md#pasos-opcionales-según-el-tamaño-de-la-tarea)).
- **Falsa sensación de completitud.** Una spec detallada puede dar la ilusión de que todos los casos están cubiertos. No sustituye la exploración, las pruebas con usuarios ni el feedback real. La spec es una herramienta, no una garantía.
