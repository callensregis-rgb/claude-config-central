# claude-config-central

Dépôt centralisé de la configuration Claude Code de Regis Callens.

## Contenu

| Fichier / Dossier | Rôle |
|---|---|
| `CLAUDE.md` | Instructions globales pour tous les projets |
| `settings.json` | Configuration Claude Code (sans credentials) |
| `settings.env.example` | Variables d'environnement locales à définir |
| `skills/` | Skills installés (`~/.claude/skills/`) |
| `agents/` | Agents personnalisés (`~/.claude/agents/`) |
| `commands/` | Commandes slash (`~/.claude/commands/`) |
| `rules/` | Règles projet (`~/.claude/rules/`) |
| `hooks/` | Scripts de synchronisation |
| `_conflicts/` | Fichiers en conflit à résoudre manuellement |

## Installation

```bash
bash ~/claude-config-central/install.sh
```

## Synchronisation manuelle

```bash
bash ~/claude-config-central/hooks/sync-to-claude.sh
```
