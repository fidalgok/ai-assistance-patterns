# HTML to PPTX Export

Export BC-branded HTML presentations to PowerPoint format for sharing via Google Slides, email, or environments where HTML isn't practical.

## Approach

We use BeautifulSoup + python-pptx because we control the HTML output format. Every presentation this skill generates follows the same structure — `<section class="slide">` containers with known class names — so parsing is deterministic, not heuristic.

## Dependencies

```bash
pip install python-pptx beautifulsoup4
```

## Color Mapping (oklch to hex)

oklch colors must be approximated as hex for PPTX. Pre-mapped values for BC brand:

| Role | oklch | Hex Approx |
|------|-------|------------|
| BC Maroon (dark accent) | `oklch(0.662 0.184 24.782)` | `#C03020` |
| BC Gold (dark accent) | `oklch(0.835 0.074 80)` | `#D4C08A` |
| BC Maroon (light text) | `oklch(0.35 0.170 25)` | `#8A100B` |
| BC Gold (light accent) | `oklch(0.70 0.085 80)` | `#B29D6C` |
| Dark background | `oklch(0.15 0.005 60)` | `#262320` |
| Light background | `oklch(0.97 0.008 80)` | `#F7F3ED` |
| Dark text (on dark) | `oklch(0.93 0.010 80)` | `#EDE8E0` |
| Light text (on light) | `oklch(0.22 0.010 60)` | `#3A3530` |

## Font Mapping

Google Fonts aren't available in PPTX, so use closest system font fallbacks:

| BC Theme Font | PPTX Fallback |
|---------------|---------------|
| Cormorant Garamond | Georgia |
| DM Sans | Calibri |
| Fraunces | Georgia |
| Work Sans | Calibri |

## Export Script

The export script lives at `scripts/export_to_pptx.py`. Run it directly — no need to extract from this doc.

## Usage

From the command line:
```bash
python scripts/export_to_pptx.py presentation.html
# or specify output path:
python scripts/export_to_pptx.py presentation.html output.pptx
```

Or from within a Claude session, run the script directly.

## What the Script Does NOT Attempt

- **Replicate CSS animations** — PPTX has its own animation system; we don't try to map between them
- **Convert oklch at runtime** — Uses pre-mapped hex values from the table above
- **Embed Google Fonts** — Uses system font fallbacks (Georgia, Calibri)
- **Recreate complex CSS grids** — Simplifies to PPTX-native text box layouts
- **Handle admin panel or theme toggle** — PPTX is static

## Supported Slide Types

| HTML Class | PPTX Layout |
|------------|-------------|
| `.title-slide` | Centered title + subtitle |
| `.slide` (default) | Left-aligned title + content body |

Additional slide types (grids, quotes, code) are rendered as content slides with text extraction. The layout is simplified but content is preserved.

## Workflow from Within the Skill

When a user requests export:
1. Locate the HTML presentation file
2. Run the export script
3. Deliver both files with explanation of what transferred and what didn't
4. Suggest Google Slides upload if that's their goal
