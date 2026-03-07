# Analysis Heuristics

Rules and patterns for extracting brand signals from raw HTML. Claude uses these heuristics when analyzing fetched website content.

## Page Fetching Strategy

### Main Page
Always fetch the URL provided by the user. This is the primary analysis source.

### Subpage Discovery
After fetching the main page, attempt to fetch up to 3 additional subpages for richer analysis. Try these URL patterns in order, stopping after 3 successful fetches:

**About page variants** (try first match):
- `/about`
- `/about-us`
- `/company`
- `/who-we-are`
- `/our-story`

**Pricing page variants** (try first match):
- `/pricing`
- `/plans`
- `/plans-pricing`

**Blog/Resources** (try first match):
- `/blog`
- `/resources`
- `/insights`

### External CSS Fetching
If the main page contains `<link rel="stylesheet" href="...">` pointing to the same domain, fetch **one** external stylesheet (the first one) for color and typography extraction. Skip third-party CDN stylesheets (Google Fonts link tags are noted but not fetched for CSS content).

## Color Extraction

### Sources (priority order)
1. `<meta name="theme-color" content="...">` — highest confidence brand color
2. CSS custom properties: `--primary`, `--brand`, `--accent`, `--color-primary`, etc.
3. Inline `style` attributes on prominent elements (header, hero, buttons)
4. External stylesheet: `background-color`, `color`, `border-color` on `body`, `header`, `nav`, `.hero`, `.cta`, `button`, `a`
5. SVG logo fill colors

### Color Parsing Regex Patterns
```
Hex:    #([0-9a-fA-F]{3,8})
RGB:    rgb\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*\)
RGBA:   rgba\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*[\d.]+\s*\)
HSL:    hsl\(\s*(\d{1,3})\s*,\s*(\d{1,3})%\s*,\s*(\d{1,3})%\s*\)
```

### Color Deduplication
- Convert all colors to RGB
- Two colors are "same" if Manhattan distance in RGB space <= 30 (i.e., |r1-r2| + |g1-g2| + |b1-b2| <= 30)
- Merge duplicates, sum their frequency counts
- Exclude: white (#fff, #fafafa, #f5f5f5 and brighter), black (#000, #111, #1a1a1a and darker), transparent
- Sort by frequency descending
- Keep top 5

### Color Usage Classification
- **background**: found on `body`, `main`, large container `background-color`
- **text**: found on `body`, `p`, `h1-h6` `color` property
- **accent**: found on `a`, `.accent`, highlight elements
- **cta**: found on `button`, `.btn`, `[class*="cta"]`, `a.button`
- **border**: found on `border-color`, `outline-color`

## Typography Detection

### Font Family Sources
1. `<link>` tags with Google Fonts or Typekit URLs — parse font name from URL
2. `@font-face` declarations in CSS
3. `font-family` on `body`, `h1`, `.heading` elements
4. CSS custom properties: `--font-heading`, `--font-body`, `--font-family`

### Style Classification
- **modern**: Sans-serif primary, clean spacing, geometric shapes
- **classic**: Serif primary, traditional layout
- **playful**: Rounded fonts, bright colors, informal tone
- **minimal**: Very limited colors, lots of whitespace, small type
- **bold**: Large type, high contrast, strong colors

## Hero Section Detection

The hero section is the primary above-the-fold content area. Look for:
- First `<section>`, `<div class="hero">`, `[class*="hero"]`, `[class*="banner"]`
- Element containing the first `<h1>` tag
- Large text block followed by a CTA button
- Full-width image or video background

Extract from hero:
- **Tagline/headline**: The `<h1>` or largest text
- **Sub-headline**: Text immediately after the headline
- **Primary CTA**: First `<button>` or `<a>` with CTA styling

## CTA Detection

Identify calls-to-action by:
- `<button>` elements (excluding navigation, cookie consent)
- `<a>` elements with classes containing: `btn`, `button`, `cta`, `signup`, `start`, `try`, `demo`
- Text patterns: "Get Started", "Sign Up", "Try Free", "Start Trial", "Book Demo", "Contact Sales", "Learn More"

Count distinct CTAs on the main page. Classify the primary CTA (the most prominent one, usually in the hero).

## Trust Signal Detection

### Customer Logos
- `[class*="logo"]`, `[class*="customer"]`, `[class*="client"]`, `[class*="partner"]`
- Image grids/carousels with company logos
- "Trusted by" or "Used by" sections

### Testimonials
- `[class*="testimonial"]`, `[class*="review"]`, `[class*="quote"]`
- `<blockquote>` elements with attribution
- Star ratings or NPS scores

### Social Proof Numbers
- Patterns like "10,000+", "1M+", "millions of" near "users", "customers", "teams", "companies"

### Certifications
- SOC 2, ISO 27001, GDPR, HIPAA badges
- Security page links
- "Enterprise-grade security" messaging

### Press/Media
- "As seen in", "Featured in" sections
- Media outlet logos (TechCrunch, Forbes, etc.)

## Technical Signal Detection

### Framework Detection
Look in HTML source for:
- `__next` or `_next` → Next.js
- `__nuxt` → Nuxt.js
- `ng-` attributes → Angular
- `data-reactroot` or `__REACT` → React (generic)
- `wp-content` → WordPress
- `shopify` in scripts → Shopify
- `webflow` → Webflow
- `gatsby` → Gatsby
- `astro` → Astro

### Analytics Detection
Look in `<script>` tags for:
- `gtag` or `google-analytics` or `GA_MEASUREMENT_ID` → Google Analytics
- `segment` → Segment
- `mixpanel` → Mixpanel
- `hotjar` → Hotjar
- `amplitude` → Amplitude
- `plausible` → Plausible
- `posthog` → PostHog
- `intercom` → Intercom

## Pricing Model Classification

From the pricing page (if found):
- **free**: Entirely free product
- **freemium**: Free tier + paid tiers
- **trial**: Free trial period, then paid
- **paid**: Paid only, no free option
- **enterprise**: "Contact sales" only, no public pricing
- **contact**: Pricing requires inquiry

If no pricing page found, infer from CTA text and main page signals.

## SEO Signal Extraction

- `<title>` tag content
- `<meta name="description">` content
- Count of `<h1>` tags (should be exactly 1)
- `<script type="application/ld+json">` presence → structured data
- `<link rel="canonical">` presence
- Open Graph tags (`og:title`, `og:description`, `og:image`)
