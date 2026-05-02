---
version: 1.0
name: BC Slide Design
description: Default design language for BC slide decks — tokens, palettes, typography, components. The two default palettes (BC Maroon dark / BC Cream light) live here. Variant palettes (Precision Product, future additions) live as separate resources in `reference/palettes/`.
palettes:
  bc-maroon-dark:
    bg-primary: "oklch(0.15 0.005 60)"
    bg-secondary: "oklch(0.20 0.008 60)"
    bg-surface: "oklch(0.25 0.010 60)"
    text-primary: "oklch(0.93 0.010 80)"
    text-secondary: "oklch(0.70 0.015 70)"
    text-muted: "oklch(0.55 0.010 65)"
    accent: "oklch(0.662 0.184 24.782)"
    accent-hover: "oklch(0.72 0.170 25)"
    accent-secondary: "oklch(0.835 0.074 80)"
    accent-secondary-hover: "oklch(0.88 0.065 80)"
    accent-glow: "oklch(0.662 0.184 24.782 / 0.20)"
    border: "oklch(0.30 0.010 60)"
    border-subtle: "oklch(0.22 0.005 60)"
    toggle-bg: "oklch(0.25 0.010 60)"
    toggle-border: "oklch(0.35 0.010 60)"
    font-display: "'Cormorant Garamond', Georgia, serif"
    font-body: "'DM Sans', system-ui, sans-serif"
    font-mono: "'JetBrains Mono', ui-monospace, monospace"
    source-hex:
      bc-maroon-base: "#8A100B"
      bc-maroon-lifted: "#C03020"
      bc-gold-base: "#B29D6C"
      bc-gold-lifted: "#D4C08A"
      bg-charcoal-feel: "#262320"
      note: "Brand anchors are #8A100B (BC Maroon) and #B29D6C (BC Gold). Lifted variants are perceptual derivations for readable contrast on dark surfaces — not in the BC brand palette officially, but used here for accessibility."
  bc-cream-light:
    bg-primary: "oklch(0.97 0.008 80)"
    bg-secondary: "oklch(0.94 0.010 75)"
    bg-surface: "oklch(0.99 0.005 80)"
    text-primary: "oklch(0.22 0.010 60)"
    text-secondary: "oklch(0.45 0.015 60)"
    text-muted: "oklch(0.60 0.012 65)"
    accent: "oklch(0.35 0.170 25)"
    accent-hover: "oklch(0.40 0.160 25)"
    accent-secondary: "oklch(0.70 0.085 80)"
    accent-secondary-hover: "oklch(0.65 0.090 80)"
    accent-glow: "oklch(0.35 0.170 25 / 0.10)"
    border: "oklch(0.88 0.012 75)"
    border-subtle: "oklch(0.92 0.008 78)"
    toggle-bg: "oklch(0.93 0.008 80)"
    toggle-border: "oklch(0.85 0.012 75)"
    font-display: "'Fraunces', Georgia, serif"
    font-body: "'Work Sans', system-ui, sans-serif"
    font-mono: "'JetBrains Mono', ui-monospace, monospace"
    source-hex:
      bc-maroon-base: "#8A100B"
      bc-gold-base: "#B29D6C"
      bg-cream-feel: "#F7F3ED"
      bg-linen-feel: "#EDE5D8"
      text-ink-feel: "#3A3530"
      note: "Brand anchors used at base hue on the cream surface — no lifting needed. Surface and text values are perceptual derivations of the BC editorial register."
typography:
  scale-architecture: "clamp(min, calc(vw * per-role-scale * font-scale), calc(rem * per-role-scale * font-scale))"
  global-scale-var: "--font-scale"
  per-role-scale-vars: ["--title-scale", "--h2-scale", "--h3-scale", "--subtitle-scale", "--body-scale", "--small-scale"]
  type-roles:
    title:
      var: "--title-size"
      preferred-vw: 6
      max-rem: 6.5
      min-rem: 2
      use: "Title slide H1, occasional hero text"
    h2:
      var: "--h2-size"
      preferred-vw: 3.5
      max-rem: 3.5
      min-rem: 1.25
      use: "Section/slide heading"
    h3:
      var: "--h3-size"
      preferred-vw: 2.2
      max-rem: 2
      min-rem: 1
      use: "Card title, sub-section heading"
    subtitle:
      var: "--subtitle-size"
      preferred-vw: 1.8
      max-rem: 1.6
      min-rem: 0.875
      use: "Lead paragraph below H2; primary bullet content"
    body:
      var: "--body-size"
      preferred-vw: 1.25
      max-rem: 1.4
      min-rem: 0.8
      use: "Card body, paragraph text, secondary bullet content"
    small:
      var: "--small-size"
      preferred-vw: 0.95
      max-rem: 1.15
      min-rem: 0.65
      use: "Eyebrows, captions, mono labels, footers"
spacing:
  base: 8px
  slide-padding: "clamp(1.5rem, 4vw, 4rem)"
  content-gap: "clamp(1rem, 2vw, 2rem)"
  element-gap: "clamp(0.5rem, 1.2vw, 1rem)"
radii:
  xs: 2px
  sm: 4px
  md: 8px
  lg: 14px
  xl: 22px
  full: 999px
motion:
  ease: "cubic-bezier(0.16, 1, 0.3, 1)"
  duration-quick: 0.4s
  duration-normal: 0.6s
  duration-slow: 0.9s
components:
  title-slide:
    layout: "grid; grid-template-rows: 1fr auto 1fr"
    centering: "ALL content centered by default — `align-items: center` on `.slide-center`"
    structure: "eyebrow → h1 → gold-rule → subtitle → footer (in 3rd row)"
  eyebrow:
    role: "Small uppercase label above a heading. Establishes section/topic."
    typography: "{type-roles.small}"
    color: "{accent-secondary}"
    treatment: "uppercase, letter-spacing 0.18em, weight 500"
  h2:
    role: "Slide heading"
    typography: "{type-roles.h2}"
    color: "{text-primary}"
    family: "{font-display}"
    centering: "text-align: center by default unless layout requires otherwise"
  lead:
    role: "Quieter intro paragraph below an H2. Always one rung quieter than the primary content above it."
    typography: "{type-roles.subtitle}"
    color: "{text-secondary}"
    max-width: "60ch"
  bullet-list-primary:
    role: "Bullet list when bullets ARE the primary content of the slide"
    typography: "{type-roles.subtitle}"
    color: "{text-primary}"
    marker: "horizontal gold rule, 12px wide, accent-secondary"
    when-to-use: "Slide 5-style — bullets are the meat; nothing on the slide outweighs them"
  bullet-list-secondary:
    role: "Bullet list when bullets support a heading or live inside a card"
    typography: "{type-roles.body}"
    color: "{text-primary}"
    marker: "same horizontal gold rule"
    when-to-use: "Inside cards, beneath dense headings, secondary lists below a primary visual"
  card-bordered:
    role: "Default content card"
    background: "{bg-surface}"
    border: "1px {border}"
    accent-rule: "2px {accent} on left edge"
    radius: "{radii.sm}"
    padding: "clamp(0.85rem, 1.6vw, 1.5rem)"
  three-col:
    role: "Three-column equal grid for cards or columns"
    columns: "repeat(3, 1fr)"
    gap: "clamp(0.75rem, 1.5vw, 1.5rem)"
    collapse-at: "max-width 900px → 1fr"
  four-col:
    role: "Four-column equal grid for orientation/landscape slides"
    columns: "repeat(4, 1fr)"
    gap: "clamp(0.75rem, 1.5vw, 1.25rem)"
    collapse-at: "max-width 900px → 1fr"
---

# BC Slide Design

This is the design contract every BC deck inherits by default. The frontmatter above is machine-readable — when generating a new deck, treat those values as authoritative tokens. The prose below explains the *why* and *when* so you can apply the contract well, not just literally.

For variant palettes (Precision Product, etc.), see `reference/palettes/`. Variants override the `palettes` block of this DESIGN.md but keep typography, spacing, motion, and components consistent unless they explicitly say otherwise.

---

> **Spec compatibility note.** This file draws inspiration from the [Google Labs DESIGN.md spec](https://github.com/google-labs-code/design.md) (alpha) but extends it deliberately for slide-design work. The spec assumes a single product UI; we ship a family of palettes with inheritance. The spec is hex-only; we use oklch so that perceptual lifts (e.g., BC Maroon `0.41 → 0.662` on dark backgrounds) carry the *reasoning* with the value. The spec's typography schema describes per-role font properties; we encode a runtime scale-factor architecture so the admin panel can rescale every role at presentation time. The spec's component properties are universal (`backgroundColor`, `textColor`, `padding`, etc.); ours are domain-specific (`centering`, `marker`, `when-to-use`, `accent-rule`). Where deliberate, our divergences are documented as token-level extensions: `palettes`, `parent`, `overrides`, `source-hex`, `modes`, `signature`, `type-roles`. Read this file as a slide-design dialect of the spec — the section order is canonical (Overview → Colors → Typography → Layout → Elevation & Depth → Shapes → Components → Motion → Do's and Don'ts → Variant Palettes appendix), but the token vocabulary is ours.

---

## Overview

BC Slide Design is the design language for slide decks generated by the `bc-slide-design` skill. The register is **warm, editorial, BC-credible** — it should feel like a thoughtful BC publication that happens to be a slide deck, not a generic conference template wearing BC colors.

**Audience.** BC faculty, staff, and learners; mixed technical backgrounds; institutional and external audiences. The default palettes carry BC identity; variant palettes carry register shifts (tutorial energy, engineering register, formal-tech, refined editorial) for moments when BC's institutional voice is the wrong frame.

**Anchors.**
- Warmth over coolness. No true black. No pure white. No indigo/purple gradients.
- Negative space and large type do the heavy work. Decoration is the exception, not the rule.
- One palette per deck — pick before generating, carry through every slide.
- Frontmatter tokens are normative; prose explains the why and the when.

**Source of truth.** This file (DESIGN.md) for the default palettes; `reference/palettes/<variant>.md` for variants; `reference/type-hierarchy.md` for type-role rules; `reference/style-presets.md` for component CSS recipes.

---

## Colors

### BC Maroon (Dark)

**Vibe:** Sophisticated, confident, premium.

**Best for:** Keynotes, formal presentations, evening events, "this is a serious talk" framing. The default for high-stakes settings where you want negative space and warmth to do the heavy lifting.

**Backgrounds are warm dark grays — never true black.** True black is a generic AI defect; BC's warmth comes from the slight amber tilt in the dark surfaces (oklch hue ~60).

**Maroon and gold are lifted for contrast** on the dark background. The base brand maroon (`oklch(0.41 0.155 29)`) is too dark to read on a dark surface; we lift to `oklch(0.662 0.184 24.782)` for WCAG-compliant contrast without losing identity.

**Signature elements:**
- Thin gold accent rules (1–2px) as section dividers
- Subtle warm gradient mesh on title slides only
- Maroon left- or top-borders on cards
- Gold for nav-dot active state and progress bar

### BC Cream (Light)

**Vibe:** Warm, approachable, editorial, inviting.

**Best for:** Workshops, team meetings, daytime teaching sessions, training modules. When you want the room to feel like an open notebook rather than a stage.

**Backgrounds are warm creams — never pure white.** Same principle: cream avoids the SaaS-template feel and signals BC's editorial register.

**Maroon stays at its base hue** (`oklch(0.35 0.170 25)`) on the light surface — no lifting needed. Body text lands on warm dark ink (`oklch(0.22 0.010 60)`), again avoiding true black.

**Signature elements:**
- Strong type hierarchy with Fraunces display + Work Sans body
- Thin gold horizontal rules between sections
- Soft card shadows tinted with warm dark ink (`oklch(0.22 0.010 60 / 0.06)`)
- Gold for bullet markers, slide numbers, subtle highlights

### Brand Anchor Reference

| Color | oklch (base) | oklch (dark theme — lifted) | Role |
|-------|-------------|-----------------------------|------|
| BC Maroon | `oklch(0.41 0.155 29)` | `oklch(0.662 0.184 24.782)` | Primary accent |
| BC Gold | `oklch(0.70 0.070 87)` | `oklch(0.835 0.074 80)` | Secondary accent |

Base values match the brand hex (`#8A100B`, `#B29D6C`). Dark-theme values are perceptually-lifted variants for readable contrast on dark surfaces.

---

## Typography

The typography system uses a **scale-factor architecture** so the admin panel can rescale every type role at runtime, on whatever projector the deck ends up on.

```
clamp(min, calc(vw * per-role-scale * font-scale), calc(rem * per-role-scale * font-scale))
```

**Critical:** both the preferred (vw) AND max (rem) values must be scaled. On laptop screens (1280–1920px), the vw value is what `clamp()` resolves to — scaling only the max has no visible effect on desktop. The frontmatter `typography.scale-architecture` field documents this.

### Type Role Mapping (the bullet lesson, codified)

The most common slide-design failure is using the wrong type role for the wrong job. Use this table:

| Role | Use when… | Don't use when… |
|------|-----------|-----------------|
| `title` | Title slide H1, hero moment | Anywhere in body content |
| `h2` | Slide heading | Inside a card |
| `h3` | Card title, sub-section | As a slide heading |
| `subtitle` | Lead text below H2; **primary bullet content** | Footers, captions |
| `body` | Card body, paragraph text; **secondary bullet content** | Slide-defining bullets |
| `small` | Eyebrow, caption, mono label, footer | Anything readers need to land on |

**The critical rule:** if bullets are the primary content of the slide (no card, no diagram, no other element competing for attention), they use `subtitle` size — *not* `body`. The lead paragraph below them, if any, also uses `subtitle` but in `text-secondary` color. Same size, lower color weight = bullets win attention without size inflation.

If bullets sit inside a card or beneath a primary visual, they drop to `body` size. They're supporting cast.

See `reference/type-hierarchy.md` for worked examples and edge cases.

---

## Layout

**Slide model:** every `.slide` is one viewport (`100vh`/`100dvh`), `overflow: hidden`, scroll-snap-locked. Content overflowing a slide is the single most common visual defect. The fix is *always* to split into multiple slides — never to add scrolling.

**Spacing:** 8px base. Use `clamp()` for all spacing so the system scales with viewport. Never hardcode `px` for padding or gaps unless the value must be exact (1px borders, fixed-pixel toggle button sizes).

**Reading column:** body content should sit near 60ch max-width for prose comfort. Slide-content wrappers cap around 1200px to keep heading widths readable on wide displays.

**Centering:**
- **Title slides** center *all* content by default. `align-items: center` on `.slide-center` is a default, not a per-deck fix. Headings, subtitles, gold rules, eyebrows — all centered.
- **Content slide H2s** are `text-align: center` by default unless the slide layout calls for left alignment (left-aligned body lists, two-column layouts).
- See `reference/style-presets.md` Common Layout Fixes for the title-slide grid pattern.

**Density limits:**

| Slide Type | Maximum Content |
|------------|-----------------|
| Title | 1 heading + 1 subtitle + optional eyebrow |
| Content | 1 heading + 4–6 bullets (max 2 lines each) |
| Feature grid | 1 heading + 6 cards (3×2 or 2×3) |
| Code | 1 heading + 8–10 lines of code |
| Quote | 1 quote (max 3 lines) + attribution |

When in doubt, split.

---

## Elevation & Depth

BC decks favor **warm hairline borders and subtle shadows over heavy depth**.

- Default card: 1px `border` + 2px `accent` left-rule. No shadow.
- Elevated card (light theme only): add `box-shadow: 0 2px 12px oklch(0.22 0.010 60 / 0.06)`.
- Title slides may layer two soft radial gradients (maroon glow + gold glow at low opacity) for atmospheric warmth.

Avoid:
- Drop shadows that read as "AI default" — heavy blur, dark semi-transparent black, no warmth.
- Glassmorphism / backdrop-blur on content panels. Reserve `backdrop-filter` for overlay UI like the presenter notes drawer.
- Stacked card-in-card. Use unframed sections or full-width bands instead.

---

## Shapes

| Use | Radius |
|-----|--------|
| Buttons, inputs, mono chips | `sm` (4px) |
| Cards, surfaces | `sm`–`md` (4–8px) |
| Pills, chaos-tags | `full` (999px) |
| Toggle/admin buttons | `full` |
| Large media sheets, lesson panels (rare in slides) | `xl` (22px) |

**Stay tight by default.** Slide cards default to `sm` (4px), not `md` (8px). Slides have less ambient warmth than product UIs — large radii read as decorative.

---

## Components

The frontmatter `components` block is the authoritative contract for slide components. Each entry maps a name to its layout, type role, color tokens, and behavior. Treat those values as load-bearing — they encode lessons learned, not stylistic preferences.

**Components currently codified:**

| Component | What it codifies |
|-----------|-----------------|
| `title-slide` | 3-row grid layout, default `align-items: center` on `.slide-center` so all title content centers without per-deck fixes |
| `eyebrow` | Small uppercase label above headings — `small` type role, accent-secondary color, 0.18em tracking, weight 500 |
| `h2` | Slide heading — `h2` type role, primary text color, display family, centered by default |
| `lead` | Quieter intro paragraph below an H2 — `subtitle` type role, secondary text color, capped at 60ch |
| `bullet-list-primary` | Bullets that ARE the slide's content — `subtitle` size in primary color (the default) |
| `bullet-list-secondary` | Bullets that support a heading or live in a card — `body` size, primary color |
| `card-bordered` | Default content card — `bg-surface` fill, 1px border, 2px accent left-rule, `radii.sm` radius |
| `three-col`, `four-col` | Equal-column grids that collapse to 1fr below 900px |

**Where to look for what.**

- For the *value* of a token (color, size, radius, etc.), consult the frontmatter of this file or the matching variant in `reference/palettes/`.
- For the *decision tree* on which type role to use (the most common slide-design failure mode), see `reference/type-hierarchy.md`.
- For the *CSS recipe* that implements a component (selectors, modifiers, responsive breakpoints), see `reference/style-presets.md` — particularly the Common Layout Fixes section for title-slide centering and bullet-list sizing.

**Component property vocabulary (extension over spec).** Components in this DESIGN.md use property names like `centering`, `marker`, `when-to-use`, `accent-rule`, `collapse-at`. These are slide-design-specific extensions — the Google Labs spec accepts only universal product-UI properties (`backgroundColor`, `textColor`, `padding`, etc.). Our extended vocabulary is by design: a slide component encodes layout intent and behavioral rules, not just styling. Tools that lint against the spec will warn on these properties; that warning is expected and not a defect.

---

## Motion

Animations should help the eye land on something. They are not decoration.

| Effect | Class | Use for |
|--------|-------|---------|
| Fade + slide up | `.reveal` | Default content entrance |
| Scale in | `.reveal-scale` | Cards, stats |
| Slide from left | `.reveal-left` | Diagram nodes, sequence steps |
| Blur in | `.reveal-blur` | Hero/title moments |

**Stagger:** children of `.reveal-children` auto-stagger via `nth-child` delays (0.15s increments). Cap at 6–8 children before staggering becomes its own distraction.

**Transition timing:** use `--ease-out-expo` (`cubic-bezier(0.16, 1, 0.3, 1)`) for everything. It's the BC house easing — confident decel without bounce.

**Respect `prefers-reduced-motion`:** every animation block must include a `@media (prefers-reduced-motion: reduce)` override.

---

## Do's and Don'ts

**Do**
- Pick one palette before generating; carry it through every slide.
- Respect type roles. If bullets are primary content, give them `subtitle` size.
- Center title-slide content by default — top to bottom.
- Split slides when content overflows. Never scroll.
- Keep the admin panel and theme toggle on every deck.

**Don't**
- Use Inter, Roboto, Arial, or system fonts as display.
- Use indigo/purple gradients, true black, or pure white.
- Nest cards inside cards.
- Write clickbait or hyperbolic headings ("The Trick That Changes Everything," "Game-Changing"). Educational content earns its own weight.
- Mix palettes within a single deck unless the user explicitly asks for comparison variants.

---

## Variant Palettes

*Appendix — deliberately positioned after the canonical Do's and Don'ts so this DESIGN.md reads as a self-contained contract for the default palettes, with variants treated as opt-in extensions.*

For decks where the default BC dark/light register is wrong, see `reference/palettes/`.

Variants override the `palettes` block of this DESIGN.md. They keep typography roles, spacing, motion, and component contracts consistent unless explicitly noted. A variant file lives at `reference/palettes/<variant-name>.md` and follows the same frontmatter shape as this file's `palettes` block, plus its own prose section explaining when to reach for it.

Currently available variants:

- **Precision Product** (`reference/palettes/precision-product.md`) — Light. Clean, IBM Plex–driven palette for tech demos and AI tooling. Borrows the editorial DNA of the AI Foundations landing pages: cream surface, hairline-bordered cards, italic-with-color-accent on display headings.
- **Playful Teacher** (`reference/palettes/playful-teacher.md`) — Light. Cloud-blue surface with Fraunces display + Work Sans body. Sky panels, berry/lemon accents in small confident moves. For tutorial decks, hands-on lessons, classroom explainers.
- **Tactile Media** (`reference/palettes/tactile-media.md`) — Dark. Forest-green surface with bone-white text and vivid acid-green accent. Heavy condensed display (Archivo Black). For engineering retros, product team reviews, creative-media work.
- **Midnight Studio** (`reference/palettes/midnight-studio.md`) — Dark. Very deep blue-black surface with imperceptible royal-blue radial gradient, white-ink body, single yellow-orange accent (#fccd08). Single-family typography (Prompt) for monolithic reading. For policy frameworks, AI strategy, formal-tech decks.
- **Phthalo Editorial** (`reference/palettes/phthalo-editorial.md`) — Light + Dark. Phthalo green and antique gold over cream/linen, Cormorant Garamond + Jost. The dark mode inverts phthalo from accent to surface. Refined editorial register with italic-with-color-accent emphasis, wide-tracked eyebrows, and a 2px "grout line" between cards. For book launches, gallery openings, lux brand presentations. Two-mode (toggle stays enabled).
