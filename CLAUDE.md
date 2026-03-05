# Claude Skills Monorepo

This is a monorepo for Claude Code skill plugins. Each plugin is an independent, distributable unit under `plugins/`.

## Project Structure

- `plugins/` - Each subdirectory is a standalone plugin (deployment unit)
- `templates/` - Scaffolding templates for new plugins and skills
- `scripts/` - Automation scripts for creating and validating plugins

## Plugin Structure

Each plugin must follow this structure:

```
plugin-name/
├── .claude-plugin/
│   └── plugin.json        # Manifest (required: name)
├── skills/
│   └── skill-name/
│       ├── SKILL.md        # Skill definition (required)
│       └── references/     # Supporting materials (optional)
├── commands/               # Slash commands (optional)
├── agents/                 # Agents (optional)
├── README.md
└── LICENSE
```

## SKILL.md Writing Rules

### Frontmatter
- `name` (required): kebab-case skill name
- `description` (required): Trigger conditions - starts with "This skill should be used when..."
  - Include specific trigger phrases users might say
  - Include keywords that indicate relevance
- `version` (optional): Semantic version number

### Body
- Use imperative/infinitive form ("To create X, do Y")
- Keep body between 1,500-2,000 words
- Move detailed content to `references/` directory
- Use `${CLAUDE_PLUGIN_ROOT}` for path references within the plugin

### Example Frontmatter
```yaml
---
name: my-skill
description: This skill should be used when the user asks to "do X", "create Y", or discusses topic-area.
version: 1.0.0
---
```

### plugin.json Format
```json
{
  "name": "plugin-name",
  "version": "0.1.0",
  "description": "What this plugin does.",
  "author": {
    "name": "author-name"
  }
}
```

Skills are auto-discovered from the `skills/` directory - no need to list them in plugin.json.

## Conventions

- Plugin names: kebab-case (e.g., `code-review-pack`)
- Skill names: kebab-case (e.g., `lint-fixer`)
- All manifests must include at least a `name` field
- Each plugin should have a README.md with usage instructions
- Use `scripts/validate-plugin.sh` to verify structure before publishing

## Deployment

### Marketplace (recommended)
```bash
claude plugin marketplace add <repo-url>
claude plugin install <plugin-name>
```

### Validate
```bash
claude plugin validate plugins/<plugin-name>
```

### Local testing
```bash
claude --plugin-dir plugins/<plugin-name>
```
