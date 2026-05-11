#!/usr/bin/env bash
# Quick check that the extension files are in place.
# Does not verify runtime loading in Zed — for that, see issue #8.

set -euo pipefail

EXTENSION_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "Checking extension files in: $EXTENSION_DIR"
echo ""

FAILED=0

check() {
    if [ -f "$EXTENSION_DIR/$1" ] || [ -d "$EXTENSION_DIR/$1" ]; then
        echo "  ok  $1"
    else
        echo "  MISSING  $1"
        FAILED=$((FAILED+1))
    fi
}

check extension.toml
check Cargo.toml
check src/gdscript.rs
check languages/gdscript/config.toml
check languages/gdscript/highlights.scm
check languages/gdshader/config.toml
check languages/godot_resource/config.toml
check debug_adapter_schemas/godot.json

echo ""

# Check WASM artifact
if [ -f "$EXTENSION_DIR/target/wasm32-wasip1/release/zed_godot_enhanced.wasm" ]; then
    echo "  ok  WASM artifact (target/wasm32-wasip1/release/zed_godot_enhanced.wasm)"
else
    echo "  missing  WASM artifact — run: cargo build --release --target wasm32-wasip1"
    FAILED=$((FAILED+1))
fi

echo ""

if [ "$FAILED" -gt 0 ]; then
    echo "$FAILED item(s) missing."
    exit 1
else
    echo "All required files present."
fi
