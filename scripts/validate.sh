#!/bin/bash
# Validate repository structure and build status.

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASSED=0
FAILED=0

pass() { PASSED=$((PASSED+1)); echo -e "${GREEN}✓${NC} $1"; }
fail() { FAILED=$((FAILED+1)); echo -e "${RED}✗${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC}  $1"; }

echo "=== Phase 1: File structure ==="

for f in \
    extension.toml Cargo.toml README.md src/gdscript.rs \
    languages/gdscript/config.toml languages/gdscript/highlights.scm \
    languages/gdscript/indents.scm languages/gdscript/outline.scm \
    languages/gdscript/brackets.scm languages/gdscript/injections.scm \
    languages/gdshader/config.toml languages/gdshader/highlights.scm \
    languages/gdshader/outline.scm \
    languages/godot_resource/config.toml \
    debug_adapter_schemas/godot.json \
    tests/fixtures/test_gdscript.gd
do
    if [ -f "$f" ]; then pass "$f"; else fail "$f missing"; fi
done

echo ""
echo "=== Phase 2: JSON validity ==="

if command -v jq &>/dev/null; then
    if jq empty debug_adapter_schemas/godot.json 2>/dev/null; then
        pass "debug_adapter_schemas/godot.json is valid JSON"
    else
        fail "debug_adapter_schemas/godot.json is invalid JSON"
    fi
else
    warn "jq not installed, skipping JSON validation"
fi

echo ""
echo "=== Phase 3: Rust tests ==="

if command -v cargo &>/dev/null; then
    if cargo test 2>&1 | grep -q "test result: ok"; then
        pass "cargo test"
    else
        fail "cargo test"
    fi
else
    warn "cargo not installed, skipping"
fi

echo ""
echo "=== Phase 4: WASM extension build ==="

if command -v cargo &>/dev/null; then
    if rustup target list --installed 2>/dev/null | grep -q "wasm32-wasip1"; then
        if cargo build --release --target wasm32-wasip1 2>&1 | grep -q "Finished"; then
            pass "WASM build (wasm32-wasip1)"
        else
            fail "WASM build failed"
        fi
    else
        warn "wasm32-wasip1 target not installed — run: rustup target add wasm32-wasip1"
        FAILED=$((FAILED+1))
    fi
else
    warn "cargo not installed, skipping WASM build"
fi

echo ""
echo "=== Summary ==="
TOTAL=$((PASSED+FAILED))
echo "Passed: $PASSED / $TOTAL"

if [ "$FAILED" -gt 0 ]; then
    echo -e "${RED}$FAILED check(s) failed.${NC}"
    exit 1
else
    echo -e "${GREEN}All checks passed.${NC}"
fi
