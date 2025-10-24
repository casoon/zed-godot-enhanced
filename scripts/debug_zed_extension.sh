#!/bin/bash

echo "🔍 Debugging Zed Godot Extension"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# 1. Check symlink
echo "1️⃣  Extension Symlink:"
if [ -L "$HOME/.config/zed/extensions/godot-enhanced" ]; then
    echo -e "   ${GREEN}✓${NC} Symlink existiert"
    echo "   → $(readlink $HOME/.config/zed/extensions/godot-enhanced)"
else
    echo -e "   ${RED}✗${NC} Symlink fehlt!"
fi
echo ""

# 2. Check extension.toml
echo "2️⃣  Extension Configuration:"
if [ -f "$HOME/.config/zed/extensions/godot-enhanced/extension.toml" ]; then
    echo -e "   ${GREEN}✓${NC} extension.toml gefunden"
    echo "   ID: $(grep '^id' $HOME/.config/zed/extensions/godot-enhanced/extension.toml | cut -d'"' -f2)"
    echo "   Name: $(grep '^name' $HOME/.config/zed/extensions/godot-enhanced/extension.toml | cut -d'"' -f2)"
else
    echo -e "   ${RED}✗${NC} extension.toml fehlt!"
fi
echo ""

# 3. Check language configs
echo "3️⃣  Language Configurations:"
langs=("gdscript" "gdshader" "godot_resource")
for lang in "${langs[@]}"; do
    config="$HOME/.config/zed/extensions/godot-enhanced/languages/$lang/config.toml"
    if [ -f "$config" ]; then
        lang_name=$(grep '^name' "$config" | cut -d'"' -f2)
        echo -e "   ${GREEN}✓${NC} $lang → $lang_name"
    else
        echo -e "   ${RED}✗${NC} $lang/config.toml fehlt!"
    fi
done
echo ""

# 4. Check highlights
echo "4️⃣  Syntax Highlighting Files:"
for lang in "${langs[@]}"; do
    highlights="$HOME/.config/zed/extensions/godot-enhanced/languages/$lang/highlights.scm"
    if [ -f "$highlights" ]; then
        lines=$(wc -l < "$highlights")
        echo -e "   ${GREEN}✓${NC} $lang/highlights.scm ($lines lines)"
    else
        echo -e "   ${RED}✗${NC} $lang/highlights.scm fehlt!"
    fi
done
echo ""

# 5. Check grammars in extension.toml
echo "5️⃣  Grammar Repositories:"
extension_toml="$HOME/.config/zed/extensions/godot-enhanced/extension.toml"
if grep -q "grammars.gdscript" "$extension_toml"; then
    echo -e "   ${GREEN}✓${NC} gdscript grammar definiert"
else
    echo -e "   ${RED}✗${NC} gdscript grammar fehlt!"
fi
if grep -q "grammars.gdshader" "$extension_toml"; then
    echo -e "   ${GREEN}✓${NC} gdshader grammar definiert"
else
    echo -e "   ${RED}✗${NC} gdshader grammar fehlt!"
fi
if grep -q "grammars.godot_resource" "$extension_toml"; then
    echo -e "   ${GREEN}✓${NC} godot_resource grammar definiert"
else
    echo -e "   ${RED}✗${NC} godot_resource grammar fehlt!"
fi
echo ""

# 6. Check Zed process
echo "6️⃣  Zed Process:"
if pgrep -x "zed" > /dev/null; then
    echo -e "   ${GREEN}✓${NC} Zed läuft (PID: $(pgrep -x zed))"
else
    echo -e "   ${YELLOW}⚠${NC}  Zed läuft nicht"
fi
echo ""

# 7. Check Zed logs
echo "7️⃣  Recent Zed Logs:"
ZED_LOG="$HOME/Library/Logs/Zed/Zed.log"
if [ -f "$ZED_LOG" ]; then
    echo -e "   ${GREEN}✓${NC} Log-Datei gefunden"
    echo ""
    echo "   Letzte 10 Zeilen mit 'godot' oder 'extension':"
    echo "   ────────────────────────────────────────────────"
    grep -i -E "(godot|extension)" "$ZED_LOG" | tail -10 || echo "   (keine relevanten Logs)"
else
    echo -e "   ${YELLOW}⚠${NC}  Keine Log-Datei gefunden"
fi
echo ""

# 8. Test file
echo "8️⃣  Test GDScript File:"
test_file="$HOME/.config/zed/extensions/godot-enhanced/tests/fixtures/test_gdscript.gd"
if [ -f "$test_file" ]; then
    echo -e "   ${GREEN}✓${NC} Test-Datei existiert"
    echo "   Pfad: $test_file"
else
    echo -e "   ${RED}✗${NC} Test-Datei fehlt!"
fi
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "💡 Nächste Schritte:"
echo ""
echo "Falls 'Unknown' angezeigt wird:"
echo "1. Zed komplett beenden: killall -9 zed"
echo "2. Extension neu verlinken: ./scripts/install_to_zed.sh"
echo "3. Zed starten: zed"
echo "4. Warten (~5 Sek) während Grammatiken kompiliert werden"
echo "5. .gd Datei öffnen"
echo ""
echo "Falls weiterhin Probleme:"
echo "- Zed Log öffnen: Cmd+Shift+P → 'zed: open log'"
echo "- Nach 'error' oder 'godot' suchen"
echo ""
