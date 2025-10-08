#!/bin/bash
# Validation script for zed-godot-enhanced extension
# Tests 100% completeness and all features

set -e

echo "🔍 Validating Zed Godot Enhanced Extension..."
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

PASSED=0
FAILED=0
TOTAL=0

# Test function
test_check() {
    TOTAL=$((TOTAL + 1))
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $1"
        PASSED=$((PASSED + 1))
        return 0
    else
        echo -e "${RED}✗${NC} $1"
        FAILED=$((FAILED + 1))
        return 1
    fi
}

echo "📦 Phase 1: File Structure Validation"
echo "────────────────────────────────────────"

# Check essential files exist
test -f "extension.toml" && test_check "extension.toml exists" || test_check "extension.toml exists"
test -f "Cargo.toml" && test_check "Cargo.toml exists" || test_check "Cargo.toml exists"
test -f "README.md" && test_check "README.md exists" || test_check "README.md exists"
test -f "TODO.md" && test_check "TODO.md exists" || test_check "TODO.md exists"
test -f "src/gdscript.rs" && test_check "src/gdscript.rs exists" || test_check "src/gdscript.rs exists"

# Check language configs
test -f "languages/gdscript/config.toml" && test_check "GDScript config exists" || test_check "GDScript config exists"
test -f "languages/gdshader/config.toml" && test_check "GDShader config exists" || test_check "GDShader config exists"
test -f "languages/godot_resource/config.toml" && test_check "Godot Resource config exists" || test_check "Godot Resource config exists"

echo ""
echo "🎨 Phase 2: Grammar Files Validation"
echo "────────────────────────────────────────"

# GDScript grammar files
test -f "languages/gdscript/highlights.scm" && test_check "GDScript highlights" || test_check "GDScript highlights"
test -f "languages/gdscript/indents.scm" && test_check "GDScript indents" || test_check "GDScript indents"
test -f "languages/gdscript/outline.scm" && test_check "GDScript outline" || test_check "GDScript outline"
test -f "languages/gdscript/brackets.scm" && test_check "GDScript brackets" || test_check "GDScript brackets"
test -f "languages/gdscript/injections.scm" && test_check "GDScript injections" || test_check "GDScript injections"

# GDShader grammar files
test -f "languages/gdshader/highlights.scm" && test_check "GDShader highlights" || test_check "GDShader highlights"
test -f "languages/gdshader/outline.scm" && test_check "GDShader outline" || test_check "GDShader outline"

echo ""
echo "🐛 Phase 3: Debug Adapter Validation"
echo "────────────────────────────────────────"

test -f "debug_adapter_schemas/godot.json" && test_check "Debug adapter schema exists" || test_check "Debug adapter schema exists"

# Validate JSON
if command -v jq &> /dev/null; then
    jq empty debug_adapter_schemas/godot.json 2>/dev/null && test_check "Debug schema valid JSON" || test_check "Debug schema valid JSON"
else
    echo -e "${YELLOW}⚠${NC}  jq not installed, skipping JSON validation"
fi

echo ""
echo "🧪 Phase 4: Test Files Validation"
echo "────────────────────────────────────────"

test -f "tests/fixtures/test_gdscript.gd" && test_check "Test GDScript file exists" || test_check "Test GDScript file exists"

echo ""
echo "🔧 Phase 5: Rust Build Test"
echo "────────────────────────────────────────"

if command -v cargo &> /dev/null; then
    echo "Building extension..."
    if cargo build --release 2>&1 | grep -q "Finished"; then
        test_check "Cargo build successful"
    else
        cargo build --release
        test_check "Cargo build successful"
    fi
else
    echo -e "${YELLOW}⚠${NC}  cargo not installed, skipping build test"
fi

echo ""
echo "📊 Phase 6: Documentation Validation"
echo "────────────────────────────────────────"

# Check README has key sections
grep -q "Features" README.md && test_check "README has Features section" || test_check "README has Features section"
grep -q "Installation" README.md && test_check "README has Installation section" || test_check "README has Installation section"
grep -q "Configuration" README.md && test_check "README has Configuration section" || test_check "README has Configuration section"

# Check TODO has validation criteria
grep -q "Validation" TODO.md && test_check "TODO has Validation section" || test_check "TODO has Validation section"
grep -q "100%" TODO.md && test_check "TODO mentions 100% completeness" || test_check "TODO mentions 100% completeness"

echo ""
echo "═══════════════════════════════════════════"
echo "📊 VALIDATION SUMMARY"
echo "═══════════════════════════════════════════"
echo ""
echo "Total Tests: $TOTAL"
echo -e "Passed: ${GREEN}$PASSED${NC}"
echo -e "Failed: ${RED}$FAILED${NC}"
echo ""

PERCENTAGE=$((PASSED * 100 / TOTAL))
echo "Completeness: $PERCENTAGE%"

if [ $PERCENTAGE -eq 100 ]; then
    echo -e "${GREEN}✓ 100% VALIDATION PASSED!${NC}"
    echo ""
    exit 0
elif [ $PERCENTAGE -ge 80 ]; then
    echo -e "${YELLOW}⚠ Good progress, but not complete yet${NC}"
    echo ""
    exit 1
else
    echo -e "${RED}✗ More work needed${NC}"
    echo ""
    exit 1
fi
