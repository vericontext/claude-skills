# Style Themes

Three built-in themes for brand diagnostic cards, plus a dynamic `brand` theme that uses extracted brand colors.

## Theme Configuration Object

```javascript
const themes = {
  clinical: {
    name: 'clinical',
    bg: '#f8fffe',
    text: '#1a2e35',
    textMuted: '#5a7a84',
    textDim: '#a3bfc8',
    accent: '#0d9488',
    accentSecondary: '#0891b2',
    gradientStart: '#0d9488',
    gradientMid: '#0891b2',
    gradientEnd: '#6366f1',
    badgeBg: 'rgba(13, 148, 136, 0.08)',
    badgeBorder: 'rgba(13, 148, 136, 0.25)',
    statBg: '#eef7f6',
    statBorder: '#c5e0de',
    barBg: '#dceeed',
    barFill: '#0d9488',
    ratingHigh: '#059669',
    ratingMid: '#d97706',
    ratingLow: '#dc2626',
    strengthColor: '#059669',
    weaknessColor: '#dc2626',
    swatchBorder: '#c5e0de',
    fontSans: "'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif",
    fontMono: "'JetBrains Mono', 'Menlo', 'Monaco', 'Courier New', monospace",
  },

  dark: {
    name: 'dark',
    bg: '#0a0f14',
    text: '#e4ecf0',
    textMuted: '#7a8f9a',
    textDim: '#3a4a54',
    accent: '#2dd4bf',
    accentSecondary: '#a78bfa',
    gradientStart: '#2dd4bf',
    gradientMid: '#818cf8',
    gradientEnd: '#f472b6',
    badgeBg: 'rgba(45, 212, 191, 0.1)',
    badgeBorder: 'rgba(45, 212, 191, 0.3)',
    statBg: '#111922',
    statBorder: '#1e2d3a',
    barBg: '#1a2530',
    barFill: '#2dd4bf',
    ratingHigh: '#34d399',
    ratingMid: '#fbbf24',
    ratingLow: '#f87171',
    strengthColor: '#34d399',
    weaknessColor: '#f87171',
    swatchBorder: '#1e2d3a',
    fontSans: "'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif",
    fontMono: "'JetBrains Mono', 'Menlo', 'Monaco', 'Courier New', monospace",
  },

  // The 'brand' theme is dynamically generated at render time.
  // See "Dynamic Brand Theme" section below.
};
```

## Theme Visual Characteristics

### Clinical (Default)
- Clean near-white background with teal/cyan medical accents
- Medical diagnostic aesthetic: clean, precise, authoritative
- Sans-serif Inter font for clinical readability
- Green/amber/red rating spectrum mimics medical vitals
- Best for: professional reports, client presentations, consulting deliverables

### Dark
- Deep dark background with neon teal/purple/pink accents
- Diagnostic dashboard feel: like a hospital monitor in a dark room
- High contrast neon text on dark for dramatic effect
- Best for: social media sharing, developer audiences, modern tech brands

### Brand (Dynamic)
- Background: lightened version of brand's primary color (10% opacity on white)
- Text: darkened brand primary or black
- Accent: brand's primary color
- Gradient: brand primary -> secondary -> accent (or monochromatic if single color)
- Rating bars: use brand colors with opacity variation
- Best for: client deliverables that should feel "on-brand"

## Dynamic Brand Theme Generation

When `--theme=brand` is selected, construct the theme at render time from `brand-analysis.json`:

```javascript
function buildBrandTheme(colors) {
  const primary = colors.primary;       // e.g., "#635bff" (Stripe purple)
  const secondary = colors.secondary || shiftHue(primary, 30);
  const accent = colors.accent || shiftHue(primary, -30);

  return {
    name: 'brand',
    bg: mixWithWhite(primary, 0.05),          // Very light tint of brand color
    text: darken(primary, 0.7),               // Very dark version for readability
    textMuted: mixWithGray(primary, 0.5),     // Muted brand tone
    textDim: mixWithGray(primary, 0.3),       // Dim brand tone
    accent: primary,
    accentSecondary: secondary,
    gradientStart: primary,
    gradientMid: secondary,
    gradientEnd: accent,
    badgeBg: withOpacity(primary, 0.08),
    badgeBorder: withOpacity(primary, 0.25),
    statBg: mixWithWhite(primary, 0.08),
    statBorder: mixWithWhite(primary, 0.20),
    barBg: mixWithWhite(primary, 0.15),
    barFill: primary,
    ratingHigh: '#059669',                    // Keep universal green
    ratingMid: '#d97706',                     // Keep universal amber
    ratingLow: '#dc2626',                     // Keep universal red
    strengthColor: '#059669',
    weaknessColor: '#dc2626',
    swatchBorder: mixWithWhite(primary, 0.20),
    fontSans: "'Inter', -apple-system, sans-serif",
    fontMono: "'JetBrains Mono', 'Menlo', monospace",
  };
}
```

**Color manipulation (approximate in SVG context):**
- `mixWithWhite(color, amount)`: Blend toward #ffffff by `amount` (0-1)
- `darken(color, amount)`: Reduce lightness by `amount`
- `shiftHue(color, degrees)`: Rotate hue in HSL space
- `withOpacity(color, alpha)`: Return `rgba(r, g, b, alpha)`

Since Claude generates SVG directly (not executing JS), these are guidelines for computing appropriate hex values. Claude should calculate the approximate colors mentally and produce valid hex codes.

## Rating Bar Colors

Rating bars use graduated colors based on score, consistent across all themes:
- Score 8-10: `ratingHigh` (green)
- Score 5-7: `ratingMid` (amber/gold)
- Score 1-4: `ratingLow` (red)

## Gradient Usage

The three-stop gradient is used for the top accent bar of the card:
```svg
<linearGradient id="accent-grad" x1="0%" y1="0%" x2="100%" y2="0%">
  <stop offset="0%" style="stop-color:{{GRADIENT_START}}" />
  <stop offset="50%" style="stop-color:{{GRADIENT_MID}}" />
  <stop offset="100%" style="stop-color:{{GRADIENT_END}}" />
</linearGradient>
```
