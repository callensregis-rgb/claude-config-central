---
description: Charge le contexte complet d'un projet depuis le vault Obsidian
---
Charge et résume le contexte complet du projet : $ARGUMENTS

1. Cherche dans le vault Obsidian via MCP Filesystem le dossier correspondant à $ARGUMENTS
2. Charge ~/.claude/MEMORY.md pour les décisions récentes
3. Produis un résumé : objectif, état actuel, dernières décisions, prochaines étapes, blocages
4. Confirme : "Contexte $ARGUMENTS chargé. Prêt."
