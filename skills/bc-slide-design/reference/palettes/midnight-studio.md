---
version: 1.0
name: Midnight Studio
description: Variant palette for formal-tech decks — policy frameworks, investor-style talks, AI strategy presentations, and high-stakes "in the dark room" moments. Very deep blue-black surface with a barely-perceptible royal-blue radial gradient at center, white ink text, single yellow-orange accent (#fccd08). Inherits typography roles, spacing, motion, and components from `DESIGN.md`.
parent: ../../DESIGN.md
overrides: palettes
palettes:
  midnight-studio:
    bg-primary: "oklch(0.10 0.020 270)"
    bg-secondary: "oklch(0.13 0.025 270)"
    bg-surface: "oklch(0.15 0.030 270)"
    bg-radial-center: "oklch(0.20 0.090 265)"
    text-primary: "oklch(0.99 0.003 270)"
    text-secondary: "oklch(0.78 0.012 270)"
    text-muted: "oklch(0.58 0.015 270)"
    accent: "oklch(0.86 0.165 90)"
    accent-hover: "oklch(0.81 0.160 88)"
    accent-secondary: "oklch(0.72 0.135 85)"
    accent-secondary-hover: "oklch(0.67 0.135 85)"
    accent-glow: "oklch(0.86 0.165 90 / 0.18)"
    border: "oklch(0.22 0.030 270)"
    border-subtle: "oklch(0.16 0.025 270)"
    toggle-bg: "oklch(0.18 0.030 270)"
    toggle-border: "oklch(0.28 0.030 270)"
    font-display: "'Prompt', system-ui, sans-serif"
    font-body: "'Prompt', system-ui, sans-serif"
    font-mono: "'JetBrains Mono', ui-monospace, monospace"
  source-hex:
    accent-source: "#fccd08"
    bg-base-feel: "near-black with imperceptible blue cast"
    font-family-source: "Prompt (Google Fonts) — used for both display and body. Hierarchy comes from weight contrast, not family contrast."
signature:
  imperceptible-radial: "Each slide carries a very subtle radial gradient centered on the slide — deep royal blue at center fading to near-black at edges. The gradient should be almost imperceptible — depth, not pattern."
  yellow-as-singular-accent: "{accent} (#fccd08) is the only accent. No secondary accent color competes. Used for headlines emphasis, key terms, slide-number marks, and the gold-rule under titles."
  white-ink: "Body text is near-pure white ({text-primary}). The only deviation from full white is a sub-1% cool cast for the eye's comfort on saturated dark backgrounds."
  one-family-weight-contrast: "Prompt (Google Fonts) for ALL text — display, body, captions. Hierarchy is communicated by weight contrast (700/600 for display, 400/500 for body, 300 for very small captions), not by switching families. The deck reads as deliberately monolithic."
  thin-yellow-rule: "A 1.5px yellow rule under titles or as a section divider — the deck's quiet identity mark"
  no-card-shadows: "Cards are flat with 1px {border}. The dark surface and bright text give plenty of contrast; shadows would muddy the register."
---

# Midnight Studio (Variant)

A formal, confident dark palette for the moments when a deck needs to feel weighty without feeling institutional. Very deep blue-black surface with an imperceptibly subtle royal-blue radial centered on each slide. White ink text. One accent color — a saturated yellow-orange (#fccd08) — used sparingly. Geometric Space Grotesk display.

The reference is the BC Law AI Course Policy Frameworks deck shown in the source image. The register is "policy talk in a dark room": serious, modern, deliberate, with one bright accent that lands every time it appears.

This is a **variant**, not a replacement. It overrides only the `palettes` block of the root `DESIGN.md`. All typography roles, spacing tokens, motion timings, and component contracts inherit unchanged.

## When to Reach for This

| Use Midnight Studio when… | Use BC Maroon / Tactile Media when… |
|---------------------------|-------------------------------------|
| Policy frameworks, governance, AI strategy | Institutional formal address (BC Maroon) |
| Investor-style or board-style presentation | Engineering retro or product team review (Tactile) |
| AI/tech topic but the room is leadership, not engineering | Audience is the team that built the work (Tactile) |
| You want a single bright accent to land hard | You want warm BC identity to do the work (Maroon) |
| The deck will be shown in a dark room | The deck will be shown in a daytime workshop |

Midnight Studio is what BC Maroon would be if it were less institutional and more contemporary. It's the right palette when the *content* is technical or strategic but the *room* is formal.

## Visual Register

The defining feature is the **imperceptible radial gradient**. The slide is *not* a flat dark background — it has a very faint royal-blue center that fades to near-black at the edges. Most viewers won't consciously register the gradient. They'll just feel the slide has depth and presence. That's the point.

The yellow-orange accent (`oklch(0.86 0.165 90)` ≈ #fccd08) is the deck's only color signal. Headlines emphasize one word in yellow; titles get a thin yellow rule below them; slide numbers and key terms in body copy use yellow. There is no secondary accent color. The whole deck holds together because of that restraint.

### Signature Moves

**The imperceptible radial gradient.** Apply to every slide via a pseudo-element so it doesn't interfere with content z-index. Tune the opacity and softness until you can barely see it — that's the right setting.

```css
.slide {
    background: var(--bg-primary);
    position: relative;
    isolation: isolate;
}

.slide::before {
    content: '';
    position: absolute;
    inset: 0;
    background: radial-gradient(
        ellipse 65% 75% at 50% 50%,
        oklch(0.20 0.090 265 / 0.55) 0%,
        oklch(0.16 0.060 268 / 0.30) 30%,
        transparent 65%
    );
    pointer-events: none;
    z-index: -1;
}
```

If the gradient reads as obviously "there," reduce the center alpha to 0.40. The test: someone glancing at the slide for two seconds should *not* notice a gradient — they should just feel the slide has a center of gravity.

**Yellow as singular accent.** One yellow moment per slide is ideal; two is the upper bound. Resist the urge to use yellow for "decoration."

```html
<h2>Lawyers are <em>responsible</em> for verifying AI output.</h2>
```

```css
h1 em, h2 em {
    color: var(--accent);
    font-style: normal;
    font-weight: inherit;
}
```

**Thin yellow rule under titles.** A 1.5px yellow rule under H1 or H2 gives the deck a recurring identity mark. Width: ~80px on title slides, full-content-width on content slides.

```css
.title-rule {
    height: 1.5px;
    background: var(--accent);
    width: 80px;
    margin: clamp(0.75rem, 1.5vw, 1.25rem) auto;
}
```

**White-ink body.** Text is near-pure white (`oklch(0.99 0.003 270)`). Don't dim it for "softness" — on this saturated dark surface, full-white reads as deliberate and confident, not harsh. Secondary text drops to `text-secondary` (light cool gray); muted captions to `text-muted`.

**Yellow slide-number mark.** The bottom-right slide number renders as a yellow `#` glyph followed by the number — small, mono font, low-key but always present. Quiet identity move borrowed from the source deck.

```html
<span class="slide-number"><span class="hash">#</span>03</span>
```

```css
.slide-number {
    position: absolute;
    bottom: clamp(1rem, 2vw, 1.5rem);
    right: clamp(1rem, 2vw, 1.5rem);
    font-family: var(--font-mono);
    font-size: var(--small-size);
    color: var(--text-muted);
}
.slide-number .hash { color: var(--accent); }
```

**Flat surfaces, no shadows.** Cards have a 1px `border` and zero shadow. The dark-on-light contrast is more than enough depth; shadows muddy the register.

## Typography Notes

**Prompt** (Google Fonts) for *everything* — display, body, captions. Prompt is a geometric sans family with weights from 100 to 900. The variant uses weight contrast within a single family to do the work that family contrast does in other palettes.

| Role | Weight | Notes |
|------|--------|-------|
| Title (H1) | 700 | Slight negative letter-spacing (-0.01em) |
| H2 | 600 | |
| H3 | 600 | |
| Eyebrow | 500 | Uppercase, 0.14em tracking |
| Body / bullets | 400 | |
| Lead | 400 | Color carries the contrast — same weight as body |
| Small / captions | 300–400 | Use 300 only at small sizes for "in the wild" labels |

The single-family rule is part of the variant's identity. The deck reads as monolithic and intentional — not as a collection of typographic decisions. Don't reach for a serif body or a contrasting display family; Prompt's weight range covers the full hierarchy.

```html
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
```

JetBrains Mono stays only for slide-number marks and any code/data — even the `#` glyph in the slide-number can use Prompt if you prefer to be strict about single-family.

Don't add italic emphasis. Prompt italic exists but isn't distinctive enough at heading scale, and the variant's identity already comes from the yellow accent + dark gradient. Keep display upright.

## Implementation Hook

```html
<html lang="en" data-theme="midnight">
```

```css
[data-theme="midnight"] {
    --bg-primary: oklch(0.10 0.020 270);
    --bg-radial-center: oklch(0.20 0.090 265);
    /* ... full palette from frontmatter above ... */
    --font-display: 'Prompt', system-ui, sans-serif;
    --font-body: 'Prompt', system-ui, sans-serif;
}

[data-theme="midnight"] .slide::before {
    /* ... radial gradient implementation, see Signature Moves above ... */
}
```

The theme toggle is **disabled** for Midnight Studio — the variant is dark-only. (A pairing light variant is not in scope; the deck's identity is the dark gradient.)

The admin panel stays on. Dark decks shown on conference projectors often need the title size pushed up at runtime; the panel makes that painless.

## What Stays the Same

- Type roles, scale architecture (see `DESIGN.md` and `reference/type-hierarchy.md`)
- Spacing scale (8px base)
- Motion timings and easing
- Component contracts (title-slide, eyebrow, lead, bullet-list, three-col, four-col)
- Viewport-fitting CSS, scroll-snap, slide controller, admin panel
- Animation classes
- Density limits per slide type

## What Doesn't Belong Here

- **Don't make the radial gradient visible.** If you can see it on first glance, dial it back. Subtle to the point of imperceptible is the goal.
- **Don't introduce a secondary accent color.** Yellow is alone. Adding orange, teal, or any other accent breaks the deck's identity.
- **Don't use italics, drop shadows, or glows.** The palette is restrained. Decorative effects read as undercutting the formal register.
- **Don't dim white text.** Full-white body text is intentional. Reducing to cream or off-white reads as compromise; the deck loses its presence.
- **Don't combine with BC Maroon's lifted gold.** The yellow here is more saturated and less warm. Mixing them produces a deck that looks confused about which palette it wants to be.
- **Don't use this in a sunlit room.** The deep dark surface and yellow accent are calibrated for projection in dim/dark spaces. Daytime workshops should default to BC Cream.
- **Don't pair Prompt with another display family for "variety."** The single-family weight-contrast rule is the variant's typographic identity. Mixing in a serif or different sans turns the deck into a generic dark theme.
