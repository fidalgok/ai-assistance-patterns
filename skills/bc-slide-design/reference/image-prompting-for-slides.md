# Image Prompting for BC Slide Presentations

Platform-agnostic prompt templates for generating custom illustrations that match the BC slide design aesthetic. Use these with any image generation tool (Gemini, DALL-E, Midjourney, etc.) or with the `generating-images` skill.

## The BC Illustration Aesthetic

**Target feel:** Clean, slightly hand-drawn, bespoke artfully crafted icons and illustrations. Think thoughtful editorial illustration, not stock art. Warm, understated, on-brand.

**Key qualities:**
- Minimal line work with intentional imperfection — feels human-crafted, not machine-perfect
- Warm color palette anchored to BC brand colors
- Generous negative space — illustrations should breathe, not fill every pixel
- Editorial confidence — illustrations that feel curated, not decorative

## BC Brand Palette for Prompts

Always reference specific colors in your prompts for consistency:

| Color | Hex | Use in Prompts |
|-------|-----|----------------|
| BC Maroon | `#8A100B` | "deep maroon", "rich burgundy red" |
| BC Gold | `#B29D6C` | "antique gold", "warm muted gold" |
| Dark Charcoal | `#262320` | "warm charcoal", "dark warm gray" |
| Warm Cream | `#F7F3ED` | "warm cream", "warm off-white" |
| Light Text | `#EDE8E0` | "pale warm beige" |

**Dark theme context:** Specify "on a dark charcoal background (#262320)"
**Light theme context:** Specify "on a warm cream background (#F7F3ED)"

## Prompt Templates by Visual Type

### Icons & Symbols

For slide accent icons, section markers, or concept indicators.

**Template:**
```
A clean, hand-drawn style icon of [subject]. Minimal line work with
subtle [maroon/gold] color accents on a transparent background.
Slightly imperfect lines that feel artisan and human-crafted. Simple,
elegant, editorial. No fill — just confident strokes.
```

**Examples:**
- "A clean, hand-drawn style icon of an open book with a small lightbulb above it. Minimal line work with subtle antique gold (#B29D6C) accents on a transparent background."
- "A hand-drawn icon of two people in conversation. Simple, warm lines in deep maroon (#8A100B). Minimal, editorial feel."
- "A sketch-style compass rose. Clean black lines with gold (#B29D6C) accent on the north point. Transparent background."

### Hero Images / Title Backgrounds

For title slides or section dividers. These should be atmospheric, not literal.

**Template:**
```
An abstract, editorial illustration evoking [concept/feeling]. Warm
tones using deep maroon, antique gold, and [cream/charcoal]. Soft
watercolor wash or ink-like textures. Minimal, with generous negative
space. Horizontal composition suitable for a wide presentation slide.
[Specify resolution, e.g., 1920x1080]
```

**Examples:**
- "An abstract editorial illustration evoking curiosity and discovery. Warm ink washes in maroon (#8A100B) and gold (#B29D6C) on warm cream (#F7F3ED). Soft edges, generous negative space. 1920x1080."
- "A subtle abstract background of overlapping geometric shapes in warm charcoal tones with a single gold accent line. Atmospheric, minimal. 1920x1080."

### Diagrams & Process Visuals

For explaining workflows, frameworks, or step-by-step processes. Should feel hand-drawn rather than mechanical.

**Template:**
```
A hand-drawn style diagram showing [process/concept]. Clean lines in
[maroon/dark] with [gold] highlights on key elements. Sketch-like
quality with slight imperfections. Labels in clean sans-serif text.
White or cream background. Simple and readable.
```

**Example:**
- "A hand-drawn style diagram showing a four-step cycle: Delegate, Describe, Discern, Diligence. Clean maroon (#8A100B) lines connecting each step in a circle, with gold (#B29D6C) arrow accents. Sketch-like quality. Labels in clean type."

### Background Textures & Patterns

For subtle slide backgrounds. These should be nearly invisible — texture, not illustration.

**Template:**
```
A subtle [texture type] in [warm neutral tones]. Barely visible,
suitable as a background layer. [Color palette]. Seamless/tileable.
Very low contrast.
```

**Examples:**
- "A subtle paper texture in warm cream tones. Barely visible grain, suitable as a slide background. Very low contrast. Seamless."
- "A faint watercolor wash in warm maroon and gold tones. Extremely subtle, background-layer opacity. Abstract, atmospheric."

### Spot Illustrations

For inline visuals within content slides — small, focused illustrations that support a point.

**Template:**
```
A small, clean illustration of [subject] in a hand-drawn editorial
style. [Color palette]. Simple composition, works at small sizes
(200-400px). Transparent or [cream/charcoal] background.
```

**Example:**
- "A small editorial illustration of a human hand and a robotic hand meeting in a handshake. Clean line work in maroon (#8A100B) with gold (#B29D6C) highlights. Simple composition, transparent background."

## Style Modifiers

Combine these terms to adjust the aesthetic:

| Modifier | Effect | Best For |
|----------|--------|----------|
| hand-drawn | Slightly imperfect lines, human feel | Icons, diagrams |
| editorial | Confident, curated, magazine-quality | Hero images, spot illustrations |
| minimal | Generous negative space, few elements | All types |
| watercolor wash | Soft, atmospheric color bleeding | Backgrounds, hero images |
| ink sketch | Bold, technical, confident strokes | Diagrams, process visuals |
| woodcut | Traditional, formal, textured | Formal/keynote presentations |
| line art | Clean outlines, no fill | Icons, symbols |

**Default BC combination:** hand-drawn + editorial + minimal

## Tips for Quality

1. **Describe the aesthetic, not the technique** — "warm and confident" beats "use Gaussian blur at 3px"
2. **Request transparent background** for overlay elements on slides
3. **Specify size context** — "suitable for a wide slide at 1920x1080" or "works at 200px as an inline icon"
4. **Include brand colors explicitly** — Use hex values in your prompts
5. **Iterate in two passes** — First pass establishes style direction, refinements dial in specifics
6. **Match theme context** — Dark slides need illustrations that work on dark backgrounds; light slides need light-compatible visuals

## Using with the `generating-images` Skill

If the `generating-images` skill is available, you can use these prompts directly. Tips:
- Use `--model flash` for iteration (~$0.04/img) and `--model pro` for final assets
- Request `--style editorial` or `--style sketch` if supported
- Generate multiple variations and let the user choose
- Save approved illustrations to the presentation's `assets/` folder
