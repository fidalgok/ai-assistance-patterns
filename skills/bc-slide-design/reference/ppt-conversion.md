# PowerPoint to HTML Conversion

Secondary workflow for converting existing PowerPoint files (.ppt/.pptx) into BC-branded HTML presentations. This is not the primary use case — most presentations are built from content/outlines.

## When to Use

- User has an existing PowerPoint file they want to convert to a BC-branded web presentation
- User says something like "convert my slides.pptx" or "make this PowerPoint into a web presentation"

## Workflow

### Step 1: Extract Content

The extraction script lives at `scripts/extract_pptx.py`. Run it with:

```bash
python scripts/extract_pptx.py <input.pptx> <output_dir>
```

This extracts all text, images, and speaker notes into a JSON structure.

### Step 2: Confirm Content Structure

Present the extracted content to the user for confirmation before proceeding to style selection. Show:
- Number of slides extracted
- Titles and content summaries
- Number of images found
- Any speaker notes

### Step 3: Style Selection

Proceed to Phase 2 (Style Selection) in the main SKILL.md with the extracted content in mind.

### Step 4: Generate HTML

Convert the extracted content into the chosen BC theme, preserving:
- All text content
- All images (referenced from assets folder)
- Slide order
- Any speaker notes (as HTML comments or separate file)

## Dependencies

- `python-pptx` — Install with `pip install python-pptx`

## Session Flow

1. User: "Convert my slides.pptx to a BC-branded web presentation"
2. Skill extracts content and images from PPT
3. Skill confirms extracted content with user
4. Skill asks about preferred BC theme
5. Skill generates HTML presentation with preserved assets
6. Final presentation delivered
