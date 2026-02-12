#!/bin/bash
# Warcraft III Claude Code Sound Hook - Installer
# Copies sound files and scripts to ~/.claude/ for use as Claude Code hooks

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEST_DIR="$HOME/.claude"

echo "=== Warcraft III Claude Code Sound Hook Installer ==="
echo ""

# Copy sounds
echo "Copying sound files to $DEST_DIR/wc3sounds/ ..."
mkdir -p "$DEST_DIR/wc3sounds"
cp -r "$SCRIPT_DIR/sounds/"* "$DEST_DIR/wc3sounds/"

# Copy scripts
echo "Copying hook scripts to $DEST_DIR/ ..."
cp "$SCRIPT_DIR/scripts/wc3_accept.sh" "$DEST_DIR/wc3_accept.sh"
cp "$SCRIPT_DIR/scripts/wc3_complete.sh" "$DEST_DIR/wc3_complete.sh"
chmod +x "$DEST_DIR/wc3_accept.sh" "$DEST_DIR/wc3_complete.sh"

echo ""
echo "Done! Files installed to $DEST_DIR/"
echo ""
echo "=== Next Step ==="
echo ""
echo "Add the following hooks to your ~/.claude/settings.json:"
echo ""
cat <<'JSONEOF'
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "type": "command",
        "command": "$HOME/.claude/wc3_accept.sh"
      }
    ],
    "Stop": [
      {
        "type": "command",
        "command": "$HOME/.claude/wc3_complete.sh"
      }
    ]
  }
}
JSONEOF
echo ""
echo "If you already have hooks configured, merge the entries into"
echo "your existing UserPromptSubmit and Stop arrays."
echo ""
echo "Lok'tar ogar! Ready to code."
