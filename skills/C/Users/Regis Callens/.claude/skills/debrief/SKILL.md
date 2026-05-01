---
name: debrief
description: Synthèse de fin de session. Résume les décisions, met à jour la mémoire et le suivi de tâches. Utiliser en fin de conversation pour ne rien perdre entre sessions.
---

# Debrief — Synthèse de fin de session

Compresse et sauvegarde les acquis d'une conversation pour enrichir la mémoire persistante.

## Quand utiliser

Trigger quand l'utilisateur :
- Dit "debrief", "résumé", "synthèse", "sauvegarde la session"
- Termine une session de travail
- Demande de "ne rien oublier"

## Workflow

### Étape 1 : Analyser la session
Parcourir la conversation et extraire :
1. **Décisions prises** — choix techniques, architecturaux, de design (pas les actions triviales)
2. **Nouvelles connaissances** — informations découvertes, patterns, préférences utilisateur
3. **Tâches créées/avancées/terminées** — tout changement de statut
4. **Problèmes rencontrés** — bugs, blocages, workarounds trouvés
5. **Éléments surprenants ou non-évidents** — ce qui ne se déduit pas du code

### Étape 2 : Mettre à jour TASKS.md
Lire le fichier `TASKS.md` à la racine du projet et :
- Cocher les tâches terminées `- [x]`
- Ajouter les nouvelles tâches identifiées `- [ ]`
- Déplacer les tâches terminées dans la section `## Terminé`
- Ajouter la date du jour entre parenthèses `(YYYY-MM-DD)`

### Étape 3 : Mettre à jour la mémoire
Décider si les nouvelles connaissances méritent d'être sauvegardées :
- **Oui** si : nouvelle préférence utilisateur, nouveau projet, config technique, feedback important
- **Non** si : action ponctuelle, information déjà dans le code, détail éphémère

Si oui :
- Mettre à jour le fichier mémoire existant le plus pertinent
- Ou créer un nouveau fichier dans `~/.claude/projects/.../memory/` et l'indexer dans `MEMORY.md`

### Étape 4 : Afficher le résumé
Présenter à l'utilisateur un résumé compact :

```
## 📋 Debrief session [DATE]

### Décisions
- ...

### Mémoire mise à jour
- [fichier] : ce qui a changé

### Tâches
- ✅ Terminées : ...
- 🆕 Nouvelles : ...
- ⏳ En cours : ...

### À retenir pour la prochaine session
- ...
```

## Règles
- Ne sauvegarder QUE ce qui est utile entre sessions (pas de bruit)
- Préférer la mise à jour d'un fichier existant à la création d'un nouveau
- Maximum 5-10 lignes par fichier mémoire mis à jour
- Toujours montrer au user ce qui a été sauvegardé (transparence)
- Si rien de notable dans la session, le dire honnêtement plutôt que de forcer une sauvegarde
