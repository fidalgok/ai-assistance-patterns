---
version: 1.0
name: Phthalo Editorial
description: Variant palette for refined editorial decks — book-launch energy, gallery openings, lux brand presentations, BC moments that want a quieter alternative to maroon. Phthalo green and antique gold over cream/linen, with Cormorant Garamond display + Jost body. Available in two modes (light and dark) — the dark mode inverts phthalo from accent to surface. Inherits typography roles, spacing, motion, and components from `DESIGN.md`.
parent: ../../DESIGN.md
overrides: palettes
modes: ["phthalo-light", "phthalo-dark"]
palettes:
  phthalo-light:
    bg-primary: "oklch(0.95 0.010 80)"
    bg-secondary: "oklch(0.91 0.018 78)"
    bg-surface: "oklch(0.97 0.005 80)"
    bg-band: "oklch(0.91 0.018 78)"
    text-primary: "oklch(0.22 0.003 0)"
    text-secondary: "oklch(0.46 0.014 70)"
    text-muted: "oklch(0.58 0.014 70)"
    accent: "oklch(0.32 0.075 158)"
    accent-hover: "oklch(0.39 0.080 158)"
    accent-secondary: "oklch(0.71 0.105 80)"
    accent-secondary-hover: "oklch(0.66 0.105 80)"
    accent-glow: "oklch(0.32 0.075 158 / 0.10)"
    border: "oklch(0.86 0.020 78)"
    border-subtle: "oklch(0.91 0.015 78)"
    toggle-bg: "oklch(0.91 0.018 78)"
    toggle-border: "oklch(0.84 0.022 78)"
    font-display: "'Cormorant Garamond', Georgia, serif"
    font-body: "'Jost', system-ui, sans-serif"
    font-mono: "'JetBrains Mono', ui-monospace, monospace"
  phthalo-dark:
    bg-primary: "oklch(0.32 0.075 158)"
    bg-secondary: "oklch(0.39 0.080 158)"
    bg-surface: "oklch(0.36 0.078 158)"
    bg-band: "oklch(0.28 0.070 158)"
    text-primary: "oklch(0.95 0.010 80)"
    text-secondary: "oklch(0.83 0.080 88)"
    text-muted: "oklch(0.74 0.030 80)"
    accent: "oklch(0.71 0.105 80)"
    accent-hover: "oklch(0.76 0.105 80)"
    accent-secondary: "oklch(0.83 0.080 88)"
    accent-secondary-hover: "oklch(0.87 0.080 88)"
    accent-glow: "oklch(0.71 0.105 80 / 0.18)"
    border: "oklch(0.42 0.075 158)"
    border-subtle: "oklch(0.36 0.072 158)"
    toggle-bg: "oklch(0.36 0.078 158)"
    toggle-border: "oklch(0.46 0.075 158)"
    font-display: "'Cormorant Garamond', Georgia, serif"
    font-body: "'Jost', system-ui, sans-serif"
    font-mono: "'JetBrains Mono', ui-monospace, monospace"
source-hex:
  phthalo-green: "#0D3D2A"
  phthalo-mid: "#155237"
  antique-gold: "#C4A35A"
  champagne: "#E2C98A"
  cream: "#F7F2EA"
  linen: "#EDE5D8"
  charcoal: "#1E1E1E"
  warm-gray: "#6B6255"
  source: "Adapted from the Emma Aesthetics style guide (`personal-projects/emma-aesthetics/style-guide.md`). Brand-agnostic in this variant — same color logic, generalized for BC slide work."
signature:
  italic-with-color-accent: "Cormorant Garamond italic is the variant's signature move. Italic emphasis word in display headings tints {accent} (light mode) or {accent-secondary} (dark mode) — never both at once on the same slide."
  wide-tracked-eyebrows: "Eyebrow labels use Jost 400, uppercase, letter-spacing 0.25–0.30em — noticeably wider than the default 0.18em. Communicates the editorial register on first glance."
  grout-line-cards: "Card grids use a 2px gap (not the default content-gap) — creates a magazine-spread 'grout line' effect. Visual signature of the lux register."
  editorial-line-height: "Display H1/H2 use line-height 1.05–1.15. Body uses 1.7–1.9 (more generous than default 1.45). Patient, readable, unhurried."
  signature-italic-footer: "Title slides may close with a single italicized signature line in {accent-secondary} — borrowed from the source style guide's 'signature' element. Once per deck max, on the title slide only."
  no-shadows: "Both modes use flat surfaces with hairline borders. No drop shadows. Editorial palettes earn depth through type and color, not effects."
  thin-gold-rule: "1px {accent-secondary} (gold) rule under titles, between sections, or as a closing mark. Width: 60–80px on title slides, full-content-width on content slides. Same in both modes."
---

# Phthalo Editorial (Variant)

A refined editorial palette for the moments when a deck wants the quietness of a book launch or gallery opening more than the institutional voice of BC Maroon. Phthalo green and antique gold over cream/linen, with Cormorant Garamond display and Jost body — the same family that powers BC Cream, but tuned for a register where green replaces maroon as the anchor color.

This is the only variant in `reference/palettes/` with **two modes**: a light mode (cream surface with phthalo as accent) and a dark mode (phthalo as surface with cream/gold as text). The inversion is the variant's whole point — Kyle requested both so the variant can be used as either a "soft luxury cream" or a "bold lux green" depending on the room.

This is a **variant**, not a replacement. It overrides only the `palettes` block of the root `DESIGN.md`. All typography roles, spacing tokens, motion timings, and component contracts inherit unchanged.

## When to Reach for This

| Use Phthalo Editorial when… | Use BC Cream / BC Maroon when… |
|----------------------------|--------------------------------|
| Refined-luxury register — book launch, gallery, lux brand | Standard BC institutional voice |
| The deck wants editorial elegance over institutional gravity | The deck needs unmistakable BC identity |
| Audience is design-aware, brand-aware, aesthetically attuned | Audience is faculty, staff, mixed-experience |
| Presentation about literature, design, hospitality, art, food | Presentation about policy, teaching, framework |
| You want green + gold as the anchor pair | You want maroon + gold as the anchor pair |

If the room expects BC's institutional voice, default to BC Maroon or BC Cream. Phthalo Editorial is for talks where the *content* warrants warmth and refinement and BC identity is secondary or absent.

## Mode Selection

**Phthalo Light** — Cream surface, phthalo green as the primary accent (CTAs, emphasis, headlines), antique gold for eyebrows, dividers, and small detail work. Reads as "linen-and-letterpress." Best for daytime decks, workshops where the room is bright, and content that wants to feel like a magazine spread.

**Phthalo Dark** — Phthalo green as the primary surface, cream as text, antique gold and champagne as accent and emphasis. Reads as "candlelight and brass." Best for evening events, dim rooms, talks where the deck should feel like a private dinner more than a meeting.

The variant supports a **theme toggle between the two modes** (unlike other variants, which are single-mode). The toggle button stays enabled, switching between `data-theme="phthalo-light"` and `data-theme="phthalo-dark"`. Type roles, components, and the signature moves apply identically in both modes — only the surface/text relationship inverts.

## Visual Register

Both modes share the same DNA: Cormorant Garamond display, Jost body, antique gold detail work, italic-with-accent emphasis, wide-tracked uppercase eyebrows, generous line-heights, hairline borders, no shadows. The variant feels like a magazine spread that happens to be a slide deck.

### Signature Moves

**Italic-with-accent in Cormorant.** The italic axis of Cormorant Garamond is genuinely beautiful and is the variant's defining move. Headlines emphasize one word in italic, tinted by the appropriate accent for the active mode.

```html
<h1>Made <em>by hand</em>, with attention.</h1>
<h2>An <em>editorial</em> approach to AI.</h2>
```

```css
[data-theme="phthalo-light"] h1 em,
[data-theme="phthalo-light"] h2 em {
    font-style: italic;
    color: var(--accent);                 /* phthalo green on cream */
    font-weight: inherit;
}

[data-theme="phthalo-dark"] h1 em,
[data-theme="phthalo-dark"] h2 em {
    font-style: italic;
    color: var(--accent-secondary);       /* champagne on phthalo */
    font-weight: inherit;
}
```

Use sparingly. One italic-with-accent moment per slide is the rule.

**Wide-tracked eyebrows.** Eyebrow labels use Jost 400, uppercase, letter-spacing 0.25–0.30em. Noticeably wider than the default 0.18em. The wide tracking is a fingerprint of the editorial register — readers feel it before they read it.

```css
.eyebrow {
    font-family: var(--font-body);
    font-size: var(--small-size);
    font-weight: 400;
    text-transform: uppercase;
    letter-spacing: 0.28em;
    color: var(--accent-secondary);    /* gold in both modes */
}
```

**Grout-line card grids.** Card grids in this variant use a **2px gap** (not the default `content-gap`). The thin gap creates a magazine-spread "grout line" effect — cards read as panels in a layout, not as separate components.

```css
.three-col, .four-col {
    gap: 2px;
}

.card {
    border-radius: var(--radius-xs);   /* 2px — almost square in this variant */
    border: 1px solid var(--border);
}
```

This is the most distinctive layout move of the variant. Use it on at least one card-grid slide so the register registers.

**Generous editorial line-heights.** Display headings use 1.05–1.15. Body and bullet text use 1.7–1.9 (well above the default 1.45). The deck reads slow on purpose.

```css
h1, h2 { line-height: 1.08; }
h3 { line-height: 1.2; }
p, ul.bullet-list li { line-height: 1.8; }
```

**Thin gold rule.** A 1px antique-gold rule under titles or between sections — 60–80px wide on title slides, full-content-width on content slides. The deck's recurring identity mark.

```css
.title-rule {
    height: 1px;
    background: var(--accent-secondary);
    width: 80px;
}
```

**Signature italic footer (title slide only).** The source style guide includes a "signature" element — a single italicized line that signs off the page. On title slides, you may close with a one-line italic in `accent-secondary`, like a calligraphic signature at the bottom of an invitation. Use once per deck. On the title slide only. Don't repeat the move on content slides.

```html
<p class="signature">— a quiet evening on AI literacy</p>
```

```css
.signature {
    font-family: var(--font-display);
    font-style: italic;
    font-weight: 300;
    font-size: var(--subtitle-size);
    color: var(--accent-secondary);
}
```

**No shadows.** Both modes use flat surfaces with hairline 1px borders. No drop shadows in either mode. Depth comes from type, color, and the grout-line spacing — not from elevation effects.

## Typography Notes

**Cormorant Garamond** for display, weights 300 and 400 (with italic axis). Light weights and italics are where this face shines — heavier weights start to feel generic. **Jost** for body, weights 300 and 400 — clean geometric sans, pairs cleanly with Cormorant without competing.

```html
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400;1,500&family=Jost:wght@300;400;500&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
```

The display weight rule:

| Role | Family | Weight | Style |
|------|--------|--------|-------|
| Title (H1) | Cormorant Garamond | 300 | Regular or italic-emphasis |
| H2 | Cormorant Garamond | 300 | |
| H3 | Cormorant Garamond | 400 | |
| Eyebrow | Jost | 400 | Uppercase, 0.28em tracking |
| Body | Jost | 300 | |
| Bullets (primary) | Jost | 300 | Subtitle size |
| Bullets (secondary) | Jost | 300 | Body size |
| Lead | Jost | 300 | |
| Signature | Cormorant Garamond | 300 italic | Title slide only |

Lighter weights are deliberate. The variant's elegance comes from restraint — heavy weights would push it toward generic-luxury territory.

## Implementation Hook

```html
<html lang="en" data-theme="phthalo-light">
<!-- or -->
<html lang="en" data-theme="phthalo-dark">
```

```css
[data-theme="phthalo-light"] {
    --bg-primary: oklch(0.95 0.010 80);
    /* ... full light-mode palette from frontmatter ... */
    --font-display: 'Cormorant Garamond', Georgia, serif;
    --font-body: 'Jost', system-ui, sans-serif;
}

[data-theme="phthalo-dark"] {
    --bg-primary: oklch(0.32 0.075 158);
    /* ... full dark-mode palette from frontmatter ... */
    --font-display: 'Cormorant Garamond', Georgia, serif;
    --font-body: 'Jost', system-ui, sans-serif;
}
```

The theme toggle **stays enabled** for this variant — it switches between `phthalo-light` and `phthalo-dark`. The toggle JS pattern from `reference/style-presets.md` works as-is; just swap the data-theme values it cycles between.

The admin panel stays on, as always.

## What Stays the Same

- Type roles, scale architecture (see `DESIGN.md` and `reference/type-hierarchy.md`)
- Spacing scale (8px base) — except card grids, which override to 2px gap
- Motion timings and easing
- Component contracts (title-slide, eyebrow, lead, bullet-list, three-col, four-col)
- Viewport-fitting CSS, scroll-snap, slide controller, admin panel
- Animation classes
- Density limits per slide type

## What Doesn't Belong Here

- **Don't use the BC Maroon accent.** Mixing maroon with phthalo green produces a confused deck. The whole point of this variant is to *not* be BC Maroon.
- **Don't use heavier display weights.** Cormorant 600 and above start to feel generic and undercut the lightness. Stick to 300/400.
- **Don't reach for blush, sky, or any fourth color.** Two accents (phthalo + gold) is the rule. Adding more breaks the editorial discipline.
- **Don't use this variant in a sunlit conference room with the dark mode.** Phthalo dark mode needs ambient dimness to read as elegant; in bright daylight it can feel muddy.
- **Don't pad the slides with decorative ornaments.** The italic-with-accent move and the wide tracking are *the* personality. Adding flourishes (laurels, dividers with curls, decorative initial caps) breaks the register.
- **Don't use the signature italic footer on more than one slide per deck.** It's a closing move on the title slide. Repeating it dilutes the gesture.
