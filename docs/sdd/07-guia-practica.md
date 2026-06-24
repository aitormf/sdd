# Guia Practica SDD

Esta guia te da un flujo real para usar SDD en un proyecto pequeño o mediano.

## Objetivo

Pasar de una idea vaga a una spec clara, luego a un plan tecnico, luego a tareas, y finalmente a una implementacion revisable.

## Flujo recomendado

1. Escribe una idea corta.
2. Expande esa idea en una spec.
3. Haz preguntas de aclaracion.
4. Convierte la spec en plan tecnico.
5. Divide el plan en tareas pequenas.
6. Implementa tarea por tarea.
7. Revisa contra la spec.

## Como empezar sin complicarte

Empieza con algo pequeno:

- una pantalla
- un formulario
- una mejora de flujo
- una API simple

Evita arrancar con una feature enorme. SDD funciona mejor cuando puedes revisar cada artefacto con calma.

## Metodo paso a paso

### Paso 1: redacta la idea base

Ejemplo:

```md
Quiero una pantalla para organizar fotos en albumes por fecha. El usuario debe poder crear albumes, mover fotos y ver una vista clara de cada album.
```

### Paso 2: convierte eso en spec

Preguntas utiles:

- Quien usa esto?
- Que problema resuelve?
- Que acciones debe permitir?
- Que no entra?
- Como se sabe que esta bien?

### Paso 3: clarifica huecos

Busca ambiguedades como estas:

- cuando se crea el album?
- que pasa si una foto no tiene fecha?
- se pueden anidar albumes?
- hay orden manual o solo por fecha?

### Paso 4: haz el plan tecnico

El plan deberia decidir:

- componentes
- datos
- contratos
- validaciones
- pruebas

### Paso 5: saca tareas pequenas

Buen tamano de tarea:

- crear modelo de datos
- crear validacion
- crear endpoint
- crear vista
- crear prueba

Mal tamano de tarea:

- implementar todo el sistema de albumes

### Paso 6: implementa y revisa

La revision debe preguntar:

- esto cumple la spec?
- faltan casos?
- hay algo sobredisenado?
- la experiencia es coherente?

## Plantilla de trabajo real

```md
1. Idea
2. Spec
3. Clarificaciones
4. Plan
5. Tareas
6. Implementacion
7. Review
8. Ajustes finales
```

## Prompts utiles

### Para la spec

```md
Ayudame a escribir una spec clara para esta funcionalidad. Quiero que describas objetivos, usuarios, requisitos funcionales, casos limite y criterios de aceptacion. No incluyas soluciones tecnicas salvo que sean restricciones reales.
```

### Para aclarar

```md
Revisa la spec y detecta ambiguedades, huecos y supuestos. Hazme solo las preguntas necesarias para poder planificarla sin adivinar nada.
```

### Para el plan

```md
Convierte esta spec en un plan tecnico. Incluye arquitectura, modelo de datos, componentes, validaciones, riesgos y estrategia de pruebas.
```

### Para tareas

```md
Divide este plan en tareas pequenas, ordenadas por dependencias y trazables a la spec.
```

### Para review

```md
Compara la implementacion con la spec y el plan. Dime que cumple, que falta y que esta sobrando.
```

## Regla de oro

Si no puedes explicar una decision en una frase y enlazarla con un requisito, probablemente sigue siendo demasiado vaga.
