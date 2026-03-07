---
name: brand-renderer
description: This skill should be used when the user asks to "render a brand card", "generate a brand diagnostic card", "create a brand visual", "make a brand card SVG", or wants to convert brand analysis data into a visual diagnostic card. It takes brand-analysis.json as input and produces a shareable SVG card.
version: 1.0.0
---

# Brand Renderer

Render a visual brand diagnostic card as an SVG file from structured analysis data. The card uses a medical diagnosis metaphor with color palette swatches, health score bars, strengths/weaknesses, and prescriptions. Output is 1200x675 with zero external dependencies.

## Prerequisites

- `brand-analysis.json` in the output directory (produced by brand-analyzer skill)
- A theme selection: `clinical` (default), `dark`, or `brand`

## Step 1: Read Input Data

Read `brand-analysis.json` from the output directory. Extract the values needed for the card layout:

- From `identity`: brandName, colors.palette (for swatches), colors.primary/secondary/accent, typography, industry, industryCode
- From `positioning`: valueProposition, tonality, uniqueSellingPoints
- From `audience`: primaryTarget
- From `conversion`: primaryCTA
- From `healthScore`: all 5 dimension scores + overall
- From `diagnosis`: strengths (3), weaknesses (3), prescriptions (top 3)
- From `meta`: url, domain

## Step 2: Select Theme

Load theme definitions from `${CLAUDE_PLUGIN_ROOT}/skills/brand-renderer/references/style-themes.md`.

### For `clinical` or `dark` themes:
Apply the selected theme's color values directly.

### For `brand` theme:
Dynamically construct the theme from extracted brand colors:
1. Use `identity.colors.primary` as the base accent color
2. Use `identity.colors.secondary` as secondary (or shift primary hue +30 degrees)
3. Use `identity.colors.accent` as tertiary (or shift primary hue -30 degrees)
4. Compute background as a very light tint of primary (5% opacity on white)
5. Compute text color as a very dark version of primary for readability
6. Keep universal rating colors (green/amber/red) for health bars
7. If fewer than 3 colors extracted, supplement from industry colors in `${CLAUDE_PLUGIN_ROOT}/skills/brand-renderer/references/industry-colors.md`

## Step 3: Prepare Data Values

### Text Truncation and Wrapping

Apply these constraints before substitution:

1. **Brand Name**: Max 80 chars total. If > 40 chars, split at word boundary into 2 lines
2. **URL Display**: Show domain only (e.g., "stripe.com"), max 30 chars
3. **Value Proposition**: Max 55 chars per line, max 2 lines. Split at word boundary
4. **Positioning**: Summarize USPs into max 2 lines of 50 chars. Format: "Strategy: [positioningStrategy]. [top USP]"
5. **Target Audience**: Max 50 chars, truncate with "..."
6. **Strengths**: Use `diagnosis.strengths[].title`, max 50 chars each
7. **Weaknesses**: Use `diagnosis.weaknesses[].title`, max 50 chars each
8. **Prescriptions**: Use `diagnosis.prescriptions[].title`, max 50 chars each

### Health Bar Widths

Calculate from score:
```
barWidth = (score / 10) * 200
```

### Health Bar Colors

From the theme, based on score:
- Score 8-10: `ratingHigh`
- Score 5-7: `ratingMid`
- Score 1-4: `ratingLow`

### Color Swatches

Extract up to 5 colors from `identity.colors.palette` (sorted by frequency):
- For each: hex color value + short hex label
- If palette has < 3 colors, use primary + secondary + accent
- Swatch 4 and 5 are optional — omit their blocks if not enough colors

### Industry Badge

Look up `industryCode` in `${CLAUDE_PLUGIN_ROOT}/skills/brand-renderer/references/industry-colors.md`:
- Badge color and background from industry mapping
- Position after URL text

### Tone and CTA Badges

- Tone badge: capitalize `positioning.tonality`
- CTA badge: show `conversion.primaryCTA` text (truncate to 20 chars)

## Step 4: Build the SVG Card

Use the template from `${CLAUDE_PLUGIN_ROOT}/skills/brand-renderer/references/card-templates.md`.

1. Replace all `{{PLACEHOLDER}}` values with prepared data
2. Escape XML special characters: `&` -> `&amp;`, `<` -> `&lt;`, `>` -> `&gt;`, `"` -> `&quot;`
3. Remove unused optional blocks (swatch 4/5 if not enough colors)
4. Insert the theme name in the footer watermark

Write the complete SVG to `$OUTPUT_DIR/brand-card.svg` using the Write tool.

## Step 5: Verify Output

Check that the output file exists and has a reasonable size (> 2KB).

**Before writing**, verify layout constraints:
- The rightmost element's x + width < 1140
- The bottommost element's y + height < 660
- All text fits within its container
- No overlapping elements

Report the file path to the user. SVG files can be:
- Opened directly in any browser
- Converted to PNG for sharing
- Embedded in documents or presentations

## Layout Constraints (CRITICAL)

The card viewBox is exactly 1200x675. ALL content MUST fit within this boundary.

**Hard rules:**
- No text or element may extend beyond x=1140 (60px right margin)
- No text or element may extend beyond y=660 (15px bottom margin)
- Left column: x range 48-560
- Right column: x range 588-1140
- Column divider: implicit at x=572

## Error Handling

- If brand-analysis.json is missing required fields, use sensible defaults:
  - Missing colors: use theme accent as primary swatch
  - Missing scores: show "N/A" instead of bars
  - Missing diagnosis items: show "—" placeholder
  - Missing typography: show "Not detected"
- Handle null/undefined fields gracefully
- If brand name contains special characters, escape for XML
- If URL is very long, truncate domain display to 30 chars
