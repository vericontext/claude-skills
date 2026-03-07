# Industry Color Mapping

Default color associations for 15 industry categories. Used as fallback accent colors when the `brand` theme lacks sufficient extracted colors, and for industry badge styling on the card.

## Industry Colors

```javascript
const industryColors = {
  saas: {
    label: 'SaaS',
    color: '#6366f1',    // Indigo
    bg: 'rgba(99, 102, 241, 0.10)',
  },
  fintech: {
    label: 'Fintech',
    color: '#059669',    // Emerald
    bg: 'rgba(5, 150, 105, 0.10)',
  },
  ecommerce: {
    label: 'E-Commerce',
    color: '#ea580c',    // Orange
    bg: 'rgba(234, 88, 12, 0.10)',
  },
  healthtech: {
    label: 'HealthTech',
    color: '#0d9488',    // Teal
    bg: 'rgba(13, 148, 136, 0.10)',
  },
  edtech: {
    label: 'EdTech',
    color: '#2563eb',    // Blue
    bg: 'rgba(37, 99, 235, 0.10)',
  },
  devtools: {
    label: 'DevTools',
    color: '#7c3aed',    // Violet
    bg: 'rgba(124, 58, 237, 0.10)',
  },
  'ai-ml': {
    label: 'AI / ML',
    color: '#db2777',    // Pink
    bg: 'rgba(219, 39, 119, 0.10)',
  },
  marketplace: {
    label: 'Marketplace',
    color: '#ca8a04',    // Yellow
    bg: 'rgba(202, 138, 4, 0.10)',
  },
  media: {
    label: 'Media',
    color: '#dc2626',    // Red
    bg: 'rgba(220, 38, 38, 0.10)',
  },
  agency: {
    label: 'Agency',
    color: '#0891b2',    // Cyan
    bg: 'rgba(8, 145, 178, 0.10)',
  },
  crypto: {
    label: 'Crypto / Web3',
    color: '#f59e0b',    // Amber
    bg: 'rgba(245, 158, 11, 0.10)',
  },
  gaming: {
    label: 'Gaming',
    color: '#9333ea',    // Purple
    bg: 'rgba(147, 51, 234, 0.10)',
  },
  social: {
    label: 'Social',
    color: '#3b82f6',    // Blue
    bg: 'rgba(59, 130, 246, 0.10)',
  },
  enterprise: {
    label: 'Enterprise',
    color: '#1e40af',    // Dark Blue
    bg: 'rgba(30, 64, 175, 0.10)',
  },
  other: {
    label: 'Other',
    color: '#6b7280',    // Gray
    bg: 'rgba(107, 114, 128, 0.10)',
  },
};
```

## Usage

### Industry Badge on Card

The industry classification badge on the card uses these colors:
```svg
<rect rx="10" ry="10" width="..." height="22"
      fill="{{INDUSTRY_BG}}" stroke="{{INDUSTRY_COLOR}}" stroke-width="1" />
<text fill="{{INDUSTRY_COLOR}}" font-size="10" font-weight="600">{{INDUSTRY_LABEL}}</text>
```

### Fallback for Brand Theme

When `--theme=brand` is selected but the extracted color palette has fewer than 3 colors, supplement with the industry's default color:
- Missing secondary: use industry color
- Missing accent: use industry color shifted 30 degrees in hue

### Color Selection

Look up by `industryCode` from `brand-analysis.json`:
```javascript
const industry = industryColors[analysis.identity.industryCode] || industryColors.other;
```
