# Plan técnico: MVP Cercanías Madrid

## Objetivo técnico

Construir un sistema pequeño de microservicios con broker de mensajería, persistencia separada por servicio y observabilidad básica.

## Arquitectura propuesta

### Servicios

- `ingestion-service`: consulta GTFS-RT y publica observaciones normalizadas.
- `analysis-service`: consume observaciones, calcula anomalías y emite eventos de alerta.
- `notification-service`: consume eventos de alerta y envía mensajes Telegram.
- `telegram-bot-service`: gestiona suscripciones y bajas por comandos de Telegram.

### Infraestructura

- `rabbitmq` como broker de mensajería.
- `postgres` para persistencia del MVP.
- `docker-compose` para levantar todo localmente.

## Responsabilidades

### ingestion-service

- Ejecutar polling programado.
- Parsear respuestas GTFS-RT.
- Publicar eventos `train.observation.recorded`.

### analysis-service

- Consumir observaciones.
- Mantener una vista agregada por línea y ventana de tiempo.
- Emitir `line.incident.detected` cuando corresponda.
- Aplicar deduplicación temporal.

### notification-service

- Consumir alertas.
- Resolver suscriptores de la línea afectada.
- Enviar notificaciones vía Telegram.

### telegram-bot-service

- Procesar comandos como `/start`, `/subscribe` y `/unsubscribe`.
- Guardar suscripciones por usuario y línea.

## Modelo de datos mínimo

### ingestion database

- Fuentes consultadas.
- Ejecuciones de polling.
- Errores de fetch.

### analysis database

- Observaciones agregadas por línea.
- Alertas generadas.
- Estado de enfriamiento.

### notification database

- Mensajes enviados.
- Reintentos.
- Fallos de entrega.

### bot database

- Usuarios de Telegram.
- Suscripciones por línea.
- Preferencias de notificación.

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

## Regla inicial de detección

Empezar con una regla simple y explicable:

- Considerar una línea en riesgo si, durante varias observaciones seguidas, la media de retraso supera un umbral y hay suficientes trenes afectados.

Esto es intencionalmente simple para el MVP. La meta es validar el flujo, no acertar con un modelo perfecto.

## Observabilidad

- Logs estructurados.
- Métricas básicas de polling, alertas y entregas.
- Trazas o correlation IDs por evento.

## Riesgos técnicos

- Calidad variable de los datos públicos.
- Rate limits o caídas de la fuente.
- Falsos positivos por umbrales demasiado agresivos.
- Deduplicación mal ajustada.

## Pruebas

- Pruebas de parsing GTFS-RT.
- Pruebas de detección con datos históricos o fixtures.
- Pruebas de envío Telegram con mocks.
- Pruebas de integración de eventos.