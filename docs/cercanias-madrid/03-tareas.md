# Tareas MVP Cercanías Madrid

## Fase 1: base del proyecto

- [ ] Crear estructura del monorepo o multi-repo.
- [ ] Crear `docker-compose` con broker y base de datos.
- [ ] Crear convenciones compartidas de logs y eventos.

## Fase 2: ingesta

- [ ] Definir cliente GTFS-RT.
- [ ] Implementar polling programado.
- [ ] Normalizar observaciones por línea.
- [ ] Persistir ejecuciones y errores.
- [ ] Publicar evento `train.observation.recorded`.

## Fase 3: detección

- [ ] Implementar consumidor de observaciones.
- [ ] Agregar observaciones por línea y ventana de tiempo.
- [ ] Calcular indicador de anomalía.
- [ ] Emitir `line.incident.detected`.
- [ ] Aplicar deduplicación temporal.

## Fase 4: Telegram

- [ ] Crear bot y manejo de comandos.
- [ ] Guardar suscripciones por usuario y línea.
- [ ] Implementar resolución de destinatarios.
- [ ] Enviar mensajes de alerta.
- [ ] Registrar entregas y fallos.

## Fase 5: observabilidad y validación

- [ ] Añadir logs estructurados.
- [ ] Añadir métricas básicas.
- [ ] Crear fixtures de datos reales o simulados.
- [ ] Probar casos de fallo de fuente.
- [ ] Probar un flujo completo end to end.

## Checklist de review

- ¿La spec está cubierta por tareas?
- ¿Cada servicio tiene una responsabilidad clara?
- ¿Los eventos tienen un contrato mínimo?
- ¿Los fallos de fuente no bloquean el sistema?
- ¿Las alertas están deduplicadas?