# Guía práctica SDD

Esta guía te da un flujo real para usar SDD en un proyecto pequeño o mediano.

## Objetivo

Pasar de una idea vaga a una spec clara, luego a un plan técnico, luego a tareas, y finalmente a una implementación revisable.

## Flujo recomendado

Ver el flujo canónico completo en [02-flujo.md](02-flujo.md). Esta guía se centra en cómo aplicarlo paso a paso en un proyecto real.

Para la organización de artefactos (dónde guardar specs, planes y tareas, cómo gestionar el backlog y el ciclo de vida), ver [13-organizacion-de-artefactos.md](13-organizacion-de-artefactos.md).

## Cómo empezar sin complicarte

Empieza con algo pequeño:

- una pantalla
- un formulario
- una mejora de flujo
- una API simple

Evita arrancar con una feature enorme. SDD funciona mejor cuando puedes revisar cada artefacto con calma.

## Método paso a paso

### Paso 1: redacta la idea base

Si tu idea es vaga o no sabes qué te falta, usa la skill `idea-to-spec` — te guía con una entrevista estructurada (problema, usuarios, alcance, edge cases, criterios) hasta que tengas suficiente detalle para escribir la spec.

Si ya tienes la idea clara, redáctala directamente. Ejemplo:

```md
Quiero una pantalla para organizar fotos en álbumes por fecha. El usuario debe poder crear álbumes, mover fotos y ver una vista clara de cada álbum.
```

### Paso 2: convierte eso en spec

Preguntas útiles:

- ¿Quién usa esto?
- ¿Qué problema resuelve?
- ¿Qué acciones debe permitir?
- ¿Qué no entra?
- ¿Cómo se sabe que está bien?

### Paso 3: clarifica huecos

Busca ambigüedades como estas:

- ¿Cuándo se crea el álbum?
- ¿Qué pasa si una foto no tiene fecha?
- ¿Se pueden anidar álbumes?
- ¿Hay orden manual o solo por fecha?

### Paso 4: haz el plan técnico

El plan debería decidir:

- componentes
- datos
- contratos
- validaciones
- pruebas

### Paso 5: saca tareas pequeñas

Buen tamaño de tarea:

- crear modelo de datos
- crear validación
- crear endpoint
- crear vista
- crear prueba

Mal tamaño de tarea:

- implementar todo el sistema de álbumes

### Paso 6: implementa y revisa

La revisión debe preguntar:

- ¿Esto cumple la spec?
- ¿Faltan casos?
- ¿Hay algo sobrediseñado?
- ¿La experiencia es coherente?

## Plantilla de trabajo real

Ver los 8 pasos del flujo completo y el flujo mínimo en [02-flujo.md](02-flujo.md).

## Prompts útiles

### Para la spec

```md
Ayúdame a escribir una spec clara para esta funcionalidad. Quiero que describas objetivos, usuarios, requisitos funcionales, casos límite y criterios de aceptación. No incluyas soluciones técnicas salvo que sean restricciones reales.
```

### Para aclarar

```md
Revisa la spec y detecta ambigüedades, huecos y supuestos. Hazme solo las preguntas necesarias para poder planificarla sin adivinar nada.
```

### Para el plan

```md
Convierte esta spec en un plan técnico. Incluye arquitectura, modelo de datos, componentes, validaciones, riesgos y estrategia de pruebas.
```

### Para tareas

```md
Divide este plan en tareas pequeñas, ordenadas por dependencias y trazables a la spec.
```

### Para review

```md
Compara la implementación con la spec y el plan. Dime qué cumple, qué falta y qué está sobrando.
```

## Regla de oro

Si no puedes explicar una decisión en una frase y enlazarla con un requisito, probablemente sigue siendo demasiado vaga.