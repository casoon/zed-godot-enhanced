#!/usr/bin/env bash
set -e

echo "🔍 Verifying Godot Enhanced Extension Installation..."
echo ""

# Check symlink
if [ -L ~/.config/zed/extensions/installed/godot-enhanced ]; then
    echo "✅ Extension symlink exists"
    LINK_TARGET=$(readlink ~/.config/zed/extensions/installed/godot-enhanced)
    echo "   → Points to: $LINK_TARGET"
else
    echo "❌ Extension symlink NOT found"
    echo "   Run: ln -sf $(pwd) ~/.config/zed/extensions/installed/godot-enhanced"
    exit 1
fi

# Check WASM binary
if [ -f "extension.wasm" ]; then
    echo "✅ extension.wasm exists ($(du -h extension.wasm | cut -f1))"
else
    echo "❌ extension.wasm NOT found - run 'cargo build --release'"
    exit 1
fi

# Check grammar
if [ -f "grammars/gdscript.wasm" ]; then
    echo "✅ gdscript.wasm grammar exists ($(du -h grammars/gdscript.wasm | cut -f1))"
else
    echo "⚠️  gdscript.wasm grammar NOT found - will compile on first run"
fi

# Check extension.toml
if [ -f "extension.toml" ]; then
    echo "✅ extension.toml exists"
    EXT_ID=$(grep '^id = ' extension.toml | cut -d'"' -f2)
    EXT_NAME=$(grep '^name = ' extension.toml | cut -d'"' -f2)
    EXT_VERSION=$(grep '^version = ' extension.toml | cut -d'"' -f2)
    echo "   → ID: $EXT_ID"
    echo "   → Name: $EXT_NAME"
    echo "   → Version: $EXT_VERSION"
else
    echo "❌ extension.toml NOT found"
    exit 1
fi

# Check languages
echo ""
echo "📦 Language configurations:"
for lang in languages/*/; do
    if [ -d "$lang" ]; then
        LANG_NAME=$(basename "$lang")
        echo "   → $LANG_NAME"
        if [ -f "${lang}config.toml" ]; then
            echo "      ✅ config.toml"
        fi
        if [ -f "${lang}highlights.scm" ]; then
            echo "      ✅ highlights.scm"
        fi
    fi
done

echo ""
echo "✅ Extension appears correctly installed!"
echo ""
echo "📝 Next steps:"
echo "   1. Restart Zed completely (Cmd+Q, then reopen)"
echo "   2. Open test.gd in Zed"
echo "   3. Check if syntax highlighting works"
echo "   4. Check Zed logs if issues: ~/Library/Logs/Zed/Zed.log"
echo ""
