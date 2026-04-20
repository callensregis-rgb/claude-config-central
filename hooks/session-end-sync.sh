#!/usr/bin/env bash
# session-end-sync.sh — Pousse les changements du dépôt centralisé à la fin de session
# Déclenché par le hook SessionEnd de Claude Code

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TIMEOUT=30

# Timeout global via sous-shell avec watchdog
(
  cd "$REPO_DIR"

  # Vérifier s'il y a des changements (tracked ou untracked)
  if git diff --quiet && git diff --cached --quiet && [ -z "$(git status --porcelain)" ]; then
    exit 0  # Rien à pousser — sortie silencieuse
  fi

  TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
  HOST="$(hostname 2>/dev/null || echo 'unknown')"
  CHANGED_FILES="$(git status --porcelain | awk '{print $2}' | tr '\n' ' ' | sed 's/ $//')"

  # Sync depuis la source avant de pousser
  if [ -d "$HOME/.claude/skills" ]; then
    cp -r "$HOME/.claude/skills/." "$REPO_DIR/skills/" 2>/dev/null || true
  fi
  if [ -f "$HOME/.claude/CLAUDE.md" ]; then
    cp "$HOME/.claude/CLAUDE.md" "$REPO_DIR/CLAUDE.md" 2>/dev/null || true
  fi

  # Pull --rebase pour éviter les conflits
  git pull --no-rebase --autostash --quiet 2>>"$REPO_DIR/sync.log" || { echo "[$(date +'%Y-%m-%d %H:%M:%S')] ERREUR pull — sync manuelle requise" >> "$REPO_DIR/sync.log"; exit 1; }

  # Stage tout
  git add --all

  # Vérifier à nouveau après pull (peut être vide)
  if git diff --cached --quiet; then
    exit 0
  fi

  # Commit
  git commit -m "auto-sync: ${HOST} @ ${TIMESTAMP} — ${CHANGED_FILES}" --quiet

  # Push
  git push --quiet 2>/dev/null

  echo "Config synchronisée. Sur les autres postes : git pull" >&2

) &
BGPID=$!

# Attendre max TIMEOUT secondes
for i in $(seq 1 $TIMEOUT); do
  if ! kill -0 "$BGPID" 2>/dev/null; then
    wait "$BGPID" 2>/dev/null || true
    exit 0
  fi
  sleep 1
done

# Timeout dépassé — tuer le sous-shell
kill "$BGPID" 2>/dev/null || true
echo "session-end-sync: timeout après ${TIMEOUT}s" >&2
exit 0
