# Cómo escribir buenas specs

Una buena spec minimiza interpretación y maximiza verificabilidad.

## Qué debe contener

- Contexto del problema.
- Objetivo del cambio.
- Usuarios o actores.
- Flujo principal.
- Casos alternativos.
- Restricciones.
- Criterios de aceptación.
- Casos límite.

## Cómo redactarlas

- Describe comportamiento observable.
- Usa lenguaje simple.
- Separa “qué” de “cómo”.
- Evita decisiones técnicas salvo que sean restricciones reales.
- Haz los criterios comprobables.

## Señales de una mala spec

- “Debe ser intuitivo”.
- “Debe ser rápido”.
- “Debería verse moderno”.
- “Hazlo escalable” sin contexto.
- Requisitos mezclados con implementación.

## Plantilla mínima

```md
# Título

## Objetivo

## Contexto

## Usuarios

## Requisitos funcionales

## Requisitos no funcionales

## Casos límite

## Criterios de aceptación

## Fuera de alcance
```

## Truco útil

Si un criterio no se puede probar o demostrar, reformúlalo.
