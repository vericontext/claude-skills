---
name: autopsy
description: Analyze a brand from its website URL and generate structured analysis, diagnostic report, and visual card
allowed-tools: Bash, Read, Write, Glob, Grep, WebFetch
argument-hint: <url> [--theme=clinical|dark|brand] [--lang=en|ko] [--output=./brand-output/{domain}/] [--competitors=url1,url2] [--no-card] [--no-qa]
---

# /autopsy

Analyze a brand from its website URL. Fetches the site, dissects it across 10 dimensions (identity, positioning, audience, competition, trust, conversion, content, technical, health scoring, diagnosis), generates a structured report, renders a visual diagnostic card, and optionally enters interactive Q&A mode.

## Usage

```
/autopsy <url> [--theme=clinical|dark|brand] [--lang=en|ko] [--output=./brand-output/{domain}/] [--competitors=url1,url2] [--no-card] [--no-qa]
```

## Parameters

- `<url>`: Website URL to analyze (required)
- `--theme`: Visual card theme (default: `clinical`)
  - `clinical` - Clean white with teal/medical accents
  - `dark` - Dark mode with neon diagnostic feel
  - `brand` - Uses the analyzed brand's extracted colors dynamically
- `--lang`: Output language for report and card (default: `en`)
  - `en` - English
  - `ko` - Korean
- `--output`: Output directory (default: `./brand-output/{domain}/`, auto-derived from URL)
- `--competitors`: Competitor URLs, comma-separated (light analysis: positioning/pricing only)
- `--no-card`: Skip visual card generation
- `--no-qa`: Skip interactive Q&A mode after analysis

## What it does

1. Fetches the website HTML (main page + key subpages)
2. Extracts visual identity: colors, typography, imagery patterns
3. Performs 10-dimension brand analysis with health scoring
4. Generates a comprehensive markdown report with diagnosis
5. Renders a shareable visual diagnostic card (1200x675 SVG + PNG)
6. Enters interactive Q&A mode for follow-up questions about the brand

## Output Files

```
brand-output/
├── brand-analysis.json    # Structured analysis data
├── brand-report.md        # Detailed markdown report
├── brand-card.svg         # Visual diagnostic card
└── brand-card.png         # PNG conversion (if converter available)
```

## Examples

```
/autopsy https://stripe.com
/autopsy https://linear.app --theme=brand --lang=ko
/autopsy https://vercel.com --competitors=https://netlify.com,https://railway.app
/autopsy https://notion.so --no-card --no-qa --output=./notion-brand/
```

## Execution

Delegate to the `brand-director` agent to orchestrate the full pipeline. Parse the user's parameters and pass them to the agent.
