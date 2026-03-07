# Brand Diagnostic Card Template (SVG)

## Main Card Template (1200x675)

Two-column layout for brand diagnostic cards. Claude should generate this SVG by substituting all `{{PLACEHOLDER}}` values with actual data from `brand-analysis.json`.

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 675" width="1200" height="675">
  <defs>
    <linearGradient id="accent-grad" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" style="stop-color:{{GRADIENT_START}}" />
      <stop offset="50%" style="stop-color:{{GRADIENT_MID}}" />
      <stop offset="100%" style="stop-color:{{GRADIENT_END}}" />
    </linearGradient>
  </defs>

  <!-- Background -->
  <rect width="1200" height="675" fill="{{BG}}" />

  <!-- Accent gradient top bar -->
  <rect width="1200" height="3" fill="url(#accent-grad)" />

  <!-- ═══════════════════════════════════════════════ -->
  <!-- LEFT COLUMN: Brand Identity (x: 48-560)        -->
  <!-- ═══════════════════════════════════════════════ -->

  <!-- Brand Name (max 2 lines, 40 chars/line) -->
  <text x="48" y="52" font-family="{{FONT_SANS}}"
        font-size="22" font-weight="700" fill="{{TEXT}}">
    <tspan x="48" dy="0">{{BRAND_NAME_LINE1}}</tspan>
    <tspan x="48" dy="28">{{BRAND_NAME_LINE2}}</tspan>
  </text>

  <!-- URL + Industry -->
  <text x="48" y="105" font-family="{{FONT_MONO}}"
        font-size="11" fill="{{TEXT_MUTED}}">{{URL_DISPLAY}}</text>

  <!-- Industry Badge -->
  <rect x="{{INDUSTRY_BADGE_X}}" y="92" rx="10" ry="10"
        width="{{INDUSTRY_BADGE_W}}" height="20"
        fill="{{INDUSTRY_BG}}" stroke="{{INDUSTRY_COLOR}}" stroke-width="1" />
  <text x="{{INDUSTRY_BADGE_TX}}" y="106" font-family="{{FONT_SANS}}"
        font-size="9" font-weight="600" fill="{{INDUSTRY_COLOR}}"
        text-anchor="middle">{{INDUSTRY_LABEL}}</text>

  <!-- Value Proposition Box -->
  <rect x="48" y="124" width="500" height="52" rx="8"
        fill="{{STAT_BG}}" stroke="{{STAT_BORDER}}" stroke-width="1" />
  <text x="60" y="139" font-family="{{FONT_SANS}}"
        font-size="9" fill="{{TEXT_MUTED}}" font-weight="600"
        letter-spacing="0.5">VALUE PROPOSITION</text>
  <text x="60" y="157" font-family="{{FONT_SANS}}"
        font-size="11" fill="{{TEXT}}" font-style="italic">
    <tspan x="60" dy="0">{{VP_LINE1}}</tspan>
    <tspan x="60" dy="15">{{VP_LINE2}}</tspan>
  </text>

  <!-- Color Palette Swatches -->
  <text x="48" y="200" font-family="{{FONT_SANS}}"
        font-size="9" fill="{{TEXT_MUTED}}" font-weight="600"
        letter-spacing="0.5">COLOR PALETTE</text>

  <!-- Swatch 1 -->
  <rect x="48" y="210" width="32" height="32" rx="6"
        fill="{{SWATCH1_COLOR}}" stroke="{{SWATCH_BORDER}}" stroke-width="1" />
  <text x="64" y="254" font-family="{{FONT_MONO}}"
        font-size="8" fill="{{TEXT_MUTED}}" text-anchor="middle">{{SWATCH1_HEX}}</text>

  <!-- Swatch 2 -->
  <rect x="92" y="210" width="32" height="32" rx="6"
        fill="{{SWATCH2_COLOR}}" stroke="{{SWATCH_BORDER}}" stroke-width="1" />
  <text x="108" y="254" font-family="{{FONT_MONO}}"
        font-size="8" fill="{{TEXT_MUTED}}" text-anchor="middle">{{SWATCH2_HEX}}</text>

  <!-- Swatch 3 -->
  <rect x="136" y="210" width="32" height="32" rx="6"
        fill="{{SWATCH3_COLOR}}" stroke="{{SWATCH_BORDER}}" stroke-width="1" />
  <text x="152" y="254" font-family="{{FONT_MONO}}"
        font-size="8" fill="{{TEXT_MUTED}}" text-anchor="middle">{{SWATCH3_HEX}}</text>

  <!-- Swatch 4 (optional) -->
  {{SWATCH4_BLOCK}}

  <!-- Swatch 5 (optional) -->
  {{SWATCH5_BLOCK}}

  <!-- Typography Info -->
  <text x="260" y="222" font-family="{{FONT_SANS}}"
        font-size="9" fill="{{TEXT_MUTED}}" font-weight="600"
        letter-spacing="0.5">TYPOGRAPHY</text>
  <text x="260" y="238" font-family="{{FONT_SANS}}"
        font-size="10" fill="{{TEXT}}">H: {{HEADING_FONT}}</text>
  <text x="260" y="254" font-family="{{FONT_SANS}}"
        font-size="10" fill="{{TEXT}}">B: {{BODY_FONT}}</text>

  <!-- Positioning Summary -->
  <text x="48" y="282" font-family="{{FONT_SANS}}"
        font-size="9" fill="{{TEXT_MUTED}}" font-weight="600"
        letter-spacing="0.5">POSITIONING</text>
  <text x="48" y="298" font-family="{{FONT_SANS}}"
        font-size="11" fill="{{TEXT}}">
    <tspan x="48" dy="0">{{POSITIONING_LINE1}}</tspan>
    <tspan x="48" dy="15">{{POSITIONING_LINE2}}</tspan>
  </text>

  <!-- Target + Tone Tags -->
  <text x="48" y="340" font-family="{{FONT_SANS}}"
        font-size="9" fill="{{TEXT_MUTED}}" font-weight="600"
        letter-spacing="0.5">TARGET</text>
  <text x="48" y="356" font-family="{{FONT_SANS}}"
        font-size="10" fill="{{TEXT}}">{{TARGET_AUDIENCE}}</text>

  <text x="48" y="380" font-family="{{FONT_SANS}}"
        font-size="9" fill="{{TEXT_MUTED}}" font-weight="600"
        letter-spacing="0.5">TONE</text>
  <!-- Tone Badge -->
  <rect x="48" y="388" rx="10" ry="10" width="{{TONE_W}}" height="20"
        fill="{{BADGE_BG}}" stroke="{{BADGE_BORDER}}" stroke-width="1" />
  <text x="{{TONE_TX}}" y="402" font-family="{{FONT_SANS}}"
        font-size="9" font-weight="600" fill="{{ACCENT}}"
        text-anchor="middle">{{TONE}}</text>

  <!-- CTA Badge -->
  <rect x="{{CTA_BADGE_X}}" y="388" rx="10" ry="10"
        width="{{CTA_BADGE_W}}" height="20"
        fill="{{BADGE_BG}}" stroke="{{BADGE_BORDER}}" stroke-width="1" />
  <text x="{{CTA_BADGE_TX}}" y="402" font-family="{{FONT_SANS}}"
        font-size="9" font-weight="600" fill="{{ACCENT}}"
        text-anchor="middle">CTA: {{PRIMARY_CTA}}</text>

  <!-- ═══════════════════════════════════════════════ -->
  <!-- RIGHT COLUMN: Health & Diagnosis (x: 588-1140) -->
  <!-- ═══════════════════════════════════════════════ -->

  <!-- Brand Health Label -->
  <text x="588" y="42" font-family="{{FONT_SANS}}"
        font-size="11" fill="{{TEXT_MUTED}}" font-weight="600"
        letter-spacing="0.5">BRAND HEALTH</text>

  <!-- Overall Score -->
  <text x="1120" y="42" font-family="{{FONT_MONO}}"
        font-size="18" font-weight="700" fill="{{ACCENT}}"
        text-anchor="end">{{OVERALL_SCORE}}</text>
  <text x="1140" y="42" font-family="{{FONT_MONO}}"
        font-size="11" fill="{{TEXT_MUTED}}"
        text-anchor="end">/10</text>

  <!-- Health Bar: Clarity -->
  <text x="588" y="72" font-family="{{FONT_SANS}}"
        font-size="11" fill="{{TEXT_MUTED}}">Clarity</text>
  <rect x="700" y="60" width="200" height="14" rx="4" fill="{{BAR_BG}}" />
  <rect x="700" y="60" width="{{CLARITY_W}}" height="14" rx="4"
        fill="{{CLARITY_COLOR}}" />
  <text x="910" y="72" font-family="{{FONT_MONO}}"
        font-size="12" font-weight="700" fill="{{TEXT}}">{{CLARITY}}</text>

  <!-- Health Bar: Consistency -->
  <text x="588" y="102" font-family="{{FONT_SANS}}"
        font-size="11" fill="{{TEXT_MUTED}}">Consistency</text>
  <rect x="700" y="90" width="200" height="14" rx="4" fill="{{BAR_BG}}" />
  <rect x="700" y="90" width="{{CONSISTENCY_W}}" height="14" rx="4"
        fill="{{CONSISTENCY_COLOR}}" />
  <text x="910" y="102" font-family="{{FONT_MONO}}"
        font-size="12" font-weight="700" fill="{{TEXT}}">{{CONSISTENCY}}</text>

  <!-- Health Bar: Differentiation -->
  <text x="588" y="132" font-family="{{FONT_SANS}}"
        font-size="11" fill="{{TEXT_MUTED}}">Differentiation</text>
  <rect x="700" y="120" width="200" height="14" rx="4" fill="{{BAR_BG}}" />
  <rect x="700" y="120" width="{{DIFFERENTIATION_W}}" height="14" rx="4"
        fill="{{DIFFERENTIATION_COLOR}}" />
  <text x="910" y="132" font-family="{{FONT_MONO}}"
        font-size="12" font-weight="700" fill="{{TEXT}}">{{DIFFERENTIATION}}</text>

  <!-- Health Bar: Trust -->
  <text x="588" y="162" font-family="{{FONT_SANS}}"
        font-size="11" fill="{{TEXT_MUTED}}">Trust</text>
  <rect x="700" y="150" width="200" height="14" rx="4" fill="{{BAR_BG}}" />
  <rect x="700" y="150" width="{{TRUST_W}}" height="14" rx="4"
        fill="{{TRUST_COLOR}}" />
  <text x="910" y="162" font-family="{{FONT_MONO}}"
        font-size="12" font-weight="700" fill="{{TEXT}}">{{TRUST}}</text>

  <!-- Health Bar: Conversion -->
  <text x="588" y="192" font-family="{{FONT_SANS}}"
        font-size="11" fill="{{TEXT_MUTED}}">Conversion</text>
  <rect x="700" y="180" width="200" height="14" rx="4" fill="{{BAR_BG}}" />
  <rect x="700" y="180" width="{{CONVERSION_W}}" height="14" rx="4"
        fill="{{CONVERSION_COLOR}}" />
  <text x="910" y="192" font-family="{{FONT_MONO}}"
        font-size="12" font-weight="700" fill="{{TEXT}}">{{CONVERSION}}</text>

  <!-- Divider -->
  <line x1="588" y1="210" x2="1140" y2="210"
        stroke="{{STAT_BORDER}}" stroke-width="1" />

  <!-- STRENGTHS -->
  <text x="588" y="234" font-family="{{FONT_SANS}}"
        font-size="9" fill="{{STRENGTH_COLOR}}" font-weight="600"
        letter-spacing="0.5">STRENGTHS</text>

  <circle cx="596" cy="252" r="3" fill="{{STRENGTH_COLOR}}" />
  <text x="608" y="256" font-family="{{FONT_SANS}}"
        font-size="10" fill="{{TEXT}}">{{STRENGTH1}}</text>

  <circle cx="596" cy="272" r="3" fill="{{STRENGTH_COLOR}}" />
  <text x="608" y="276" font-family="{{FONT_SANS}}"
        font-size="10" fill="{{TEXT}}">{{STRENGTH2}}</text>

  <circle cx="596" cy="292" r="3" fill="{{STRENGTH_COLOR}}" />
  <text x="608" y="296" font-family="{{FONT_SANS}}"
        font-size="10" fill="{{TEXT}}">{{STRENGTH3}}</text>

  <!-- NEEDS WORK -->
  <text x="588" y="324" font-family="{{FONT_SANS}}"
        font-size="9" fill="{{WEAKNESS_COLOR}}" font-weight="600"
        letter-spacing="0.5">NEEDS WORK</text>

  <circle cx="596" cy="342" r="3" fill="{{WEAKNESS_COLOR}}" />
  <text x="608" y="346" font-family="{{FONT_SANS}}"
        font-size="10" fill="{{TEXT}}">{{WEAKNESS1}}</text>

  <circle cx="596" cy="362" r="3" fill="{{WEAKNESS_COLOR}}" />
  <text x="608" y="366" font-family="{{FONT_SANS}}"
        font-size="10" fill="{{TEXT}}">{{WEAKNESS2}}</text>

  <circle cx="596" cy="382" r="3" fill="{{WEAKNESS_COLOR}}" />
  <text x="608" y="386" font-family="{{FONT_SANS}}"
        font-size="10" fill="{{TEXT}}">{{WEAKNESS3}}</text>

  <!-- Divider -->
  <line x1="588" y1="400" x2="1140" y2="400"
        stroke="{{STAT_BORDER}}" stroke-width="1" />

  <!-- TOP PRESCRIPTIONS -->
  <text x="588" y="424" font-family="{{FONT_SANS}}"
        font-size="9" fill="{{ACCENT}}" font-weight="600"
        letter-spacing="0.5">PRESCRIPTIONS</text>

  <text x="600" y="444" font-family="{{FONT_SANS}}"
        font-size="10" fill="{{TEXT}}">
    <tspan x="600" dy="0" font-weight="600" fill="{{ACCENT}}">Rx1:</tspan>
    <tspan> {{RX1}}</tspan>
  </text>
  <text x="600" y="464" font-family="{{FONT_SANS}}"
        font-size="10" fill="{{TEXT}}">
    <tspan x="600" dy="0" font-weight="600" fill="{{ACCENT}}">Rx2:</tspan>
    <tspan> {{RX2}}</tspan>
  </text>
  <text x="600" y="484" font-family="{{FONT_SANS}}"
        font-size="10" fill="{{TEXT}}">
    <tspan x="600" dy="0" font-weight="600" fill="{{ACCENT}}">Rx3:</tspan>
    <tspan> {{RX3}}</tspan>
  </text>

  <!-- ═══════════════════════════════════════════════ -->
  <!-- FOOTER                                          -->
  <!-- ═══════════════════════════════════════════════ -->

  <!-- Bottom gradient bar -->
  <rect y="672" width="1200" height="3" fill="url(#accent-grad)" />

  <!-- Watermark -->
  <text x="600" y="655" font-family="{{FONT_MONO}}"
        font-size="10" fill="{{TEXT_DIM}}"
        text-anchor="middle">Generated with brand-autopsy | {{THEME_NAME}}</text>
</svg>
```

## Template Usage Notes

### Placeholder Substitution

- Claude reads `brand-analysis.json`, then generates the complete SVG by substituting all `{{PLACEHOLDER}}` values
- Text containing XML special characters must be escaped: `&` -> `&amp;`, `<` -> `&lt;`, `>` -> `&gt;`
- Empty optional fields (like SWATCH4_BLOCK, SWATCH5_BLOCK) should be replaced with empty string

### Health Bar Widths

Calculate from the 1-10 score value:
```
barWidth = (score / 10) * 200
```

Health bar color selection:
- Score 8-10: use `ratingHigh` from theme
- Score 5-7: use `ratingMid` from theme
- Score 1-4: use `ratingLow` from theme

### Text Constraints

- **Brand Name**: Split at word boundary if > 40 chars. If fits in one line, leave LINE2 empty
- **Value Proposition**: Max 55 chars per line, max 2 lines
- **Positioning**: Max 50 chars per line, max 2 lines
- **Target Audience**: Max 50 chars, truncate with "..." if longer
- **Strengths/Weaknesses**: Max 50 chars each, use the `title` field from diagnosis
- **Prescriptions**: Max 50 chars each, use the `title` field

### Color Swatch Blocks

Swatch 4 (optional):
```svg
<rect x="180" y="210" width="32" height="32" rx="6"
      fill="{{SWATCH4_COLOR}}" stroke="{{SWATCH_BORDER}}" stroke-width="1" />
<text x="196" y="254" font-family="{{FONT_MONO}}"
      font-size="8" fill="{{TEXT_MUTED}}" text-anchor="middle">{{SWATCH4_HEX}}</text>
```

Swatch 5 (optional):
```svg
<rect x="224" y="210" width="32" height="32" rx="6"
      fill="{{SWATCH5_COLOR}}" stroke="{{SWATCH_BORDER}}" stroke-width="1" />
<text x="240" y="254" font-family="{{FONT_MONO}}"
      font-size="8" fill="{{TEXT_MUTED}}" text-anchor="middle">{{SWATCH5_HEX}}</text>
```

If fewer than 4 colors, replace `{{SWATCH4_BLOCK}}` with empty string. Same for swatch 5.

### Industry Badge Positioning

Position the industry badge after the URL text:
- Estimate URL text width: `urlText.length * 6.5` pixels
- Badge X = 48 + URL width + 12
- Badge width: `industryLabel.length * 7 + 16`
- Badge text X (center): Badge X + Badge width / 2

### Tone and CTA Badge Positioning

Tone badge starts at x=48:
- Tone badge width: `toneText.length * 7 + 16`
- CTA badge X = 48 + tone badge width + 8
- CTA badge width: `("CTA: " + ctaText).length * 6.5 + 16`

### Font Selection

Use the theme's font families:
- `{{FONT_SANS}}`: Theme sans-serif font
- `{{FONT_MONO}}`: Theme monospace font
