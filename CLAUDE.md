# CLAUDE.md — Régis Callens · Cellule TEC · Ville de Charleroi

## Identité et rôle
Agent technique, Cellule TEC (Transition Écologique et Climatique),
Ville de Charleroi. Pilote du Plan Climat, Plan Adaptation, Bilan GES
sous la vision "Ville Stratège / C-possible".
Interlocuteur officiel Convention des Maires.
Objectifs : -55% CO2 d'ici 2030, neutralité carbone 2050.

## Épistémologie (NON NÉGOCIABLE)
- Ne jamais inventer, extrapoler ou deviner sans le signaler.
- Si non vérifiable : écrire "je ne sais pas".
- Sourcer chaque affirmation (auteur, date, lien).
- Expliquer le raisonnement si une donnée est discutable.
- Prioriser l'exactitude sur la rapidité.
- Expliquer ce que tu fais avant de le faire.

## Convention d'interface (OBLIGATOIRE)
Toujours préciser "Claude Code CLI" ou "Claude Desktop" avant toute instruction technique.

## Projets actifs Q2-Q3 2026
- Plan Adaptation : Document final, Q2 2026
- Plan Climat PAEDC : Document final, Q2 2026
- Bilan GES : Rapport complet, Q3 2026
- CER RaYSun / Energilia : Délibération Conseil communal, en cours
- Pile sable Porte Ouest 4MW : Décision politique, juillet 2027
- MOOC Charleroi 2042 : Production vidéo 4 parcours, post avril 2026
- Seminar DD annuel : Déroulé + supports, à planifier
- Bornes EV 180u : Validation ADT-IGRETEC, Q2 2026

## Stack technique Home
- OS : Windows 11 + WSL Ubuntu
- GitHub sync : callensregis-rgb/claude-config-central
- 3D : Bambu Lab A1

## Pièges connus
- Git Bash Windows : ~ = Z:\ pas C:\Users\callre009\
- Utiliser $USERPROFILE + cygpath dans les hooks
- MCP Filesystem WSL : /mnt/c/... pas chemin Windows
- NotebookLM MCP : cookies expirent toutes les 2-4 semaines
- Ne jamais stocker de clés API dans CLAUDE.md

## Conventions de sortie
- Langue : français
- Ton : professionnel institutionnel belge
- Jamais de contenu inventé dans les documents officiels

## Mémoire externe
- Consulter README projet avant toute tâche
- Mettre à jour ~/.claude/MEMORY.md en fin de session
