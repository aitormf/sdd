# Organización de artefactos

## Para qué

SDD genera artefactos en cada paso del flujo: specs, planes, tareas, reviews. Sin una convención de dónde guardarlos, cómo nombrarlos y cómo saber en qué estado está cada uno, el proyecto se desordena rápido — especialmente cuando hay varias features, bugs y refactors en paralelo.

Este documento define:

- Dónde viven los artefactos.
- Cómo se organizan.
- Cómo se controla el ciclo de vida de cada work item.
- Quién puede hacer qué en cada fase.

## Estructura de `.sdd/`

Todos los artefactos SDD viven en un directorio `.sdd/` en la raíz del proyecto. Se commitea al repositorio — los artefactos son documentación del proyecto, no archivos temporales.

```
.sdd/
├── backlog.md                              # Índice central
├── constitution.md                         # Constitución del proyecto
│
├── 20260625-feat-auth-login/
│   ├── spec.md
│   ├── plan.md
│   ├── tasks.md
│   └── review.md
│
├── 20260627-fix-timezone-offset/
│   ├── spec.md
│   └── tasks.md
│
└── 20260701-refactor-api-v2/
    ├── spec.md
    ├── plan.md
    ├── tasks.md
    └── review.md
```

Cada work item es un directorio con formato `YYYYMMDD-tipo-nombre`:

- **YYYYMMDD** — fecha de creación. Da orden cronológico al listar y evita colisiones entre ramas (dos personas pueden crear specs en paralelo sin conflicto).
- **tipo** — alineado con conventional commits: `feat`, `fix`, `refactor`, `docs`, etc.
- **nombre** — slug descriptivo en kebab-case.

Si hay colisión (mismo día y mismo slug), se añade sufijo `-2`.

Dentro de cada directorio, los archivos siguen la [convención de nombres](README.md) del proyecto: `spec.md`, `plan.md`, `tasks.md`, `review.md`. No todos son obligatorios — depende del [tamaño del cambio](#adaptación-por-tamaño).

La constitución vive en `.sdd/constitution.md`. Si el proyecto ya tiene una en otro sitio (por ejemplo `docs/constitution.md`), se puede referenciar en lugar de duplicar. Ver [constitucion-guia.md](constitucion-guia.md).

## El backlog

`backlog.md` es el índice central del proyecto. Lista todos los work items con su estado actual. No duplica contenido — solo referencia a los directorios.

```md
# Backlog

| Item | Estado | Descripción |
|------|--------|-------------|
| [20260625-feat-auth-login](20260625-feat-auth-login/) | implementando | Login con OAuth2 |
| [20260627-fix-timezone-offset](20260627-fix-timezone-offset/) | spec-escrita | Fechas incorrectas en UTC- |
| [20260701-refactor-api-v2](20260701-refactor-api-v2/) | plan-en-revisión | Migrar a API v2 |
| [20260610-feat-user-registration](20260610-feat-user-registration/) | hecho | Registro básico |
| [20260615-feat-dark-mode](20260615-feat-dark-mode/) | descartado | Sin ROI suficiente |
```

Un solo archivo para ver el estado global. Editable a mano o por el agente. Compatible con cualquier herramienta. Git diff muestra los cambios de estado claramente.

## Estados y ciclo de vida

Los estados mapean directamente a los pasos del [flujo SDD](02-flujo.md):

| Estado | Paso SDD | Siguiente paso |
|--------|----------|----------------|
| `borrador` | — | Escribir la spec |
| `spec-escrita` | 2. Spec | Clarificar o revisar la spec |
| `spec-en-revisión` | 3. Clarificación | Aprobar o pedir cambios |
| `spec-aprobada` | — | Escribir el plan |
| `plan-escrito` | 4. Plan | Revisar el plan |
| `plan-en-revisión` | 4. Plan | Aprobar o pedir cambios |
| `plan-aprobado` | — | Generar tareas |
| `tareas-listas` | 5. Tareas | Implementar |
| `implementando` | 6. Implementación | Validar |
| `validando` | 7. Validación | Corregir o cerrar |
| `corrigiendo` | 8. Corrección | Volver a validar |
| `hecho` | — | — |
| `descartado` | — | — |

**Regla fundamental:** un work item no puede avanzar a un estado sin haber completado el anterior. Esta regla es lo que da estructura al flujo y evita que se implemente sin spec aprobada o se generen tareas sin plan revisado.

### Diagrama de transiciones

```
borrador
  │
  ▼
spec-escrita ◄─────────────┐
  │                         │
  ▼                         │
spec-en-revisión ──────── (devuelta)
  │
  ▼
spec-aprobada
  │
  ▼
plan-escrito ◄──────────────┐
  │                         │
  ▼                         │
plan-en-revisión ─────── (devuelto)
  │
  ▼
plan-aprobado
  │
  ▼
tareas-listas
  │
  ▼
implementando
  │
  ▼
validando ──────────────► corrigiendo
  │                         │
  ▼                         │
hecho                       └──► validando
```

Cualquier estado puede pasar a `descartado` en cualquier momento.

## Control de acceso por fase

Cada rol solo puede actuar sobre work items en estados específicos. Esto funciona como un equipo real: el implementador no toca algo que no tiene plan aprobado, el revisor no modifica la spec.

| Rol | Estados permitidos | Qué puede hacer |
|-----|-------------------|-----------------|
| **Autor** (humano o agente de spec) | `borrador`, `spec-escrita` | Crear y editar la spec |
| **Revisor de spec** | `spec-en-revisión` | Revisar spec, aprobar o devolver |
| **Planificador** | `spec-aprobada` | Escribir el plan |
| **Revisor de plan** | `plan-en-revisión` | Revisar plan, aprobar o devolver |
| **Generador de tareas** | `plan-aprobado` | Generar `tasks.md` |
| **Implementador** | `tareas-listas`, `implementando`, `corrigiendo` | Codificar |
| **Validador** | `validando` | Revisar contra spec (read-only) |

**El revisor no modifica** — aprueba o devuelve con motivo. Si la spec necesita cambios, vuelve al autor. Si el plan necesita cambios, vuelve al planificador.

Esto se implementa como convención documentada. La enforcement depende de la herramienta: instrucciones de agente, CLAUDE.md, AGENTS.md, o reglas del orquestador.

## Flujo de devolución

Cuando una revisión no pasa:

- **Spec devuelta** → vuelve a `spec-escrita`. El autor corrige según el feedback del revisor y reenvía a revisión.
- **Plan devuelto** → vuelve a `plan-escrito`. El planificador corrige.
- **Validación fallida** → pasa a `corrigiendo`. El implementador ajusta y vuelve a `validando`.

El motivo de la devolución se registra en `review.md` del work item para trazabilidad.

## Agente orquestador

El orquestador es un agente que actúa como project manager del flujo SDD. No escribe specs ni código — gestiona el estado y delega al agente correcto.

### Responsabilidades

1. Leer `backlog.md` para conocer el estado de cada work item.
2. Validar que las transiciones de estado son legales (no se saltan pasos).
3. Delegar al agente o skill correcto según el estado actual.
4. Actualizar `backlog.md` tras cada transición.
5. Rechazar acciones fuera de fase.

### Tabla de delegación

| Estado actual | Acción | Delega a |
|---------------|--------|----------|
| `borrador` | Escribir spec | Autor / skill `idea-to-spec` |
| `spec-escrita` | Revisar spec | Revisor / skill `review-spec` |
| `spec-en-revisión` → aprobada | Aprobar | Orquestador actualiza estado |
| `spec-en-revisión` → devuelta | Devolver con motivo | Orquestador pasa a `spec-escrita` |
| `spec-aprobada` | Escribir plan | Planificador / skill `spec-to-plan` |
| `plan-escrito` | Revisar plan | Revisor |
| `plan-en-revisión` → aprobado | Aprobar | Orquestador actualiza estado |
| `plan-aprobado` | Generar tareas | Skill `plan-to-tasks` |
| `tareas-listas` | Implementar | Agente implementador |
| `implementando` | Validar | Validador (read-only) |
| `validando` → ok | Cerrar | Orquestador pasa a `hecho` |
| `validando` → fallos | Corregir | Orquestador pasa a `corrigiendo` |

### Ejemplo de interacción

```
Usuario: "Avanza feat-auth-login"
Orquestador: Lee backlog → estado actual: spec-aprobada
Orquestador: "El siguiente paso es escribir el plan. Delegando al planificador."
Orquestador: Ejecuta skill spec-to-plan con .sdd/20260625-feat-auth-login/spec.md
Orquestador: Actualiza backlog → estado: plan-escrito
```

```
Usuario: "Implementa refactor-api-v2"
Orquestador: Lee backlog → estado actual: plan-en-revisión
Orquestador: "No puedo implementar. El plan está pendiente de revisión.
              Siguiente paso disponible: revisar el plan."
```

El orquestador se implementa como skill (reglas del flujo) + agente (ejecución con herramientas). La skill puede cargarse en cualquier herramienta compatible; el agente usa la skill como base y añade acceso a herramientas para leer y modificar archivos.

## Convenciones

### Slugs

Formato: `YYYYMMDD-tipo-nombre`

- **Fecha:** `YYYYMMDD` del día de creación.
- **Tipo:** `feat`, `fix`, `refactor`, `docs`, etc. (alineado con conventional commits).
- **Nombre:** kebab-case descriptivo.
- **Colisión:** si coinciden fecha y slug, añadir sufijo `-2`.

Ejemplos: `20260625-feat-auth-login`, `20260627-fix-timezone-offset`, `20260701-refactor-api-v2`.

### Artefactos

Siempre `spec.md`, `plan.md`, `tasks.md`, `review.md`. Consistente con la [convención del proyecto](README.md).

### Tareas dentro de `tasks.md`

Checkboxes estándar de markdown:

```md
- [x] Crear modelo de datos
- [x] Implementar endpoint POST /albums
- [ ] Añadir validación de inputs
- [ ] Escribir tests de integración
```

### Git

- Todo `.sdd/` se commitea al repositorio.
- El slug puede coincidir con la rama git: `feat-auth-login`.
- Los cambios de estado en `backlog.md` se ven claramente en el diff.

## Adaptación por tamaño

No todos los work items necesitan el flujo completo. Alineado con la [tabla de `02-flujo.md`](02-flujo.md#pasos-opcionales-según-el-tamaño-de-la-tarea):

| Tipo de cambio | Artefactos mínimos | Estados que se saltan |
|----------------|-------------------|-----------------------|
| Bug de una línea | `tasks.md` (o nada) | Todo salvo implementar y validar |
| Bug complejo | `spec.md` + `tasks.md` | Plan, revisiones formales |
| Feature pequeña | `spec.md` + `plan.md` + `tasks.md` | Revisiones formales |
| Feature de producción | Todos | Ninguno — flujo completo |
| Refactor arquitectural | Todos | Ninguno — flujo completo |

Cuando se saltan pasos, el estado en el backlog refleja el paso real en el que está el work item. Un bug simple puede ir directamente de `borrador` a `tareas-listas`.

## Ejemplo completo

Un proyecto con cuatro work items en distintas fases:

```
.sdd/
├── backlog.md
├── constitution.md
│
├── 20260610-feat-user-registration/
│   ├── spec.md          ← spec aprobada
│   ├── plan.md          ← plan aprobado
│   ├── tasks.md         ← todas las tareas [x]
│   └── review.md        ← validación OK
│
├── 20260625-feat-auth-login/
│   ├── spec.md          ← spec aprobada
│   ├── plan.md          ← plan aprobado
│   └── tasks.md         ← 3 de 7 tareas [x]
│
├── 20260627-fix-timezone-offset/
│   └── spec.md          ← spec escrita, pendiente de revisión
│
└── 20260701-refactor-api-v2/
    ├── spec.md          ← spec aprobada
    └── plan.md          ← plan devuelto por el revisor
```

Y su `backlog.md`:

```md
# Backlog

| Item | Estado | Descripción |
|------|--------|-------------|
| [20260625-feat-auth-login](20260625-feat-auth-login/) | implementando | Login con OAuth2 |
| [20260627-fix-timezone-offset](20260627-fix-timezone-offset/) | spec-en-revisión | Fechas incorrectas en UTC- |
| [20260701-refactor-api-v2](20260701-refactor-api-v2/) | plan-escrito | Migrar a API v2 (devuelto, pendiente de corrección) |
| [20260610-feat-user-registration](20260610-feat-user-registration/) | hecho | Registro básico de usuarios |
```

## Referencias

- [GitHub Spec Kit](https://github.com/github/spec-kit) — toolkit SDD con directorio `specs/` numerado y comandos `/speckit.*`.
- [AWS Kiro](https://kiro.dev/docs/specs/) — IDE con `.kiro/specs/` y estados automáticos en tareas.
- [Harness Engineering](https://www.augmentcode.com/guides/harness-engineering-ai-coding-agents) — la disciplina de estructurar el entorno alrededor de agentes IA.
- [Martin Fowler — SDD Tools](https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html) — comparativa de herramientas SDD.
