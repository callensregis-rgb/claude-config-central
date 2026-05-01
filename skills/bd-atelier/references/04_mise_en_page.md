# Reference 04 — Assembly, Layout, Lettering & Bubbles

This reference covers page composition, panel grids, reading flow,
bubble placement, and lettering — the craft of turning generated images
into a readable comic page.

---

## 1. Page Layout Principles

### The Grid
A comic page is built on an invisible grid. All panels align to this grid.
Deviations from the grid are intentional and meaningful (splash panels, bleed panels).

**Standard grids (see SVG files in assets/grilles_cases/):**
- 6-panel grid (2×3): classic album, balanced pacing
- 4-panel grid (2×2): slower pacing, more space per panel
- 9-panel grid (3×3): fast pacing, information density (Watchmen style)
- Cinematic strips (3×1): wide horizontal panels, cinematic feel
- Webtoon vertical: single column, any height ratio

**White space (gutters):**
- Standard gutter: 5–8mm for print, 10–15px for digital
- Wider gutters = slower reading, more breathing room
- No gutter (bleed between panels) = visual collision, urgency

### Visual Weight and Balance
Distribute visual weight across the page:
- Dark/complex panels balanced by light/simple panels
- A splash panel should not appear on a page with 5 other busy panels
- Start and end pages with strong visual anchors

---

## 2. Custom Panel Shapes

Break the rectangular grid only with intention:

| Shape | Use | Effect |
|---|---|---|
| Circular panel | Memory, dream, flashback, or spotlight focus | Nostalgic, isolated |
| Diagonal cut between panels | Action sequence, fight | Dynamic, violent energy |
| Panel with no border | Character "breaks" the page | Power, unreality |
| Overlapping panels | Layered time, simultaneous action | Complex, film-like |
| Irregular shape (explosion, splatter) | Impact, chaos | Violent, chaotic |
| Full bleed (no white border) | Maximum immersion | Epic, overwhelming |

---

## 3. Reading Flow Engineering

In left-to-right comics (European, US), the eye follows a Z-pattern across the page.

**Rules to embed in every page:**
1. **Entry point**: Top-left panel is always the first read. Make it a strong establishing shot.
2. **Exit point**: Bottom-right panel is the last read. Use for cliffhangers or punchlines.
3. **Gaze direction**: Characters looking right pull the eye to the next panel. Characters looking left disrupt flow (use deliberately for resistance, doubt).
4. **Balloon placement**: First balloon = top-left of panel. Reading order follows balloon chain L→R, T→B.
5. **Avoid orphan balloons**: Never place a balloon so it reads ambiguously between two characters.

---

## 4. Lettering Standards

### Fonts
Comic lettering requires specific fonts. Do NOT use standard body text fonts.

**Free / open source:**
- Komika Axis (general purpose)
- Bangers (display, titles)
- Comic Neue (modern, accessible alternative)
- CC Wild Words (DC standard, very readable)
- Anime Ace (manga-adjacent)

**Professional (paid):**
- Comicraft fonts (industry standard for US comics)
- Blambot fonts (independent comics standard)

### Font Sizes (print — 300dpi reference)
| Element | Size | Style |
|---|---|---|
| Regular dialogue | 7–8pt | Regular |
| Emphasis word | 7–8pt | **Bold** |
| Whisper | 6pt | Regular |
| Shout / shout | 9–10pt + caps | Bold |
| Caption text | 6.5–7pt | Regular or italic |
| SFX | 18–72pt | Display font, stylized |
| Chapter title | 24–48pt | Display font |

**Minimum readable size for digital**: 14px body text equivalent at 72dpi.

### Tracking and Leading
- Tracking: -20 to 0 (tighter than body text)
- Leading: 100–115% of font size (comic letterers prefer tight vertical spacing)
- Align: center for speech bubbles, left for caption boxes

---

## 5. Speech Bubble Anatomy and Placement

### Bubble Types

| Type | Shape | Outline | Use |
|---|---|---|---|
| Speech | Oval / rounded rectangle | Solid | Standard spoken dialogue |
| Thought | Cloud-shaped | Solid | Internal monologue (classic) |
| Thought (modern) | Rounded rectangle | Dashed or no border | Modern, minimalist thought |
| Whisper | Oval | Dashed | Quiet speech |
| Shout / Yell | Jagged / spiked | Solid bold | Loud, angry, panicked |
| Electronic / Radio | Rounded rect | Jagged/lightning bolt edge | Phone, radio, screen |
| Caption | Rectangle | Solid (colored background) | Narration, inner voice |
| No bubble | None | None | Ambient speech, graffiti, signs |

### Bubble Tail Rules
- Tail must point to the speaker's **mouth area** (not head, not body center)
- For off-panel speakers: tail exits the panel edge in speaker's general direction
- Never cross a tail over another bubble without necessity
- Tail angle: roughly 45° preferred — too steep or too shallow looks unnatural
- Multiple bubbles from same speaker: cascade them with connecting tails or use a single tail from last bubble

### Bubble Placement Rules
1. Place bubbles **before** the character who will respond — top of panel, reading order
2. Never cover the speaker's face with their own bubble
3. Leave at least 20% of the panel free of bubbles for visual breathing room
4. Overlap bubbles from different characters only if the overlap is intentional (interruption)
5. Padding inside bubble: 4–6px minimum around text (more for hand-lettered style)

---

## 6. Sound Effects (SFX) Design

SFX are part of the visual art — they are drawn, not placed as text overlays.

**SFX placement principles:**
- Integrate into the visual action (an explosion's SFX lives inside the explosion)
- Match the style of the art (ligne claire SFX = clean outline; manga SFX = dynamic brush strokes)
- Size: proportional to sound intensity (KRAAK > crack)
- Color: derive from the action's color palette or use high-contrast complement

**Standard SFX vocabulary (adapt to story language):**

| Sound | SFX |
|---|---|
| Punch impact | WHAM / POW / CRACK / SMAK |
| Gunshot | BANG / BLAM / KRAK |
| Explosion | BOOM / KRAKOOOM / FWOOM |
| Car crash | SCREEECH / KRASH |
| Door slam | SLAM / BAM |
| Glass break | KRASH / TINKL |
| Running footsteps | TUMP TUMP / STOMP |
| Swoosh / fast movement | WHOOSH / FWIP / ZWOOOM |
| Electricity | ZZZZT / KRAK |
| Rain | PITTER PATTER / SHHHH |
| Silence (ironic) | ...or empty panel |

---

## 7. Assembly Software Options

| Tool | Cost | Strength | Best for |
|---|---|---|---|
| Clip Studio Paint (CSP) | ~60€/year | Native comic tools, bubble templates, layer management | Primary recommendation |
| Adobe InDesign | ~25€/month | Professional print layout, master pages | Print-ready publication |
| Canva Pro | ~13€/month | Fast, accessible, templates | Digital-only, simple layouts |
| Krita | Free | Drawing + layout, good for single pages | Budget option |
| Affinity Publisher 2 | ~75€ one-time | InDesign alternative, no subscription | Print professional, budget |
| AI Comic Factory | Free | Automatic layout from panels | Rapid prototyping only |

---

## 8. Assembly Workflow (Recommended Order)

```
1. Import all accepted panel images at final resolution
2. Apply the chosen grid template
3. Place panels (crop/scale to fit grid)
4. Adjust panel order against script — verify reading flow
5. Add SFX (as art elements, not text overlays)
6. Add lettering: caption boxes first, then speech bubbles
7. Verify balloon reading order (top-left → bottom-right)
8. Verify bubble tails point to correct speakers
9. Run full page human review checklist (see SKILL.md Step 4d)
10. Export at target format (see SKILL.md Step 5b)
```

---

## 9. Page Assembly Checklist

Before exporting any page:

**Composition:**
- [ ] Panel order matches script
- [ ] Reading flow is clear (no ambiguous panel sequence)
- [ ] Page turn effect considered (if right-hand page)
- [ ] Visual weight balanced across page

**Text:**
- [ ] All bubbles have correct tail direction and speaker attribution
- [ ] Reading order of bubbles is unambiguous
- [ ] No text overflows bubble boundaries
- [ ] Font sizes within standards
- [ ] SFX stylistically integrated

**Image quality:**
- [ ] No visible seams or compositing artifacts
- [ ] Consistent resolution across all panels
- [ ] No JPEG compression artifacts on text or fine lines

**Consistency:**
- [ ] Character appearance matches bible across all panels on page
- [ ] Lighting direction consistent within each scene
- [ ] Continuity log updated
