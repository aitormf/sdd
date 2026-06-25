# Plantilla de spec

La plantilla operativa está en [`templates/spec-template.md`](../../templates/spec-template.md). Para una explicación detallada de cada sección, consulta [secciones-spec-explicadas.md](secciones-spec-explicadas.md).

## Plantilla completa

Para features de producción, refactors arquitecturales o cualquier cambio con ambigüedad significativa.

```md
# Nombre de la funcionalidad

## Objetivo

## Problema que resuelve

## Usuarios

## User stories

## Requisitos funcionales

## Requisitos no funcionales

## Casos límite

## Criterios de aceptación

## Alcance

## Fuera de alcance

## Entidades / Modelo de datos

## Métricas de éxito

## Dependencias

## Riesgos

## Supuestos

## Preguntas abiertas
```

## Plantilla mínima

Para features pequeñas, bugs complejos o tareas bien definidas donde el contexto es obvio.

```md
# Nombre de la funcionalidad

## Objetivo

## Problema que resuelve

## Usuarios

## User stories

## Requisitos funcionales

## Requisitos no funcionales

## Casos límite

## Criterios de aceptación
```

## Checklist de calidad

- ¿Se entiende qué se quiere hacer?
- ¿Se entiende por qué importa?
- ¿Los criterios de aceptación son comprobables?
- ¿Hay casos límite contemplados?
- ¿Queda claro qué no entra?
- ¿Las user stories cubren a todos los usuarios relevantes?
- ¿Hay preguntas abiertas explícitas?

## Ejemplo de buen criterio

- Malo: "El usuario debe tener una buena experiencia".
- Bueno: "Dado un álbum con 50 fotos, cuando el usuario arrastra 3 fotos a otro álbum, entonces las fotos desaparecen del origen y aparecen en el destino sin recargar la página".
