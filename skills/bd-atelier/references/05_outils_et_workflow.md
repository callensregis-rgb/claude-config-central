# Reference 05 — Tools, Licenses & Workflow Orchestration

This reference maps the tool ecosystem, clarifies commercial licensing,
and provides the master orchestration guide for the full pipeline.

---

## 1. Tool Map by Pipeline Stage

### Stage 1: Script & Story (Text AI)
| Tool | Strength | Notes |
|---|---|---|
| Claude | Script, dialogue, world-building, continuity | Primary recommendation |
| ChatGPT (GPT-4o) | Script, dialogue, alternative | Good for brainstorming alternatives |
| Gemini | Research-heavy scripts, factual consistency | Better for documentary/historical BD |
| Notion / Obsidian | Continuity tracking, bible storage | Use as external memory |

### Stage 2: Image Generation (Visual AI)
| Tool | Style strength | Consistency method | Commercial? |
|---|---|---|---|
| Midjourney 6+ | Artistic quality, painterly | `--cref` image reference | Yes (paid plans) |
| Stable Diffusion (AUTOMATIC1111) | Full control, LoRA, poses | LoRA + seed lock + ControlNet | Yes (open weights) |
| ComfyUI | Advanced workflows, batch | Full pipeline control | Yes (open source) |
| Adobe Firefly | Commercial safe, clean | Style reference upload | Yes (CC license) |
| DALL-E / GPT Image | Quick ideation | Image reference upload | Yes (OpenAI ToS) |
| Ideogram 2 | Text-in-image, typography | Style reference | Yes (paid plans) |
| Flux (Black Forest Labs) | High realism + artistic | Prompt-based | Check license per model |
| AI Comic Factory | Automatic panel layout | Limited | Free, non-commercial default |

### Stage 3: Assembly & Retouching
| Tool | Cost | Primary use |
|---|---|---|
| Clip Studio Paint | ~60€/year | Comic native — bubbles, inks, SFX, assembly |
| Photoshop | ~25€/month | Inpainting, retouching, compositing |
| Krita | Free | Drawing, painting, compositing |
| Affinity Publisher 2 | ~75€ once | Print-ready layout, no subscription |
| Adobe InDesign | ~25€/month | Professional print layout |
| Canva Pro | ~13€/month | Fast digital layout, social media export |

### Stage 4: Export & Publication
| Tool | Use |
|---|---|
| Clip Studio Paint | Export CBZ, PDF, per-page PNG |
| Adobe Acrobat / InDesign | PDF/X-1a for offset print |
| Calibre | CBZ/CBR management |
| WebtoonCMS | Webtoon platform publishing |
| Tapas / Tapastic | Alternative webcomic platform |
| Instagram | Carousel format (1080px) |
| Gumroad / Ko-fi | Self-publishing / sale |
| Amazon KDP | Print-on-demand |

---

## 2. Commercial Licensing — Per Tool

**Critical: verify before using generated art commercially.**

| Tool | Commercial use allowed? | Conditions |
|---|---|---|
| Midjourney (paid plan) | **Yes** | Requires active paid subscription |
| Midjourney (free trial) | **No** | Trial outputs non-commercial only |
| Stable Diffusion (open weights) | **Generally yes** | Depends on base model license — check each model's card on HuggingFace |
| ComfyUI | **Yes** | Tool is open source; output governed by model license |
| Adobe Firefly | **Yes** | Adobe CC subscription — trained on licensed content |
| DALL-E / OpenAI | **Yes** | OpenAI ToS: user owns output, commercial allowed |
| Midjourney Turbo / Relax | **Yes** | Same as regular paid plan |
| Flux (FLUX.1-dev) | **No** (non-commercial) | FLUX.1-schnell = Apache 2.0 (commercial ok) |
| Flux (FLUX.1-schnell) | **Yes** | Apache 2.0 — commercial use allowed |
| Ideogram | **Yes** (paid) | Free tier: non-commercial |
| AI Comic Factory | **Check** | Uses Stable Diffusion models — check per model |
| Gemini Imagen | **Yes** | Google ToS: user owns output |

**General rule**: when in doubt, use Adobe Firefly or DALL-E for commercial projects.
For maximum control + commercial rights: Stable Diffusion with a permissively-licensed model.

---

## 3. Naming Living Artists in Prompts — Legal Position

**Do not name living artists in commercial prompts.** Instead, describe style characteristics.

| Instead of... | Write... |
|---|---|
| "in the style of Moebius" | "graphic novel illustration, loose expressive inks, spacious clean linework, pastel sci-fi palette, retro-futuristic aesthetic" |
| "in the style of Miyazaki" | "anime illustration, soft painterly backgrounds, detailed natural environments, expressive character faces, Ghibli-adjacent color palette" |
| "in the style of Frank Miller" | "noir graphic novel, high contrast black and white, heavy inks, dramatic chiaroscuro, gritty urban atmosphere" |
| "in the style of Hergé" | "ligne claire comic art, flat colors, bold clean outlines, no crosshatching, highly legible character design" |

**Deceased artists (pre-1954)**: Generally safe to reference by name (copyright expired in most jurisdictions for published works). However, style itself is not copyrightable — describing style characteristics is always safer.

---

## 4. Master Pipeline Orchestration

This is the recommended orchestration flow for a complete comic project.

### Where AI Works Best
```
✅ Generating script drafts, dialogue options, plot structures
✅ Writing precise image prompts from script descriptions
✅ Batch-generating panel variants for human selection
✅ Inpainting corrections (hands, text in backgrounds)
✅ Suggesting panel transitions and pacing
✅ Continuity tracking (maintaining the log)
✅ Formatting and export setup
```

### Where Humans Must Lead
```
🧠 Final story and character decisions
🧠 Art direction (style selection, mood validation)
🧠 Character design approval (selecting canonical reference)
🧠 Panel selection from generated batches
🧠 Dialogue tone and voice validation
🧠 Page composition final review
🧠 Publication and distribution decisions
```

### Decision Points in the Pipeline
At these moments, stop AI production and wait for human decision:

| Decision point | What to present to human |
|---|---|
| After Graphic Bible draft | Full character sheets + style anchor — confirm before any image generation |
| After script Act 1 | Pages 1–12 in script format — confirm structure before continuing |
| After first 4 panel variants | Present grid of 4 options — human selects canonical reference |
| After each completed page | Full assembled page with lettering — approve before next page |
| Before export | Final quality check on all pages together |

---

## 5. GitHub Sync — File Organization for the Skill

Recommended repository structure for storing both the skill and project assets:

```
[your-github-repo]/
│
├── bd-atelier/                    ← The skill itself (sync with claude-config-central)
│   ├── SKILL.md
│   ├── references/
│   └── assets/
│
└── projects/
    └── [project-name]/
        ├── bible/
        │   ├── bible_graphique.md
        │   └── personnages/
        │       ├── [character]_canonical_ref.png
        │       └── [character]_fiche.md
        ├── script/
        │   ├── act1.md
        │   ├── act2.md
        │   └── act3.md
        ├── panels/
        │   ├── p01_c01_v1.png
        │   ├── p01_c01_v2.png     ← variants
        │   └── p01_c01_ACCEPTED.png
        ├── pages/
        │   ├── page_01_draft.psd
        │   └── page_01_FINAL.png
        └── export/
            ├── print_pdf/
            ├── digital_cbz/
            └── webtoon/
```

**Sync with claude-config-central:**
Add `bd-atelier/` as a subdirectory in the skills folder of the repo.
Use the same SessionStart pull / SessionEnd push hooks already configured.

---

## 6. Quick Reference — Common Problems & Fixes

| Problem | Cause | Fix |
|---|---|---|
| Character looks different every panel | No prompt seed / no image reference | Use character seed + `--cref` or IP-Adapter |
| Hands always deformed | Known AI limitation | Inpaint hands specifically with hand reference image |
| Style drifts across pages | Style anchor not used consistently | Verify style anchor string in every prompt |
| Text appears in generated images | No negative prompt | Add "no text, no watermark" to all prompts |
| Bubbles overlap character's face | Bubble placed before image composition | Leave planned space in panel description ("upper third empty for dialogue") |
| Backgrounds too detailed (ligne claire) | Style not specific enough | Add "simplified background, flat architectural detail" to style anchor |
| Character ages between panels | Prompt seed too vague on age | Be explicit: "appears 28 years old, no facial lines" |
| Two characters look the same | Insufficient differentiation in seeds | Add contrasting physical anchor: "significantly taller than", "much lighter skin than" |
