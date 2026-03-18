# BC Slide Design

A Claude Code skill for generating BC-branded HTML slide presentations. Creates zero-dependency, animation-rich single-file HTML presentations using Boston College's official maroon and gold palette in oklch color space.

## File Structure

```
SKILL.md                              -- Core skill (what Claude reads first)
README.md                             -- This file (human reference)
scripts/
  _bootstrap.py                      -- Auto-installs deps (venv locally, pip in sandboxes)
  requirements.txt                   -- Python dependencies
  export_to_pptx.py                  -- HTML → PPTX export script
  extract_pptx.py                    -- PPT → JSON content extraction
reference/
  style-presets.md                    -- Theme definitions, CSS, admin panel code
  html-template.md                    -- Full HTML/CSS/JS template architecture
  ppt-conversion.md                   -- PPT → HTML conversion workflow
  html-to-pptx-export.md             -- HTML → PPTX export details (color/font mapping)
  image-prompting-for-slides.md       -- Prompt templates for custom illustrations
```

## Themes

| Theme | Vibe | Fonts |
|-------|------|-------|
| **BC Maroon** (Dark) | Sophisticated, confident, premium | Cormorant Garamond + DM Sans |
| **BC Cream** (Light) | Warm, approachable, editorial | Fraunces + Work Sans |

Both themes include a light/dark mode toggle and an admin panel for on-the-fly typography adjustment.

## Key Features

- **Single HTML file** — No dependencies, no build step. Just open in a browser.
- **oklch color space** — Modern, perceptually uniform colors throughout.
- **Admin panel** — Adjust font sizes live during a presentation. Essential for varying projectors and screens.
- **Theme toggle** — Switch between dark and light modes on the fly.
- **Keyboard + touch navigation** — Arrow keys, space, scroll, and swipe.
- **Scroll-triggered animations** — Content reveals as you navigate.
- **PPTX export** — Share via Google Slides or email when HTML isn't practical.

## Style Previews (`--preview`)

To generate a quick visual comparison of both themes before committing to one:

1. Include `--preview` in your request (e.g., "create a presentation about X --preview")
2. Two mini HTML files are generated in `.claude-design/slide-previews/`:
   - `bc-maroon-preview.html` — One title slide in the dark theme
   - `bc-cream-preview.html` — One title slide in the light theme
3. Open both in your browser to compare
4. Pick your preferred theme and the skill continues with full generation

Each preview is self-contained (~80-120 lines), includes the theme toggle, and demonstrates the animation style.

## Integration

- **`workshop-slides` skill** — Creates outlines with talking points and timing. Feed directly into bc-slide-design as content.
- **`generating-images` skill** — Generate custom illustrations matching the BC aesthetic. See `reference/image-prompting-for-slides.md` for prompt templates.
- **Planning files** — Any structured content (markdown outlines, notes) works as input.

## Deployment

Copy this entire directory to `~/.claude/skills/bc-slide-design/` to make it available in all Claude Code sessions:

```bash
cp -r "BC Slide Design" ~/.claude/skills/bc-slide-design
```
