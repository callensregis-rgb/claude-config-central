# Reference 01 — Script & Scenario

Comic writing differs from prose and screenplay. This reference covers
the conventions, panel description format, dialogue rules, and pacing logic.

---

## 1. The Comic Script Format

Use this format for every page. It is the bridge between writer and visual AI.

```
PAGE [N] — [total panels on this page]

[N.1] — [SHOT TYPE] / [PANEL SIZE: small/medium/large/splash]
ACTION: [What happens, physically. No internal states — only visible actions.]
SETTING: [Where, when, lighting, key props visible.]
DIALOGUE:
  [CHARACTER NAME]: "[bubble text]"
  [CAPTION]: "[narrator text if any]"
SFX: [sound effect text and approximate position in panel]
NOTES: [special instructions for image generation — angles, props, continuity alerts]

[N.2] — ...
```

**Rule: one panel = one moment.** Never describe two simultaneous actions in one panel unless they are part of a single continuous motion.

---

## 2. Shot Types (required in every panel description)

| Shot Type | French | Use Case |
|---|---|---|
| Extreme wide shot (EWS) | Très grand plan (TGP) | Establish setting, show scale |
| Wide shot (WS) | Plan général (PG) | Show character in full environment |
| Medium wide shot (MWS) | Plan de demi-ensemble | Character + immediate surroundings |
| Medium shot (MS) | Plan américain | Character from waist up, social interaction |
| Medium close-up (MCU) | Plan rapproché taille | Chest up, emotional engagement |
| Close-up (CU) | Gros plan (GP) | Face, strong emotion, key detail |
| Extreme close-up (ECU) | Très gros plan (TGP) | Eye, hand, object — maximum intensity |
| Over-the-shoulder (OTS) | Champ/contrechamp | Dialogue scenes |
| Bird's eye view | Plongée verticale | God perspective, character vulnerability |
| Worm's eye view | Contre-plongée | Power, threat, monumental feeling |
| Dutch angle | Plan incliné | Psychological unease, disorientation |

---

## 3. Panel Size Logic

| Size | Usage |
|---|---|
| **Small** (1/6 page) | Quick action, reaction, detail insert |
| **Medium** (1/3–1/4 page) | Standard narrative panel |
| **Large** (1/2 page) | Dramatic moment, new setting introduction |
| **Splash** (full page) | Maximum impact: revelation, action climax, emotional peak |
| **Double splash** (2 pages) | Rare: opening of a chapter or final act revelation |

**Pacing rule**: alternate small and large panels. A page of all medium panels reads as flat.
A page that builds from small → medium → large creates rhythmic acceleration.

---

## 4. Panel Transitions (McCloud's 6 Types)

Apply intentionally — the transition between panels IS the storytelling.

| Type | Description | Best use |
|---|---|---|
| Moment-to-moment | Tiny time increment, same action | Slow motion effect, suspense |
| Action-to-action | Subject performs single action | Standard narrative flow |
| Subject-to-subject | Different subjects, same scene | Dialogue, reaction shots |
| Scene-to-scene | Time or space jump | Chapter transitions, flashback |
| Aspect-to-aspect | Mood fragments, no time | Atmosphere, world-building |
| Non-sequitur | No logical connection | Humor, experimental, surreal |

**Most comics use ~65% action-to-action** (Scott McCloud, Understanding Comics, 1993).

---

## 5. Dialogue Rules for Comics

### Economy
- Maximum 30–40 words per bubble. If more, break into two bubbles.
- Never more than 3 bubbles per panel (reading overwhelm).
- Caption boxes: maximum 2 per panel.

### Register
- Bubbles read in order: top-left → top-right → bottom-left → bottom-right.
- The first bubble in a panel sets the reading entry point.
- Speech bubble tail must point to the character's mouth (not chin, not forehead).

### Types and Markup
When writing dialogue in script format, use these markers:

```
[SPEECH] "Regular spoken dialogue."
[THOUGHT] *Internal thought, no tail or cloud tail*
[WHISPER] ~Quiet, dashed bubble outline~
[SHOUT] "CAPS, jagged/spiked bubble outline!"
[CAPTION] {Narrator voice, rectangular box, past tense or present}
[SFX] KRAAK / WHOOSH / CLANG — describe placement: "upper right, integrated into smoke"
[RADIO/PHONE] <Jagged outline, technical filter text>
[ALIEN/ROBOT] §Stylized lettering, different font°
```

### Silence
Empty panels (no dialogue, no caption) are valid and powerful.
Use them for: shock, weight, transition, breath before impact.

---

## 6. Visual Symbols — Comic Conventions

These symbols are universally readable in comics. Use them in panel descriptions.

| Symbol | Meaning | How to describe in prompt |
|---|---|---|
| Stars around head | Physical pain / impact | "stars orbiting character's head, impact stars" |
| Sweat drop (large) | Embarrassment / nervousness | "large sweat drop on cheek, anime-style" |
| Spiral eyes | Dizziness / stunned | "swirling spiral eyes" |
| Pulsing vein on forehead | Rage / irritation | "throbbing forehead vein" |
| Hearts in eyes | Infatuation | "heart-shaped pupils" |
| Question marks above head | Confusion | "floating question marks" |
| Exclamation mark | Sudden realization | "bold exclamation mark in speech bubble or above character" |
| Speed lines | Motion / speed | "radial speed lines behind character" |
| Thought bubble chain | Thinking | "small circles leading to cloud thought bubble" |
| Jagged speech bubble | Loud/distorted/electronic | "jagged-edged speech bubble" |

---

## 7. Narrative Codes Specific to Comics

### The Gutter
The space between panels is where the reader's imagination completes the action.
The writer controls what happens in the gutter by choosing what to show in adjacent panels.

**Exploit the gutter deliberately:**
- Show a character raising a fist → next panel: opponent on the ground = violent moment implied, not shown
- Show a door opening → next panel: empty room = mystery, absence

### Reading Flow
In left-to-right languages (French, English):
- Panel sequence reads L→R, then top→bottom
- Characters moving right = moving forward (narrative momentum)
- Characters moving left = retreating, returning, regression
- Gaze direction leads the eye to the next panel

### Page Turn Effect
The bottom-right panel of a right-hand page is the last panel seen before the turn.
Use it for: cliffhangers, punchlines, reveals.
The top-left panel of a left-hand page (after the turn) is the first seen after.
Use it for: consequence, payoff, new scene establishment.

### Act Structure in Pages
For a 46-page album:
- Pages 1–3: Opening hook (in medias res or establishing world)
- Pages 4–12: Act 1 — Setup, character introduction, inciting incident
- Pages 13–30: Act 2 — Confrontation, escalation, midpoint reversal
- Pages 31–42: Act 3 — Crisis, climax, resolution
- Pages 43–46: Denouement, final image

Adjust proportions for shorter formats (one-shot 24p, mini-comic 8p, webtoon episodes).

---

## 8. Script Checklist (per page)

Before passing a script page to visual production:

- [ ] Each panel has a shot type defined
- [ ] Each panel has a setting description (even minimal)
- [ ] No panel has more than 3 dialogue bubbles
- [ ] No bubble exceeds 40 words
- [ ] Transition type between panels is intentional
- [ ] Page-turn effect considered (if right-hand page)
- [ ] Continuity log updated (clothing, props, lighting)
- [ ] Visual symbols noted for AI prompt (stars, speed lines, etc.)
