# HTML Presentation Template

This is the complete HTML/CSS/JS template for BC-branded presentations. Claude reads this file when generating a presentation. Every presentation follows this architecture.

## File Structure

For single presentations:
```
presentation.html    # Self-contained presentation
assets/              # Images, if any
```

For projects with multiple presentations:
```
[presentation-name].html
[presentation-name]-assets/
```

## HTML Architecture

Follow this structure for all presentations. See `style-presets.md` for complete CSS custom properties for each theme.

```html
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Presentation Title</title>

    <!-- Fonts (Google Fonts) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=..." rel="stylesheet">

    <style>
        /* ===========================================
           CSS CUSTOM PROPERTIES (BC THEME)
           Uses oklch color space throughout
           Toggle between dark/light via data-theme attribute
           =========================================== */

        /* --- Dark theme (BC Maroon) --- */
        [data-theme="dark"] {
            --bg-primary: oklch(0.15 0.005 60);
            --bg-secondary: oklch(0.20 0.008 60);
            --bg-surface: oklch(0.25 0.010 60);
            --text-primary: oklch(0.93 0.010 80);
            --text-secondary: oklch(0.70 0.015 70);
            --text-muted: oklch(0.55 0.010 65);
            --accent: oklch(0.662 0.184 24.782);
            --accent-hover: oklch(0.72 0.170 25);
            --accent-secondary: oklch(0.835 0.074 80);
            --accent-glow: oklch(0.662 0.184 24.782 / 0.20);
            --border: oklch(0.30 0.010 60);
            --toggle-bg: oklch(0.25 0.010 60);
            --toggle-border: oklch(0.35 0.010 60);
            --font-display: 'Cormorant Garamond', Georgia, serif;
            --font-body: 'DM Sans', system-ui, sans-serif;
        }

        /* --- Light theme (BC Cream) --- */
        [data-theme="light"] {
            --bg-primary: oklch(0.97 0.008 80);
            --bg-secondary: oklch(0.94 0.010 75);
            --bg-surface: oklch(0.99 0.005 80);
            --text-primary: oklch(0.22 0.010 60);
            --text-secondary: oklch(0.45 0.015 60);
            --text-muted: oklch(0.60 0.012 65);
            --accent: oklch(0.35 0.170 25);
            --accent-hover: oklch(0.40 0.160 25);
            --accent-secondary: oklch(0.70 0.085 80);
            --accent-glow: oklch(0.35 0.170 25 / 0.10);
            --border: oklch(0.88 0.012 75);
            --toggle-bg: oklch(0.93 0.008 80);
            --toggle-border: oklch(0.85 0.012 75);
            --font-display: 'Fraunces', Georgia, serif;
            --font-body: 'Work Sans', system-ui, sans-serif;
        }

        /* --- Typography (scale-factor architecture) ---
           Both preferred (vw) AND max (rem) are multiplied
           by the scale factors so changes are visible at
           every viewport width. See style-presets.md
           for the full explanation. */
        :root {
            --font-scale: 1;       /* Global: 0.7 to 1.5 */
            --title-scale: 1;      /* Per-variable: 0.5 to 2.0 */
            --h2-scale: 1;
            --h3-scale: 1;
            --subtitle-scale: 1;
            --body-scale: 1;
            --small-scale: 1;

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

            --slide-padding: clamp(1.5rem, 4vw, 4rem);
            --content-gap: clamp(1rem, 2vw, 2rem);

            --ease-out-expo: cubic-bezier(0.16, 1, 0.3, 1);
            --duration-normal: 0.6s;
        }

        /* ===========================================
           MANDATORY VIEWPORT FITTING BASE STYLES
           (see style-presets.md for full version)
           =========================================== */

        * { margin: 0; padding: 0; box-sizing: border-box; }

        html {
            scroll-behavior: smooth;
            scroll-snap-type: y mandatory;
            height: 100%;
        }

        body {
            font-family: var(--font-body);
            background: var(--bg-primary);
            color: var(--text-primary);
            overflow-x: hidden;
            height: 100%;
            transition: background 0.4s ease, color 0.4s ease;
        }

        .slide {
            width: 100vw;
            height: 100vh;
            height: 100dvh;
            padding: var(--slide-padding);
            scroll-snap-align: start;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .slide-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            max-height: 100%;
            overflow: hidden;
        }

        /* ===========================================
           LIGHT/DARK MODE TOGGLE
           Small, elegant button — top-right corner
           =========================================== */
        .theme-toggle {
            position: fixed;
            top: clamp(0.75rem, 2vw, 1.5rem);
            right: clamp(0.75rem, 2vw, 1.5rem);
            z-index: 1000;
            background: var(--toggle-bg);
            border: 1px solid var(--border);
            border-radius: 999px;
            width: 44px;
            height: 44px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            opacity: 0.7;
        }
        .theme-toggle:hover { opacity: 1; transform: scale(1.1); }

        /* ... remaining presentation styles ... */

        /* RESPONSIVE BREAKPOINTS */
        @media (max-height: 700px) { /* ... */ }
        @media (max-height: 600px) { /* ... */ }
        @media (max-height: 500px) { /* ... */ }
        @media (max-width: 600px) { /* ... */ }
        @media (prefers-reduced-motion: reduce) { /* ... */ }
    </style>
</head>
<body>
    <!-- Theme toggle -->
    <button class="theme-toggle" aria-label="Toggle light/dark mode" title="Toggle theme">
        <span class="toggle-icon">&#9790;</span>
    </button>

    <!-- Progress bar (optional) -->
    <div class="progress-bar"></div>

    <!-- Navigation dots (optional) -->
    <nav class="nav-dots" aria-label="Slide navigation">
        <!-- Generated by JS -->
    </nav>

    <!-- Slides -->
    <section class="slide title-slide">
        <h1 class="reveal">Presentation Title</h1>
        <p class="reveal">Subtitle or author</p>
    </section>

    <section class="slide">
        <div class="slide-content">
            <h2 class="reveal">Slide Title</h2>
            <p class="reveal">Content...</p>
        </div>
    </section>

    <!-- More slides... -->

    <script>
        /* ===========================================
           THEME TOGGLE
           Switches data-theme on <html> between dark/light.
           Persists choice in sessionStorage so it survives
           page refresh during a presentation.
           =========================================== */
        class ThemeToggle {
            constructor() {
                this.html = document.documentElement;
                this.btn = document.querySelector('.theme-toggle');
                this.icon = this.btn.querySelector('.toggle-icon');
                this.current = sessionStorage.getItem('bc-theme') ||
                               this.html.dataset.theme || 'dark';
                this.apply(this.current);
                this.btn.addEventListener('click', () => this.toggle());
            }
            toggle() {
                this.current = this.current === 'dark' ? 'light' : 'dark';
                this.apply(this.current);
            }
            apply(theme) {
                this.html.dataset.theme = theme;
                this.icon.innerHTML = theme === 'dark' ? '&#9790;' : '&#9728;';
                sessionStorage.setItem('bc-theme', theme);
            }
        }

        /* ===========================================
           SLIDE PRESENTATION CONTROLLER
           Handles navigation, animations, and interactions
           =========================================== */
        class SlidePresentation {
            constructor() {
                this.slides = document.querySelectorAll('.slide');
                this.currentSlide = 0;
                this.setupObserver();
                this.setupKeyboard();
                this.setupNavDots();
                this.setupProgressBar();
                this.setupTouchNavigation();
            }

            setupObserver() {
                const observer = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            entry.target.classList.add('visible');
                            this.currentSlide = [...this.slides].indexOf(entry.target);
                            this.updateNavDots();
                            this.updateProgressBar();
                        }
                    });
                }, { threshold: 0.5 });
                this.slides.forEach(slide => observer.observe(slide));
            }

            setupKeyboard() {
                document.addEventListener('keydown', (e) => {
                    if (e.key === 'ArrowRight' || e.key === 'ArrowDown' || e.key === ' ') {
                        e.preventDefault();
                        this.goToSlide(this.currentSlide + 1);
                    } else if (e.key === 'ArrowLeft' || e.key === 'ArrowUp') {
                        e.preventDefault();
                        this.goToSlide(this.currentSlide - 1);
                    }
                });
            }

            setupTouchNavigation() {
                let startY = 0;
                document.addEventListener('touchstart', (e) => {
                    startY = e.touches[0].clientY;
                });
                document.addEventListener('touchend', (e) => {
                    const diff = startY - e.changedTouches[0].clientY;
                    if (Math.abs(diff) > 50) {
                        this.goToSlide(this.currentSlide + (diff > 0 ? 1 : -1));
                    }
                });
            }

            goToSlide(index) {
                if (index >= 0 && index < this.slides.length) {
                    this.slides[index].scrollIntoView({ behavior: 'smooth' });
                }
            }

            setupNavDots() {
                const nav = document.querySelector('.nav-dots');
                if (!nav) return;
                this.slides.forEach((_, i) => {
                    const dot = document.createElement('button');
                    dot.className = 'nav-dot';
                    dot.setAttribute('aria-label', `Go to slide ${i + 1}`);
                    dot.addEventListener('click', () => this.goToSlide(i));
                    nav.appendChild(dot);
                });
                this.updateNavDots();
            }

            updateNavDots() {
                document.querySelectorAll('.nav-dot').forEach((dot, i) => {
                    dot.classList.toggle('active', i === this.currentSlide);
                });
            }

            setupProgressBar() {
                this.progressBar = document.querySelector('.progress-bar');
                this.updateProgressBar();
            }

            updateProgressBar() {
                if (!this.progressBar) return;
                const progress = ((this.currentSlide + 1) / this.slides.length) * 100;
                this.progressBar.style.width = `${progress}%`;
            }
        }

        // Initialize
        new ThemeToggle();
        new SlidePresentation();
    </script>
</body>
</html>
```

## Required JavaScript Features

Every presentation MUST include:

1. **ThemeToggle Class** — Light/dark mode switch
   - Reads/writes `data-theme` attribute on `<html>`
   - Persists in `sessionStorage` for page refreshes
   - Updates toggle icon (moon/sun)
   - Smooth CSS transition between themes

2. **SlidePresentation Class** — Main navigation controller
   - Keyboard navigation (arrows, space)
   - Touch/swipe support
   - Mouse wheel navigation (via scroll-snap)
   - Progress bar updates
   - Navigation dots

3. **Intersection Observer** — For scroll-triggered animations
   - Add `.visible` class when slides enter viewport
   - Trigger CSS animations efficiently

4. **Admin Panel** — On-the-fly typography adjustment (ALWAYS INCLUDE)
   - See `style-presets.md` Admin Panel section for complete implementation
   - Uses Popover API + CSS Anchor Positioning
   - Provides global and per-variable font scale controls
   - Persists settings in sessionStorage

5. **Optional Enhancements** (based on content):
   - Subtle gradient mesh backgrounds
   - Counter animations for stats
   - 3D tilt on hover for cards
   - Staggered entrance for grid items

## Code Quality Requirements

**Comments:**
Every section should have clear comments explaining what it does, why it exists, and how to modify it.

**Accessibility:**
- Semantic HTML (`<section>`, `<nav>`, `<main>`)
- Keyboard navigation works
- ARIA labels on toggle button, nav dots
- Reduced motion support
- Color contrast meets WCAG AA

**CSS Function Negation:**
- Never negate CSS functions directly — `-clamp()`, `-min()`, `-max()` are silently ignored by browsers with no console error
- Always use `calc(-1 * clamp(...))` instead

**Responsive & Viewport Fitting (CRITICAL):**
- Every `.slide` must have `height: 100vh; height: 100dvh; overflow: hidden;`
- All typography and spacing must use `clamp()`
- Respect content density limits (max 4-6 bullets, max 6 cards, etc.)
- Include breakpoints for heights: 700px, 600px, 500px
- When content doesn't fit, split into multiple slides — never scroll
