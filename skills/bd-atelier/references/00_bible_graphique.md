# Reference 00 — Graphic Bible (Character & Setting Bible)

The Graphic Bible is the single source of truth for visual consistency.
It must be created before any image prompt is written.
It is updated whenever the story introduces a change (costume, injury, new setting).

---

## 1. Character Sheet Structure

Each main character requires a complete sheet. Secondary characters need a shorter version.

### Main Character Sheet

```
CHARACTER NAME: _______________
Role: protagonist / antagonist / supporting
First appearance: Page ___, Panel ___

--- PHYSICAL DESCRIPTION ---
Age (apparent): ___
Height: ___ / Build: ___
Skin tone: ___ (use descriptive + hex if known, e.g. "warm medium brown, #8D5524")
Hair: color ___, length ___, texture ___, style ___
Eyes: color ___, shape ___, expression tendency ___
Distinctive features: scars, freckles, glasses, tattoos, etc.

--- DEFAULT COSTUME (most frequent) ---
Top: ___
Bottom: ___
Footwear: ___
Accessories: ___
Color palette: [list 3–5 hex codes or named colors]

--- ALTERNATE COSTUMES ---
[Label each: "Formal", "Combat", "Disguise", etc.]

--- EXPRESSION REPERTOIRE ---
Neutral: ___
Happy: ___
Angry: ___
Afraid: ___
Determined: ___

--- POSTURE & BODY LANGUAGE ---
Default stance: ___
Under stress: ___
Characteristic gesture: ___

--- PROMPT SEED (copy verbatim into every prompt) ---
[A 150–200 word block describing this character precisely, for direct use in AI image tools]
Example:
"A 28-year-old woman, athletic build, warm medium-brown skin, sharp dark brown almond eyes,
short natural black hair with a fade on the sides, a small scar above her left eyebrow.
Wearing a worn red leather jacket over a white tank top, dark blue jeans, white sneakers.
Confident posture, slight forward lean, hands often in pockets or crossed. Determined
expression as default. [STYLE ANCHOR]"
```

### Secondary Character Sheet (abbreviated)

```
NAME: ___
Role: ___
Physical: age/build/skin/hair/eyes in one sentence
Costume: one sentence
Prompt seed: 80–100 words max
```

---

## 2. Setting Sheet Structure

Each recurring setting requires a sheet.

```
SETTING NAME: _______________
Type: interior / exterior / mixed
First appearance: Page ___, Panel ___

--- DESCRIPTION ---
Location type: apartment, street, office, forest, etc.
Time of day most frequent: ___
Atmosphere / mood: ___
Key visual elements (always present): ___
Key props: ___
Lighting source: natural / artificial / mixed — describe quality and direction

--- COLOR PALETTE ---
Dominant colors: ___
Accent colors: ___
Shadow tone: ___

--- PROMPT SEED ---
[100–150 words for background generation]
Example:
"A cramped 1970s Parisian apartment, warm amber lighting from a single floor lamp,
walls covered in peeling floral wallpaper (faded green and cream), stacks of books
on every surface, a large window overlooking rainy cobblestones. Late evening.
Dusty, lived-in atmosphere. [STYLE ANCHOR]"
```

---

## 3. Visual Consistency Rules

Apply these rules to every panel:

- **Palette lock**: once the main character's color palette is defined, no element should introduce a new color unless narratively motivated.
- **Lighting consistency**: if a scene is set at noon in exterior, all panels in that scene maintain the same light direction.
- **Scale consistency**: if a car is established as large relative to the character, it must remain so throughout.
- **Background density**: establish a rule per scene — detailed backgrounds (realistic), medium (key elements only), or simplified (emotion-driven panels). Do not mix within the same scene without intention.

---

## 4. Style Anchor — Definition and Usage

The style anchor is a fixed string that ends every image prompt.
It encodes the art style and ensures visual coherence across all generated images.

**Define the style anchor once, in the Graphic Bible header.**
**Never modify it during production** — any change creates visual rupture.

Structure:
```
[Art style name], [rendering technique], [line quality], [color treatment],
[reference aesthetic if needed], no text, no watermark, comic panel composition
```

Examples:
```
Ligne claire: ligne claire comic art, flat colors, bold clean outlines, no crosshatching,
clear delineation between foreground and background, no text, no watermark

Manga: manga illustration, expressive linework, screentone shading, dynamic panel
composition, black and white preferred, high contrast, no text, no watermark

Franco-belge realist: Franco-Belgian comic style, rich saturated flat colors,
detailed architectural backgrounds, clear character silhouettes, no text, no watermark

Graphic Novel (dark): graphic novel ink illustration, high contrast black and white,
heavy shadows, minimal flat color accents, gritty texture, no text, no watermark
```

---

## 5. Graphic Bible Header Template

Place this at the top of every project's bible document:

```
PROJECT: _______________
Genre: ___
Format: ___ pages / ___ panels per page
Audience: ___
Art style: ___
Style anchor: [paste full anchor string here]
Publication target: ___

Main characters: [list names]
Secondary characters: [list names]
Recurring settings: [list names]

Last updated: ___
```
