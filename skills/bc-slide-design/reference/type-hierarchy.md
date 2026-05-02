# Type Hierarchy: Roles and When to Use Them

This file expands on the type-roles section of `DESIGN.md` with worked examples. The single most common slide-design failure is a type-role mismatch — usually bullets sized too small relative to a "lead" line below them, which inverts the visual hierarchy and tells the reader the lead is more important than the bullets.

## The Core Rule

**Primary content gets the largest size in its own neighborhood. Supporting content is one rung quieter — by color, not by size.**

Two things on the same slide should rarely fight for attention with size. They should agree on size and disagree on color weight.

## Role Inventory

| Role | Var | Color default | Family | Used for |
|------|-----|---------------|--------|----------|
| `title` | `--title-size` | `text-primary` | display | Title-slide H1, hero text |
| `h2` | `--h2-size` | `text-primary` | display | Slide heading |
| `h3` | `--h3-size` | `text-primary` | display | Card title, sub-section heading |
| `subtitle` | `--subtitle-size` | varies — see below | body | Lead text, primary bullets |
| `body` | `--body-size` | `text-primary` | body | Paragraph text, card body, secondary bullets |
| `small` | `--small-size` | `text-muted` (or `accent-secondary` for eyebrows) | body | Eyebrow, caption, mono label, footer |

## Decision Trees

### "What size should this paragraph be?"

```
Is it the slide's main thesis statement, sitting under an H2?
  → subtitle, color: text-secondary  (the "lead" pattern)

Is it body copy inside a card?
  → body, color: text-primary

Is it a footer, source attribution, or caption?
  → small, color: text-muted
```

### "What size should these bullets be?"

```
Are these bullets the primary content of the slide?
(no card, no diagram, no other element competing)
  → subtitle, color: text-primary  (use .bullet-list--primary)

Are these bullets inside a card or supporting a primary visual above?
  → body, color: text-primary  (use .bullet-list--secondary, or default)

Is the bullet a one-line stat or callout, not a sentence?
  → It's probably not a bullet. Consider a card or a stat-panel layout.
```

### "What size should this lead/intro line be?"

```
Is there primary content below it (bullets, cards, diagram)?
  → subtitle, color: text-secondary
  Same size as primary bullets if any. Quieter color does the work.

Is this the only paragraph on the slide?
  → subtitle, color: text-primary
  Not competing with anything; full color weight is fine.
```

## Worked Examples

### Example 1 — Bullets are the slide

```
H2: "Why Claude Code stuck for me"
- Capability. The most powerful surface…
- Ergonomics. Terminal-native fits how I think…
- Fit. Anthropic's models match my taste…
Lead (below): "This is preference talking, not a recommendation."
```

**Sizing:**
- H2: `h2`, primary color
- Bullets: `subtitle`, primary color (`bullet-list--primary`)
- Lead below: `subtitle`, secondary color

The bullets and the lead are the same size. The bullets win attention because they're in primary text color and the lead is in `text-secondary`. Hierarchy reads correctly.

**Anti-pattern (what we had before this rule):**
- Bullets at `body` size + lead at `subtitle` size = lead looks more important than the bullets it's wrapping. Visual hierarchy inverts.

### Example 2 — Bullets inside a card

```
H2: "Three layers of personalization"
[Card 1] CLAUDE.md files
  - Cascade by directory
  - Plain markdown
  - Loads automatically
[Card 2] Skills
[Card 3] Project files
```

**Sizing:**
- H2: `h2`
- Card title (h3): `h3`
- Bullets in cards: `body` (`bullet-list--secondary` or default)

Bullets are *not* primary content — they're details inside a card. Body size is correct.

### Example 3 — Three columns of cards with body text

```
H2: "One bet, three choices"
[Card] One home    | A single place where notes and AI context live together.
[Card] Local-first | Plain text files on a disk I control.
[Card] Markdown    | The format the AI ecosystem is converging on.
Lead below: "Saw creators online pairing Claude Code with Obsidian…"
```

**Sizing:**
- H2: `h2`
- Card titles (h3): `h3`
- Card body: `body`, primary color
- Lead below cards: `subtitle`, secondary color

The cards are the primary content. The lead below is one rung quieter (color), one rung *louder* (size). That's intentional — it draws the eye down off the cards into the punchline. The size shift signals "this is a different beat." Quiet color keeps it from competing with the cards above.

### Example 4 — Pull quote slide

```
[Large quote, italic]
"AI use that a reasonable client would want to know about,
kept invisible, is a problem."
[Attribution]
— ABA Formal Opinion 512
```

**Sizing:**
- Quote: `h2` size, display family, italic, `text-primary`
- Attribution: `small` size, body family, uppercase tracked, `text-muted`

Single primary element. No competing content. The quote uses heading-scale type because it *is* the heading.

## CSS Hooks

The two bullet-list variants:

```css
/* Primary — bullets ARE the content */
ul.bullet-list--primary li,
ul.bullet-list li {              /* default */
    font-size: var(--subtitle-size);
    color: var(--text-primary);
    line-height: 1.45;
}

/* Secondary — bullets support a heading or live in a card */
ul.bullet-list--secondary li,
.card ul.bullet-list li {        /* auto-secondary inside cards */
    font-size: var(--body-size);
    color: var(--text-primary);
    line-height: 1.5;
}
```

The default (no modifier) is `--primary` because that's the case where the size matters most. Inside a card, `.bullet-list` auto-shrinks via the descendant selector.

## What Not to Do

- **Don't use `body` size for slide-defining bullets.** They lose the visual fight with anything else on the slide.
- **Don't use `subtitle` size inside cards.** It blows out the card's internal hierarchy and the card title (h3) loses its job.
- **Don't put two `subtitle`-sized blocks in primary color on the same slide.** Pick one to be primary, one to be secondary. If you can't, you have two slides' worth of content.
- **Don't size eyebrows up to look like H3s.** Eyebrows are deliberately small; their job is to label, not announce. If you want a labeled section heading, use H3 with an eyebrow above it.
