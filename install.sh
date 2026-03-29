#!/usr/bin/env bash
# install.sh — Crée les symlinks ~/.claude/* → ~/claude-config-central/*
# Usage : bash ~/claude-config-central/install.sh
#
# Fonctionne sur Linux/macOS (bash ln) et Windows (Git Bash + PowerShell mklink)

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
CONFLICTS_DIR="$REPO_DIR/_conflicts"
CREATED=0
CONFLICTS=0

# ── Détection OS ──────────────────────────────────────────────────────────────
IS_WINDOWS=false
if [[ "${OSTYPE:-}" == "msys" || "${OSTYPE:-}" == "cygwin" || "${OS:-}" == "Windows_NT" ]]; then
  IS_WINDOWS=true
fi

echo "==> OS détecté : $(uname -s 2>/dev/null || echo Windows)"
echo "==> Source     : $REPO_DIR"
echo "==> Cible      : $CLAUDE_DIR"
echo ""

mkdir -p "$CONFLICTS_DIR"

# ── Helpers ───────────────────────────────────────────────────────────────────

# Convertit un chemin POSIX en chemin Windows natif (C:\...) pour PowerShell
to_win_path() {
  if $IS_WINDOWS; then
    echo "$1" | sed 's|^/\([a-zA-Z]\)/|\1:\\|; s|/|\\|g'
  else
    echo "$1"
  fi
}

# Crée un symlink (fichier ou dossier)
make_symlink() {
  local link="$1"   # chemin du lien à créer
  local target="$2" # chemin vers lequel il pointe
  local is_dir="${3:-false}"

  if $IS_WINDOWS; then
    local win_link
    local win_target
    win_link="$(to_win_path "$link")"
    win_target="$(to_win_path "$target")"
    if $is_dir; then
      powershell.exe -NoProfile -Command \
        "New-Item -ItemType SymbolicLink -Path '$win_link' -Target '$win_target' -Force | Out-Null" 2>/dev/null \
      || cmd.exe /c "mklink /D \"$win_link\" \"$win_target\"" > /dev/null 2>&1
    else
      powershell.exe -NoProfile -Command \
        "New-Item -ItemType SymbolicLink -Path '$win_link' -Target '$win_target' -Force | Out-Null" 2>/dev/null \
      || cmd.exe /c "mklink \"$win_link\" \"$win_target\"" > /dev/null 2>&1
    fi
  else
    ln -sf "$target" "$link"
  fi
}

# Vérifie si un chemin est déjà un symlink pointant vers la bonne cible
is_correct_symlink() {
  local link="$1"
  local target="$2"
  if [ -L "$link" ]; then
    local actual
    actual="$(readlink "$link" 2>/dev/null || true)"
    # Normaliser les chemins pour la comparaison
    [ "$actual" = "$target" ] && return 0
    # Comparer les chemins résolus
    local resolved_actual resolved_target
    resolved_actual="$(realpath "$actual" 2>/dev/null || echo "$actual")"
    resolved_target="$(realpath "$target" 2>/dev/null || echo "$target")"
    [ "$resolved_actual" = "$resolved_target" ] && return 0
  fi
  return 1
}

# Contenu identique (fichier vs fichier, ou répertoire vs répertoire)
content_identical() {
  local a="$1"
  local b="$2"
  if [ -f "$a" ] && [ -f "$b" ]; then
    cmp -s "$a" "$b"
  elif [ -d "$a" ] && [ -d "$b" ]; then
    # Comparaison récursive légère via checksums
    local ha hb
    ha="$(find "$a" -type f -exec md5sum {} \; 2>/dev/null | sort | md5sum)"
    hb="$(find "$b" -type f -exec md5sum {} \; 2>/dev/null | sort | md5sum)"
    [ "$ha" = "$hb" ]
  else
    return 1
  fi
}

# ── Fonction principale de traitement de chaque entrée ────────────────────────
process_entry() {
  local name="$1"       # ex: CLAUDE.md, settings.json, skills/
  local is_dir="$2"     # true | false
  local link="$CLAUDE_DIR/$name"
  local target="$REPO_DIR/$name"
  local label="$name"

  # La cible repo doit exister
  if $is_dir && [ ! -d "$target" ]; then
    echo "  [SKIP] $label — absent du dépôt"
    return
  fi
  if ! $is_dir && [ ! -f "$target" ]; then
    echo "  [SKIP] $label — absent du dépôt"
    return
  fi

  # Cas 1 : symlink correct déjà en place
  if is_correct_symlink "$link" "$target"; then
    echo "  [OK]   $label — symlink déjà correct"
    return
  fi

  # Cas 2 : symlink cassé ou pointant ailleurs → recréer
  if [ -L "$link" ]; then
    rm -f "$link"
    make_symlink "$link" "$target" "$is_dir"
    echo "  [LINK] $label — symlink mis à jour"
    CREATED=$((CREATED + 1))
    return
  fi

  # Cas 3 : absent → créer
  if [ ! -e "$link" ]; then
    make_symlink "$link" "$target" "$is_dir"
    echo "  [LINK] $label — symlink créé"
    CREATED=$((CREATED + 1))
    return
  fi

  # Cas 4 : fichier/dossier réel présent
  if content_identical "$link" "$target"; then
    # Identique → remplacer par symlink
    rm -rf "$link"
    make_symlink "$link" "$target" "$is_dir"
    echo "  [LINK] $label — fichier identique, remplacé par symlink"
    CREATED=$((CREATED + 1))
  else
    # Différent → backup dans _conflicts/ puis symlink
    local backup="$CONFLICTS_DIR/${name//\//_}_BACKUP"
    cp -r "$link" "$backup"
    rm -rf "$link"
    make_symlink "$link" "$target" "$is_dir"
    echo "  [CONF] $label — conflit détecté, backup → _conflicts/${name//\//_}_BACKUP"
    CONFLICTS=$((CONFLICTS + 1))
    CREATED=$((CREATED + 1))
  fi
}

# ── Traitement des entrées ────────────────────────────────────────────────────
process_entry "CLAUDE.md"      false
process_entry "settings.json"  false
process_entry "skills"         true
process_entry "agents"         true
process_entry "commands"       true
process_entry "rules"          true

# ── Rapport final ─────────────────────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════"
echo "  Rapport d'installation"
echo "  Symlinks créés  : $CREATED"
echo "  Conflits backup : $CONFLICTS"
echo "═══════════════════════════════════════"
if [ "$CONFLICTS" -gt 0 ]; then
  echo "  Vérifie _conflicts/ pour les fichiers sauvegardés."
fi
echo ""
echo "Relance Claude Code pour appliquer les changements."
