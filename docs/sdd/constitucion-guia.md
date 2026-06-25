# Constitución del proyecto — Guía

## Qué es

La constitución es un documento que recoge las reglas inmutables de tu proyecto: las decisiones que aplican a todo cambio, siempre, sin excepción. No cambia por feature ni por sprint — cambia cuando cambia una decisión fundamental del proyecto.

No es un template que rellena la IA. Es un documento que escribes tú como responsable del proyecto. La IA puede ayudarte a pensar qué te falta, pero las decisiones son tuyas.

## Qué NO es

- **No es un CLAUDE.md.** CLAUDE.md mezcla contexto del proyecto, instrucciones de comportamiento, y convenciones en un solo archivo. La constitución es solo la parte de reglas inmutables.
- **No es una spec.** La spec describe una funcionalidad concreta. La constitución describe cómo se construye cualquier funcionalidad.
- **No es un documento técnico exhaustivo.** No necesita cubrir cada caso — solo las decisiones que, si alguien (humano o IA) las ignora, generan problemas.

## Cómo se usa

1. La escribes una vez al inicio del proyecto.
2. La guardas como archivo (por ejemplo `constitution.md` o `docs/constitution.md`).
3. La referencias desde tu archivo de instrucciones del agente (CLAUDE.md, AGENTS.md, steering files) para que la IA la cargue como contexto.
4. La actualizas cuando cambia una decisión fundamental — no por cada feature.

## Qué tipo de decisiones incluir

Piensa en las preguntas que un desarrollador nuevo te haría el primer día, o los errores que la IA comete si no le das contexto. La constitución responde a preguntas como estas:

### Stack y arquitectura
- ¿Qué lenguaje y versión usamos?
- ¿Qué framework y por qué ese y no otro?
- ¿Monolito, microservicios, serverless?
- ¿Qué base de datos y por qué?
- ¿Hay restricciones de infraestructura (cloud específico, on-premise)?

### Calidad y testing
- ¿Qué nivel de testing se espera (unitarios, integración, e2e)?
- ¿TDD estricto o tests después?
- ¿Qué cobertura mínima?
- ¿Qué herramientas de testing usamos?

### Seguridad
- ¿Cómo se gestiona la autenticación?
- ¿Hay datos sensibles que requieran tratamiento especial?
- ¿Qué validaciones son obligatorias en inputs?
- ¿Hay requisitos de compliance (GDPR, HIPAA)?

### Convenciones de código
- ¿Naming conventions?
- ¿Estructura de directorios?
- ¿Linter y formatter obligatorios?
- ¿Patrones preferidos (repositorio, servicio, etc.)?
- ¿Patrones prohibidos?

### Proceso
- ¿Cómo se nombran las ramas?
- ¿Cómo se escriben los commits?
- ¿Hay CI/CD? ¿Qué debe pasar antes de merge?
- ¿Hay review obligatorio?

### Dependencias
- ¿Se permiten dependencias externas libremente o hay un proceso de aprobación?
- ¿Hay librerías prohibidas?
- ¿Se prefiere código propio sobre dependencias?

## Ejemplo real: API de gestión de álbumes de fotos

```md
# Constitución — PhotoAlbum API

## Stack
- Backend: Python 3.12 + FastAPI.
- Base de datos: PostgreSQL 16.
- ORM: SQLAlchemy 2.x con migraciones Alembic.
- Frontend: fuera del alcance de este proyecto.

## Testing
- Tests unitarios obligatorios para toda lógica de negocio.
- Tests de integración para endpoints y acceso a datos.
- Cobertura mínima: 80%.
- Framework: pytest.
- No mockear la base de datos en tests de integración — usar una instancia PostgreSQL de test.

## Seguridad
- Autenticación con JWT. Sin sesiones en servidor.
- Todos los inputs de usuario se validan con Pydantic.
- Las fotos se sirven con URLs firmadas con expiración (15 min).
- No almacenar datos personales fuera de la tabla `users`.

## Convenciones
- Código en inglés, documentación en español.
- snake_case para todo (variables, funciones, endpoints).
- Un módulo por dominio: albums/, photos/, users/, sharing/.
- Cada módulo tiene: router, service, repository, schemas.
- No usar herencia de clases para lógica de negocio — preferir composición.

## Proceso
- Ramas: feature/nombre-corto, fix/nombre-corto.
- Commits: conventional commits (feat:, fix:, refactor:, test:).
- CI: ruff + pytest deben pasar antes de merge.
- No se hace push directo a main.

## Dependencias
- Nuevas dependencias requieren justificación.
- Prohibido: ORM que no sea SQLAlchemy, frameworks web que no sean FastAPI.
- Preferir stdlib sobre dependencias para utilidades simples.
```

## Cómo puede ayudarte la IA

La IA no debe escribir tu constitución, pero sí puede ayudarte a pensar en ella. Algunos prompts útiles:

> "Revisa esta constitución y dime qué áreas importantes no estoy cubriendo para un proyecto de este tipo."

> "¿Qué decisiones técnicas debería tomar antes de empezar a escribir specs para este proyecto?"

> "¿Hay contradicciones o ambigüedades en estas reglas?"

La decisión final sobre cada punto es tuya. Si la IA sugiere añadir algo y no estás seguro, no lo añadas — una regla que no entiendes o no defiendes no debería estar en la constitución.

## Cuándo actualizar la constitución

- Cuando cambias de framework o herramienta principal.
- Cuando añades un requisito de compliance nuevo.
- Cuando descubres que la IA comete un error repetidamente por falta de contexto — eso probablemente es una regla que falta.
- Cuando una regla ya no aplica (por ejemplo, dejáis de usar TDD estricto).

No la actualices por cada feature ni por cada bug. Si te encuentras cambiándola a menudo, probablemente estás poniendo cosas que deberían ir en la spec, no en la constitución.