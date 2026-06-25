# Clarificaciones iniciales

Estas son las preguntas que deberías cerrar antes de implementar.

## Fuente de datos

- ¿Qué endpoint GTFS-RT se usará exactamente?
- ¿Es una sola fuente o varias por línea?
- ¿Hay límites de uso o autenticación?

## Detección

- ¿Qué intervalo de polling quieres?
- ¿Cuántas observaciones consecutivas deben superar el umbral?
- ¿Cuál será el umbral inicial de retraso?
- ¿Qué ventana de enfriamiento quieres para una alerta?

## Telegram

- ¿La suscripción será por línea, por varias líneas o por líneas favoritas?
- ¿El bot enviará alertas a chats privados, grupos o ambos?
- ¿Quieres comandos simples o un flujo guiado con botones?

## Operación

- ¿Quieres panel web de administración en el MVP?
- ¿Qué métricas son imprescindibles desde el primer día?
- ¿Cómo quieres revisar manualmente falsos positivos?

## Recomendación para empezar

- Una sola fuente GTFS-RT.
- Polling cada 30 a 60 segundos.
- Regla simple por media de retraso y número mínimo de trenes.
- Ventana de enfriamiento de 10 a 15 minutos.
- Bot por comandos de Telegram primero, sin panel web.