#!/bin/bash

# Pretty Git Push Installation Script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRETTY_PUSH="$SCRIPT_DIR/pretty-git-push"
PRETTY_ADD="$SCRIPT_DIR/pretty-git-add"
PRETTY_COMMIT="$SCRIPT_DIR/pretty-git-commit"

echo "🚀 Installing Pretty Git Push..."
echo ""
echo "Choose installation method:"
echo "1) Aliases (git p, git a, git c) - Type 'git p', 'git a', 'git c'"
echo "2) Override git commands - Replace 'git push', 'git add', 'git commit'"
echo ""
read -p "Enter choice (1 or 2): " choice

case $choice in
    1)
        echo ""
        echo "📝 Setting up git aliases..."
        git config --global alias.p "!$PRETTY_PUSH"
        git config --global alias.a "!$PRETTY_ADD"
        git config --global alias.c "!$PRETTY_COMMIT"
        echo "✅ Aliases created!"
        echo ""
        echo "🎉 Installation complete!"
        echo "Use pretty git commands:"
        echo "  git p origin main    (push)"
        echo "  git a .             (add)"
        echo "  git c -m 'message'  (commit)"
        ;;
    2)
        echo ""
        echo "📝 Setting up git command overrides..."

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
        echo "# Pretty Git Commands Override" >> "$SHELL_RC"
        echo "git() {" >> "$SHELL_RC"
        echo "    if [[ \$1 == \"push\" ]]; then" >> "$SHELL_RC"
        echo "        shift" >> "$SHELL_RC"
        echo "        $PRETTY_PUSH \"\$@\"" >> "$SHELL_RC"
        echo "    elif [[ \$1 == \"add\" ]]; then" >> "$SHELL_RC"
        echo "        shift" >> "$SHELL_RC"
        echo "        $PRETTY_ADD \"\$@\"" >> "$SHELL_RC"
        echo "    elif [[ \$1 == \"commit\" ]]; then" >> "$SHELL_RC"
        echo "        shift" >> "$SHELL_RC"
        echo "        $PRETTY_COMMIT \"\$@\"" >> "$SHELL_RC"
        echo "    else" >> "$SHELL_RC"
        echo "        command git \"\$@\"" >> "$SHELL_RC"
        echo "    fi" >> "$SHELL_RC"
        echo "}" >> "$SHELL_RC"

        echo "✅ Added override function to $SHELL_RC"
        echo ""
        echo "🎉 Installation complete!"
        echo "Restart your terminal or run: source $SHELL_RC"
        echo "Then git commands will be colorful:"
        echo "  git push origin main"
        echo "  git add ."
        echo "  git commit -m 'message'"
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
    echo "  git config --global --unset alias.a"
    echo "  git config --global --unset alias.c"
else
    echo "  Remove the git function from $SHELL_RC"
fi