# Tareas MVP Cercanias Madrid

## Fase 1: base del proyecto

- Crear estructura del monorepo o multi-repo.
- Crear `docker-compose` con broker y base de datos.
- Crear convenciones compartidas de logs y eventos.

## Fase 2: ingesta

- [ ] Definir cliente GTFS-RT.
- [ ] Implementar polling programado.
- [ ] Normalizar observaciones por linea.
- [ ] Persistir ejecuciones y errores.
- [ ] Publicar evento `train.observation.recorded`.

## Fase 3: deteccion

- [ ] Implementar consumidor de observaciones.
- [ ] Agregar observaciones por linea y ventana de tiempo.
- [ ] Calcular indicador de anomalia.
- [ ] Emitir `line.incident.detected`.
- [ ] Aplicar deduplicacion temporal.

## Fase 4: Telegram

- [ ] Crear bot y manejo de comandos.
- [ ] Guardar suscripciones por usuario y linea.
- [ ] Implementar resolucion de destinatarios.
- [ ] Enviar mensajes de alerta.
- [ ] Registrar entregas y fallos.

## Fase 5: observabilidad y validacion

- [ ] Añadir logs estructurados.
- [ ] Añadir metricas basicas.
- [ ] Crear fixtures de datos reales o simulados.
- [ ] Probar casos de fallo de fuente.
- [ ] Probar un flujo completo end to end.

## Checklist de review

- La spec esta cubierta por tareas.
- Cada servicio tiene una responsabilidad clara.
- Los eventos tienen un contrato minimo.
- Los fallos de fuente no bloquean el sistema.
- Las alertas estan deduplicadas.
