---
name: brand-analyzer
description: This skill should be used when the user asks to "analyze a brand", "audit a website brand", "dissect a brand", "review brand strategy", "evaluate brand positioning", or wants to extract structured brand analysis from a website URL. It fetches the site and produces a comprehensive brand-analysis.json.
version: 1.0.0
---

# Brand Analyzer

Fetch a website and produce a structured 10-dimension brand analysis as `brand-analysis.json`. This skill extracts visual identity, positioning, trust signals, conversion strategy, and generates a Brand Health Score with diagnosis and prescriptions.

## Prerequisites

- A website URL provided by the user
- WebFetch tool available for HTTP requests

## Step 1: Fetch Website Content

1. Fetch the main URL using WebFetch
2. Parse the HTML to identify subpage links
3. Attempt to fetch up to 3 subpages following the URL patterns in `${CLAUDE_PLUGIN_ROOT}/skills/brand-analyzer/references/analysis-heuristics.md`:
   - About page: try `/about`, `/about-us`, `/company`, `/who-we-are`, `/our-story` (first success)
   - Pricing page: try `/pricing`, `/plans`, `/plans-pricing` (first success)
   - Blog/resources: try `/blog`, `/resources`, `/insights` (first success)
4. If the main page contains a same-domain `<link rel="stylesheet">`, fetch one external CSS file for color/typography extraction
5. Record all successfully fetched URLs in `meta.pagesAnalyzed`

**Error handling:**
- If main URL fails, abort with error message
- If subpage fetches fail, continue with main page only
- If CSS fetch fails, rely on inline styles and HTML attributes only

## Step 2: Extract Brand Identity

Analyze the fetched HTML and CSS to extract visual identity signals.

### Colors
Follow the color extraction rules in `${CLAUDE_PLUGIN_ROOT}/skills/brand-analyzer/references/analysis-heuristics.md`:

1. Check `<meta name="theme-color">` first (highest confidence)
2. Scan CSS custom properties for brand color variables
3. Parse inline styles on header, hero, buttons, and navigation
4. Parse external CSS for key selectors
5. Deduplicate colors (RGB Manhattan distance <= 30)
6. Exclude whites, blacks, and transparent
7. Sort by frequency, keep top 5
8. Classify each color by usage: background, text, accent, cta, border
9. Designate the most prominent non-background color as `primary`

### Typography
1. Check Google Fonts / Typekit `<link>` tags
2. Scan `@font-face` declarations
3. Identify heading vs body font families
4. Classify overall typography style: modern, classic, playful, minimal, bold

### Visual Style
Compose a 1-sentence description of the overall visual approach (e.g., "Minimalist dark theme with geometric illustrations and generous whitespace").

## Step 3: Analyze Positioning & Messaging

1. Identify the hero section using the detection heuristics
2. Extract the primary headline (tagline/value proposition)
3. Extract the sub-headline or supporting text
4. Scan the full page for repeated messaging themes
5. Identify 3-5 key messages the brand communicates
6. Determine the brand's tonality: professional, friendly, technical, playful, authoritative, minimal
7. Extract 2-4 unique selling points (what makes them different)
8. Classify category position: leader, challenger, niche, disruptor, emerging

## Step 4: Infer Target Audience

Based on all available signals, infer:
1. **Primary target**: Who is the main audience? (e.g., "Series A-C SaaS startups with 50-200 employees")
2. **Secondary target**: Is there a secondary audience?
3. **Evidence**: List 3-5 signals supporting the inference (language complexity, use cases mentioned, pricing tiers, imagery)
4. **Sophistication level**: beginner, intermediate, advanced, expert

## Step 5: Analyze Competitive Positioning

1. Determine the positioning strategy: cost-leader, differentiator, niche-focus, blue-ocean, fast-follower
2. Identify 2-4 key differentiators from the messaging
3. Note any competitors mentioned or implied on the site ("Unlike X", comparison pages, "switch from")
4. If `--competitors` flag is provided:
   - Fetch each competitor's main page only
   - Extract: brand name, positioning statement, pricing model, one key difference
   - Keep competitor analysis lightweight (no subpage fetching)

## Step 6: Evaluate Trust Signals

Follow the trust signal detection patterns from the heuristics reference:

1. **Customer logos**: Present? Recognizable brands?
2. **Testimonials**: Count and quality (named? with photos? with metrics?)
3. **Case studies**: Present? Linked from main page?
4. **User numbers**: Specific numbers or vague claims?
5. **Certifications**: Security badges, compliance logos?
6. **Press/Media**: "Featured in" sections?
7. Assign a trust score 1-10 based on comprehensiveness

## Step 7: Analyze Conversion Strategy

1. Detect all CTAs using the CTA detection heuristics
2. Identify the primary CTA (most prominent, usually in hero)
3. Count total distinct CTAs on the main page
4. Determine pricing model from pricing page or main page signals
5. Assess friction level (signup requirements, credit card needed)
6. Identify conversion tactics used (urgency, scarcity, social proof near CTA, risk reversal)
7. Classify the funnel stage the site optimizes for: awareness, consideration, decision

## Step 8: Assess Content Strategy

1. Check for blog presence (link in navigation or footer)
2. Check for documentation, changelog, tutorials
3. List all content types found
4. Extract SEO signals:
   - `<title>` tag content
   - `<meta name="description">` content
   - Count `<h1>` tags
   - Check for structured data (`application/ld+json`)

## Step 9: Detect Technical Signals

1. Scan HTML for framework indicators (Next.js, Nuxt, WordPress, etc.)
2. Scan `<script>` tags for analytics tools
3. Check for performance signals (lazy loading, minification)
4. Note notable third-party integrations

## Step 10: Calculate Brand Health Score

Use the scoring rubric from `${CLAUDE_PLUGIN_ROOT}/skills/brand-analyzer/references/scoring-rubric.md`.

Score each of the 5 health dimensions (1-10) with a rationale:
1. **Clarity** (25%): How clearly does the brand communicate?
2. **Consistency** (15%): How consistent across visual and verbal elements?
3. **Differentiation** (25%): How distinct from competitors?
4. **Trust** (20%): How effectively does it build credibility?
5. **Conversion** (15%): How effectively does it guide visitors to action?

Calculate overall:
```
overall = clarity * 0.25 + differentiation * 0.25 + trust * 0.20 + consistency * 0.15 + conversion * 0.15
```

## Step 11: Generate Diagnosis & Prescriptions

Using the medical metaphor:
1. Identify 3 **strengths** (highest-performing areas)
2. Identify 3 **weaknesses** (lowest-performing areas)
3. Generate 3-5 **prescriptions** (actionable recommendations)
   - Focus on the weakest dimensions
   - Each prescription: title, detail, priority (high/medium/low), effort (quick-win/moderate/major)
   - Don't prescribe for dimensions already scoring 8+

## Step 12: Write Output

Assemble all extracted data following the schema in `${CLAUDE_PLUGIN_ROOT}/skills/brand-analyzer/references/analysis-schema.md`.

Write to `$OUTPUT_DIR/brand-analysis.json` using the Write tool.

Print a brief summary to the user:
```
Brand: [brandName]
URL: [url] | Industry: [industry]
Value Prop: [valueProposition — truncated to 80 chars]
Colors: [primary] [secondary] [accent] (palette of [count])
Health Score: [overall]/10
  Clarity: [X] | Consistency: [X] | Differentiation: [X]
  Trust: [X] | Conversion: [X]
Diagnosis: [strengths count] strengths, [weaknesses count] needs work, [prescriptions count] prescriptions
```

## Error Handling

- If WebFetch fails for the main URL, report the error and abort
- If WebFetch returns non-HTML content (redirect to app, PDF, etc.), inform the user
- If a subpage returns 404, silently skip it and try the next variant
- If color extraction yields fewer than 2 colors, note "limited color data" and use what's available
- If the site is a single-page app with minimal HTML content, note the limitation and analyze what's available
- Never abort the entire analysis for a single dimension failure — fill what's available, mark gaps as null
