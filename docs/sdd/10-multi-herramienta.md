# Estrategia Multi Herramienta

La mejor forma de trabajar con OpenCode, Claude Code y Codex es separar entre:

- **contenido compartido** (una sola fuente de verdad)
- **adaptadores por herramienta** (generados por el instalador)

## Contenido compartido

El repositorio SDD contiene la fuente canónica:

```text
agents/         ← agentes (YAML frontmatter + Markdown)
skills/         ← skills (formato Open Agent Skills)
templates/      ← plantillas de spec, plan, tasks, review
```

## Instalador

```bash
scripts/install-sdd.sh <dest-dir> [cli ...]
```

Copia agents, skills y templates a `.sdd/` en el proyecto destino y genera los adaptadores para cada CLI seleccionado.

CLIs disponibles: `claude`, `agents`, `opencode`, `codex`. Si no se especifica ninguno, instala todos.

```bash
# Instalar para Claude Code y Codex
scripts/install-sdd.sh /ruta/al/proyecto claude codex

# Instalar para todos los CLIs
scripts/install-sdd.sh /ruta/al/proyecto
```

## Resultado en el proyecto destino

```text
proyecto/
├── .sdd/
│   ├── agents/          ← fuente local (copiados)
│   ├── skills/          ← fuente local (copiados)
│   └── templates/       ← plantillas (copiadas)
├── .claude/             ← symlinks a .sdd/ (si seleccionado)
├── .agents/             ← symlinks a .sdd/ (si seleccionado)
├── .opencode/           ← skills: symlinks, agentes: generados
└── .codex/              ← skills: symlinks, agentes: TOML generado
```

## Formatos por herramienta

| CLI | Skills | Agentes |
|-----|--------|---------|
| claude | symlink a .sdd/ | symlink a .sdd/ |
| agents | symlink a .sdd/ | symlink a .sdd/ |
| opencode | symlink a .sdd/ | generados (schema `permission:` granular) |
| codex | symlink a .sdd/ | generados TOML (`developer_instructions`, `sandbox_mode`) |

## Regla de oro

No pongas la misma lógica del proceso en tres formatos distintos.

Ponla una vez en el repo SDD y usa `install-sdd.sh` para desplegar.

## Variables de entorno

- `CODEX_MODEL` — modelo de Codex (default: `gpt-5.4`)
- `CODEX_REASONING` — esfuerzo de razonamiento (default: `high`)

## Ventaja

Esto te permite cambiar de herramienta sin cambiar de metodología.
