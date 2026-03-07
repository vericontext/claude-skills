---
name: brand
description: Alias for /autopsy - analyze a brand from its website URL
allowed-tools: Bash, Read, Write, Glob, Grep, WebFetch
argument-hint: <url> [--theme=clinical|dark|brand] [--lang=en|ko] [--output=./brand-output/] [--competitors=url1,url2] [--no-card] [--no-qa]
---

# /brand

This is an alias for `/autopsy`. See the autopsy command for full documentation.

## Usage

```
/brand <url> [options]
```

Identical to `/autopsy`. All parameters are the same.

## Execution

Delegate to the `brand-director` agent to orchestrate the full pipeline. Parse the user's parameters and pass them to the agent.
