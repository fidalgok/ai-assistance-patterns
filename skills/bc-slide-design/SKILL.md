---
name: bc-slide-design
description: Create animation-rich HTML presentations styled with Boston College's brand identity. Two default BC themes (dark and light) using oklch color space, plus opt-in variant palettes (e.g., Precision Product) for tech-focused decks. Includes built-in light/dark mode toggle and on-the-fly typography adjustment. Supports building from outlines/content, creating from scratch, enhancing existing HTML, converting PPT files, and exporting to PPTX. Use when the user wants BC-branded slides, presentations, or slide design. Also use when the user needs to present content at a meeting, conference, workshop, or talk — even if they say "deck", "visuals for my talk", "something to show on screen", or just describe needing formatted content for an audience.
metadata:
  version: "1.1.0"
  sharing: public
---

# BC Slide Design Skill

Create zero-dependency, animation-rich HTML presentations styled with Boston College's brand identity. Single-file HTML with inline CSS/JS, using BC's official maroon and gold palette in oklch color space, with a built-in light/dark mode toggle and admin panel for live typography adjustment.

## Core Philosophy

1. **Zero Dependencies** — Single HTML files with inline CSS/JS. No npm, no build tools.
2. **Content-First** — Most sessions start with prepared content. Design serves the message.
3. **On-Brand by Default** — Every presentation uses BC's official color palette. No guessing.
4. **Production Quality** — Well-commented, accessible, and performant code.
5. **Viewport Fitting** — Every slide fits exactly within the viewport. No scrolling within slides, ever. This is the single most common visual defect to watch for.

---

## Design Contract (Read First)

The design language for this skill lives in two places:

- **`DESIGN.md`** (skill root) — Authoritative tokens and language for the two default BC palettes (BC Maroon dark / BC Cream light). Read this **before** generating any deck. The frontmatter is machine-readable; treat the values as the canonical source for colors, typography roles, spacing, radii, motion, and component contracts. The prose explains the *why* and *when*.
- **`reference/palettes/`** — Variant palettes (e.g., `precision-product.md`) that override the `palettes` block of `DESIGN.md` while inheriting everything else. Only load a variant file if the user has chosen that palette in Phase 2.

**The two specific rules most easily missed:**

1. **Title-slide content centers by default** — `align-items: center` on `.slide-center` is part of the title-slide contract, not a per-deck fix. See `reference/style-presets.md` Common Layout Fixes.
2. **Bullet sizing depends on role.** Bullets that *are* the slide's main content use `subtitle` size (`bullet-list--primary`, the default). Bullets that support a heading or live inside a card use `body` size (`bullet-list--secondary`). See `reference/type-hierarchy.md` for the decision tree and worked examples.

When in doubt about a sizing or component decision, `DESIGN.md` and `reference/type-hierarchy.md` answer first; this SKILL.md governs *workflow*.

---

## Viewport Fitting

The single most common visual defect is content overflowing a slide. Each slide should be exactly one viewport height (100vh/100dvh). When content overflows, the fix is always to split into multiple slides — never to add scrolling.

Every presentation includes the mandatory base CSS from `reference/style-presets.md` (the viewport fitting section), which handles scroll-snap locking, `clamp()` typography, responsive breakpoints, and overflow prevention. See that file for the content density limits table and the full overflow prevention checklist.

---

## Phase 0: Detect Mode

Determine what the user wants. Modes are listed in order of frequency:

**Mode A: Content-Ready (PRIMARY)**
User arrives with content, an outline, or output from another skill (e.g., `workshop-slides`). This is the most common path. Proceed directly to Phase 2 (Style Selection).

**Mode B: New from Scratch**
User wants to build a presentation with no existing content. Proceed to Phase 1 (Content Discovery).

**Mode C: Existing HTML Enhancement**
User has an HTML presentation and wants to improve it. Read the existing file, understand the structure, then enhance using the BC theme system.

**Mode D: PPT Conversion**
User has a PowerPoint file (.ppt/.pptx) to convert. Run `scripts/extract_pptx.py` to extract content (see `reference/ppt-conversion.md` for the full workflow), then return to Phase 2 for styling.

**Mode E: Export**
User has an existing BC-themed HTML presentation and wants a PPTX version. Proceed directly to Phase 4 (Export).

---

## Phase 1: Content Discovery (New Presentations)

This phase is for Mode B only — when the user has no existing content. Most sessions skip this.

Ask via AskUserQuestion:

**Question 1: Purpose**
- Header: "Purpose"
- Question: "What is this presentation for?"
- Options:
  - "Teaching/Workshop" — Explaining concepts, how-to guides, educational content
  - "Team presentation" — Internal meetings, strategy updates, project reviews
  - "Conference talk" — Speaking at an event, keynote, panel presentation
  - "Pitch/Proposal" — Selling an idea, initiative, or program to stakeholders

**Question 2: Slide Count**
- Header: "Length"
- Question: "Approximately how many slides?"
- Options:
  - "Short (5-10)" — Quick overview, lightning talk
  - "Medium (10-20)" — Standard presentation
  - "Long (20+)" — Deep dive, comprehensive talk

**Question 3: Content**
- Header: "Content"
- Question: "Do you have the content ready, or do you need help structuring it?"
- Options:
  - "I have all content ready" — Just need to design the presentation
  - "I have rough notes" — Need help organizing into slides
  - "I have a topic only" — Need help creating the full outline

If user has content, ask them to share it (text, bullet points, images, etc.).

---

## Phase 2: Style Selection

### Default BC Presets

Two default BC-branded themes using oklch color space with warm understated tones and no true black. Full token reference in `DESIGN.md`.

| Preset | Vibe | Best For |
|--------|------|----------|
| **BC Maroon** (Dark) | Sophisticated, confident, premium | Keynotes, formal presentations, evening events |
| **BC Cream** (Light) | Warm, approachable, editorial | Workshops, team meetings, teaching sessions |

Default decks include both modes with a light/dark toggle, plus the admin panel for on-the-fly typography adjustment.

### Variant Palettes

When the default register is wrong for the room, use a variant palette from `reference/palettes/`. Each variant is a single-mode (light-only or dark-only) palette swap that inherits all typography roles, spacing, motion, and component contracts from `DESIGN.md`.

| Variant | File | Mode | Best For |
|---------|------|------|----------|
| **Precision Product** | `reference/palettes/precision-product.md` | Light | Tech demos, AI tooling, product walkthroughs, code-heavy talks |
| **Playful Teacher** | `reference/palettes/playful-teacher.md` | Light | Tutorial decks, hands-on lessons, classroom explainers, onboarding |
| **Tactile Media** | `reference/palettes/tactile-media.md` | Dark | Engineering retros, product team reviews, creative-media work |
| **Midnight Studio** | `reference/palettes/midnight-studio.md` | Dark | Policy frameworks, AI strategy, formal-tech decks shown in dark rooms |
| **Phthalo Editorial** | `reference/palettes/phthalo-editorial.md` | Light + Dark | Refined editorial decks — book launches, gallery openings, lux brand presentations. Two-mode (toggle enabled). |

### Theme Selection

**Question: Theme Selection**
- Header: "Theme"
- Question: "Which palette fits this deck?"
- Options:
  - "BC Maroon (Dark)" — Default. Sophisticated dark background with maroon and gold accents (Recommended for keynotes)
  - "BC Cream (Light)" — Default. Warm cream background with maroon text and gold highlights (Recommended for workshops)
  - "Precision Product" — Variant. Cream/paper editorial palette for tech demos and product walkthroughs
  - "Playful Teacher" — Variant. Cloud-blue cream with friendly Fraunces, sky/lemon/berry accents — for tutorials and lessons
  - "Tactile Media" — Variant. Forest-green dark with acid-green accent and condensed display — for engineering and creative reviews
  - "Midnight Studio" — Variant. Deep blue-black with subtle radial gradient and yellow-orange (#fccd08) accent — for formal-tech and policy talks
  - "Phthalo Editorial" — Variant. Phthalo green + antique gold + cream, Cormorant + Jost — for refined editorial decks. Two modes (toggle stays enabled).

If the user picks a variant, **load the matching file from `reference/palettes/`** before generating the deck. The variant file contains the palette tokens and signature visual moves that override the defaults.

> **Style previews:** If the user includes `--preview` in their request, generate mini-preview files (one title slide per option) in `.claude-design/slide-previews/` so they can compare in the browser. See README.md for details.

---

## Phase 3: Generate Presentation

Generate the full presentation based on content and chosen theme.

### Architecture

Follow the complete HTML/CSS/JS template in `reference/html-template.md`. Every presentation includes:

- **Theme system** — oklch color variables for both dark and light modes, switchable via `data-theme` attribute
- **Scale-factor typography** — `clamp()` with CSS custom property multipliers for responsive sizing
- **Viewport fitting base styles** — Mandatory CSS from `reference/style-presets.md`
- **Theme toggle** — Fixed button (top-right) switching dark/light, persisted in sessionStorage
- **Admin panel** — On-the-fly typography controls (see below)
- **Slide controller** — Keyboard, touch, and scroll-snap navigation
- **Intersection Observer** — Scroll-triggered `.reveal` animations
- **Progress bar and nav dots** — Visual navigation aids

### Admin Panel

Every presentation includes the admin panel for on-the-fly typography adjustment. Presentations are frequently shown on varying projectors and screens where font sizes need real-time tweaking — the admin panel makes this painless.

See `reference/style-presets.md` Admin Panel section for the complete implementation (Popover API + CSS Anchor Positioning, range inputs for global and per-variable scale factors, sessionStorage persistence).

### Suggested: Custom Illustrations

After generating slides, offer to create custom illustrations that match the BC aesthetic. This works with any image generation tool.

Ask: "Would you like custom illustrations for any of your slides? I can help craft image prompts for icons, hero visuals, or diagrams in a clean, hand-drawn style that matches the BC brand."

See `reference/image-prompting-for-slides.md` for prompt templates and style guidance.

### Code Quality

**Comments:** Every CSS/JS section should have clear comments explaining what it does and how to modify it.

**Accessibility:** Semantic HTML, keyboard navigation, ARIA labels, reduced motion support, WCAG AA contrast.

**CSS gotcha:** Never negate CSS functions directly — `-clamp()` is silently ignored. Always use `calc(-1 * clamp(...))`.

### Post-Generation Checklist

Before delivering, verify:
- [ ] Every slide fits within viewport (no overflow)
- [ ] Theme toggle switches correctly between dark/light
- [ ] Admin panel opens and adjusts typography
- [ ] Keyboard navigation works (arrows, space)
- [ ] Animations trigger on scroll
- [ ] Content density limits respected
- [ ] Code is well-commented

---

## Phase 4: Export to PPTX

When the user wants to share slides via Google Slides, email, or in contexts where HTML isn't practical.

### How It Works

Run `scripts/export_to_pptx.py` which parses the structured HTML and rebuilds it as PPTX using BeautifulSoup + python-pptx. See `reference/html-to-pptx-export.md` for color/font mapping tables and details on what transfers.

### What Transfers
- Text content (headings, body, lists)
- Slide structure and ordering
- Images (extracted and embedded)
- BC brand colors (oklch approximated as hex fallbacks)

### What Doesn't Transfer
- CSS animations (PPTX has its own animation system)
- oklch colors (converted to hex approximations)
- Google Fonts (replaced with system font fallbacks: Georgia, Calibri)
- Complex CSS layouts (simplified to PPTX-native layouts)
- Theme toggle and admin panel (PPTX is static)

### Limitations Note

The PPTX export preserves content and approximate styling, but the full visual experience lives in the HTML version. The export is best for sharing content, not recreating the design.

---

## Phase 5: Delivery

### Final Output

When the presentation is complete:

1. **Clean up** — Delete `.claude-design/slide-previews/` if it exists

2. **Open the presentation** — Use `open [filename].html` to launch in browser

3. **Provide summary:**
```
Your presentation is ready!

File: [filename].html
Theme: [BC Maroon / BC Cream]
Slides: [count]

Navigation:
- Arrow keys or Space to navigate
- Scroll/swipe also works
- Click the dots on the right to jump to a slide
- Toggle button (top-right) switches light/dark mode
- Settings gear (top-right) opens typography controls

To customize colors: Look for [data-theme] CSS variables at the top
To change fonts: Update the Google Fonts link

Would you like me to make any adjustments?
```

4. **Offer export** — "Would you like a PPTX version for Google Slides or email? I can export this presentation."

---

## Style Reference: Effect to Feeling Mapping

Use this guide to match animations to intended feelings:

### Sophisticated / Confident (BC Maroon default)
- Slow fade-ins (0.8-1.2s)
- Subtle scale transitions (0.95 to 1)
- Dark backgrounds with warm accent lighting
- Gold accent borders and dividers
- Generous whitespace

### Warm / Approachable (BC Cream default)
- Medium-speed animations (0.5-0.8s)
- Gentle slide-up entrances
- Cream backgrounds with maroon typography
- Editorial feel with strong type hierarchy
- Soft gold highlights on interactive elements

### Teaching / Workshop
- Clear, readable animations (0.4-0.6s)
- Numbered section indicators
- Feature grids for comparing concepts
- Pull quotes for key takeaways
- Minimal decoration — content-first

### Formal / Keynote
- Dramatic, slow reveals (1-1.5s)
- Full-viewport title slides
- Minimal bullet points — one idea per slide
- Bold maroon accents
- Cinematic transitions

---

## Animation Patterns Reference

See `reference/style-presets.md` for complete animation CSS. Quick reference:

### Entrance Animations
- **Fade + Slide Up** (default) — `.reveal` class
- **Scale In** — `.reveal-scale` class
- **Slide from Left** — `.reveal-left` class
- **Blur In** — `.reveal-blur` class

### Background Effects
- **Gradient Mesh** — Soft radial gradients using oklch accent colors
- **Subtle Noise** — Inline SVG noise texture for warmth
- **Grid Pattern** — Fine lines for structure (dark theme only)

### Stagger Timing
- Children of `.reveal` auto-stagger via `nth-child` transition delays (0.1s increments)

---

## DO NOT USE (Generic AI Patterns)

Avoid generic AI design defaults: Inter/Roboto fonts, indigo/purple gradients, true black (#000000), everything-centered layouts, gratuitous glassmorphism, clickbait/hyperbolic headings. See `reference/style-presets.md` for the full list and the Common Layout Fixes section for centering patterns.

---

## Troubleshooting

**Fonts not loading:** Check Google Fonts URL and font-family names in CSS.

**Animations not triggering:** Verify Intersection Observer is running and `.visible` class is being added to slides.

**Theme toggle not working:** Verify `data-theme` attribute is on `<html>` element and CSS custom properties are scoped to `[data-theme="dark"]` and `[data-theme="light"]`.

**Scroll snap not working:** Ensure `scroll-snap-type` on html and `scroll-snap-align: start` on each slide.

**Mobile issues:** Test touch events, verify `100dvh` support, check toggle button is reachable on small screens.

**Admin panel not opening:** Verify Popover API support (Chrome 114+, Firefox 125+, Safari 17+). Check `popovertarget` attribute and anchor positioning.

**Viewport overflow:** See the Overflow Prevention Checklist in `reference/style-presets.md`. When content doesn't fit, split into multiple slides.

---

## Integration Notes

This skill works well alongside:

- **`workshop-slides`** — Creates workshop outlines with talking points, timing, and facilitator notes. Feed this output directly into bc-slide-design as Mode A (content-ready).
- **`generating-images`** — Generate custom illustrations for slides. See `reference/image-prompting-for-slides.md` for prompt templates matched to the BC aesthetic.
- **Content from planning files** — Markdown outlines, structured notes, or any content prepared in the vault.

---

## Example Session Flows

### Content-Ready (Primary)
1. User shares outline or content (from workshop-slides, planning file, etc.)
2. Skill detects Mode A, proceeds to theme selection
3. User picks BC Maroon or BC Cream
4. Skill generates full presentation with admin panel + all features
5. User reviews, requests adjustments
6. Final presentation delivered

### Build from Scratch
1. User: "I need a presentation about AI literacy for faculty"
2. Skill asks about purpose, length, content readiness
3. User collaborates on outline
4. Theme selection → generation → delivery

### Export
1. User: "Can you export that presentation as a PowerPoint?"
2. Skill runs the PPTX export on the existing HTML
3. Delivers both HTML (full experience) and PPTX (for sharing)
