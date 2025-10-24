#!/bin/bash
# Complete Godot + Zed integration setup script

echo "🎮 Setting up Godot + Zed Integration"
echo "======================================"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check prerequisites
echo "📋 Checking Prerequisites..."
echo ""

# Check Zed
if ! command -v zed &> /dev/null; then
    echo -e "${RED}✗${NC} Zed not installed"
    echo "  Install: brew install --cask zed"
    exit 1
else
    echo -e "${GREEN}✓${NC} Zed installed"
fi

# Check Godot
if ! command -v godot &> /dev/null; then
    echo -e "${YELLOW}⚠${NC} Godot not found in PATH"
    echo "  You can still use this, but LSP won't work without Godot"
    echo "  Install: brew install --cask godot"
else
    echo -e "${GREEN}✓${NC} Godot installed"
    GODOT_VERSION=$(godot --version 2>&1 | head -1 || echo "unknown")
    echo "  Version: $GODOT_VERSION"
fi

# Check netcat
if ! command -v nc &> /dev/null; then
    echo -e "${YELLOW}⚠${NC} Netcat not installed (needed for LSP)"
    echo "  Install: brew install netcat"
else
    echo -e "${GREEN}✓${NC} Netcat installed"
fi

echo ""
echo "🔧 Setting up Extension..."
echo ""

# 1. Link extension
EXTENSION_PATH="/Users/jseidel/GitHub/zed-godot-enhanced"
ZED_EXTENSIONS="$HOME/.config/zed/extensions"

mkdir -p "$ZED_EXTENSIONS"

if [ -L "$ZED_EXTENSIONS/godot-enhanced" ]; then
    echo -e "${GREEN}✓${NC} Extension already linked"
else
    ln -sf "$EXTENSION_PATH" "$ZED_EXTENSIONS/godot-enhanced"
    echo -e "${GREEN}✓${NC} Extension linked"
fi

# 2. Create/Update Zed settings
ZED_SETTINGS="$HOME/.config/zed/settings.json"

echo -e "${BLUE}→${NC} Configuring Zed settings..."

if [ ! -f "$ZED_SETTINGS" ]; then
    # Create new settings file
    cat > "$ZED_SETTINGS" << 'EOF'
{
  "theme": "One Dark",
  "buffer_font_size": 13,
  "tab_size": 4,
  "languages": {
    "GDScript": {
      "tab_size": 4,
      "hard_tabs": false,
      "format_on_save": "off",
      "formatter": {
        "external": {
          "command": "gdformat",
          "arguments": ["-"]
        }
      }
    }
  },
  "lsp": {
    "gdscript": {
      "binary": {
        "path": "nc",
        "arguments": ["127.0.0.1", "6005"]
      }
    }
  }
}
EOF
    echo -e "${GREEN}✓${NC} Zed settings created"
else
    echo -e "${GREEN}✓${NC} Zed settings already exist"
    echo "  Location: $ZED_SETTINGS"
    echo "  (Manual LSP config needed if not already set)"
fi

# 3. Setup Godot external editor (if Godot project exists)
echo ""
echo "🎮 Godot Configuration..."
echo ""

GODOT_PROJECT="/Users/jseidel/GitHub/sporeguard-v2/project.godot"

if [ -f "$GODOT_PROJECT" ]; then
    echo -e "${GREEN}✓${NC} Found Godot project: sporeguard-v2"
    echo ""
    echo -e "${YELLOW}Manual Step Required:${NC}"
    echo "  1. Open Godot: godot $GODOT_PROJECT"
    echo "  2. Go to: Editor → Editor Settings"
    echo "  3. Navigate to: Text Editor → External"
    echo "  4. Enable: 'Use External Editor'"
    echo "  5. Set 'Exec Path': $(which zed)"
    echo "  6. Set 'Exec Flags': {project} {file}:{line}:{col}"
    echo ""
    echo "  Navigate to: Network → Language Server"
    echo "  7. Enable: 'Enable Language Server'"
    echo "  8. Host: 127.0.0.1"
    echo "  9. Port: 6005"
else
    echo -e "${YELLOW}⚠${NC} Godot project not found"
    echo "  When you have a project, configure external editor in Godot"
fi

echo ""
echo "📝 Optional: Install gdformat for code formatting"
echo ""
echo "  pip install gdformat"
echo "  or: pip3 install gdformat"

echo ""
echo "═══════════════════════════════════════════"
echo "✅ Setup Complete!"
echo "═══════════════════════════════════════════"
echo ""
echo "🚀 Next Steps:"
echo ""
echo "1. Restart Zed:"
echo "   killall zed && zed"
echo ""
echo "2. Open a .gd file:"
echo "   zed ~/GitHub/sporeguard-v2/scripts/player/player_controller.gd"
echo ""
echo "3. Check syntax highlighting works"
echo ""
echo "4. (Optional) Start Godot for LSP:"
echo "   godot ~/GitHub/sporeguard-v2/project.godot &"
echo ""
echo "5. Test autocomplete (type: Input.)"
echo ""
echo "📚 Documentation:"
echo "  - TESTING_GUIDE.md - Complete testing guide"
echo "  - README.md - Full documentation"
echo "  - ./scripts/test_local.sh - Run automated tests"
echo ""
echo "🎉 Happy coding with Godot + Zed!"
