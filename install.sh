#!/bin/bash

# Pretty Git Push Installation Script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_PATH="$SCRIPT_DIR/pretty-git-push"

echo "🚀 Installing Pretty Git Push..."

# Check if script exists
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "❌ Error: pretty-git-push script not found at $SCRIPT_PATH"
    exit 1
fi

# Make script executable
chmod +x "$SCRIPT_PATH"
echo "✅ Made script executable"

# Set up git alias
git config --global alias.push "!$SCRIPT_PATH"
echo "✅ Set up git alias"

echo ""
echo "🎉 Installation complete!"
echo ""
echo "Now when you type 'git push', you'll get beautiful colored output with emojis!"
echo "To uninstall: git config --global --unset alias.push"
echo ""
echo "Try it out:"
echo "  git push --help"
echo "  git push origin main"