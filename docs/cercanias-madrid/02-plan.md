# Plan tecnico: MVP Cercanias Madrid

## Objetivo tecnico

Construir un sistema pequeno de microservicios con broker de mensajeria, persistencia separada por servicio y observabilidad basica.

## Arquitectura propuesta

### Servicios

- `ingestion-service`: consulta GTFS-RT y publica observaciones normalizadas.
- `analysis-service`: consume observaciones, calcula anomalias y emite eventos de alerta.
- `notification-service`: consume eventos de alerta y envia mensajes Telegram.
- `telegram-bot-service`: gestiona suscripciones y bajas por comandos de Telegram.

### Infraestructura

- `rabbitmq` como broker de mensajeria.
- `postgres` para persistencia del MVP.
- `docker-compose` para levantar todo localmente.

## Responsabilidades

### ingestion-service

- Ejecutar polling programado.
- Parsear respuestas GTFS-RT.
- Publicar eventos `train.observation.recorded`.

### analysis-service

- Consumir observaciones.
- Mantener una vista agregada por linea y ventana de tiempo.
- Emitir `line.incident.detected` cuando corresponda.
- Aplicar deduplicacion temporal.

### notification-service

- Consumir alertas.
- Resolver suscriptores de la linea afectada.
- Enviar notificaciones via Telegram.

### telegram-bot-service

- Procesar comandos como `/start`, `/subscribe` y `/unsubscribe`.
- Guardar suscripciones por usuario y linea.

## Modelo de datos minimo

### ingestion database

- fuentes consultadas
- ejecuciones de polling
- errores de fetch

### analysis database

- observaciones agregadas por linea
- alertas generadas
- estado de enfriamiento

### notification database

- mensajes enviados
- reintentos
- fallos de entrega

### bot database

- usuarios de Telegram
- suscripciones por linea
- preferencias de notificacion

## Contratos de eventos

### `train.observation.recorded`

- `observation_id`
- `line_id`
- `timestamp`
- `delay_seconds`
- `source`

### `line.incident.detected`

- `incident_id`
- `line_id`
- `detected_at`
- `severity`
- `summary`

### `notification.send.requested`

- `incident_id`
- `line_id`
- `telegram_user_id`
- `message`

## Regla inicial de deteccion

Empezar con una regla simple y explicable:

- considerar una linea en riesgo si, durante varias observaciones seguidas, la media de retraso supera un umbral y hay suficientes trenes afectados.

Esto es intencionalmente simple para el MVP. La meta es validar el flujo, no acertar con un modelo perfecto.

## Observabilidad

- logs estructurados.
- metricas basicas de polling, alertas y entregas.
- trazas o correlation ids por evento.

## Riesgos tecnicos

- calidad variable de los datos publicos.
- rate limits o caidas de la fuente.
- falsos positivos por umbrales demasiado agresivos.
- deduplicacion mal ajustada.

## Pruebas

- pruebas de parsing GTFS-RT.
- pruebas de deteccion con datos historicos o fixtures.
- pruebas de envio Telegram con mocks.
- pruebas de integracion de eventos.
