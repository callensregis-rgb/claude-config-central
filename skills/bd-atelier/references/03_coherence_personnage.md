# Reference 03 — Character Consistency

The single hardest technical challenge in AI-assisted comics.
This reference covers all available techniques to maintain consistent character appearance
across multiple generated panels.

---

## 1. The Core Problem

AI image generators are stateless — each generation is independent.
Without explicit consistency mechanisms, the same character description will produce
a different-looking character on every panel.

**Acceptable variation**: minor (lighting-induced color shift, slight angle difference)
**Unacceptable variation**: different hair, wrong eye color, different build, different costume

---

## 2. Technique 1 — The Character Prompt Seed (Universal)

Works with every tool. The most important technique.

**Principle**: Write a single, precise, exhaustive character description (150–200 words).
Copy it verbatim into every prompt that features this character. Never paraphrase it.

**Structure of a good seed:**
```
[Age] [gender] [build] [skin tone precise], [hair: color + length + texture + style],
[eyes: color + shape], [distinctive features: scars, glasses, freckles, etc.].
Wearing [TOP detailed], [BOTTOM detailed], [FOOTWEAR], [ACCESSORIES].
[Posture characteristic]. [Expression tendency].
```

**Example seed:**
```
A 32-year-old man, lean athletic build, warm olive skin, short dark brown hair
slightly disheveled with a natural wave, deep-set hazel eyes with subtle bags underneath,
a thin scar on his chin from an old wound.
Wearing a faded navy blue mechanic's jumpsuit unzipped to the waist with the sleeves
tied around his hips, white undershirt, heavy brown work boots, a battered silver watch
on his left wrist.
Confident but tired posture, slightly hunched shoulders. Neutral expression tends
toward a thoughtful frown.
```

**Rules:**
- Never vary a single word of the seed for the same character
- If a costume change happens in the story, create a second seed ("COSTUME B") and switch explicitly
- Keep the seed in the Graphic Bible, not just in your head

---

## 3. Technique 2 — Image Reference (Most Effective)

Once you have an accepted panel image of the character, use it as a reference for subsequent generations.

| Tool | How to use image reference |
|---|---|
| Midjourney 6+ | `--cref [image URL]` — character reference mode |
| Stable Diffusion | ControlNet IP-Adapter or Reference mode |
| Adobe Firefly | Upload as "Reference image" in style reference |
| DALL-E / GPT Image | Upload image + write "maintain the exact appearance of the character in this image" |
| AI Comic Factory | Upload character sheet as reference image |

**Workflow:**
1. Generate 4–6 character variants from seed only
2. Select the best one as your **canonical reference image**
3. Save it as `[CHARACTER_NAME]_canonical_ref.png`
4. Use this image as reference for all subsequent panels featuring this character
5. If the tool allows it, also save the seed number/hash

---

## 4. Technique 3 — Seed Locking (Stable Diffusion / ComfyUI)

In SD-based tools, the same seed + same model + same prompt = nearly identical result.

**Protocol:**
1. Generate with random seeds until you find an acceptable character
2. Note the seed number
3. Fix that seed for all panels featuring this character
4. Vary only the parts of the prompt that change (action, setting, shot type)

**Limitation**: Changing any other significant prompt element can still drift.
Combine with Character Prompt Seed for best results.

---

## 5. Technique 4 — LoRA (Stable Diffusion Advanced)

A LoRA (Low-Rank Adaptation) is a small trained model that encodes a specific appearance.

**When to use**: For a long project (20+ panels) with a main character.
**How to create**: Train on 15–30 images of the character (from generated canonical images).
**How to use**: `<lora:character_name:0.7>` in the prompt (weight 0.6–0.8 recommended).

**Tools that support LoRA**: AUTOMATIC1111, ComfyUI, Forge.
**Tools that don't**: Midjourney, Adobe Firefly, DALL-E.

---

## 6. Technique 5 — Multi-Panel Grid Generation

Some tools allow generating a 2×2 or 3×3 grid of the same character in different poses.
This ensures style coherence because all images are generated in a single pass.

**Midjourney**: Add `--tile` or describe a grid layout in the prompt.
**ComfyUI**: Use a batch node with pose variations.
**Manual workaround**: Generate 4 images, select consistent ones, use them as reference batch.

---

## 7. Costume Change Protocol

When the story requires a new costume:

1. Create a new prompt seed: `[CHARACTER NAME] — COSTUME B:`
2. Keep all physical descriptors identical to the original seed
3. Replace only the clothing section
4. Add to the Graphic Bible: "COSTUME B first appears page X, panel Y"
5. Create a new canonical reference image for COSTUME B
6. In the continuity log, mark which costume is active per scene

---

## 8. Multi-Character Consistency in the Same Panel

When two or more characters appear together:

- Write both character seeds, separated by a comma or semicolon
- Establish size relationship explicitly: "Character A is a head taller than Character B"
- Specify each character's position: "Character A on left, Character B on right"
- If tools allow, generate each character separately then composite (Photoshop, Krita)

**Compositing approach (most reliable for complex scenes):**
1. Generate Character A alone on transparent background
2. Generate Character B alone on transparent background
3. Generate background separately
4. Composite in Photoshop/Krita with correct scale and perspective
5. Add unified lighting pass over the composite

---

## 9. Consistency Verification Checklist

Before accepting any generated panel, verify:

**Physical:**
- [ ] Hair: correct color, length, style
- [ ] Eyes: correct color and shape
- [ ] Skin tone: consistent with canonical reference
- [ ] Distinctive features present (scar, glasses, freckles, etc.)
- [ ] Build and height match

**Costume:**
- [ ] Correct costume version for this scene
- [ ] All costume elements present (accessories, footwear)
- [ ] Colors match palette from Graphic Bible

**Cross-panel:**
- [ ] Character matches previous accepted panels (not just the seed)
- [ ] No new props appeared on character without narrative justification
- [ ] Injuries/state changes from story are reflected (if scene calls for it)

---

## 10. Acceptable Variation vs. Rejection Criteria

| Variation type | Acceptable? | Action |
|---|---|---|
| Slightly different lighting on face | Yes | Keep |
| Minor hairstyle variation (same length/color) | Marginal | Use if no better option |
| Different hair length | No | Regenerate |
| Wrong eye color | No | Fix in inpainting or regenerate |
| Missing distinctive feature | No | Fix in inpainting |
| Wrong costume color | No | Regenerate with stronger color emphasis |
| Different costume entirely | No | Regenerate |
| Anatomical issues (hands, fingers) | Depends | Fix in inpainting if panel is otherwise good |
| Wrong body proportions | No | Regenerate |
