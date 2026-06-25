# Ejemplo completo

Ejemplo de una spec que sigue la [plantilla completa](06-plantilla-de-spec.md). Para la explicación de cada sección, consulta [secciones-spec-explicadas.md](secciones-spec-explicadas.md). Para otro ejemplo completo aplicado a un proyecto real (con clarificaciones, spec, plan y tareas), ver [`docs/cercanias-madrid/`](../cercanias-madrid/).

---

# Organizar fotos en álbumes por fecha

## Objetivo

Permitir a los usuarios organizar sus fotos en álbumes agrupados por fecha para facilitar la búsqueda y el recuerdo de momentos.

## Problema que resuelve

Actualmente las fotos se muestran en una lista plana sin organización. Los usuarios con más de 200 fotos no encuentran lo que buscan y abandonan la app. El 40% de los tickets de soporte piden "alguna forma de ordenar fotos".

## Usuarios

- **Usuario casual:** tiene 50–200 fotos, usa la app desde el móvil, quiere encontrar fotos de un viaje concreto sin esfuerzo.
- **Usuario intensivo:** tiene 2.000+ fotos, usa la app desde escritorio y móvil, necesita organización avanzada y gestión en lote.
- **Administrador familiar:** gestiona álbumes compartidos con familiares, necesita control de permisos.

## User stories

- Como **usuario casual**, quiero ver mis fotos agrupadas por mes y año para encontrar rápidamente las fotos de un viaje.
- Como **usuario casual**, quiero crear un álbum manual con nombre personalizado para agrupar fotos de un evento.
- Como **usuario intensivo**, quiero mover varias fotos a un álbum de una vez para no tener que hacerlo una por una.
- Como **usuario intensivo**, quiero renombrar un álbum para corregir un nombre que puse rápidamente.
- Como **administrador familiar**, quiero compartir un álbum con permisos de solo lectura para que mi familia vea las fotos sin poder borrarlas.

## Requisitos funcionales

- RF-01: El sistema debe agrupar las fotos automáticamente por mes y año basándose en la fecha EXIF.
- RF-02: El sistema debe permitir crear álbumes manuales con nombre personalizado.
- RF-03: El sistema debe permitir renombrar un álbum existente.
- RF-04: El sistema debe permitir mover fotos entre álbumes mediante drag & drop (escritorio) o selección múltiple (móvil).
- RF-05: El sistema debe mostrar una vista de miniaturas por álbum.
- RF-06: El sistema debe permitir compartir un álbum con otros usuarios con permisos de lectura o lectura/escritura.

## Requisitos no funcionales

- RNF-01: La vista de álbumes debe cargar en menos de 2 segundos con hasta 5.000 fotos.
- RNF-02: Las miniaturas deben generarse en segundo plano sin bloquear la interfaz.
- RNF-03: Los álbumes compartidos deben requerir autenticación; no se accede por URL pública.
- RNF-04: La interfaz debe ser usable en pantallas desde 320px de ancho.

## Casos límite

- ¿Qué pasa si una foto no tiene fecha EXIF? → Se agrupa en "Sin fecha".
- ¿Qué pasa si el usuario crea un álbum con nombre duplicado? → Se permite, añadiendo un sufijo numérico.
- ¿Qué pasa si el usuario borra un álbum compartido? → Las fotos vuelven a "Sin álbum", los otros usuarios ven un aviso.
- ¿Qué pasa si se suben 500 fotos de golpe? → Se procesan en cola con barra de progreso.
- ¿Qué pasa si dos usuarios mueven la misma foto a la vez? → Gana la última escritura, sin error.
- ¿Qué pasa si un álbum está vacío? → Se muestra con un mensaje "Sin fotos" y opción de añadir.

## Criterios de aceptación

- Dado un usuario con 300 fotos con fecha EXIF, cuando abre la vista de álbumes, entonces ve las fotos agrupadas por mes y año en orden cronológico descendente.
- Dado un álbum con 50 fotos, cuando el usuario arrastra 3 fotos a otro álbum, entonces las fotos desaparecen del álbum origen y aparecen en el destino sin recargar la página.
- Dado un álbum existente, cuando el usuario lo renombra, entonces el cambio se refleja en la vista principal inmediatamente.
- Dado un álbum compartido como solo lectura, cuando un invitado intenta borrar una foto, entonces el sistema muestra "No tienes permisos" y la foto no se borra.
- Dado un conjunto de fotos sin fecha EXIF, cuando el sistema las procesa, entonces aparecen agrupadas bajo "Sin fecha".

## Alcance

Esta spec cubre la organización de fotos en álbumes por fecha y la compartición básica. Incluye la vista de álbumes, la creación/edición/borrado de álbumes, el movimiento de fotos y la compartición con permisos.

## Fuera de alcance

- Edición de fotos (recorte, filtros, rotación).
- Álbumes inteligentes por reconocimiento facial.
- Sincronización con servicios externos (Google Photos, iCloud).
- Versión offline.

## Entidades / Modelo de datos

- **Foto:** id, url, fecha EXIF, fecha de subida, propietario.
- **Álbum:** id, nombre, tipo (automático/manual), creador, fecha de creación.
- **Pertenencia:** una foto puede estar en varios álbumes. Un álbum tiene muchas fotos.
- **Compartición:** un álbum se comparte con usuarios, cada uno con un nivel de permiso (lectura / lectura+escritura).

## Métricas de éxito

- El 70% de los usuarios con más de 100 fotos usan la vista de álbumes al menos una vez por semana.
- Los tickets de soporte relacionados con "encontrar fotos" se reducen un 50% en 3 meses.
- El tiempo medio para encontrar una foto concreta baja de 45 segundos a 15 segundos.

## Dependencias

- Servicio de almacenamiento de imágenes (ya existe, v2.3).
- API de lectura de metadatos EXIF (por implementar, bloqueante).
- Sistema de autenticación y permisos (ya existe, necesita extensión para permisos por álbum).

## Riesgos

- El 30% de las fotos subidas desde WhatsApp no tienen fecha EXIF → la agrupación automática puede ser incompleta.
- El rendimiento de la vista de álbumes con usuarios de 10.000+ fotos no está validado.
- El sistema de permisos actual no soporta permisos por recurso, solo por rol global → puede requerir refactor.

## Supuestos

- La mayoría de fotos tienen fecha EXIF válida.
- Los usuarios entienden el concepto de "álbum" sin necesidad de onboarding.
- El almacenamiento actual soporta la carga adicional de miniaturas.

## Preguntas abiertas

- ¿Permitimos álbumes vacíos o se crean solo cuando tienen al menos una foto?
- ¿El orden cronológico por defecto es ascendente o descendente?
- ¿Qué límite ponemos al nombre del álbum (caracteres, longitud)?
- ¿Los álbumes automáticos por fecha son editables o solo de lectura?

---

## Cómo pasaría a plan

- Definir modelo de datos (Foto, Álbum, Pertenencia, Compartición).
- Definir reglas de agrupación automática por fecha EXIF.
- Diseñar API: endpoints para CRUD de álbumes, mover fotos, compartir.
- Definir estrategia de generación de miniaturas (cola asíncrona).
- Diseñar extensión del sistema de permisos para permisos por recurso.
- Definir estrategia de pruebas (unitarias, integración, carga).

## Cómo pasaría a tareas

- Crear modelo de datos y migraciones.
- Implementar lógica de agrupación automática por fecha EXIF.
- Implementar endpoint de creación/edición/borrado de álbumes.
- Implementar endpoint de mover fotos entre álbumes.
- Implementar generación de miniaturas en cola asíncrona.
- Implementar compartición de álbumes con permisos.
- Crear UI de vista de álbumes con miniaturas.
- Crear UI de drag & drop (escritorio) y selección múltiple (móvil).
- Crear pruebas para casos límite (sin fecha, álbum vacío, duplicados, concurrencia).
- Crear pruebas de carga con 5.000+ fotos.