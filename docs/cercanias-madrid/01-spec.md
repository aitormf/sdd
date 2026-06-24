# Spec: Alertas en Tiempo Real para Cercanias Madrid

## Objetivo

Detectar incidencias probables en lineas de Cercanias Madrid a partir de datos publicos de puntualidad y notificar a usuarios suscritos por Telegram.

## Problema

Renfe puede tardar en publicar avisos oficiales, pero los retrasos en tiempo real suelen dar senales tempranas de que hay una incidencia en una linea.

## Alcance del MVP

- Leer datos GTFS-RT de posicion y/o puntualidad desde fuentes publicas.
- Analizar retrasos por linea con una regla simple y explicable.
- Generar una alerta cuando una linea supera un umbral de anomalia.
- Enviar notificaciones por Telegram a usuarios suscritos a esa linea.
- Evitar avisos duplicados durante una misma incidencia.

## Fuera de alcance

- Prediccion avanzada con ML.
- App movil propia.
- Integraciones con otras redes ferroviarias.
- Intervencion manual de operadores en tiempo real.

## Actores

- Usuario suscrito por Telegram.
- Servicio de ingesta GTFS-RT.
- Servicio de deteccion de incidencias.
- Servicio de notificaciones.
- Bot de Telegram.

## Requisitos funcionales

### Suscripcion

- El usuario puede suscribirse a una o varias lineas mediante Telegram.
- El usuario puede darse de baja de una linea.
- El sistema conserva la preferencia de linea por usuario.

### Ingesta

- El sistema consulta periodicamente las fuentes GTFS-RT.
- El sistema normaliza los datos relevantes por tren y linea.
- Si una fuente falla de forma temporal, el sistema registra el error y continua con el siguiente ciclo.

### Deteccion

- El sistema calcula un indicador sencillo de anomalia por linea.
- El sistema genera una alerta cuando el indicador supera un umbral predefinido.
- El sistema evita emitir multiples alertas equivalentes dentro de una ventana de enfriamiento.

### Notificacion

- El sistema envia mensajes a los usuarios suscritos a la linea afectada.
- El mensaje incluye la linea, la hora de deteccion y un resumen breve del motivo.

## Requisitos no funcionales

- La arquitectura debe ser simple y ejecutable con Docker Compose.
- Los servicios deben estar desacoplados.
- Debe haber trazabilidad basica de eventos y errores.
- El sistema debe ser facil de observar y depurar.
- La solucion debe tolerar fallos temporales de fuentes externas.

## Reglas de negocio iniciales

- Una alerta representa una sospecha de incidencia, no una confirmacion oficial.
- Una linea con retrasos anormalmente altos durante varias observaciones puede disparar una alerta.
- Una alerta debe ser deduplicada durante una ventana temporal.

## Criterios de aceptacion

- Dado un usuario suscrito, cuando el sistema detecta una alerta en su linea, recibe un mensaje por Telegram.
- Dado un fallo temporal en la fuente GTFS-RT, el sistema no se cae y sigue ejecutando el siguiente ciclo.
- Dada una linea con retrasos persistentes por encima del umbral, el sistema genera una alerta una sola vez dentro de la ventana de enfriamiento.
- Dado un usuario dado de baja, el sistema deja de notificarle sobre esa linea.

## Supuestos

- Las fuentes publicas GTFS-RT estan disponibles y contienen los datos necesarios para el MVP.
- Se puede identificar la linea de cada tren con suficiente fiabilidad.
- Telegram sera el canal de notificacion principal del MVP.

## Preguntas abiertas

- Que fuente GTFS-RT exacta se usara?
- Cada cuanto se debe consultar la fuente?
- Cual es el umbral inicial de anomalia?
- Como se define una ventana de enfriamiento razonable?
- Se notificara por linea, por tramo o por estacion?
- Se necesitara una pagina web de administracion en el MVP?
