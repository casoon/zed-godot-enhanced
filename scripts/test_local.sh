#!/bin/bash
# Local testing script for zed-godot-enhanced extension

echo "🧪 Testing Zed Godot Enhanced Extension Locally"
echo "================================================"
echo ""

# Check if Zed is installed
if ! command -v zed &> /dev/null; then
    echo "❌ Zed is not installed!"
    echo "Install with: brew install --cask zed"
    exit 1
fi

echo "✅ Zed is installed"
echo ""

# Check if extension is linked
if [ -L ~/.config/zed/extensions/godot-enhanced ]; then
    echo "✅ Extension is linked"
    echo "   Location: $(readlink ~/.config/zed/extensions/godot-enhanced)"
else
    echo "❌ Extension is not linked!"
    echo "Linking now..."
    mkdir -p ~/.config/zed/extensions
    ln -sf /Users/jseidel/GitHub/zed-godot-enhanced ~/.config/zed/extensions/godot-enhanced
    echo "✅ Extension linked"
fi

echo ""
echo "📋 Test Checklist:"
echo "=================="
echo ""
echo "1. ✅ Extension linked to Zed"
echo "2. ⏳ Open test file in Zed"
echo "3. ⏳ Check syntax highlighting"
echo "4. ⏳ Check code folding"
echo "5. ⏳ Check symbol outline"
echo "6. ⏳ Test LSP (if Godot running)"
echo ""

# Open test file in Zed
TEST_FILE="/Users/jseidel/GitHub/zed-godot-enhanced/tests/fixtures/test_gdscript.gd"

if [ -f "$TEST_FILE" ]; then
    echo "🚀 Opening test file in Zed..."
    echo "   File: $TEST_FILE"
    echo ""
    
    # Open Zed with test file
    zed "$TEST_FILE" &
    
    echo "✅ Zed opened!"
    echo ""
    echo "📝 Manual Testing Steps:"
    echo "========================"
    echo ""
    echo "1. Check Syntax Highlighting:"
    echo "   - Keywords (func, var, class) should be colored"
    echo "   - Strings should be colored"
    echo "   - Comments (#) should be colored"
    echo ""
    echo "2. Check Code Folding:"
    echo "   - Click on arrows next to functions"
    echo "   - Functions should collapse/expand"
    echo ""
    echo "3. Check Symbol Outline:"
    echo "   - Open outline panel (Cmd+Shift+O)"
    echo "   - Should show: TestScript class, functions, etc."
    echo ""
    echo "4. Check Extension in Zed:"
    echo "   - Cmd+Shift+P → 'zed: extensions'"
    echo "   - Look for 'Godot Enhanced'"
    echo "   - Should show as 'Installed'"
    echo ""
    echo "5. Test LSP (Optional):"
    echo "   - Start Godot: godot ~/GitHub/sporeguard-v2/project.godot &"
    echo "   - Wait 5 seconds"
    echo "   - In Zed: Cmd+Shift+P → 'editor: restart language server'"
    echo "   - Type 'Input.' - should show autocomplete"
    echo ""
    echo "6. Test .gd File Association:"
    echo "   - Bottom right corner should show 'GDScript'"
    echo "   - Not 'Plain Text'"
    echo ""
else
    echo "❌ Test file not found: $TEST_FILE"
    exit 1
fi

echo "─────────────────────────────────────────────"
echo "📊 Expected Results:"
echo "─────────────────────────────────────────────"
echo "✅ File opens with syntax highlighting"
echo "✅ GDScript language detected"
echo "✅ Code folding works"
echo "✅ Symbol outline shows classes/functions"
echo "✅ Extension visible in extensions panel"
echo ""
echo "🎉 If all above work → Extension is functional!"
