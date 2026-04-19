#!/usr/bin/env bash
# sync-to-claude.sh — Copie ~/.claude/ vers claude-config-central
# Usage : bash ~/claude-config-central/hooks/sync-to-claude.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"
LOG="$REPO_DIR/sync.log"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Début sync" | tee -a "$LOG"

# skills/
if [ -d "$CLAUDE_DIR/skills" ]; then
  rsync -a --delete "$CLAUDE_DIR/skills/" "$REPO_DIR/skills/" 2>/dev/null || \
    cp -r "$CLAUDE_DIR/skills/." "$REPO_DIR/skills/"
  echo "[OK] skills/" | tee -a "$LOG"
fi

# agents/
if [ -d "$CLAUDE_DIR/agents" ]; then
  mkdir -p "$REPO_DIR/agents"
  cp -r "$CLAUDE_DIR/agents/." "$REPO_DIR/agents/" 2>/dev/null || true
  echo "[OK] agents/" | tee -a "$LOG"
fi

# commands/
if [ -d "$CLAUDE_DIR/commands" ]; then
  mkdir -p "$REPO_DIR/commands"
  cp -r "$CLAUDE_DIR/commands/." "$REPO_DIR/commands/" 2>/dev/null || true
  echo "[OK] commands/" | tee -a "$LOG"
fi

# CLAUDE.md
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
  cp "$CLAUDE_DIR/CLAUDE.md" "$REPO_DIR/CLAUDE.md"
  echo "[OK] CLAUDE.md" | tee -a "$LOG"
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Sync terminé" | tee -a "$LOG"
echo ""
echo "==> Pense à committer les changements :"
echo "    cd $REPO_DIR && git add -A && git commit -m 'sync: $(date +%Y-%m-%d)'"
