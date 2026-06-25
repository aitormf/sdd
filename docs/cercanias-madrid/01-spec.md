# Spec: Alertas en tiempo real para Cercanías Madrid

## Objetivo

Detectar incidencias probables en líneas de Cercanías Madrid a partir de datos públicos de puntualidad y notificar a usuarios suscritos por Telegram.

## Problema que resuelve

Renfe puede tardar en publicar avisos oficiales, pero los retrasos en tiempo real suelen dar señales tempranas de que hay una incidencia en una línea. Los usuarios no tienen forma de saber que su tren va a llegar tarde hasta que ya están en el andén.

## Usuarios

- **Viajero habitual:** usa Cercanías a diario para ir al trabajo. Necesita saber cuanto antes si su línea tiene problemas para buscar alternativas.
- **Viajero ocasional:** usa Cercanías puntualmente. Quiere recibir alertas solo de la línea que va a usar ese día.

## User stories

- Como **viajero habitual**, quiero suscribirme a mi línea de Cercanías para recibir alertas automáticas cuando haya incidencias.
- Como **viajero habitual**, quiero darme de baja de una línea cuando deje de usarla para no recibir alertas innecesarias.
- Como **viajero ocasional**, quiero suscribirme y darme de baja fácilmente desde Telegram para no tener que instalar otra app.
- Como **viajero habitual**, quiero que la alerta me diga qué línea está afectada y un resumen del motivo para decidir rápidamente si busco alternativa.

## Requisitos funcionales

### Suscripción

- RF-01: El usuario puede suscribirse a una o varias líneas mediante Telegram.
- RF-02: El usuario puede darse de baja de una línea.
- RF-03: El sistema conserva la preferencia de línea por usuario.

### Ingesta

- RF-04: El sistema consulta periódicamente las fuentes GTFS-RT.
- RF-05: El sistema normaliza los datos relevantes por tren y línea.
- RF-06: Si una fuente falla de forma temporal, el sistema registra el error y continúa con el siguiente ciclo.

### Detección

- RF-07: El sistema calcula un indicador sencillo de anomalía por línea basado en la media de retraso y el número de trenes afectados.
- RF-08: El sistema genera una alerta cuando el indicador supera un umbral predefinido durante varias observaciones consecutivas.
- RF-09: El sistema evita emitir múltiples alertas equivalentes dentro de una ventana de enfriamiento.

### Notificación

- RF-10: El sistema envía mensajes a los usuarios suscritos a la línea afectada.
- RF-11: El mensaje incluye la línea, la hora de detección y un resumen breve del motivo.

## Requisitos no funcionales

- RNF-01: La arquitectura debe ser simple y ejecutable con Docker Compose.
- RNF-02: Los servicios deben estar desacoplados mediante un broker de mensajería.
- RNF-03: Debe haber trazabilidad básica de eventos y errores (logs estructurados).
- RNF-04: El sistema debe tolerar fallos temporales de fuentes externas sin caerse.
- RNF-05: El sistema debe ser fácil de observar y depurar.

## Casos límite

- ¿Qué pasa si la fuente GTFS-RT devuelve datos vacíos? → Se registra como error y se espera al siguiente ciclo.
- ¿Qué pasa si no se puede identificar la línea de un tren? → Se descarta esa observación y se registra.
- ¿Qué pasa si un usuario se suscribe a una línea que no existe? → Se informa al usuario y no se crea la suscripción.
- ¿Qué pasa si hay retrasos en varias líneas simultáneamente? → Se generan alertas independientes por línea.
- ¿Qué pasa si Telegram está caído? → Se registra el fallo y se reintenta.
- ¿Qué pasa si el umbral genera muchos falsos positivos? → El umbral es configurable sin redesplegar.

## Criterios de aceptación

- Dado un usuario suscrito, cuando el sistema detecta una alerta en su línea, entonces recibe un mensaje por Telegram con la línea, hora y motivo.
- Dado un fallo temporal en la fuente GTFS-RT, cuando el sistema intenta consultar, entonces registra el error y sigue ejecutando el siguiente ciclo sin caerse.
- Dada una línea con retrasos persistentes por encima del umbral, cuando se cumplen las observaciones consecutivas requeridas, entonces el sistema genera una alerta una sola vez dentro de la ventana de enfriamiento.
- Dado un usuario dado de baja, cuando se detecta una alerta en su antigua línea, entonces el sistema no le notifica.
- Dado un usuario que envía `/subscribe C4`, cuando el comando se procesa, entonces el sistema confirma la suscripción y la persiste.

## Alcance

Ingesta de datos GTFS-RT, detección de incidencias con una regla simple, notificación por Telegram y gestión de suscripciones por comandos.

## Fuera de alcance

- Predicción avanzada con ML.
- App móvil propia.
- Integraciones con otras redes ferroviarias.
- Intervención manual de operadores en tiempo real.
- Panel web de administración.

## Entidades / Modelo de datos

- **Observación:** id, línea, tren, retraso en segundos, timestamp, fuente.
- **Alerta:** id, línea, detectada_en, severidad, resumen, ventana de enfriamiento.
- **Usuario:** telegram_id, nombre.
- **Suscripción:** usuario, línea, fecha de alta.

## Métricas de éxito

- El 80% de las incidencias reales de Cercanías generan una alerta antes de que Renfe publique el aviso oficial.
- Menos del 20% de las alertas son falsos positivos en el primer mes.
- Los usuarios suscritos reciben la notificación en menos de 2 minutos desde la detección.

## Dependencias

- Fuente pública GTFS-RT con datos de Cercanías Madrid (por validar disponibilidad y formato).
- API de Telegram Bot (disponible, sin coste para bots).
- Docker y Docker Compose para despliegue local.

## Riesgos

- Calidad variable de los datos públicos GTFS-RT — puede haber huecos o datos incorrectos.
- Rate limits o caídas de la fuente GTFS-RT.
- Falsos positivos por umbrales demasiado agresivos.
- No poder identificar la línea de cada tren con fiabilidad suficiente.

## Supuestos

- Las fuentes públicas GTFS-RT están disponibles y contienen los datos necesarios para el MVP.
- Se puede identificar la línea de cada tren con suficiente fiabilidad.
- Telegram será el canal de notificación principal del MVP.

## Preguntas abiertas

- ¿Qué fuente GTFS-RT exacta se usará?
- ¿Cada cuánto se debe consultar la fuente?
- ¿Cuál es el umbral inicial de anomalía?
- ¿Cómo se define una ventana de enfriamiento razonable?
- ¿Se notificará por línea, por tramo o por estación?