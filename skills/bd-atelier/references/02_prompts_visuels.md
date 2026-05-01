# Reference 02 — Visual Prompts for Comic Generation

This reference contains prompt formulas, style anchors, shot-type vocabulary,
and tool-specific syntax for generating comic panels with AI image tools.

---

## 1. Universal Prompt Formula

```
[SHOT TYPE] + [CHARACTER SEED] + [ACTION] + [SETTING SEED] +
[ATMOSPHERE / LIGHTING] + [STYLE ANCHOR] + [TECHNICAL PARAMS]
```

Always include all 7 elements. Omitting any element increases unpredictability.

**Example — Ligne claire, medium shot:**
```
Medium shot, [CHARACTER SEED: young woman, red jacket, short black hair],
running through a rain-slicked alley, puddles reflecting neon signs,
dramatic side rim lighting, wet pavement steam,
ligne claire comic art, flat colors, bold clean outlines, no crosshatching,
no text, no watermark, comic panel composition, 4:3 aspect ratio
```

---

## 2. Style Anchor Library

### Ligne Claire (Hergé / Tintin tradition)
```
ligne claire comic art, flat colors with no gradients, bold uniform outlines,
clear separation between foreground and background, highly legible,
Hergé-inspired European comic style, no crosshatching, clean delineation,
no text, no watermark, comic panel composition
```

### Franco-Belge Coloré (Dupuis / Lombard / Spirou aesthetic)
```
Franco-Belgian comic style, rich saturated flat colors, rounded expressive characters,
highly detailed architectural backgrounds, clear character silhouettes, warm lighting,
Franquin-inspired line quality, no text, no watermark, comic panel composition
```

### Manga (Japanese black & white)
```
manga illustration, expressive dynamic linework, screentone shading,
Japanese comic panel composition, high contrast black and white,
speed lines for action, emotional close-up conventions, no text, no watermark
```

### Manga (color)
```
manga-style color illustration, clean linework, cel shading, vibrant saturated colors,
anime-adjacent color palette, expressive character faces, no text, no watermark,
comic panel composition
```

### Graphic Novel — Gritty / Dark (Mignola / Miller)
```
graphic novel ink illustration, heavy black inks, stark shadows, minimal color accents,
high contrast chiaroscuro, noir aesthetic, gritty urban texture,
no text, no watermark, comic panel composition
```

### Graphic Novel — Painterly (Moebius / Bilal)
```
painted graphic novel style, detailed painterly backgrounds, loose expressive inks,
rich color palette, science fiction or surrealist aesthetic,
Moebius-inspired line freedom, no text, no watermark, comic panel composition
```

### US Superhero Comics (Marvel / DC classic)
```
classic American superhero comic art, dynamic poses, muscular anatomy,
bold primary colors, dramatic lighting, Ben-Day dots texture,
Jack Kirby or Neal Adams inspired, no text, no watermark, comic panel composition
```

### Watercolor BD
```
watercolor comic illustration, soft color washes, visible brush texture,
ink outline with watercolor fill, light and airy atmosphere,
painterly backgrounds, no text, no watermark, comic panel composition
```

### Webtoon / Manhwa (Korean digital)
```
Korean webtoon digital art style, clean digital linework, soft cel shading,
pastel to vibrant color palette, expressive character designs,
vertical panel composition, no text, no watermark
```

### Retro / Silver Age Comics (1950s–1970s)
```
retro silver age comic art, Ben-Day dot printing texture, limited color palette,
bold outlines, melodramatic composition, vintage printing imperfections,
no text, no watermark, comic panel composition
```

---

## 3. Shot Type Prompt Vocabulary

| Shot | English prompt phrase |
|---|---|
| Extreme wide shot | "aerial establishing shot showing vast landscape with tiny figures" |
| Wide shot | "full body shot, character visible head to toe, environment dominant" |
| Medium shot | "medium shot, character visible from waist up" |
| Close-up | "close-up portrait, face fills most of frame, strong emotion" |
| Extreme close-up | "extreme close-up, eye detail / hand detail / object detail" |
| Over-the-shoulder | "over-the-shoulder shot, [CHARACTER A] facing [CHARACTER B]" |
| Bird's eye / High angle | "top-down bird's eye view" / "high angle shot looking down at character" |
| Worm's eye / Low angle | "low angle shot looking up at character, dramatic foreshortening" |
| Dutch angle | "Dutch angle, tilted frame, psychological tension" |

---

## 4. Lighting Formulas for Comics

| Mood | Lighting prompt |
|---|---|
| Heroic / Dramatic | "dramatic three-quarter lighting, strong highlight on one side, deep shadow on other" |
| Mysterious / Noir | "low-key lighting, single harsh light source from below, deep shadows" |
| Warm / Intimate | "warm golden hour lighting, soft diffused shadows, amber color cast" |
| Cold / Threatening | "cold blue lighting, overcast flat light, desaturated shadows" |
| Horror / Suspense | "underlighting from below, unnatural light source, eerie green or red tint" |
| Documentary / Neutral | "natural daylight, even diffused lighting, realistic shadows" |
| Night / Urban | "artificial street lighting, neon reflections on wet surfaces, high contrast" |
| Interior / Cozy | "warm interior lamp light, soft shadows, practical light sources visible" |

---

## 5. Atmosphere Boosters

Add 1–2 of these to strengthen mood without changing composition:

```
cinematic atmosphere, epic scale
rain-soaked, reflective puddles
dust particles in light beams
heat haze shimmer
morning mist, soft fog
dramatic smoke or steam
falling autumn leaves
dense urban crowds in background
stark winter emptiness
```

---

## 6. Negative Prompts (what to exclude)

Always add tool-appropriate negative prompts:

**Universal:**
```
text, watermark, signature, username, blurry, low quality, extra limbs,
deformed hands, missing fingers, duplicate characters, bad anatomy,
out of frame, cropped faces, multiple heads
```

**For consistent character panels:**
```
different hairstyle, wrong costume color, different eye color,
aged differently, wrong skin tone, different body type
```

**For clean comic panels:**
```
photorealistic, 3D render, painting texture (if ligne claire),
gradient backgrounds (if flat style), photo collage, realistic skin texture
```

---

## 7. Batch Generation Protocol

Never generate a single version and accept it. Use this workflow:

```
Step 1: Generate 4 variations of the panel (same prompt, different seeds)
Step 2: Evaluate each against: character accuracy / composition / style consistency
Step 3: Select best variant. If none acceptable → refine prompt, repeat.
Step 4: Use inpainting for targeted corrections (hands, face, specific props)
Step 5: Archive with naming convention: p[page]_c[panel]_v[variant].png
         Example: p03_c05_v2.png = page 3, panel 5, variant 2
Step 6: Update continuity log with the accepted image's character state
```

**Accept threshold**: a panel is acceptable if it matches:
- Character appearance (≥80% accuracy to bible)
- Composition (shot type correct)
- Style anchor (visually consistent with other panels)

Do not chase perfection at generation stage — fix at inpainting/retouching stage.

---

## 8. Tool-Specific Syntax Notes

### Midjourney
- Append `--ar 4:3` (landscape panel) or `--ar 3:4` (portrait/webtoon)
- Use `--style raw` for more literal prompt interpretation
- Use `--cref [image URL]` for character reference (MJ6+)
- Use `--sref [image URL]` for style reference

### Stable Diffusion (AUTOMATIC1111 / ComfyUI)
- Use LoRA for character consistency: `<lora:character_name:0.8>`
- Seed lock: fix seed for same character across panels
- ControlNet: use pose reference for action consistency

### Adobe Firefly
- Append "for commercial use, Adobe Stock compatible"
- Avoid named artist references (ToS issue)
- Use "Reference image" upload for style guidance

### DALL-E / GPT Image (via API or ChatGPT)
- More literal prompt interpretation — be explicit about every element
- Cannot fix seeds — use "same character as previous" with image reference
- Good for quick ideation, less reliable for style consistency

### AI Comic Factory (Hugging Face)
- Direct panel generation with automatic layout
- Limited style control — use for rapid prototyping only
- Export individual panels for manual layout reassembly

---

## 9. Prompt Building Checklist

Before submitting any image prompt:

- [ ] Shot type specified
- [ ] Character seed pasted verbatim (if character present)
- [ ] Action described physically (not emotionally)
- [ ] Setting seed referenced
- [ ] Lighting type specified
- [ ] Style anchor appended
- [ ] Negative prompt included
- [ ] Aspect ratio / technical params included
- [ ] No living artist named directly
