# Onboarding — Nouvelle machine

Guide pour restaurer l'environnement Claude Code complet depuis ce dépôt.

## Prérequis

- Git installé
- Claude Code CLI installé (`npm install -g @anthropic-ai/claude-code` ou équivalent)
- Bash disponible (Git Bash sur Windows)

## Étapes

### 1. Cloner le dépôt

```bash
git clone <url-du-repo> ~/claude-config-central
```

### 2. Configurer les variables locales

```bash
cp ~/claude-config-central/settings.env.example ~/claude-config-central/.env
# Éditer .env et remplir les vraies valeurs
```

### 3. Lancer l'installation

```bash
bash ~/claude-config-central/install.sh
```

Ce script copie :
- `CLAUDE.md` → `~/.claude/CLAUDE.md`
- `settings.json` → `~/.claude/settings.json`
- `skills/*` → `~/.claude/skills/`
- `agents/*` → `~/.claude/agents/`
- `commands/*` → `~/.claude/commands/`

### 4. Ajouter les credentials

Les credentials ne sont pas dans ce dépôt. Se reconnecter via :
```bash
claude login
```

## Structure mémoire

La mémoire auto est dans `~/.claude/projects/<projet>/memory/`.
Elle n'est pas versionnée ici — elle est propre à chaque machine.
