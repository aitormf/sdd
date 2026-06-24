# Ejemplo Completo

Ejemplo corto de una spec bien formada.

## Funcion

Organizar fotos en albumes por fecha.

## Objetivo

Permitir que el usuario agrupe fotos en albumes y encuentre rapidamente imagenes segun su fecha o coleccion.

## Usuarios

- Persona que quiere ordenar su biblioteca de fotos.

## Requisitos funcionales

- El usuario puede crear un album.
- El usuario puede renombrar un album.
- El usuario puede mover fotos entre albumes.
- El sistema agrupa fotos por fecha de captura cuando no se asignan manualmente.
- El usuario puede ver una vista de miniaturas por album.

## Requisitos no funcionales

- La interfaz debe ser usable en escritorio y movil.
- La accion principal de mover una foto debe ser facil de entender.
- Las operaciones comunes deben responder rapido.

## Casos limite

- Foto sin fecha.
- Album vacio.
- Nombre de album duplicado.
- Foto movida a un album inexistente.

## Fuera de alcance

- Edicion avanzada de imagen.
- Compartir albumes.
- Sincronizacion en la nube.

## Criterios de aceptacion

- Dado un album existente, cuando el usuario renombra el album, el cambio se refleja en la vista principal.
- Dada una foto valida, cuando el usuario la mueve a otro album, la foto deja de aparecer en el album anterior.
- Dado un conjunto de fotos sin organizacion manual, el sistema las agrupa por fecha visible para el usuario.

## Como pasaria a plan

- Definir modelo de album y foto.
- Definir reglas de agrupacion por fecha.
- Definir acciones de crear, renombrar y mover.
- Definir pruebas para casos limite.

## Como pasaria a tareas

- Crear modelo de datos.
- Crear logica de agrupacion.
- Crear UI de albumes.
- Crear accion de mover foto.
- Crear pruebas.
