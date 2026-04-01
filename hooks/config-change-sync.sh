#!/usr/bin/env bash
# config-change-sync.sh — Synchronise ~/.claude/ vers le dépôt centralisé
# Déclenché par le hook ConfigChange de Claude Code (async, non-bloquant)

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# Sur Windows, $HOME peut pointer vers un lecteur réseau (Z:) au lieu du profil réel.
# USERPROFILE pointe toujours vers C:\Users\xxx, on l'utilise en priorité.
CLAUDE_DIR="${USERPROFILE:-$HOME}/.claude"
LOG="$REPO_DIR/sync.log"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
CHANGED=0

log() {
  echo "[$TIMESTAMP] $*" >> "$LOG"
}

sync_dir() {
  local src="$1"
  local dst="$2"
  local label="$3"

  [ -d "$src" ] || return 0

  mkdir -p "$dst"

  # Détecter les nouveaux fichiers ou fichiers modifiés
  while IFS= read -r -d '' file; do
    rel="${file#$src/}"
    target="$dst/$rel"

    if [ ! -f "$target" ]; then
      # Nouveau fichier
      mkdir -p "$(dirname "$target")"
      cp "$file" "$target"
      log "NOUVEAU  [$label] $rel"
      CHANGED=1
    elif ! cmp -s "$file" "$target"; then
      # Fichier modifié — vérifier s'il y a conflit (target plus récent)
      if [ "$target" -nt "$file" ]; then
        cp "$target" "$REPO_DIR/_conflicts/$(basename "$rel").$(date +%s).conflict"
        log "CONFLIT  [$label] $rel → copié dans _conflicts/"
      fi
      cp "$file" "$target"
      log "MIS-A-JOUR [$label] $rel"
      CHANGED=1
    fi
  done < <(find "$src" -type f -print0)
}

# Synchroniser chaque répertoire géré
sync_dir "$CLAUDE_DIR/skills"   "$REPO_DIR/skills"   "skills"
sync_dir "$CLAUDE_DIR/agents"   "$REPO_DIR/agents"   "agents"
sync_dir "$CLAUDE_DIR/commands" "$REPO_DIR/commands" "commands"
sync_dir "$CLAUDE_DIR/rules"    "$REPO_DIR/rules"    "rules"

# CLAUDE.md
if [ -f "$CLAUDE_DIR/CLAUDE.md" ] && ! cmp -s "$CLAUDE_DIR/CLAUDE.md" "$REPO_DIR/CLAUDE.md" 2>/dev/null; then
  cp "$CLAUDE_DIR/CLAUDE.md" "$REPO_DIR/CLAUDE.md"
  log "MIS-A-JOUR [CLAUDE.md]"
  CHANGED=1
fi

if [ "$CHANGED" -eq 0 ]; then
  log "Aucun changement détecté"
fi

exit 0
