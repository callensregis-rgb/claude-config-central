---
name: bd-atelier
description: >
  Full-pipeline comic book / graphic novel creation skill. Use whenever the user mentions:
  "BD", "bande dessinée", "comic", "manga", "webtoon", "graphic novel", "planche", "case",
  "bulle", "scénario de BD", "personnage cohérent", "storyboard", "mise en page BD",
  "script BD", "dialogue de BD", "style franco-belge", "ligne claire", "prompt pour BD",
  "character consistency", or any request to create, write, draw, or produce a comic.
  Also trigger when the user asks to generate image prompts for sequential art, build a
  character bible, or assemble comic panels — even if they don't use the word "BD" or "comic".
  Covers the complete pipeline: pre-production → script → visual prompts → assembly → export.
---

# BD Atelier — Full Comic Pipeline Skill

This skill guides Claude through the complete production of a comic book or graphic novel,
from concept to final export. It covers both **textual AI** (script, dialogue, structure)
and **generative visual AI** (image prompts, character consistency, style control).

---

## Step 0 — Detect where the user is in the pipeline

If the user has not specified a stage, ask one focused question:

> "Where are you in your comic project? (A) Starting from scratch, (B) Script/story phase,
> (C) Visual prompt generation, (D) Assembly/layout, or (E) Post-production/export?"

If the user says "from scratch" or is unclear → run the full pipeline from Step 1.
If they name a specific stage → jump directly to that stage, loading only the relevant reference files.

---

## Pipeline Overview

```
[Step 1] Pre-production     → character bible, format, audience, style choice
[Step 2] Script & Story     → acts, pages, panels, dialogue, narrative codes
[Step 3] Visual Prompts     → prompt-to-image formulas, style, consistency
[Step 4] Assembly & Layout  → panel grids, transitions, lettering, bubbles
[Step 5] Post-production    → retouching, export formats, publication
```

Read reference files **on demand** — only load what the current step requires.
Never load all references at once.

---

## Step 1 — Pre-Production

**Reference file to load:** `references/00_bible_graphique.md`

Collect the following information (ask if not provided):

| Parameter | Examples |
|---|---|
| Format | Album franco-belge (46p), One-shot, Series, Webtoon vertical, Zine |
| Audience | Children, YA, Adult, General public |
| Genre | Adventure, Thriller, Humor, Documentary, Fantasy, Slice of life |
| Art style | Ligne claire, Manga, Realistic, Watercolor, Graphic novel (US), Retro |
| Number of characters | How many recurring? How many secondary? |
| Recurring settings | How many? Interior/exterior? |
| Publication target | Print (CMYK 300dpi), Digital (RGB 72–150dpi), Webtoon platform, Instagram |

Once collected, produce the **Graphic Bible** using the template in
`assets/template_fiche_personnage.md` for each main character, and
`assets/template_planche_script.md` for the script format.

The Graphic Bible is the single source of truth for all subsequent prompts.
**Never generate visual prompts without a completed character description.**

---

## Step 2 — Script & Story

**Reference file to load:** `references/01_scenario_et_script.md`

### 2a. Story Structure
Break the story into:
- **Acts** (typically 3): Setup / Confrontation / Resolution
- **Pages** per act (use the page count from Step 1 format)
- **Panels per page** (typically 4–6 for album, 3–5 vertical for webtoon)

### 2b. Script Format
Use the standardized format from `assets/template_planche_script.md`.

Each panel description must include:
1. **Shot type** (close-up, medium shot, wide shot, bird's eye, worm's eye)
2. **Character action** (physical, precise — no internal emotions without visual expression)
3. **Setting** (lighting, atmosphere, key props)
4. **Dialogue / caption** (bubble type: speech, thought, whisper, shout, caption box)

### 2c. Comic-Specific Codes
See `references/01_scenario_et_script.md` for full list.
Key codes to apply by default:
- Ellipsis between panels — show only the start and end of an action, not the middle
- Gaze direction — characters look toward the next panel (drives reading flow)
- Visual symbols — stars (pain), spirals (dizziness), sweat drops (embarrassment)
- Sound effects (SFX) — integrated into the panel visually, not as dialogue

### 2d. Continuity Tracking
Maintain a **continuity log** in conversation:
- Character status per scene (clothing, injuries, location)
- Recurring props and their last known position
- Timeline of events (day/night, weather, time elapsed)

---

## Step 3 — Visual Prompts

**Reference files to load:** `references/02_prompts_visuels.md` + `references/03_coherence_personnage.md`

### 3a. Prompt Structure
Every image prompt follows this 6-element formula:

```
[SHOT TYPE] + [SUBJECT + ACTION] + [SETTING + ATMOSPHERE] +
[LIGHTING] + [ART STYLE] + [TECHNICAL PARAMS]
```

Example:
```
Medium shot, young woman in red jacket running through rain-slicked alley at dusk,
dramatic side lighting, ligne claire comic art style, flat colors, bold black outlines,
cinematic composition, 16:9 aspect ratio
```

### 3b. Style Lock
Once a style is chosen, create a **style anchor** — a fixed string appended to every prompt:

| Style | Style Anchor String |
|---|---|
| Ligne claire | `ligne claire comic art, flat colors, bold clean outlines, no crosshatching, Hergé-inspired` |
| Manga | `manga illustration, screentone shading, expressive linework, Japanese comic style` |
| Franco-belge color | `Franco-Belgian comic style, rich flat colors, Dupuis/Lombard aesthetic, detailed backgrounds` |
| US Graphic Novel | `graphic novel illustration, high contrast inks, dynamic composition, Mignola-inspired` |
| Watercolor BD | `watercolor comic art, soft color washes, visible brush texture, painterly backgrounds` |

### 3c. Character Consistency
See `references/03_coherence_personnage.md` for full techniques.
Core rules:
- Write a **character prompt seed** (150–200 words) describing appearance once, precisely
- Reuse this seed verbatim in every prompt featuring the character
- Never vary clothing, hair, or physical features unless the script calls for it
- For tools supporting seeds/references: use image reference on first generation, then seed lock

### 3d. Batch Generation Workflow
1. Generate 3–4 variations per panel — do not seek perfection on first try
2. Select the best variant
3. Use inpainting/outpainting only for specific corrections (hands, perspective errors)
4. Archive accepted panels with consistent naming: `p01_c03_v2.png` (page_panel_variant)

### 3e. Commercial Rights
See `references/05_outils_et_workflow.md` for per-tool licensing.
**Never generate prompts citing living artists by name** — describe style characteristics instead.

---

## Step 4 — Assembly & Layout

**Reference files to load:** `references/04_mise_en_page.md`

### 4a. Panel Grid
Choose a grid from `assets/grilles_cases/` or describe a custom layout.
Standard grids available:
- `grille_standard_6cases.svg` — 2×3, classic album layout
- `grille_cinematique_3cases.svg` — cinematic strips, dramatic pacing
- `grille_webtoon_vertical.svg` — single-column vertical scroll

### 4b. Panel Transitions (Scott McCloud taxonomy)
Identify the transition type for each panel pair:
1. **Moment-to-moment** — very slow pacing, detail focus
2. **Action-to-action** — standard narrative, single subject
3. **Subject-to-subject** — same scene, different subject
4. **Scene-to-scene** — time/space jump
5. **Aspect-to-aspect** — mood/atmosphere, no chronological progression
6. **Non-sequitur** — deliberate break (humor, experimental)

### 4c. Lettering & Bubbles
- **Speech bubble**: oval, tail pointing to speaker's mouth
- **Thought bubble**: cloud-shaped, small circles as tail
- **Whisper**: dashed outline
- **Shout**: jagged/spiked outline, CAPS text
- **Caption box**: rectangular, narrator voice, typically top of panel
- **SFX**: integrated into artwork, style-matched font

Tools: Clip Studio Paint (recommended), Canva Pro (accessible), Adobe Illustrator.

### 4d. Human Review Checkpoints
Before finalizing each page, verify:
- [ ] Character appearance consistent with bible
- [ ] Reading flow (gaze direction, panel sequence)
- [ ] Text fits in bubbles (no overflow)
- [ ] Style anchor applied consistently
- [ ] Continuity log updated

---

## Step 5 — Post-Production & Export

**Reference file to load:** `references/05_outils_et_workflow.md`

### 5a. Retouching Priority
1. Hands and fingers (most common AI error)
2. Text and signage in backgrounds
3. Perspective inconsistencies
4. Character face deviations from bible

Tools: Photoshop Generative Fill, Krita (free), Clip Studio Paint.

### 5b. Export Formats

| Destination | Format | Resolution | Color mode |
|---|---|---|---|
| Print (offset) | PDF/X-1a | 300 dpi + 3mm bleed | CMYK |
| Print (home/digital print) | PDF | 150–300 dpi | RGB or CMYK |
| Digital reading (CBZ) | CBZ (ZIP of JPGs) | 150 dpi | RGB |
| Webtoon platform | JPG strips | 800px wide, max 3MB/strip | RGB |
| Instagram carousel | JPG | 1080×1080 or 1080×1350 | RGB sRGB |
| PDF portfolio | PDF | 150 dpi | RGB |

### 5c. Accessibility
- Add alt-text to all images if publishing digitally
- Ensure bubble text is minimum 8pt (print) or equivalent pixel size
- Maintain 4.5:1 contrast ratio between bubble text and background

---

## Orchestration — Where Humans Must Take the Lead

The AI handles: script generation, prompt writing, structural decisions, continuity tracking.
The human must decide:
- Artistic direction (final style selection, mood approval)
- Character design approval (from generated variants)
- Panel selection from generated batches
- Story and dialogue tone validation
- Final publication decision

**The AI is a production assistant, not a creative director.**

---

## Reference Files Index

| File | Load when... |
|---|---|
| `references/00_bible_graphique.md` | Creating/updating character or setting sheets |
| `references/01_scenario_et_script.md` | Writing script, dialogue, or panel descriptions |
| `references/02_prompts_visuels.md` | Generating image prompts for any tool |
| `references/03_coherence_personnage.md` | Ensuring character consistency across panels |
| `references/04_mise_en_page.md` | Assembling pages, choosing grids, adding lettering |
| `references/05_outils_et_workflow.md` | Choosing tools, checking licenses, export pipeline |
| `assets/template_fiche_personnage.md` | Filling in a new character sheet |
| `assets/template_planche_script.md` | Writing a new script page |
| `assets/grilles_cases/*.svg` | Selecting or referencing panel grid layouts |
