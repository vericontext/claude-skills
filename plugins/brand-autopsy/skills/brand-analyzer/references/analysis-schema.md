# Brand Analysis JSON Schema

The brand-analyzer skill produces a `brand-analysis.json` file following this schema. All fields are required unless marked optional.

## Schema

```json
{
  "meta": {
    "url": "string — analyzed URL",
    "domain": "string — domain name (e.g., stripe.com)",
    "fetchedAt": "string — ISO 8601 timestamp",
    "pagesAnalyzed": ["string[] — list of URLs fetched"],
    "lang": "string — detected site language (ISO 639-1)"
  },

  "identity": {
    "brandName": "string — detected brand/company name",
    "tagline": "string|null — tagline or hero headline",
    "industry": "string — inferred industry classification",
    "industryCode": "string — one of: saas, fintech, ecommerce, healthtech, edtech, devtools, ai-ml, marketplace, media, agency, crypto, gaming, social, enterprise, other",
    "colors": {
      "primary": "string — hex color",
      "secondary": "string|null — hex color",
      "accent": "string|null — hex color",
      "palette": [
        {
          "hex": "string",
          "usage": "string — background|text|accent|cta|border",
          "frequency": "number — relative frequency 0-1"
        }
      ]
    },
    "typography": {
      "headingFont": "string|null — detected heading font family",
      "bodyFont": "string|null — detected body font family",
      "style": "string — modern|classic|playful|minimal|bold"
    },
    "visualStyle": "string — description of overall visual approach"
  },

  "positioning": {
    "valueProposition": "string — core value proposition (1-2 sentences)",
    "tonality": "string — professional|friendly|technical|playful|authoritative|minimal",
    "keyMessages": ["string[] — 3-5 key messages from the site"],
    "uniqueSellingPoints": ["string[] — 2-4 USPs"],
    "categoryPosition": "string — leader|challenger|niche|disruptor|emerging"
  },

  "audience": {
    "primaryTarget": "string — inferred primary target audience",
    "secondaryTarget": "string|null — inferred secondary audience",
    "signals": ["string[] — evidence for audience inference"],
    "sophisticationLevel": "string — beginner|intermediate|advanced|expert"
  },

  "competition": {
    "positioningStrategy": "string — cost-leader|differentiator|niche-focus|blue-ocean|fast-follower",
    "differentiators": ["string[] — 2-4 key differentiators"],
    "impliedCompetitors": ["string[] — competitors mentioned or implied"],
    "competitorAnalysis": [
      {
        "url": "string — competitor URL (only if --competitors provided)",
        "name": "string",
        "positioning": "string",
        "pricing": "string|null",
        "keyDifference": "string"
      }
    ]
  },

  "trustSignals": {
    "socialProof": {
      "customerLogos": "boolean",
      "testimonials": "number — count",
      "caseStudies": "boolean",
      "userCount": "string|null — e.g., '10M+ users'"
    },
    "certifications": ["string[] — security badges, compliance certs"],
    "pressMedia": ["string[] — media mentions"],
    "trustScore": "number — 1-10 overall trust signal strength"
  },

  "conversion": {
    "primaryCTA": "string — main call-to-action text",
    "ctaCount": "number — number of CTAs on main page",
    "pricingModel": "string|null — free|freemium|trial|paid|enterprise|contact",
    "pricingVisible": "boolean",
    "funnelStage": "string — awareness|consideration|decision",
    "conversionTactics": ["string[] — urgency, scarcity, social proof, etc."]
  },

  "content": {
    "hasBlog": "boolean",
    "hasDocumentation": "boolean",
    "hasChangelog": "boolean",
    "contentTypes": ["string[] — blog|docs|tutorials|videos|podcasts|newsletter"],
    "seoSignals": {
      "metaTitle": "string|null",
      "metaDescription": "string|null",
      "h1Count": "number",
      "hasStructuredData": "boolean"
    }
  },

  "technical": {
    "framework": "string|null — detected frontend framework",
    "analytics": ["string[] — detected analytics tools"],
    "performance": {
      "hasLazyLoading": "boolean",
      "hasMinification": "boolean"
    },
    "thirdParty": ["string[] — notable third-party integrations detected"]
  },

  "healthScore": {
    "clarity": {
      "score": "number — 1-10",
      "rationale": "string"
    },
    "consistency": {
      "score": "number — 1-10",
      "rationale": "string"
    },
    "differentiation": {
      "score": "number — 1-10",
      "rationale": "string"
    },
    "trust": {
      "score": "number — 1-10",
      "rationale": "string"
    },
    "conversion": {
      "score": "number — 1-10",
      "rationale": "string"
    },
    "overall": "number — weighted average (clarity 25%, differentiation 25%, trust 20%, consistency 15%, conversion 15%)"
  },

  "diagnosis": {
    "strengths": [
      {
        "title": "string — short label",
        "detail": "string — 1-2 sentence explanation"
      }
    ],
    "weaknesses": [
      {
        "title": "string — short label",
        "detail": "string — 1-2 sentence explanation"
      }
    ],
    "prescriptions": [
      {
        "title": "string — short actionable label",
        "detail": "string — 1-2 sentence recommendation",
        "priority": "string — high|medium|low",
        "effort": "string — quick-win|moderate|major"
      }
    ]
  }
}
```

## Field Notes

### Colors
- Extract from inline styles, CSS custom properties (`--brand-color`), `<link>` stylesheet, and `<meta name="theme-color">`
- Deduplicate: merge colors within RGB distance of 10 units
- Exclude pure white (#fff, #ffffff), pure black (#000, #000000), and transparent
- Sort by frequency, keep top 5

### Industry Classification
Use the `industryCode` field for programmatic mapping. The `industry` field is a human-readable label (e.g., "Developer Tools & Infrastructure").

### Health Score Weights
```
overall = clarity * 0.25 + differentiation * 0.25 + trust * 0.20 + consistency * 0.15 + conversion * 0.15
```

### Competitor Analysis
Only populated when `--competitors` flag is provided. Each competitor gets a light analysis (main page only): positioning, pricing model, and key difference from the target brand.
