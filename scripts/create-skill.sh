#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
SKILL_TEMPLATE="$ROOT_DIR/templates/skill-template/SKILL.md"
PLUGINS_DIR="$ROOT_DIR/plugins"

usage() {
    echo "Usage: $0 <plugin-name> <skill-name>"
    echo ""
    echo "Adds a new skill to an existing plugin."
    echo ""
    echo "Arguments:"
    echo "  plugin-name   Name of the existing plugin"
    echo "  skill-name    Name of the new skill (kebab-case)"
    exit 1
}

if [[ $# -lt 2 ]]; then
    usage
fi

PLUGIN_NAME="$1"
SKILL_NAME="$2"
PLUGIN_DIR="$PLUGINS_DIR/$PLUGIN_NAME"
SKILL_DIR="$PLUGIN_DIR/skills/$SKILL_NAME"

if [[ ! -d "$PLUGIN_DIR" ]]; then
    echo "Error: Plugin '$PLUGIN_NAME' does not exist at $PLUGIN_DIR"
    exit 1
fi

if [[ -d "$SKILL_DIR" ]]; then
    echo "Error: Skill '$SKILL_NAME' already exists in plugin '$PLUGIN_NAME'"
    exit 1
fi

echo "Adding skill '$SKILL_NAME' to plugin '$PLUGIN_NAME'..."

# Create skill directory
mkdir -p "$SKILL_DIR/references"

# Copy and customize template
cp "$SKILL_TEMPLATE" "$SKILL_DIR/SKILL.md"
sed -i '' "s/__SKILL_NAME__/$SKILL_NAME/g" "$SKILL_DIR/SKILL.md"

echo "Skill created at: $SKILL_DIR"
echo ""
echo "Next steps:"
echo "  1. Edit $SKILL_DIR/SKILL.md"
echo "  2. Add reference materials to $SKILL_DIR/references/ (optional)"
echo "  3. Test with: claude --plugin-dir $PLUGIN_DIR"
