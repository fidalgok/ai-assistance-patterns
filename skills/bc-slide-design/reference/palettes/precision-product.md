---
version: 1.0
name: Precision Product
description: Variant palette for tech-focused BC decks — AI tooling demos, product walkthroughs, code-heavy talks. Borrows the editorial DNA of the AI Foundations landing pages. Cream/paper surface, IBM Plex–driven, italic-with-color-accent on display headings. Inherits all typography roles, spacing, motion, and components from `DESIGN.md`.
parent: ../../DESIGN.md
overrides: palettes
palettes:
  precision-product:
    bg-primary: "oklch(0.985 0.005 80)"
    bg-secondary: "oklch(0.96 0.008 75)"
    bg-surface: "oklch(1 0 0)"
    bg-band: "oklch(0.94 0.012 80)"
    text-primary: "oklch(0.20 0.020 230)"
    text-secondary: "oklch(0.42 0.025 230)"
    text-muted: "oklch(0.58 0.018 230)"
    accent: "oklch(0.50 0.085 50)"
    accent-hover: "oklch(0.45 0.090 50)"
    accent-secondary: "oklch(0.45 0.155 25)"
    accent-secondary-hover: "oklch(0.40 0.160 25)"
    accent-glow: "oklch(0.50 0.085 50 / 0.10)"
    border: "oklch(0.90 0.012 75)"
    border-subtle: "oklch(0.94 0.008 78)"
    toggle-bg: "oklch(0.96 0.008 75)"
    toggle-border: "oklch(0.88 0.012 75)"
    font-display: "'IBM Plex Serif', Georgia, serif"
    font-body: "'IBM Plex Sans', system-ui, sans-serif"
    font-mono: "'JetBrains Mono', ui-monospace, monospace"
signature:
  italic-with-accent: "Display headings often include an italicized word in {accent-secondary} for emphasis (e.g., 'Build your AI <em>foundations</em>.')"
  hairline-cards: "1px solid {border}, no left-rule by default. Optional very-soft shadow `0 1px 2px oklch(0.20 0.020 230 / 0.06)`"
  section-bands: "Quiet tinted backgrounds ({bg-band}) for section breaks instead of horizontal rules"
  pull-quote-moment: "Standalone pull quotes get oversized italic display type, gold open-quote glyph"
  eyebrow-treatment: "Same as default — uppercase {accent-secondary}, but tracking 0.14em (slightly tighter than 0.18em default)"
  number-mark: "Section/card numbering uses small serif § or roman numerals in {accent}, not bold sans"
---

# Precision Product (Variant)

A clean, restrained palette for tech-focused BC decks — AI tooling demos, product walkthroughs, code-heavy talks. Borrows directly from the AI Foundations landing-page mocks: cream surface, italic-with-color-accent on display headings, hairline-bordered cards, quiet tinted section bands.

This is a **variant**, not a replacement. It overrides only the `palettes` block of the root `DESIGN.md`. All typography roles (`title`, `h2`, `h3`, `subtitle`, `body`, `small`), spacing tokens, motion timings, and component contracts inherit from the root unchanged.

## When to Reach for This

| Use Precision Product when… | Use BC Maroon/Cream when… |
|-----------------------------|---------------------------|
| Demoing AI tools, code, or product UI | Teaching, workshops, framework talks |
| Audience is technical or product-curious | Audience is faculty, learners, mixed |
| The deck has live screens, terminal output, or product simulations | The deck is mostly typography and frameworks |
| You want the deck to feel like a thoughtful product page | You want the deck to feel like a BC presentation |

If the talk content sits squarely in BC's institutional register — workshop, faculty meeting, leadership presentation — stay with the default palettes. Precision Product is for the moments when "BC presentation" would be the wrong frame for the room.

## Visual Register

The reference for this palette is the AI Foundations landing pages: warm cream surfaces, IBM Plex Sans body, IBM Plex Serif (or Newsreader-style serif) display, italic emphasis with a single colored word, hairline 1px borders on cards, soft-tinted section bands for breaks instead of horizontal rules.

The accent system is muted on purpose — burnt-gold and BC-maroon-base, not the lifted maroon and brightened gold of the dark theme. On a cream surface, lifted accents look loud. Restrained accents read as confident.

### Signature Moves

**Italic-with-accent display headings.** This is the defining visual move borrowed from the AI Foundations landing pages. Display headings frequently italicize one word and tint it `accent-secondary`:

```html
<h1>Build your AI <em>foundations</em>.</h1>
<h2>Learning AI <em>shouldn't</em> be complicated.</h2>
```

```css
h1 em, h2 em {
    font-style: italic;
    color: var(--accent-secondary);
    font-weight: inherit;
}
```

Use sparingly — once or twice in a deck. Loses meaning if every heading does it.

**Section bands instead of rules.** Replace gold horizontal rules between sections with full-bleed tinted bands using `--bg-band`. Reads cleaner on the cream surface than a thin line.

```css
.section-band {
    background: var(--bg-band);
    border-top: 1px solid var(--border);
    border-bottom: 1px solid var(--border);
    margin: 0 calc(-1 * var(--slide-padding));
    padding: var(--slide-padding);
}
```

**Hairline cards, soft shadow.** Drop the 2px left-accent-rule from the default card spec. Use a 1px border on all sides plus an extremely soft shadow:

```css
.card {
    border: 1px solid var(--border);
    box-shadow: 0 1px 2px oklch(0.20 0.020 230 / 0.06);
    /* drop: border-left: 2px solid var(--accent); */
}
```

**Pull-quote with serif open-quote glyph.** Standalone pull quotes use oversized italic display type with a large gold open-quote character above:

```html
<section class="pull-quote">
    <span class="open-quote">"</span>
    <p>The quote text in italic display type.</p>
    <p class="attribution">— Source</p>
</section>
```

**Italic Newsreader-style ornamentation.** Captions, micro-labels, and "in the wild" attributions use italic body-serif style — small `subtitle` size, italic, `text-secondary`. Gives the deck the feel of an editorial product page rather than a slide deck.

## Typography Notes

The variant uses IBM Plex (Sans + Serif) instead of Cormorant Garamond / DM Sans / Fraunces / Work Sans. The type roles in `DESIGN.md` are unchanged — only the families swap.

```html
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;600&family=IBM+Plex+Serif:ital,wght@0,400;0,500;0,600;1,400;1,500&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
```

The serif face's italic axis is what unlocks the italic-with-accent move — IBM Plex Serif's italic is distinctive enough to read as deliberate emphasis without looking like a system-default italic.

## Implementation Hook

When generating a Precision Product deck, the theme block in the HTML uses a different `data-theme` attribute value to avoid colliding with the dark/light toggle:

```html
<html lang="en" data-theme="precision">
```

```css
[data-theme="precision"] {
    --bg-primary: oklch(0.985 0.005 80);
    /* ... full palette from frontmatter above ... */
    --font-display: 'IBM Plex Serif', Georgia, serif;
    --font-body: 'IBM Plex Sans', system-ui, sans-serif;
}
```

The theme toggle button can be **disabled** for Precision Product decks — the variant doesn't have a paired dark mode in this version. Hide the toggle:

```css
[data-theme="precision"] .theme-toggle { display: none; }
```

The admin panel stays on. Typography scaling matters more on tech-focused decks because they often run on conference-room projectors with weird aspect ratios.

## What Stays the Same

Everything below the palette block:

- Type roles, scale architecture, role-to-use mapping (see `DESIGN.md` and `reference/type-hierarchy.md`)
- Spacing scale (8px base, slide-padding, content-gap)
- Radii (xs through full)
- Motion timings and easing
- Component contracts (title-slide, eyebrow, lead, bullet-list, three-col, four-col)
- Viewport-fitting CSS, scroll-snap, slide controller, admin panel
- Animation classes (`.reveal`, `.reveal-scale`, `.reveal-left`, `.reveal-blur`)
- Density limits per slide type

The variant is a palette swap with three signature moves on top — not a different design system.

## What Doesn't Belong Here

- Don't use the BC Maroon `accent-secondary` lifted gold here. Stay with the burnt-gold (`oklch(0.50 0.085 50)`) — it's quieter, fits cream backgrounds.
- Don't add purple/blue gradients trying to look "tech-y." That's the generic AI default we explicitly avoid in `DESIGN.md`.
- Don't combine this palette with the dark theme on the same deck. Variant decks are single-mode.
