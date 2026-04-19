#!/usr/bin/env bash
# session-start-sync.sh — Pull automatique au démarrage de session
# Déclenché par le hook SessionStart de Claude Code (async: true)
# Toujours exit 0 — ne jamais bloquer le démarrage de session

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TIMEOUT=10

(
  cd "$REPO_DIR" || exit 0

  # Fetch silencieux avec timeout
  git fetch origin --quiet 2>/dev/null || exit 0

  # Comparer HEAD et origin/main
  LOCAL="$(git rev-parse HEAD 2>/dev/null)" || exit 0
  REMOTE="$(git rev-parse origin/main 2>/dev/null)" || exit 0

  # À jour → sortie silencieuse
  [ "$LOCAL" = "$REMOTE" ] && exit 0

  # Vérifier qu'on est bien EN RETARD (pas en avance)
  BASE="$(git merge-base HEAD origin/main 2>/dev/null)" || exit 0
  [ "$BASE" = "$LOCAL" ] || exit 0  # divergé ou en avance → ne rien faire

  # Compter les nouveaux commits
  N="$(git rev-list HEAD..origin/main --count 2>/dev/null)" || N="?"

  # Pull avec rebase
  git pull --rebase --autostash --quiet 2>/dev/null || exit 0

  echo "Config mise à jour depuis GitHub (${N} nouveau$([ "$N" = "1" ] && echo '' || echo 'x') commit$([ "$N" = "1" ] && echo '' || echo 's'))" >&2

) &
BGPID=$!

# Watchdog timeout
for i in $(seq 1 $TIMEOUT); do
  kill -0 "$BGPID" 2>/dev/null || { wait "$BGPID" 2>/dev/null; exit 0; }
  sleep 1
done

kill "$BGPID" 2>/dev/null || true
exit 0
