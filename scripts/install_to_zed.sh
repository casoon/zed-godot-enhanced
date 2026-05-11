#!/bin/bash
# Link this extension into the Zed local extensions directory for development.
# On macOS: ~/Library/Application Support/Zed/extensions/installed/
# On Linux: ~/.config/zed/extensions/installed/
#
# Alternatively, use Zed's built-in: Extensions > Install Dev Extension...

set -euo pipefail

EXTENSION_DIR="$(cd "$(dirname "$0")/.." && pwd)"

case "$(uname -s)" in
    Darwin)
        ZED_EXTENSIONS_DIR="$HOME/Library/Application Support/Zed/extensions/installed"
        ;;
    Linux)
        ZED_EXTENSIONS_DIR="$HOME/.config/zed/extensions/installed"
        ;;
    *)
        echo "Unsupported platform: $(uname -s)" >&2
        exit 1
        ;;
esac

TARGET="$ZED_EXTENSIONS_DIR/godot-enhanced"

echo "Extension source: $EXTENSION_DIR"
echo "Zed extensions dir: $ZED_EXTENSIONS_DIR"

mkdir -p "$ZED_EXTENSIONS_DIR"

if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
    rm -rf "$TARGET"
fi

ln -sf "$EXTENSION_DIR" "$TARGET"
echo "Linked: $TARGET -> $EXTENSION_DIR"
echo ""
echo "Restart Zed to pick up the extension."
