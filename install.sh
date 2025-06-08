#!/bin/bash

# Pretty Git Push Installation Script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRETTY_PUSH="$SCRIPT_DIR/pretty-git-push"

echo "🚀 Installing Pretty Git Push..."
echo ""
echo "Choose installation method:"
echo "1) git p (alias) - Type 'git p' instead of 'git push'"
echo "2) Override git push - Replace 'git push' with pretty version"
echo ""
read -p "Enter choice (1 or 2): " choice

case $choice in
    1)
        echo ""
        echo "📝 Setting up 'git p' alias..."
        git config --global alias.p "!$PRETTY_PUSH"
        echo "✅ Alias created!"
        echo ""
        echo "🎉 Installation complete!"
        echo "Use 'git p' for pretty colored push:"
        echo "  git p origin main"
        echo "  git p --force-with-lease"
        ;;
    2)
        echo ""
        echo "📝 Setting up git push override..."

        # Detect shell
        if [[ -n "$ZSH_VERSION" ]]; then
            SHELL_RC="$HOME/.zshrc"
        elif [[ -n "$BASH_VERSION" ]]; then
            SHELL_RC="$HOME/.bashrc"
        else
            SHELL_RC="$HOME/.profile"
        fi

        # Add function to shell rc file
        echo "" >> "$SHELL_RC"
        echo "# Pretty Git Push Override" >> "$SHELL_RC"
        echo "git() {" >> "$SHELL_RC"
        echo "    if [[ \$1 == \"push\" ]]; then" >> "$SHELL_RC"
        echo "        shift" >> "$SHELL_RC"
        echo "        $PRETTY_PUSH \"\$@\"" >> "$SHELL_RC"
        echo "    else" >> "$SHELL_RC"
        echo "        command git \"\$@\"" >> "$SHELL_RC"
        echo "    fi" >> "$SHELL_RC"
        echo "}" >> "$SHELL_RC"

        echo "✅ Added override function to $SHELL_RC"
        echo ""
        echo "🎉 Installation complete!"
        echo "Restart your terminal or run: source $SHELL_RC"
        echo "Then 'git push' will be colorful:"
        echo "  git push origin main"
        echo "  git push --force-with-lease"
        ;;
    *)
        echo "❌ Invalid choice. Run ./install.sh again."
        exit 1
        ;;
esac

echo ""
echo "To uninstall:"
if [[ $choice == "1" ]]; then
    echo "  git config --global --unset alias.p"
else
    echo "  Remove the git function from $SHELL_RC"
fi