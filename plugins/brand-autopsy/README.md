# Brand Autopsy

Analyze any brand from its website URL. Fetches the site, dissects it across 10 dimensions, and produces a medical-style brand diagnosis with visual identity extraction, positioning analysis, and health scoring.

## Install

```bash
# 1. Register marketplace (once)
claude plugin marketplace add https://github.com/vericontext/skillforge

# 2. Install
claude plugin install brand-autopsy
```

### Update

```bash
# Refresh marketplace index, then update
claude plugin marketplace update
claude plugin update brand-autopsy
```

## Usage

```bash
/autopsy <url> [--theme=clinical|dark|brand] [--lang=en|ko] [--output=./brand-output/{domain}/] [--competitors=url1,url2] [--no-card] [--no-qa]
```

Or use the alias:
```bash
/brand <url> [options]
```

### Examples

```bash
# Basic brand analysis
/autopsy https://stripe.com

# Brand theme (uses extracted brand colors) + Korean
/autopsy https://linear.app --theme=brand --lang=ko

# Competitor comparison
/autopsy https://vercel.com --competitors=https://netlify.com,https://railway.app

# Skip card and Q&A
/autopsy https://notion.so --no-card --no-qa
```

## What It Does

1. **Website Fetching** - Fetches the main page + key subpages (about, pricing, etc.)
2. **10-Dimension Analysis** - Brand identity, positioning, target audience, competitive positioning, trust signals, conversion strategy, content strategy, technical signals, health scoring, diagnosis & prescriptions
3. **Color Extraction** - Extracts the brand's actual color palette from CSS
4. **Health Scoring** - Rates clarity, consistency, differentiation, trust, and conversion (1-10)
5. **Diagnosis** - Identifies strengths, weaknesses, and prescriptions using a medical metaphor
6. **Markdown Report** - Comprehensive brand analysis document
7. **Visual Card** - Renders a shareable 1200x675 SVG diagnostic card with color swatches and health bars
8. **Interactive Q&A** - Ask follow-up questions about the brand

## Analysis Dimensions

| # | Dimension | What It Covers |
|---|-----------|---------------|
| 1 | **Brand Identity** | Colors, typography, visual style, logo signals |
| 2 | **Positioning & Messaging** | Value proposition, tone, key messages, USPs |
| 3 | **Target Audience** | Inferred primary/secondary audience with evidence |
| 4 | **Competitive Positioning** | Differentiation strategy, implied competitors |
| 5 | **Trust Signals** | Social proof, testimonials, certifications, press |
| 6 | **Conversion Strategy** | CTAs, pricing model, funnel stage, tactics |
| 7 | **Content Strategy** | Blog, docs, SEO signals, content types |
| 8 | **Technical Signals** | Framework, analytics, performance hints |
| 9 | **Brand Health Score** | Clarity, Consistency, Differentiation, Trust, Conversion (each 1-10) |
| 10 | **Diagnosis & Prescriptions** | 3 strengths, 3 weaknesses, 3-5 actionable prescriptions |

## Output Files

Output is auto-organized by domain name. Each brand gets its own folder, so you can analyze multiple brands without overwriting previous results.

```
brand-output/
├── stripe.com/
│   ├── brand-analysis.json    # Structured 10-dimension analysis data
│   ├── brand-report.md        # Full markdown diagnostic report
│   ├── brand-card.svg         # Visual diagnostic card (1200x675)
│   └── brand-card.png         # PNG conversion (if converter available)
├── linear.app/
│   └── ...
└── vercel.com/
    └── ...
```

### Output Details

- **brand-analysis.json** - Machine-readable structured data covering all 10 dimensions. Includes extracted color palette (hex + frequency), health scores with rationale, and prioritized prescriptions. Useful as input for further automation or dashboards.
- **brand-report.md** - Human-readable diagnostic report with executive summary, per-dimension analysis, scorecard table, and prescription table with priority/effort estimates. Supports `--lang=ko` for Korean output.
- **brand-card.svg** - Shareable visual card featuring color palette swatches, 5 health score bars, strengths/weaknesses bullets, and top 3 prescriptions. Zero external dependencies (pure SVG). Opens in any browser.
- **brand-card.png** - Auto-converted from SVG at 2x resolution (2400x1350). Requires one of: `librsvg`, `inkscape`, `imagemagick`, or macOS `qlmanage`.

## Themes

| Theme | Description | Best For |
|-------|-------------|----------|
| `clinical` | Clean white background with teal/medical accents. Precise, clinical aesthetic. | Client reports, consulting deliverables |
| `dark` | Deep dark background with neon teal/purple/pink accents. Dashboard monitor feel. | Social media, developer audiences |
| `brand` | Dynamically constructed from the analyzed brand's own extracted colors. Card background, accents, and gradients all match the brand's palette. | On-brand client deliverables, pitch decks |

## Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `<url>` | (required) | Website URL to analyze |
| `--theme` | `clinical` | Card visual theme: `clinical`, `dark`, or `brand` |
| `--lang` | `en` | Output language: `en` (English) or `ko` (Korean) |
| `--output` | `./brand-output/{domain}/` | Output directory, auto-derived from URL domain |
| `--competitors` | - | Competitor URLs, comma-separated. Each gets light analysis (positioning + pricing only) for comparison |
| `--no-card` | - | Skip visual card generation (faster, analysis + report only) |
| `--no-qa` | - | Skip interactive Q&A mode after analysis |

## How It Works

```
URL ──> WebFetch (main + subpages) ──> 10-Dimension Analysis ──> brand-analysis.json
                                                                       │
                                                          ┌────────────┼────────────┐
                                                          v            v            v
                                                   brand-report.md  brand-card.svg  Q&A mode
```

1. **Fetch**: Main page HTML + up to 3 subpages (about, pricing, blog) + 1 same-domain CSS file
2. **Extract**: Colors from CSS/inline styles/meta tags, fonts from link tags/@font-face, CTAs from buttons/links
3. **Analyze**: 10 dimensions scored and rationalized using the built-in scoring rubric
4. **Diagnose**: Top 3 strengths, top 3 weaknesses, 3-5 prioritized prescriptions with effort estimates
5. **Render**: SVG card with color swatches, health bars, and medical-style diagnosis layout
6. **Q&A**: Interactive follow-up mode for deep-dives on any dimension

## Requirements

- Claude Code with plugin support
- Internet access (WebFetch) for fetching website content
- For PNG conversion (optional): `librsvg`, `inkscape`, `imagemagick`, or macOS `qlmanage`

## Local Development

```bash
# Validate plugin structure
bash scripts/validate-plugin.sh brand-autopsy

# Test locally
claude --plugin-dir plugins/brand-autopsy
```

## License

MIT
