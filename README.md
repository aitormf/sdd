# SDD — Spec-Driven Development
Guía práctica y kit de herramientas para aplicar Spec-Driven Development con cualquier CLI de agente (Claude Code, OpenCode, Codex, o cualquier herramienta compatible con Open Agent Skills).
## Qué es SDD
En SDD la spec es la fuente de verdad compartida. El código, los tests, el plan y las tareas derivan de esa spec, no al revés.
## Estructura del repositorio
```
agents/         Agentes (implement, spec-planner, spec-reviewer)
skills/         Skills (idea-to-spec, spec-to-plan, plan-to-tasks, review-spec)
templates/      Plantillas (spec, plan, tasks, review)
scripts/        Instalador y tests
docs/sdd/       Guía completa de SDD (12 capítulos)
docs/cercanias-madrid/  Ejemplo completo de SDD aplicado
```
## Instalación en un proyecto
```bash
# Instalar para todos los CLIs
scripts/install-sdd.sh /ruta/al/proyecto
# Instalar solo para CLIs específicos
scripts/install-sdd.sh /ruta/al/proyecto claude codex
```
CLIs soportados: `claude`, `agents`, `opencode`, `codex`.
El instalador copia agents, skills y templates a `.sdd/` en el proyecto destino y crea los adaptadores (symlinks o archivos generados) para cada CLI seleccionado.
## Flujo SDD
1. **Idea → Spec** — skill `idea-to-spec`
2. **Spec → Plan** — skill `spec-to-plan`
3. **Plan → Tareas** — skill `plan-to-tasks`
4. **Review** — skill `review-spec` o agente `spec-reviewer`
5. **Implementación** — agente `implement`
## Documentación
La guía completa está en [`docs/sdd/`](docs/sdd/README.md). Orden recomendado:
1. [Qué es SDD](docs/sdd/01-que-es-sdd.md)
2. [Flujo de trabajo](docs/sdd/02-flujo.md)
3. [Cómo escribir buenas specs](docs/sdd/03-como-escribir-buenas-specs.md)
4. [De spec a plan, tareas y review](docs/sdd/04-de-spec-a-plan-tareas-y-review.md)
5. [Referencias y skills](docs/sdd/05-referencias-y-skills.md)
6. [Plantilla de spec](docs/sdd/06-plantilla-de-spec.md)
7. [Guía práctica](docs/sdd/07-guia-practica.md)
8. [Ejemplo completo](docs/sdd/08-ejemplo-completo.md)
9. [Herramienta por paso](docs/sdd/09-herramienta-por-paso.md)
10. [Estrategia multi herramienta](docs/sdd/10-multi-herramienta.md)
11. [Agente implementador](docs/sdd/11-agente-implementador.md)
12. [Instalador](docs/sdd/12-installer.md)
## Tests
```bash
bash scripts/tests/test-install.sh
```