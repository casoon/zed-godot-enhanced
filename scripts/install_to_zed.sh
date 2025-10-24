#!/bin/bash
set -e

echo "🔧 Installing Godot Enhanced Extension to Zed..."
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Paths
EXTENSION_DIR="/Users/jseidel/GitHub/zed-godot-enhanced"
ZED_EXTENSIONS_DIR="$HOME/.config/zed/extensions"
TARGET_DIR="$ZED_EXTENSIONS_DIR/godot-enhanced"

# Step 1: Check if Zed is running
if pgrep -x "zed" > /dev/null; then
    echo -e "${YELLOW}⚠️  Zed ist noch aktiv. Bitte Zed schließen und Enter drücken...${NC}"
    read -p "Press Enter wenn Zed geschlossen ist..."
fi

# Step 2: Create extensions directory
echo "📁 Erstelle Extensions-Verzeichnis..."
mkdir -p "$ZED_EXTENSIONS_DIR"

# Step 3: Remove old symlink/directory if exists
if [ -e "$TARGET_DIR" ] || [ -L "$TARGET_DIR" ]; then
    echo "🗑️  Entferne alte Extension..."
    rm -rf "$TARGET_DIR"
fi

# Step 4: Create symlink
echo "🔗 Verlinke Extension..."
ln -sf "$EXTENSION_DIR" "$TARGET_DIR"

# Step 5: Verify
if [ -L "$TARGET_DIR" ]; then
    echo -e "${GREEN}✅ Extension erfolgreich verlinkt!${NC}"
    echo "   Ziel: $TARGET_DIR"
    echo "   Quelle: $(readlink $TARGET_DIR)"
else
    echo -e "${RED}❌ Fehler beim Verlinken!${NC}"
    exit 1
fi

# Step 6: Verify extension files
echo ""
echo "📋 Prüfe Extension-Dateien..."
required_files=(
    "extension.toml"
    "languages/gdscript/config.toml"
    "languages/gdscript/highlights.scm"
    "languages/gdshader/config.toml"
    "languages/godot_resource/config.toml"
)

all_good=true
for file in "${required_files[@]}"; do
    if [ -f "$TARGET_DIR/$file" ]; then
        echo -e "   ${GREEN}✓${NC} $file"
    else
        echo -e "   ${RED}✗${NC} $file (FEHLT!)"
        all_good=false
    fi
done

if [ "$all_good" = true ]; then
    echo -e "${GREEN}✅ Alle benötigten Dateien vorhanden!${NC}"
else
    echo -e "${RED}❌ Einige Dateien fehlen!${NC}"
    exit 1
fi

# Step 7: Check Zed settings
echo ""
echo "⚙️  Prüfe Zed-Konfiguration..."
ZED_SETTINGS="$HOME/.config/zed/settings.json"

if [ ! -f "$ZED_SETTINGS" ]; then
    echo "📝 Erstelle Zed settings.json..."
    cat > "$ZED_SETTINGS" << 'EOF'
{
  "language_models": {
    "anthropic": {
      "version": "1"
    }
  },
  "assistant": {
    "default_model": {
      "provider": "anthropic",
      "model": "claude-3-5-sonnet-20241022"
    },
    "version": "2"
  },
  "languages": {
    "GDScript": {
      "format_on_save": "off",
      "tab_size": 4,
      "hard_tabs": true
    }
  }
}
EOF
    echo -e "${GREEN}✅ settings.json erstellt${NC}"
else
    echo -e "${GREEN}✅ settings.json existiert bereits${NC}"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}🎉 Installation abgeschlossen!${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📝 Nächste Schritte:"
echo ""
echo "1. Starte Zed:"
echo "   $ zed"
echo ""
echo "2. Prüfe Extensions:"
echo "   - Drücke Cmd+Shift+P"
echo "   - Tippe: 'extensions'"
echo "   - Wähle: 'zed: extensions'"
echo "   - Suche nach 'Godot Enhanced'"
echo ""
echo "3. Teste die Extension:"
echo "   $ zed /Users/jseidel/GitHub/zed-godot-enhanced/tests/fixtures/test_gdscript.gd"
echo ""
echo "   Prüfe:"
echo "   - Unten rechts sollte 'GDScript' stehen (nicht 'Plain Text')"
echo "   - Keywords sollten farbig sein"
echo "   - Cmd+Shift+O sollte Symbol-Outline zeigen"
echo ""
echo "💡 Debug-Tipp:"
echo "   Wenn die Extension nicht erscheint:"
echo "   - Cmd+Shift+P → 'zed: open log'"
echo "   - Suche nach 'godot' oder 'extension'"
echo ""
