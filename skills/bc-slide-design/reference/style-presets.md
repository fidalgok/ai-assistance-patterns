# BC Style Presets Reference

Two curated visual styles for BC Slide Design, built on Boston College's official maroon and gold palette. All colors use the oklch color space. **No true black. Abstract shapes only — no illustrations.**

## Contents

- [Design Principles](#design-principles)
- [Viewport Fitting (Mandatory CSS)](#critical-viewport-fitting-non-negotiable)
- [Theme 1: BC Maroon (Dark)](#theme-1-bc-maroon-dark)
- [Theme 2: BC Cream (Light)](#theme-2-bc-cream-light)
- [Light/Dark Mode Toggle](#lightdark-mode-toggle)
- [Admin Panel (Display Settings)](#admin-panel-display-settings--always-include)
- [Font Pairing Reference](#font-pairing-reference)
- [Animation Reference](#animation-reference)
- [CSS Gotchas](#css-gotchas-common-mistakes)
- [DO NOT USE (Generic AI Patterns)](#do-not-use-generic-ai-patterns)
- [Troubleshooting Viewport Issues](#troubleshooting-viewport-issues)

---

## Design Principles

- **Warm and understated** — Colors should feel inviting, not cold or clinical
- **Minimalistic** — Pleasing accents, selective use of color, generous whitespace
- **On-brand** — BC Maroon and Gold are the anchors; everything else supports them
- **oklch throughout** — Perceptually uniform lightness makes palette construction predictable

### BC Brand Color Anchors (oklch)

| Color | oklch (base) | oklch (dark theme) | Role |
|-------|-------------|-------------------|------|
| BC Maroon | `oklch(0.41 0.155 29)` | `oklch(0.662 0.184 24.782)` | Primary accent (lifted for dark bg readability) |
| BC Gold | `oklch(0.70 0.070 87)` | `oklch(0.835 0.074 80)` | Secondary accent (brightened for dark bg) |

Note: The base oklch values match the brand hex (#8A100B, #B29D6C). On dark backgrounds, lightness is lifted for WCAG-compliant contrast.

---

## CRITICAL: Viewport Fitting (Non-Negotiable)

**Every slide MUST fit exactly in the viewport. No scrolling within slides, ever.**

### Content Density Limits Per Slide

| Slide Type | Maximum Content |
|------------|-----------------|
| Title slide | 1 heading + 1 subtitle |
| Content slide | 1 heading + 4-6 bullets (max 2 lines each) |
| Feature grid | 1 heading + 6 cards (2x3 or 3x2) |
| Code slide | 1 heading + 8-10 lines of code |
| Quote slide | 1 quote (max 3 lines) + attribution |

**Too much content? Split into multiple slides. Never scroll.**

### Required Base CSS (Include in ALL Presentations)

```css
/* ===========================================
   VIEWPORT FITTING: MANDATORY
   Copy this entire block into every presentation
   =========================================== */

/* 1. Lock document to viewport */
html, body {
    height: 100%;
    overflow-x: hidden;
}

html {
    scroll-snap-type: y mandatory;
    scroll-behavior: smooth;
}

/* 2. Each slide = exact viewport height */
.slide {
    width: 100vw;
    height: 100vh;
    height: 100dvh;
    overflow: hidden;
    scroll-snap-align: start;
    display: flex;
    flex-direction: column;
    position: relative;
}

/* 3. Content wrapper */
.slide-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    max-height: 100%;
    overflow: hidden;
    padding: var(--slide-padding);
}

/* 4. Typography — scale-factor architecture.
   CRITICAL: Both preferred (vw) AND max (rem) must be
   multiplied by the scale factors. On laptop screens
   (1280-1920px), the vw value is what clamp() resolves to.
   Scaling only the max has NO visible effect on desktop.
   See the Admin Panel section for the full explanation. */
:root {
    /* Scale factors — adjustable via admin panel or hardcoded */
    --font-scale: 1;       /* Global multiplier: 0.7 to 1.5 */
    --title-scale: 1;      /* Per-variable: 0.5 to 2.0 */
    --h2-scale: 1;
    --h3-scale: 1;
    --subtitle-scale: 1;
    --body-scale: 1;
    --small-scale: 1;

    /* Typography — each scales preferred AND max */
    --title-size: clamp(2rem,
        calc(6vw * var(--title-scale) * var(--font-scale)),
        calc(6.5rem * var(--title-scale) * var(--font-scale)));
    --h2-size: clamp(1.25rem,
        calc(3.5vw * var(--h2-scale) * var(--font-scale)),
        calc(3.5rem * var(--h2-scale) * var(--font-scale)));
    --h3-size: clamp(1rem,
        calc(2.5vw * var(--h3-scale) * var(--font-scale)),
        calc(2.25rem * var(--h3-scale) * var(--font-scale)));
    --subtitle-size: clamp(0.875rem,
        calc(2vw * var(--subtitle-scale) * var(--font-scale)),
        calc(1.8rem * var(--subtitle-scale) * var(--font-scale)));
    --body-size: clamp(0.8rem,
        calc(1.4vw * var(--body-scale) * var(--font-scale)),
        calc(1.6rem * var(--body-scale) * var(--font-scale)));
    --small-size: clamp(0.65rem,
        calc(1vw * var(--small-scale) * var(--font-scale)),
        calc(1.3rem * var(--small-scale) * var(--font-scale)));

    /* Spacing */
    --slide-padding: clamp(1rem, 4vw, 4rem);
    --content-gap: clamp(0.5rem, 2vw, 2rem);
    --element-gap: clamp(0.25rem, 1vw, 1rem);
}

/* 5. Cards/containers use viewport-relative max sizes */
.card, .container, .content-box {
    max-width: min(90vw, 1000px);
    max-height: min(80vh, 700px);
}

/* 6. Lists auto-scale with viewport */
.feature-list, .bullet-list {
    gap: clamp(0.4rem, 1vh, 1rem);
}

.feature-list li, .bullet-list li {
    font-size: var(--body-size);
    line-height: 1.4;
}

/* 7. Grids adapt to available space */
.grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(min(100%, 220px), 1fr));
    gap: clamp(0.5rem, 1.5vw, 1rem);
}

/* 8. Images constrained */
img {
    max-width: 100%;
    max-height: min(50vh, 400px);
    object-fit: contain;
}

/* ===========================================
   RESPONSIVE BREAKPOINTS - Height-based
   =========================================== */

/* Short screens (< 700px height) */
@media (max-height: 700px) {
    :root {
        --slide-padding: clamp(0.75rem, 3vw, 2rem);
        --content-gap: clamp(0.4rem, 1.5vw, 1rem);
        --title-size: clamp(1.25rem, 4.5vw, 2.5rem);
        --h2-size: clamp(1rem, 3vw, 1.75rem);
    }
}

/* Very short (< 600px height) */
@media (max-height: 600px) {
    :root {
        --slide-padding: clamp(0.5rem, 2.5vw, 1.5rem);
        --content-gap: clamp(0.3rem, 1vw, 0.75rem);
        --title-size: clamp(1.1rem, 4vw, 2rem);
        --body-size: clamp(0.7rem, 1.2vw, 0.95rem);
    }

    .nav-dots, .keyboard-hint, .decorative {
        display: none;
    }
}

/* Extremely short - landscape phones (< 500px) */
@media (max-height: 500px) {
    :root {
        --slide-padding: clamp(0.4rem, 2vw, 1rem);
        --title-size: clamp(1rem, 3.5vw, 1.5rem);
        --h2-size: clamp(0.9rem, 2.5vw, 1.25rem);
        --body-size: clamp(0.65rem, 1vw, 0.85rem);
    }
}

/* Narrow screens */
@media (max-width: 600px) {
    :root {
        --title-size: clamp(1.25rem, 7vw, 2.5rem);
    }

    .grid {
        grid-template-columns: 1fr;
    }
}

/* Reduced motion */
@media (prefers-reduced-motion: reduce) {
    *, *::before, *::after {
        animation-duration: 0.01ms !important;
        transition-duration: 0.2s !important;
    }

    html {
        scroll-behavior: auto;
    }
}
```

### Viewport Fitting Checklist

Before finalizing any presentation, verify:

- [ ] Every `.slide` has `height: 100vh; height: 100dvh; overflow: hidden;`
- [ ] All font sizes use `clamp(min, preferred, max)`
- [ ] All spacing uses `clamp()` or viewport units
- [ ] Breakpoints exist for heights: 700px, 600px, 500px
- [ ] Content respects density limits (max 6 bullets, max 6 cards)
- [ ] No fixed pixel heights on content elements
- [ ] Images have `max-height` constraints
- [ ] No negated CSS functions (use `calc(-1 * clamp(...))` not `-clamp(...)`)

---

## Theme 1: BC Maroon (Dark)

**Vibe:** Sophisticated, confident, warm, premium

**Layout:** Centered content on dark warm background. Subtle maroon accent lines and gold highlights. Generous whitespace.

**Typography:**
- Display: `Cormorant Garamond` (500/600) — elegant, editorial serif
- Body: `DM Sans` (400/500) — clean, modern sans-serif

**Colors (oklch):**
```css
[data-theme="dark"] {
    /* Backgrounds — warm dark grays, never true black */
    --bg-primary: oklch(0.15 0.005 60);        /* Deep warm charcoal */
    --bg-secondary: oklch(0.20 0.008 60);       /* Slightly lighter */
    --bg-surface: oklch(0.25 0.010 60);         /* Cards, elevated surfaces */
    --bg-gradient: linear-gradient(
        135deg,
        oklch(0.15 0.005 60) 0%,
        oklch(0.18 0.008 50) 50%,
        oklch(0.15 0.005 60) 100%
    );

    /* Text — warm off-whites */
    --text-primary: oklch(0.93 0.010 80);       /* Main text */
    --text-secondary: oklch(0.70 0.015 70);     /* Subdued text */
    --text-muted: oklch(0.55 0.010 65);         /* Captions, footnotes */

    /* Accents — BC brand (lightness-lifted for dark bg readability) */
    --accent: oklch(0.662 0.184 24.782);        /* BC Maroon (lifted) */
    --accent-hover: oklch(0.72 0.170 25);       /* Maroon hover state */
    --accent-secondary: oklch(0.835 0.074 80);  /* BC Gold (brightened) */
    --accent-secondary-hover: oklch(0.88 0.065 80);
    --accent-glow: oklch(0.662 0.184 24.782 / 0.20); /* Maroon glow */

    /* Borders & dividers */
    --border: oklch(0.30 0.010 60);
    --border-subtle: oklch(0.22 0.005 60);

    /* Toggle button */
    --toggle-bg: oklch(0.25 0.010 60);
    --toggle-border: oklch(0.35 0.010 60);
}
```

**Signature Elements:**
- Thin gold accent lines (1-2px) as section dividers
- Subtle warm gradient mesh background (radial gradients in oklch)
- Maroon accent on card left-borders or top-borders
- Gold for slide numbers and navigation dot highlights
- No heavy drop shadows — use subtle `oklch` border or glow instead

**Background Pattern (optional):**
```css
/* Subtle warm gradient mesh for title slides */
.title-slide::before {
    content: '';
    position: absolute;
    inset: 0;
    background:
        radial-gradient(ellipse at 20% 80%, oklch(0.662 0.184 24.782 / 0.06) 0%, transparent 50%),
        radial-gradient(ellipse at 80% 20%, oklch(0.835 0.074 80 / 0.04) 0%, transparent 50%);
    pointer-events: none;
}
```

---

## Theme 2: BC Cream (Light)

**Vibe:** Warm, approachable, editorial, inviting

**Layout:** Centered content on warm cream background. Maroon typography with gold accents. Clean editorial hierarchy.

**Typography:**
- Display: `Fraunces` (600/700) — distinctive, warm serif with optical size axis
- Body: `Work Sans` (400/500) — friendly, highly readable sans-serif

**Colors (oklch):**
```css
[data-theme="light"] {
    /* Backgrounds — warm creams, never pure white */
    --bg-primary: oklch(0.97 0.008 80);         /* Warm cream */
    --bg-secondary: oklch(0.94 0.010 75);       /* Slightly darker */
    --bg-surface: oklch(0.99 0.005 80);         /* Cards, elevated surfaces */
    --bg-gradient: linear-gradient(
        135deg,
        oklch(0.97 0.008 80) 0%,
        oklch(0.95 0.012 78) 50%,
        oklch(0.97 0.008 80) 100%
    );

    /* Text — dark warm tones, never true black */
    --text-primary: oklch(0.22 0.010 60);       /* Main text */
    --text-secondary: oklch(0.45 0.015 60);     /* Subdued text */
    --text-muted: oklch(0.60 0.012 65);         /* Captions, footnotes */

    /* Accents — BC brand */
    --accent: oklch(0.35 0.170 25);             /* BC Maroon */
    --accent-hover: oklch(0.40 0.160 25);       /* Maroon hover state */
    --accent-secondary: oklch(0.70 0.085 80);   /* BC Gold */
    --accent-secondary-hover: oklch(0.65 0.090 80);
    --accent-glow: oklch(0.35 0.170 25 / 0.10); /* Subtle maroon tint */

    /* Borders & dividers */
    --border: oklch(0.88 0.012 75);
    --border-subtle: oklch(0.92 0.008 78);

    /* Toggle button */
    --toggle-bg: oklch(0.93 0.008 80);
    --toggle-border: oklch(0.85 0.012 75);
}
```

**Signature Elements:**
- Strong type hierarchy — large Fraunces headings, comfortable Work Sans body
- Horizontal rules using gold accent (thin, elegant)
- Maroon for headings and key callouts
- Gold for bullets, numbering, and subtle highlights
- Soft card shadows using oklch:
  ```css
  box-shadow: 0 2px 12px oklch(0.22 0.010 60 / 0.06);
  ```
- Optional geometric accent shapes (circles, lines) in muted gold

**Background Pattern (optional):**
```css
/* Subtle noise texture for warmth */
.slide::before {
    content: '';
    position: absolute;
    inset: 0;
    opacity: 0.03;
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E");
    pointer-events: none;
}
```

---

## Light/Dark Mode Toggle

Both themes include a toggle button that switches between BC Maroon (dark) and BC Cream (light) on the fly.

### Toggle CSS
```css
/* ===========================================
   THEME TOGGLE BUTTON
   Small, elegant, unobtrusive. Top-right corner.
   =========================================== */
.theme-toggle {
    position: fixed;
    top: clamp(0.75rem, 2vw, 1.5rem);
    right: clamp(0.75rem, 2vw, 1.5rem);
    z-index: 1000;
    background: var(--toggle-bg);
    border: 1px solid var(--toggle-border);
    border-radius: 999px;
    width: 40px;
    height: 40px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1rem;
    line-height: 1;
    transition: all 0.3s ease;
    opacity: 0.6;
    color: var(--text-secondary);
}

.theme-toggle:hover {
    opacity: 1;
    transform: scale(1.1);
    border-color: var(--accent-secondary);
}

.theme-toggle:focus-visible {
    outline: 2px solid var(--accent-secondary);
    outline-offset: 2px;
}

/* Hide on very short screens */
@media (max-height: 500px) {
    .theme-toggle { display: none; }
}
```

### Toggle JavaScript
```javascript
class ThemeToggle {
    constructor() {
        this.html = document.documentElement;
        this.btn = document.querySelector('.theme-toggle');
        this.icon = this.btn.querySelector('.toggle-icon');
        // Restore saved preference, or fall back to default
        this.current = sessionStorage.getItem('bc-theme')
                    || this.html.dataset.theme
                    || 'dark';
        this.apply(this.current);
        this.btn.addEventListener('click', () => this.toggle());
    }

    toggle() {
        this.current = this.current === 'dark' ? 'light' : 'dark';
        this.apply(this.current);
    }

    apply(theme) {
        this.html.dataset.theme = theme;
        // Moon for dark mode, sun for light mode
        this.icon.innerHTML = theme === 'dark' ? '&#9790;' : '&#9728;';
        sessionStorage.setItem('bc-theme', theme);
    }
}
```

### Toggle HTML
```html
<!-- Place immediately inside <body> -->
<button class="theme-toggle" aria-label="Toggle light/dark mode" title="Toggle theme">
    <span class="toggle-icon">&#9790;</span>
</button>
```

### Theme Transition

Add this to `body` for smooth transitions when toggling:
```css
body {
    transition: background-color 0.4s ease, color 0.4s ease;
}

/* Transition all themed elements */
.slide, .card, .content-box, .nav-dots, .progress-bar {
    transition: background-color 0.4s ease, color 0.4s ease,
                border-color 0.4s ease, box-shadow 0.4s ease;
}
```

---

## Admin Panel (Display Settings) — ALWAYS INCLUDE

A popover-based control panel for adjusting typography on the fly. Uses native Popover API + CSS Anchor Positioning — no libraries. **This is included in every presentation** because slides are frequently shown on varying projectors and screens where font sizes need real-time adjustment.

### Architecture

The typography system uses a two-layer scale-factor approach:

1. **Global scale** (`--font-scale`) — multiplier for all sizes at once (0.7 to 1.5)
2. **Per-variable scales** (`--title-scale`, `--h2-scale`, etc.) — individual multiplier per size (0.5 to 2.0)

**Critical: both the preferred (vw) AND max (rem) values must be scaled.** On laptop/desktop screens (1280–1920px), the vw-based preferred value is what clamp() resolves to — scaling only the max has no visible effect.

```css
:root {
    --font-scale: 1;
    --title-scale: 1;
    --h2-scale: 1;
    --h3-scale: 1;
    --subtitle-scale: 1;
    --body-scale: 1;
    --small-scale: 1;

    /* Both preferred AND max are multiplied by the scale factors */
    --title-size: clamp(2rem,
        calc(6vw * var(--title-scale) * var(--font-scale)),
        calc(6.5rem * var(--title-scale) * var(--font-scale)));
    --h2-size: clamp(1.25rem,
        calc(3.5vw * var(--h2-scale) * var(--font-scale)),
        calc(3.5rem * var(--h2-scale) * var(--font-scale)));
    /* ... same pattern for all sizes */
}
```

**Why this works:** `clamp(min, preferred, max)` resolves to whichever of the three is the "middle" value. On a 1440px laptop, `6vw = 86px` which is less than `6.5rem = 104px`, so the preferred wins. If you only scale the max, nothing changes. By scaling the preferred too, slider adjustments are always visible.

This gives two levels of control: adjust everything at once with `--font-scale`, or fine-tune individual sizes with the `--*-scale` variables. Both stack multiplicatively.

### HTML (Popover + Anchor Trigger)

```html
<!-- Gear trigger — anchors the popover -->
<button class="admin-trigger"
        popovertarget="admin-panel"
        aria-label="Display settings"
        title="Display settings">
    &#9881;
</button>

<!-- Popover panel -->
<div id="admin-panel" class="admin-panel" popover="auto">
    <div class="admin-header">
        <h4>Display Settings</h4>
        <button class="admin-reset" id="admin-reset">Reset</button>
    </div>
    <div class="admin-body">
        <div class="admin-section-label">Global Scale</div>
        <div class="admin-row">
            <label for="ctrl-font-scale">Scale</label>
            <input type="range" id="ctrl-font-scale"
                   min="0.7" max="1.3" step="0.05" value="1">
            <output id="out-font-scale">100%</output>
        </div>
        <div class="admin-separator"></div>
        <div class="admin-section-label">Type Sizes (max)</div>
        <!-- One admin-row per variable: title, h2, h3, subtitle, body, small -->
    </div>
</div>
```

### CSS (Anchor Positioning + Popover Styling)

```css
/* Trigger button acts as CSS anchor */
.admin-trigger {
    anchor-name: --admin-trigger;
    /* ... button styles (fixed, top-right, pill shape) */
}

/* Popover anchored below the trigger */
.admin-panel {
    position-anchor: --admin-trigger;
    position-area: bottom span-left;
    margin-top: 8px;
    /* ... panel styles */
}

/* Entry animation using @starting-style */
.admin-panel:popover-open {
    opacity: 1;
    transform: translateY(0);
}

@starting-style {
    .admin-panel:popover-open {
        opacity: 0;
        transform: translateY(-4px);
    }
}
```

Key points:
- `popover="auto"` gives light-dismiss (click outside to close)
- `popovertarget` on the button handles show/hide declaratively
- `anchor-name` / `position-anchor` / `position-area` handle positioning in CSS
- `@starting-style` enables entry animation for the popover
- `allow-discrete` on transition enables animating `display` and `overlay`

### JavaScript

```javascript
class AdminControls {
    constructor() {
        this.root = document.documentElement;
        /* All values are unitless scale factors */
        this.controls = {
            'font-scale':     { prop: '--font-scale',     fmt: v => Math.round(v * 100) + '%' },
            'title-scale':    { prop: '--title-scale',    fmt: v => v.toFixed(2) + 'x' },
            'h2-scale':       { prop: '--h2-scale',       fmt: v => v.toFixed(2) + 'x' },
            /* ... same pattern for all sizes */
        };
        /* Bind each input to its CSS variable via input event */
        /* All values set as unitless — CSS calc() handles the math */
        /* Persist all values in sessionStorage as JSON */
        /* Reset button restores defaultValue on all inputs */
    }
}
```

### Always Included

The admin panel is a standard feature of every BC presentation. Once you've dialed in typography for a specific venue, the settings persist in sessionStorage for the session. The panel stays available but unobtrusive — a small gear icon that doesn't interfere with the presentation.

---

## Font Pairing Reference

| Theme | Display Font | Body Font | Source | Pairing Rationale |
|-------|-------------|-----------|--------|-------------------|
| BC Maroon (Dark) | Cormorant Garamond (500/600) | DM Sans (400/500) | Google Fonts | Elegant serif meets clean sans — premium, readable |
| BC Cream (Light) | Fraunces (600/700) | Work Sans (400/500) | Google Fonts | Distinctive warm serif meets friendly body — editorial, inviting |

### Google Fonts Links

**BC Maroon:**
```html
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;1,400&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
```

**BC Cream:**
```html
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet">
```

**Both themes (for toggle support):**
```html
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;1,400&family=DM+Sans:wght@400;500;600&family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Work+Sans:wght@400;500;600&display=swap" rel="stylesheet">
```

### Font Assignment by Theme
```css
[data-theme="dark"] {
    --font-display: 'Cormorant Garamond', Georgia, serif;
    --font-body: 'DM Sans', system-ui, sans-serif;
}

[data-theme="light"] {
    --font-display: 'Fraunces', Georgia, serif;
    --font-body: 'Work Sans', system-ui, sans-serif;
}
```

---

## Animation Reference

### Entrance Animations

```css
/* Fade + Slide Up (default) */
.reveal {
    opacity: 0;
    transform: translateY(30px);
    transition: opacity 0.6s var(--ease-out-expo),
                transform 0.6s var(--ease-out-expo);
}

.slide.visible .reveal {
    opacity: 1;
    transform: translateY(0);
}

/* Scale In */
.reveal-scale {
    opacity: 0;
    transform: scale(0.9);
    transition: opacity 0.6s, transform 0.6s var(--ease-out-expo);
}

.slide.visible .reveal-scale {
    opacity: 1;
    transform: scale(1);
}

/* Slide from Left */
.reveal-left {
    opacity: 0;
    transform: translateX(-50px);
    transition: opacity 0.6s, transform 0.6s var(--ease-out-expo);
}

.slide.visible .reveal-left {
    opacity: 1;
    transform: translateX(0);
}

/* Blur In */
.reveal-blur {
    opacity: 0;
    filter: blur(10px);
    transition: opacity 0.8s, filter 0.8s var(--ease-out-expo);
}

.slide.visible .reveal-blur {
    opacity: 1;
    filter: blur(0);
}

/* Stagger children */
.reveal:nth-child(1) { transition-delay: 0.1s; }
.reveal:nth-child(2) { transition-delay: 0.2s; }
.reveal:nth-child(3) { transition-delay: 0.3s; }
.reveal:nth-child(4) { transition-delay: 0.4s; }
.reveal:nth-child(5) { transition-delay: 0.5s; }
.reveal:nth-child(6) { transition-delay: 0.6s; }
```

### Progress Bar
```css
.progress-bar {
    position: fixed;
    top: 0;
    left: 0;
    height: 3px;
    background: var(--accent-secondary);
    z-index: 999;
    transition: width 0.3s ease;
    width: 0%;
}
```

### Navigation Dots
```css
.nav-dots {
    position: fixed;
    right: clamp(0.5rem, 1.5vw, 1rem);
    top: 50%;
    transform: translateY(-50%);
    display: flex;
    flex-direction: column;
    gap: 8px;
    z-index: 999;
}

.nav-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    border: 1px solid var(--text-secondary);
    background: transparent;
    cursor: pointer;
    transition: all 0.3s ease;
    padding: 0;
}

.nav-dot.active {
    background: var(--accent-secondary);
    border-color: var(--accent-secondary);
    transform: scale(1.3);
}

.nav-dot:hover {
    border-color: var(--accent-secondary);
}
```

---

## CSS Gotchas (Common Mistakes)

### Negating CSS Functions

**WRONG — silently ignored by browsers:**
```css
right: -clamp(28px, 3.5vw, 44px);   /* Invalid! Browser ignores this */
margin-left: -min(10vw, 100px);      /* Invalid! */
```

**CORRECT — wrap in `calc()`:**
```css
right: calc(-1 * clamp(28px, 3.5vw, 44px));  /* Correct */
margin-left: calc(-1 * min(10vw, 100px));     /* Correct */
```

**Rule: Always use `calc(-1 * ...)` to negate CSS function values.**

### oklch Browser Support

oklch has excellent modern browser support (Chrome 111+, Safari 15.4+, Firefox 113+). For presentations viewed in modern browsers, no fallback is needed. If you need broader support, include a hex fallback:

```css
/* Fallback pattern */
color: #8A100B;               /* Fallback */
color: oklch(0.41 0.155 29);  /* Modern browsers */
```

---

## Common Layout Fixes

### Title/End Slide Vertical Centering

**Problem:** Using `flex` with `justify-content: center` on a slide column, then pushing a footer to the bottom with `margin-top: auto`. This biases the main content upward — it's not truly centered, it's centered *above* the footer.

**Fix:** Use a 3-row CSS grid: `grid-template-rows: 1fr auto 1fr`. Content goes in row 2 (centered), footer goes in row 3 with `align-self: end`. The empty first row balances the footer's height.

```css
.title-slide {
    display: grid;
    grid-template-rows: 1fr auto 1fr;
    align-items: center;
    justify-items: center;
    text-align: center;
}
.title-slide .slide-center {
    grid-row: 2;
    display: flex;
    flex-direction: column;
    align-items: center;       /* REQUIRED — centers H1 and other children
                                  inside the flex column. Without this,
                                  any child with a max-width aligns to the
                                  flex-start (left) edge. This is the
                                  single most common title-slide bug. */
    gap: clamp(1rem, 2vw, 1.5rem);
}
.title-slide .slide-footer { grid-row: 3; align-self: end; }
```

```html
<section class="slide title-slide">
    <div class="slide-center">
        <!-- Main content — all children center horizontally -->
    </div>
    <p class="slide-footer small-text">Footer text</p>
</section>
```

Apply this pattern to any slide that has a footer element pinned to the bottom. **All title-slide content centers by default — this is a contract, not a per-deck fix.**

### Heading Centering

**Default:** `h2` elements in presentations should be `text-align: center` unless the slide layout specifically calls for left-aligned headings (e.g., slides with left-aligned body lists or two-column layouts). When body content below a heading is centered, a left-aligned heading looks like a bug.

### Bullet List Sizing (Primary vs Secondary)

**Problem:** Sizing bullets at `body` size when they're the slide's main content — then a `subtitle`-sized lead paragraph below "punches through" the bullets visually, inverting hierarchy.

**Rule (from `DESIGN.md` and `reference/type-hierarchy.md`):**
- Bullets that ARE the slide's main content → `subtitle` size (`bullet-list--primary`, default)
- Bullets that support a heading or live inside a card → `body` size (`bullet-list--secondary`)

```css
/* Primary — bullets ARE the main slide content. This is the default. */
ul.bullet-list li,
ul.bullet-list--primary li {
    font-size: var(--subtitle-size);
    color: var(--text-primary);
    line-height: 1.45;
    padding-left: 1.5em;
    position: relative;
}

/* Secondary — bullets support a heading or live inside a card */
ul.bullet-list--secondary li,
.card ul.bullet-list li {     /* auto-secondary inside cards */
    font-size: var(--body-size);
    color: var(--text-primary);
    line-height: 1.5;
}

/* Marker (shared) */
ul.bullet-list li::before {
    content: '';
    position: absolute;
    left: 0;
    top: 0.7em;
    width: 12px;
    height: 1.5px;
    background: var(--accent-secondary);
}

ul.bullet-list li strong {
    color: var(--accent-secondary);
    font-weight: 500;
}
```

When a `lead` paragraph appears below primary bullets, it should be `subtitle` size in `--text-secondary` color — same size as the bullets, lower color weight. Hierarchy is communicated by color, not size.

---

## DO NOT USE (Generic AI Patterns)

**Fonts:** Inter, Roboto, Arial, system fonts as display

**Colors:** Generic indigo, purple gradients, true black (#000000), pure white (#ffffff)

**Layouts:** Everything centered, generic hero sections, identical card grids

**Decorations:** Realistic illustrations, gratuitous glassmorphism, drop shadows without purpose

**Copy:** Clickbait or hyperbolic headings on slides ("The Trick That Changes Everything," "Game-Changing," "The One Thing You Need"). Educational content earns its own weight — describe what it is, not what it promises. See anti-pattern #20 in the Writing with AI hub.

---

## Troubleshooting Viewport Issues

### Content Overflows the Slide

**Symptoms:** Scrollbar appears, content cut off, elements outside viewport

**Solutions:**
1. Check slide has `overflow: hidden` (not `overflow: auto` or `visible`)
2. Reduce content — split into multiple slides
3. Ensure all fonts use `clamp()` not fixed `px` or `rem`
4. Add/fix height breakpoints for smaller screens
5. Check images have `max-height: min(50vh, 400px)`

### Text Too Small on Mobile / Too Large on Desktop

**Solutions:**
```css
font-size: clamp(1rem, 3vw, 2.5rem);
/*              min    scales   max */
```

### Testing Recommendations

Test at these viewport sizes:
- **Desktop:** 1920x1080, 1440x900, 1280x720
- **Tablet:** 1024x768 (landscape), 768x1024 (portrait)
- **Mobile:** 375x667 (iPhone SE), 414x896 (iPhone 11)
- **Landscape phone:** 667x375, 896x414

Use browser DevTools responsive mode to quickly test multiple sizes.
