---
version: 1.0
name: Playful Teacher
description: Variant palette for tutorial decks, classroom-friendly explainer slides, hands-on lesson walkthroughs, and onboarding sessions. Cloud-blue page surface, friendly Fraunces display, sky/lemon/berry accents in small confident moves. Inherits all typography roles, spacing, motion, and components from `DESIGN.md`.
parent: ../../DESIGN.md
overrides: palettes
palettes:
  playful-teacher:
    bg-primary: "oklch(0.985 0.012 230)"
    bg-secondary: "oklch(0.96 0.020 225)"
    bg-surface: "oklch(1 0 0)"
    bg-band: "oklch(0.92 0.045 215)"
    text-primary: "oklch(0.18 0.005 0)"
    text-secondary: "oklch(0.42 0.010 250)"
    text-muted: "oklch(0.58 0.012 250)"
    accent: "oklch(0.55 0.265 270)"
    accent-hover: "oklch(0.50 0.260 270)"
    accent-secondary: "oklch(0.62 0.235 5)"
    accent-secondary-hover: "oklch(0.57 0.230 5)"
    accent-tertiary: "oklch(0.95 0.105 100)"
    accent-glow: "oklch(0.55 0.265 270 / 0.12)"
    border: "oklch(0.88 0.025 220)"
    border-subtle: "oklch(0.93 0.018 220)"
    toggle-bg: "oklch(0.96 0.020 225)"
    toggle-border: "oklch(0.88 0.025 220)"
    font-display: "'Fraunces', Georgia, serif"
    font-body: "'Work Sans', system-ui, sans-serif"
    font-mono: "'JetBrains Mono', ui-monospace, monospace"
signature:
  rounded-everything: "Cards use {radii.lg} (14px), pills use {radii.full}. Friendlier shapes than default."
  primary-action-blue: "Strong saturated blue ({accent}) for the most important interactive moments — never berry"
  berry-as-emphasis: "{accent-secondary} (berry/pink) used sparingly for callout highlights and key terms — once or twice per slide max"
  lemon-notes: "{accent-tertiary} (soft lemon) as a sticky-note background for tips, asides, or pull-quotes — feels handwritten"
  sky-panels: "Quiet sky-blue ({bg-band}) for section backgrounds — very low saturation, never competing"
  generous-padding: "Cards use noticeably more internal padding than default (clamp(1.25rem, 2vw, 1.75rem)) — friendlier feel"
---

# Playful Teacher (Variant)

A friendly, classroom-grade palette for tutorial slides, explainer walkthroughs, hands-on lesson decks, and onboarding sessions. The energy is approachable — not childish — with a warm rounded geometry, a confident saturated-blue primary, and small berry/lemon accents that show personality without overwhelming the content.

This is a **variant**, not a replacement. It overrides only the `palettes` block of the root `DESIGN.md`. All typography roles (`title`, `h2`, `h3`, `subtitle`, `body`, `small`), spacing tokens, motion timings, and component contracts inherit from the root unchanged.

## When to Reach for This

| Use Playful Teacher when… | Use BC Cream / Precision Product when… |
|---------------------------|---------------------------------------|
| Tutorial walkthrough or hands-on lesson | Workshop with framework content |
| Audience is mixed-experience, possibly intimidated | Audience is faculty or technical |
| The deck explains *how* to do something | The deck argues *why* or analyzes |
| You want the slides to feel like a friendly textbook | You want the slides to feel like a presentation |

If the talk is heavier on argument or critique than on demonstration, default palettes will read better. Playful Teacher is for the moments when "let me show you" is the right frame.

## Visual Register

The palette draws from the studio system's playful direction — sky, cloud, berry, blue, and lemon — but keeps slide content in mind: bigger type, more whitespace, small confident accent moves rather than decorative flourishes. The page surface is cloud-blue (just a hint warmer than gray-white) so cards and elements lift cleanly.

### Signature Moves

**Saturated blue as the primary action color.** When something is the "click here," "look here," or "this is the headline" — use `accent` blue. Berry is for emphasis *within* content, not for primary actions.

```css
.cta, .primary-action, h1 em.highlight {
    color: var(--accent);
}
```

**Berry pops, used sparingly.** One or two berry moments per slide max — a key term, a pull-quote glyph, an underline. Think "highlighter on important text," not "the brand color."

```html
<h2>Three steps to <em class="berry">working with</em> AI</h2>
```

```css
em.berry {
    color: var(--accent-secondary);
    font-style: normal;
    font-weight: inherit;
}
```

**Lemon sticky-notes for asides.** Tips, pro-tips, "watch out for this" callouts use a lemon-yellow note background that reads as a sticky note attached to the slide.

```css
.lemon-note {
    background: var(--accent-tertiary);
    color: var(--text-primary);
    border-radius: var(--radius-lg);          /* 14px — friendlier */
    padding: clamp(1rem, 1.8vw, 1.25rem) clamp(1.25rem, 2vw, 1.5rem);
    box-shadow: 0 4px 12px oklch(0.18 0.005 0 / 0.08);
    transform: rotate(-0.5deg);                /* very slight tilt */
}
```

Use lemon notes on no more than two slides per deck. They lose meaning if every other slide has one.

**Sky-blue section bands.** Replace gold rules with full-bleed `bg-band` panels for section breaks. The blue tint is barely there but signals "we're moving to a new beat."

```css
.section-band {
    background: var(--bg-band);
    margin: 0 calc(-1 * var(--slide-padding));
    padding: var(--slide-padding);
    border-top: 1px solid var(--border);
    border-bottom: 1px solid var(--border);
}
```

**Friendlier shapes.** Default cards use `radii.lg` (14px) instead of the standard `sm` (4px). Pills and chips use `radii.full`. The deck should feel rounder than a Maroon or Precision Product deck.

```css
.card {
    border-radius: var(--radius-lg);
    padding: clamp(1.25rem, 2vw, 1.75rem);     /* notice the more generous default */
}
```

**No card-on-card.** Tempting in tutorial decks. Resist. Use sky-blue section bands or unframed full-width sections instead.

## Typography Notes

**Fraunces** for display, weight 600–700. The 700 weight has a warmth that fits the friendly register without losing seriousness. **Work Sans** for body — friendly, highly readable, pairs well with Fraunces.

```html
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,500;9..144,600;9..144,700&family=Work+Sans:wght@400;500;600&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
```

The italic axis on Fraunces lets you do italic-with-color emphasis the same way Precision Product does — but here use `accent-secondary` (berry) instead of gold:

```html
<h2>Tools that <em>actually</em> teach.</h2>
```

```css
h1 em, h2 em {
    font-style: italic;
    color: var(--accent-secondary);
    font-weight: inherit;
}
```

## Implementation Hook

```html
<html lang="en" data-theme="playful">
```

```css
[data-theme="playful"] {
    --bg-primary: oklch(0.985 0.012 230);
    /* ... full palette from frontmatter above ... */
    --font-display: 'Fraunces', Georgia, serif;
    --font-body: 'Work Sans', system-ui, sans-serif;
    --radius-card: var(--radius-lg);  /* override card radius for friendlier feel */
}
```

The theme toggle is **disabled** for Playful Teacher decks — the variant is light-only in this version.

The admin panel stays on. Tutorial decks often run in classrooms with varied screens, and the panel makes accommodating that painless.

## What Stays the Same

- Type roles, scale architecture, role-to-use mapping (see `DESIGN.md` and `reference/type-hierarchy.md`)
- Spacing scale (8px base)
- Motion timings and easing
- Component contracts (title-slide, eyebrow, lead, bullet-list, three-col, four-col)
- Viewport-fitting CSS, scroll-snap, slide controller, admin panel
- Animation classes (`.reveal`, `.reveal-scale`, `.reveal-left`, `.reveal-blur`)
- Density limits per slide type

## What Doesn't Belong Here

- **Don't decorate.** No background blobs, no doodles, no illustration ornaments. Personality comes from the color choices and the accent moves, not from cluttering the slide.
- **Don't combine berry and lemon on the same slide unless it's a deliberate spotlight.** Pick one accent per slide.
- **Don't use Comic Sans, rounded display fonts, or anything that signals "kids." This is friendly for adults learning new things — not infantilizing.
- **Don't use this for keynote, formal, or institutional decks.** Default to BC Maroon or BC Cream when the room is more formal than the content.
