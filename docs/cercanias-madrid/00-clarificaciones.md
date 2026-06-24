# Clarificaciones iniciales

Estas son las preguntas que deberias cerrar antes de implementar.

## Fuente de datos

- Que endpoint GTFS-RT se usara exactamente?
- Es una sola fuente o varias por linea?
- Hay limites de uso o autenticacion?

## Deteccion

- Que intervalo de polling quieres?
- Cuantas observaciones consecutivas deben superar el umbral?
- Cual sera el umbral inicial de retraso?
- Que ventana de enfriamiento quieres para una alerta?

## Telegram

- La suscripcion sera por linea, por varias lineas o por lineas favoritas?
- El bot enviara alertas a chats privados, grupos o ambos?
- Quieres comandos simples o un flujo guiado con botones?

## Operacion

- Quieres panel web de administracion en el MVP?
- Que metricas son imprescindibles desde el primer dia?
- Como quieres revisar manualmente falsos positivos?

## Recomendacion para empezar

- Una sola fuente GTFS-RT.
- Polling cada 30 a 60 segundos.
- Regla simple por media de retraso y numero minimo de trenes.
- Ventana de enfriamiento de 10 a 15 minutos.
- Bot por comandos de Telegram primero, sin panel web.
