---
name: mooc-builder
description: >
  Use this skill whenever the user wants to design, structure, or produce content
  for an online course or MOOC. Triggers include: any mention of "MOOC", "cours en ligne",
  "module pédagogique", "session de formation", "parcours apprenant", "quiz", "évaluation",
  "objectifs pédagogiques", "Bloom", "plan de cours", or requests to build course content
  for any audience (citizens, public servants, elected officials, etc.).
  Also trigger when the user wants to export course content to Word/docx, generate
  slide outlines, or draft learning assessments. Use proactively whenever a user mentions
  building structured educational content, even if they don't use the word "MOOC" explicitly.
---

# MOOC Builder Skill

Ce skill guide Claude dans la construction complète d'un MOOC structuré, depuis
l'architecture pédagogique jusqu'aux livrables exportables (Word, quiz, plans de sessions).

Il est calé sur la **taxonomie de Bloom** (6 niveaux) et supporte plusieurs **parcours apprenants**
en parallèle (ex. : tronc commun + parcours citoyen / agent / élu).

---

## Workflow général

Suivre ces étapes dans l'ordre, sauf si l'utilisateur indique où il en est :

1. **Cadrage** — Définir le sujet, le public cible, les parcours, et le nombre de sessions
2. **Architecture** — Construire le plan du MOOC (modules, sessions, séquençage)
3. **Objectifs pédagogiques** — Formuler les OA selon Bloom pour chaque session
4. **Contenu** — Rédiger le texte des sessions (narration, explications, exemples)
5. **Évaluations** — Produire les quiz et exercices associés à chaque session
6. **Export** — Générer les livrables Word/docx via le skill `docx`

Pour chaque livrable de type fichier Word, **toujours lire `/mnt/skills/public/docx/SKILL.md`
avant de produire le fichier**.

---

## Étape 1 — Cadrage

Collecter les informations suivantes (poser les questions si non fournies) :

| Information | Exemples |
|---|---|
| Sujet du MOOC | Climat urbain, transition énergétique, gestion communale |
| Titre provisoire | "Charleroi 2042", "Transition énergétique en pratique" |
| Public(s) cible(s) | Citoyens, agents communaux, élus, grand public |
| Parcours | Tronc commun + parcours spécialisés (1 à 4) |
| Nombre de modules | Typiquement 3 à 6 modules |
| Nombre de sessions/module | Typiquement 2 à 5 sessions |
| Durée cible par session | 10–20 min de lecture/écoute |
| Langue | Français par défaut |
| Contraintes spécifiques | Format plateforme, accessibilité, partenaires |

---

## Étape 2 — Architecture pédagogique

Produire un **tableau de structure** avec colonnes :

- Numéro de session (ex. 0.1, 0.2, 1.1…)
- Titre de la session
- Parcours concerné(s) (tronc commun / citoyen / agent / élu)
- Niveau Bloom cible (voir ci-dessous)
- Résumé en 1 phrase

### Niveaux Bloom de référence

| Niveau | Verbe d'action | Usage typique en MOOC |
|---|---|---|
| 1 – Se souvenir | Identifier, nommer, lister | Sessions introductives |
| 2 – Comprendre | Expliquer, décrire, résumer | Fondamentaux |
| 3 – Appliquer | Utiliser, calculer, démontrer | Études de cas |
| 4 – Analyser | Comparer, distinguer, examiner | Sessions avancées |
| 5 – Évaluer | Juger, critiquer, défendre | Sessions de synthèse |
| 6 – Créer | Concevoir, produire, proposer | Projets, plans d'action |

---

## Étape 3 — Objectifs pédagogiques

Pour **chaque session**, formuler :

- 2 à 4 **objectifs pédagogiques** rédigés selon la formule :
  > "À l'issue de cette session, l'apprenant sera capable de **[verbe Bloom]** [contenu] **[contexte/condition]**."

- Le **niveau Bloom** associé à chaque objectif
- Le **critère d'évaluation** (comment savoir que l'objectif est atteint)

---

## Étape 4 — Contenu de session

Structure type pour chaque session :

```
## [Numéro] — [Titre de la session]
**Parcours :** [liste des parcours]
**Durée estimée :** [X min]
**Niveau Bloom :** [niveau]

### Accroche
[Question ou situation qui capte l'attention — 2-3 phrases]

### Développement
[Corps du contenu — structuré en sous-parties, avec exemples concrets,
données locales si disponibles, analogies accessibles]

### Synthèse
[Résumé des points clés — 3 à 5 bullet points]

### Pour aller plus loin
[Ressources optionnelles : liens, lectures, vidéos]
```

**Règles de rédaction :**
- Niveau de langue : accessible au grand public (pas de jargon non expliqué)
- Longueur : 600–1200 mots par session (tronc commun) ; adapter selon parcours
- Ancrage local : privilegier des exemples tirés du contexte du MOOC si connu
- Progressivité : chaque session suppose acquis le contenu des sessions précédentes

---

## Étape 5 — Évaluations / Quiz

Pour chaque session, produire **3 à 5 questions** selon ce format :

```
**Q[n] — [Type]**
[Énoncé de la question]

A) [Option]
B) [Option]
C) [Option]
D) [Option]

✅ Bonne réponse : [lettre]
💡 Explication : [pourquoi c'est la bonne réponse, en 1-2 phrases]
```

**Types de questions supportés :**
- QCM à choix unique
- QCM à choix multiples (indiquer "plusieurs réponses possibles")
- Vrai/Faux avec justification
- Question ouverte courte (pour export Word uniquement)

**Calibrage Bloom :**
- Sessions niveau 1-2 → questions de mémorisation/compréhension
- Sessions niveau 3-4 → questions d'application et d'analyse
- Sessions niveau 5-6 → questions de jugement ou mini-cas

---

## Étape 6 — Export Word/docx

Avant tout export, **lire `/mnt/skills/public/docx/SKILL.md`** pour respecter
les conventions de mise en forme.

### Livrables types à produire

| Livrable | Contenu |
|---|---|
| `plan_mooc_[titre].docx` | Architecture complète (tableau de structure + OA) |
| `session_[num]_[titre].docx` | Contenu d'une session + quiz associé |
| `quiz_complet_[titre].docx` | Toutes les questions regroupées par session |
| `tableau_de_bord_[titre].xlsx` | Suivi avancement (si demandé — utiliser skill `xlsx`) |

---

## Référence rapide — Séquençage conseillé

```
Cadrage → Architecture → OA session par session
                              ↓
                        Contenu session
                              ↓
                          Quiz session
                              ↓
                      Export docx session
                              ↓
                    Session suivante...
```

Produire les sessions **une par une** sauf si l'utilisateur demande
une vue d'ensemble d'abord.

---

## Notes et conventions

- **Numérotation des sessions** : Module.Session (ex. 0.1 = Module 0 / Session 1)
- **Module 0** = module introductif (contexte, enjeux, présentation du MOOC)
- **Tronc commun** = sessions suivies par tous les parcours
- Si le contexte du MOOC est Charleroi/Wallonie, utiliser les données locales
  disponibles dans la conversation (Plan Climat, GES, vulnérabilités, etc.)
- Ne jamais inventer de données factuelles : signaler clairement si une donnée
  est à vérifier ou à compléter par l'utilisateur
