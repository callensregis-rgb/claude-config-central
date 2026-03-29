#!/usr/bin/env bash
# install.sh — Crée les symlinks ~/.claude/* → ~/claude-config-central/*
# Usage : bash ~/claude-config-central/install.sh
#
# Garde-fous :
#   - Teste la capacité à créer des symlinks AVANT toute modification
#   - Ne supprime jamais un fichier avant d'avoir confirmé que le symlink peut être créé
#   - Détecte les symlinks pointant vers un autre dépôt et les ignore
#   - Fallback copie directe si symlinks indisponibles (Windows sans Developer Mode)

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
CONFLICTS_DIR="$REPO_DIR/_conflicts"
CREATED=0
CONFLICTS=0
WARNED=0
SYMLINKS_AVAILABLE=false
FALLBACK_COPY=false

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

to_win_path() {
  if $IS_WINDOWS; then
    # Convertit /c/Users/... → C:\Users\...
    echo "$1" | sed 's|^/\([a-zA-Z]\)/|\1:\\|; s|/|\\|g'
  else
    echo "$1"
  fi
}

# Tente de créer un symlink de test — ne touche rien de réel
probe_symlink() {
  local tmp_link
  tmp_link="$(mktemp -u ~/.claude/.symtest_XXXXXX)"
  local tmp_target
  tmp_target="$(mktemp)"

  local ok=false

  if $IS_WINDOWS; then
    local wl wt
    wl="$(to_win_path "$tmp_link")"
    wt="$(to_win_path "$tmp_target")"
    powershell.exe -NoProfile -Command \
      "New-Item -ItemType SymbolicLink -Path '$wl' -Target '$wt' -Force | Out-Null" 2>/dev/null \
    && ok=true
    # Nettoyer
    powershell.exe -NoProfile -Command "Remove-Item -Force '$wl' -ErrorAction SilentlyContinue" 2>/dev/null || true
  else
    ln -sf "$tmp_target" "$tmp_link" 2>/dev/null && ok=true
    rm -f "$tmp_link"
  fi

  rm -f "$tmp_target"
  $ok
}

# Crée un symlink (ne doit être appelé qu'après probe_symlink réussi)
make_symlink() {
  local link="$1"
  local target="$2"
  local is_dir="${3:-false}"

  if $IS_WINDOWS; then
    local win_link win_target
    win_link="$(to_win_path "$link")"
    win_target="$(to_win_path "$target")"
    if $is_dir; then
      powershell.exe -NoProfile -Command \
        "New-Item -ItemType SymbolicLink -Path '$win_link' -Target '$win_target' -Force | Out-Null" 2>/dev/null
    else
      powershell.exe -NoProfile -Command \
        "New-Item -ItemType SymbolicLink -Path '$win_link' -Target '$win_target' -Force | Out-Null" 2>/dev/null
    fi
  else
    ln -sf "$target" "$link"
  fi

  # Vérifier que le symlink existe vraiment
  [ -L "$link" ] || [ -e "$link" ]
}

# Copie directe (fallback si symlinks indisponibles)
make_copy() {
  local src="$1"
  local dst="$2"
  local is_dir="${3:-false}"
  if $is_dir; then
    cp -r "$src/." "$dst/" 2>/dev/null || cp -r "$src" "$dst"
  else
    cp "$src" "$dst"
  fi
}

# Normalise un chemin pour comparaison
normalize_path() {
  realpath "$1" 2>/dev/null || echo "$1"
}

# Vérifie si le lien pointe vers ce dépôt
points_to_this_repo() {
  local link="$1"
  local target="$2"
  [ -L "$link" ] || return 1
  local actual resolved_actual resolved_target
  actual="$(readlink "$link" 2>/dev/null || true)"
  resolved_actual="$(normalize_path "$actual")"
  resolved_target="$(normalize_path "$target")"
  [ "$resolved_actual" = "$resolved_target" ]
}

# Vérifie si le lien pointe vers un AUTRE chemin (pas ce dépôt)
points_elsewhere() {
  local link="$1"
  local target="$2"
  [ -L "$link" ] || return 1
  ! points_to_this_repo "$link" "$target"
}

content_identical() {
  local a="$1" b="$2"
  if [ -f "$a" ] && [ -f "$b" ]; then
    cmp -s "$a" "$b"
  elif [ -d "$a" ] && [ -d "$b" ]; then
    local ha hb
    ha="$(find "$a" -type f -exec md5sum {} \; 2>/dev/null | sort | md5sum)"
    hb="$(find "$b" -type f -exec md5sum {} \; 2>/dev/null | sort | md5sum)"
    [ "$ha" = "$hb" ]
  else
    return 1
  fi
}

# ── Test de disponibilité des symlinks (une seule fois, avant tout) ───────────
echo "==> Test de disponibilité des symlinks..."
if probe_symlink; then
  SYMLINKS_AVAILABLE=true
  echo "    Symlinks : disponibles"
else
  SYMLINKS_AVAILABLE=false
  echo ""
  echo "  [WARN] Les symlinks ne sont pas disponibles sur ce système."
  if $IS_WINDOWS; then
    echo "         Windows requiert le Mode Développeur ou des droits Administrateur."
    echo "         Paramètre > Mise à jour > Pour les développeurs > Mode développeur : ON"
  fi
  echo ""
  echo "  Fallback : copie directe des fichiers (pas de synchronisation automatique)"
  echo -n "  Continuer avec la copie ? [o/N] "
  read -r answer
  if [[ "${answer,,}" == "o" || "${answer,,}" == "oui" || "${answer,,}" == "y" ]]; then
    FALLBACK_COPY=true
  else
    echo "  Installation annulée."
    exit 1
  fi
fi
echo ""

# ── Traitement d'une entrée ───────────────────────────────────────────────────
process_entry() {
  local name="$1"
  local is_dir="$2"
  local link="$CLAUDE_DIR/$name"
  local target="$REPO_DIR/$name"

  # La cible doit exister dans le dépôt
  if $is_dir && [ ! -d "$target" ]; then
    echo "  [SKIP] $name — absent du dépôt"
    return
  fi
  if ! $is_dir && [ ! -f "$target" ]; then
    echo "  [SKIP] $name — absent du dépôt"
    return
  fi

  # ── Garde-fou 2 : symlink existant pointant vers UN AUTRE dépôt ──────────
  if points_elsewhere "$link" "$target"; then
    local other
    other="$(readlink "$link" 2>/dev/null || echo '?')"
    echo "  [WARN] $name — déjà géré par : $other  (ignoré)"
    WARNED=$((WARNED + 1))
    return
  fi

  # Symlink correct déjà en place
  if points_to_this_repo "$link" "$target"; then
    echo "  [OK]   $name — symlink déjà correct"
    return
  fi

  # ── Mode fallback copie ───────────────────────────────────────────────────
  if $FALLBACK_COPY; then
    if [ -e "$link" ] && ! content_identical "$link" "$target"; then
      local backup="$CONFLICTS_DIR/${name//\//_}_BACKUP"
      cp -r "$link" "$backup"
      echo "  [CONF] $name — backup → _conflicts/${name//\//_}_BACKUP"
      CONFLICTS=$((CONFLICTS + 1))
    fi
    if $is_dir; then
      mkdir -p "$link"
    fi
    make_copy "$target" "$link" "$is_dir"
    echo "  [COPY] $name — copié (mode fallback)"
    CREATED=$((CREATED + 1))
    return
  fi

  # ── Mode symlink ──────────────────────────────────────────────────────────

  # Garde-fou 1a : tester la création dans un fichier temporaire
  # (déjà validé par probe_symlink global, mais on vérifie le résultat réel après création)

  if [ ! -e "$link" ] && ! [ -L "$link" ]; then
    # Absent → créer directement
    if make_symlink "$link" "$target" "$is_dir"; then
      echo "  [LINK] $name — symlink créé"
      CREATED=$((CREATED + 1))
    else
      echo "  [WARN] $name — échec création symlink, original intact"
      WARNED=$((WARNED + 1))
    fi
    return
  fi

  # Présent (fichier/dossier réel) → backup d'abord, symlink ensuite
  local backup="$CONFLICTS_DIR/${name//\//_}_BACKUP"

  # Garde-fou 1b : sauvegarder AVANT toute suppression
  cp -r "$link" "$backup" 2>/dev/null || { echo "  [WARN] $name — impossible de sauvegarder, opération annulée"; WARNED=$((WARNED + 1)); return; }

  # Tenter le symlink dans un chemin temporaire pour valider les droits
  local tmp_test="$CLAUDE_DIR/.symtest_$$"
  if ! make_symlink "$tmp_test" "$target" "$is_dir" 2>/dev/null; then
    # Droits insuffisants — restaurer et abandonner
    rm -rf "$backup"
    echo "  [WARN] $name — droits symlink insuffisants, original intact"
    WARNED=$((WARNED + 1))
    return
  fi
  # Test réussi — nettoyer le test
  rm -rf "$tmp_test" 2>/dev/null || true

  # Maintenant on peut supprimer et créer le vrai symlink en sécurité
  rm -rf "$link"
  if make_symlink "$link" "$target" "$is_dir"; then
    if content_identical "$backup" "$target" 2>/dev/null; then
      rm -rf "$backup"
      echo "  [LINK] $name — fichier identique, remplacé par symlink"
    else
      echo "  [CONF] $name — conflit, backup → _conflicts/${name//\//_}_BACKUP"
      CONFLICTS=$((CONFLICTS + 1))
    fi
    CREATED=$((CREATED + 1))
  else
    # Échec inattendu : restaurer depuis le backup
    cp -r "$backup" "$link"
    rm -rf "$backup"
    echo "  [WARN] $name — échec symlink, original restauré depuis backup"
    WARNED=$((WARNED + 1))
  fi
}

# ── Traitement ────────────────────────────────────────────────────────────────
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
if $SYMLINKS_AVAILABLE && ! $FALLBACK_COPY; then
  echo "  Mode          : symlinks"
else
  echo "  Mode          : copie directe (fallback)"
fi
echo "  Symlinks/copies créés : $CREATED"
echo "  Conflits backup       : $CONFLICTS"
echo "  Avertissements        : $WARNED"
echo "═══════════════════════════════════════"
[ "$CONFLICTS" -gt 0 ] && echo "  Vérifie _conflicts/ pour les fichiers sauvegardés."
[ "$WARNED"    -gt 0 ] && echo "  Certaines entrées n'ont pas pu être traitées (voir [WARN] ci-dessus)."
echo ""
echo "Relance Claude Code pour appliquer les changements."
