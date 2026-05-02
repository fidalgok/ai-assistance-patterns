---
version: 1.0
name: Tactile Media
description: Variant palette for product, engineering, and creative-media decks. Deep forest-green surface, bone-white text, vivid acid-green accent. Bold condensed display type. Built for technical demos, engineering retros, product reviews, and image-led media talks where confidence and contrast matter more than warmth. Inherits typography roles, spacing, motion, and components from `DESIGN.md`.
parent: ../../DESIGN.md
overrides: palettes
palettes:
  tactile-media:
    bg-primary: "oklch(0.18 0.030 145)"
    bg-secondary: "oklch(0.22 0.035 145)"
    bg-surface: "oklch(0.24 0.040 145)"
    bg-band: "oklch(0.14 0.025 145)"
    text-primary: "oklch(0.96 0.008 100)"
    text-secondary: "oklch(0.78 0.015 100)"
    text-muted: "oklch(0.62 0.020 105)"
    accent: "oklch(0.93 0.220 122)"
    accent-hover: "oklch(0.88 0.215 122)"
    accent-secondary: "oklch(0.65 0.135 130)"
    accent-secondary-hover: "oklch(0.60 0.135 130)"
    accent-glow: "oklch(0.93 0.220 122 / 0.20)"
    border: "oklch(0.32 0.040 145)"
    border-subtle: "oklch(0.24 0.035 145)"
    toggle-bg: "oklch(0.24 0.040 145)"
    toggle-border: "oklch(0.34 0.040 145)"
    font-display: "'Archivo Black', 'Arial Black', sans-serif"
    font-body: "'Space Grotesk', system-ui, sans-serif"
    font-mono: "'JetBrains Mono', ui-monospace, monospace"
signature:
  acid-as-spotlight: "{accent} (acid green) used as the single high-contrast spotlight per slide — never decorative"
  square-labels: "Acid-green labels and chips use {radii.xs} (2px) — almost-square edges, terminal-like"
  condensed-bold-display: "Display type is heavy condensed grotesque — Archivo Black or similar — at large scale, with negative letter-spacing"
  hairline-rule-acid: "1px {accent} rule under section eyebrows, full-width or short — the deck's recurring identity mark"
  no-shadows: "Flat surfaces only. Depth comes from the color jump between {bg-primary} and {accent}, not from shadow tricks."
  monospace-data: "Stats, version numbers, timestamps, and labels use {font-mono} — reinforces the engineering register"
---

# Tactile Media (Variant)

A confident dark palette for product, engineering, and creative-media decks. Deep forest-green surface, bone-white text, vivid acid-green accent, and heavy condensed display type. Built for the moments when slides need to look like the work the team is doing — technical, opinionated, in motion — rather than like a presentation about that work.

This is a **variant**, not a replacement. It overrides only the `palettes` block of the root `DESIGN.md`. All typography roles, spacing tokens, motion timings, and component contracts inherit unchanged.

## When to Reach for This

| Use Tactile Media when… | Use Precision Product / Midnight Studio when… |
|-------------------------|-----------------------------------------------|
| Engineering retro, post-mortem, system review | Tech demo with audience that's not the engineering team |
| Product launch deck for an internal team | Product launch deck for external/leadership |
| Creative review of media work, video, podcast | Pitch deck or formal presentation |
| You want the slides to feel like the codebase | You want the slides to feel like the company |

If the audience is broader than the people who built the thing, default to Precision Product or Midnight Studio. Tactile Media is for the room that already speaks the work's vocabulary — and rewards tight, confident slides that don't pad themselves.

## Visual Register

Forest-green-near-black surface — earthy, technical, unmistakably *not* a generic dark theme. Bone-white type lifts cleanly off it with full WCAG-AA contrast. Acid-green accent does *one job per slide*: it spotlights the single thing that matters. Heavy condensed display type lets headings carry weight without taking many lines.

### Signature Moves

**Acid-green as a single-element spotlight, not decoration.** Use `accent` for exactly one element per slide: the headline word, the metric that moved, the term being defined. If two things are green, neither is special.

```html
<h2>Latency dropped by <em>62%</em>.</h2>
```

```css
h1 em, h2 em {
    color: var(--accent);
    font-style: normal;
    font-weight: inherit;
}
```

**Square labels and chips.** Acid-green labels use `radii.xs` (2px) — almost square. Reads as terminal/IDE, not as a marketing pill.

```css
.tactile-label {
    background: var(--accent);
    color: oklch(0.18 0.030 145);            /* dark forest text on acid green */
    padding: 0.4em 0.7em;
    border-radius: var(--radius-xs);
    font-family: var(--font-mono);
    font-size: var(--small-size);
    text-transform: uppercase;
    letter-spacing: 0.06em;
    font-weight: 500;
}
```

**Hairline acid rules under eyebrows.** A 1px acid-green rule under each section eyebrow becomes the deck's recurring identity mark. Short (60–80px) or full-bleed depending on the slide's mood.

```css
.eyebrow {
    color: var(--accent);
    font-family: var(--font-mono);
    font-size: var(--small-size);
    text-transform: uppercase;
    letter-spacing: 0.12em;
    padding-bottom: 0.5em;
    border-bottom: 1px solid var(--accent);
    width: fit-content;
}
```

**Condensed bold display.** Headings use Archivo Black (or system Arial Black) at large scale with slightly negative letter-spacing. The weight is the point — the text is meant to *land*, not whisper.

```css
h1, h2 {
    font-family: var(--font-display);
    font-weight: 900;
    letter-spacing: -0.02em;
    line-height: 0.96;
    text-transform: none;     /* the weight does the work; uppercase is overkill */
}
```

**Monospace for data.** Stats, version numbers, timestamps, file paths, hashes — anything that's a *fact* — uses the mono font. Reinforces the engineering register and quietly improves alignment in tables.

```css
.stat-number, .version, .timestamp, code, kbd {
    font-family: var(--font-mono);
}
```

**Flat surfaces, no shadows.** Cards have a 1px `border` and zero shadow. The color jump between the deep forest background and the acid-green accent is enough depth.

```css
.card {
    background: var(--bg-surface);
    border: 1px solid var(--border);
    box-shadow: none;
}
```

## Typography Notes

**Archivo Black** for display — heavy condensed grotesque, on Google Fonts, gives the deck its weight. **Space Grotesk** for body — geometric, technical, complements the display without competing. **JetBrains Mono** for data and code.

```html
<link href="https://fonts.googleapis.com/css2?family=Archivo+Black&family=Space+Grotesk:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
```

The `Archivo Black` family has only one weight (900) — that's intentional. If you need a lighter heading, use `Space Grotesk 700` instead. Don't reach for a different display family.

## Implementation Hook

```html
<html lang="en" data-theme="tactile">
```

```css
[data-theme="tactile"] {
    --bg-primary: oklch(0.18 0.030 145);
    /* ... full palette from frontmatter above ... */
    --font-display: 'Archivo Black', 'Arial Black', sans-serif;
    --font-body: 'Space Grotesk', system-ui, sans-serif;
    --radius-card: var(--radius-xs);   /* squarer cards reinforce the register */
}
```

The theme toggle is **disabled** for Tactile Media — the variant is dark-only in this version. (A bone/light variant is possible — bone background + tactile-black text + acid for accents — but is not in scope yet.)

## What Stays the Same

- Type roles, scale architecture (see `DESIGN.md` and `reference/type-hierarchy.md`)
- Spacing scale (8px base)
- Motion timings and easing
- Component contracts (title-slide, eyebrow, lead, bullet-list, three-col, four-col)
- Viewport-fitting CSS, scroll-snap, slide controller, admin panel
- Animation classes
- Density limits per slide type

## What Doesn't Belong Here

- **Don't put acid green on more than one thing per slide.** The whole register depends on the spotlight rule.
- **Don't add gradients, glows, or backdrop-blurs.** The palette is intentionally flat. Glow effects read as "AI default."
- **Don't soften the corners.** Square-leaning radii and heavy display type are the register's identity. Rounded everything turns this into a generic dark theme.
- **Don't use this for institutional, faculty-facing, or warm-tone presentations.** Default to BC Cream or AI Foundations Editorial when the room expects warmth, not confidence.
- **Don't pair Archivo Black with a serif body.** The grotesque-grotesque pairing is the point. Serif body undercuts the engineering feel.
