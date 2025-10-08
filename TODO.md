# 📋 TODO - Zed Godot Enhanced Extension

**Ziel: 100% messbare Vollständigkeit & Validierung**

---

## 🎯 Phase 1: Core Extension Setup ✅

### 1.1 Projekt-Struktur
- [x] Repository erstellen
- [x] Verzeichnisstruktur anlegen
- [x] Git initialisieren
- [x] README.md erstellen
- [x] TODO.md erstellen

### 1.2 Extension Configuration
- [ ] `extension.toml` finalisieren
- [ ] `Cargo.toml` erstellen
- [ ] `src/gdscript.rs` implementieren
- [ ] Tree-sitter Grammars integrieren

**Validation:**
- [ ] Extension lädt in Zed ohne Fehler
- [ ] Alle Config-Dateien valide TOML/JSON

---

## 🔧 Phase 2: Language Server Integration

### 2.1 GDScript LSP
- [ ] LSP Binary Wrapper (`src/gdscript.rs`)
- [ ] Netcat Connection Handler
- [ ] Error Handling & Retry Logic
- [ ] Connection Health Monitoring
- [ ] Automatic Reconnection

### 2.2 Configuration
- [ ] Default LSP Settings
- [ ] User Settings Override
- [ ] Port/Host Configuration
- [ ] Timeout Configuration

**Validation:**
- [ ] LSP verbindet zu Godot (Port 6005)
- [ ] Autocomplete funktioniert
- [ ] Go to Definition funktioniert
- [ ] Hover-Tooltips funktionieren
- [ ] Error-Handling zeigt klare Meldungen

**Test Command:**
```bash
./scripts/test_lsp.sh
```

---

## 🎨 Phase 3: Syntax & Grammars

### 3.1 GDScript Grammar
- [ ] Highlights (`languages/gdscript/highlights.scm`)
- [ ] Indents (`languages/gdscript/indents.scm`)
- [ ] Outlines (`languages/gdscript/outlines.scm`)
- [ ] Injections (`languages/gdscript/injections.scm`)
- [ ] Brackets (`languages/gdscript/brackets.scm`)

### 3.2 GDShader Grammar
- [ ] Highlights (`languages/gdshader/highlights.scm`)
- [ ] Indents (`languages/gdshader/indents.scm`)
- [ ] Outlines (`languages/gdshader/outlines.scm`)

### 3.3 Godot Resources
- [ ] `.tres` File Support
- [ ] `.tscn` File Support
- [ ] Syntax Highlighting

**Validation:**
- [ ] Alle Keywords highlighted
- [ ] Korrekte Code-Folding
- [ ] Symbol-Outline zeigt Klassen/Funktionen
- [ ] Bracket-Matching funktioniert

**Test Files:**
- `tests/syntax/test_gdscript.gd`
- `tests/syntax/test_gdshader.gdshader`
- `tests/syntax/test_resource.tres`

---

## 🐛 Phase 4: Debug Adapter

### 4.1 Godot Debug Adapter
- [ ] Debug Adapter Schema (`debug_adapter_schemas/godot.json`)
- [ ] Launch Configuration
- [ ] Attach Configuration
- [ ] Breakpoint Support
- [ ] Variable Inspection
- [ ] Step Debugging

### 4.2 Debug UI
- [ ] Debug Tasks in Zed
- [ ] Breakpoint Visualization
- [ ] Call Stack View

**Validation:**
- [ ] Breakpoints können gesetzt werden
- [ ] Launch startet Godot Debugging
- [ ] Attach verbindet zu laufendem Game
- [ ] Variables sind inspizierbar
- [ ] Step-in/over/out funktioniert

**Test:**
```bash
./scripts/test_debug.sh
```

---

## 🎯 Phase 5: Code Formatting

### 5.1 gdformat Integration
- [ ] External Formatter Config
- [ ] Format on Save
- [ ] Format Selection
- [ ] Format Document

**Validation:**
- [ ] `gdformat` installiert erkannt
- [ ] Format on Save funktioniert
- [ ] Formatierung korrekt nach Godot Style Guide

**Test:**
```bash
echo "func test(): pass" | gdformat -
```

---

## 🧪 Phase 6: Testing & Validation

### 6.1 Test Suite
- [ ] Unit Tests (`tests/unit/`)
- [ ] Integration Tests (`tests/integration/`)
- [ ] Syntax Tests (`tests/syntax/`)
- [ ] LSP Tests (`tests/lsp/`)
- [ ] Debug Tests (`tests/debug/`)

### 6.2 Validation Scripts
- [ ] `scripts/validate.sh` - Gesamtvalidierung
- [ ] `scripts/test_lsp.sh` - LSP-Test
- [ ] `scripts/test_syntax.sh` - Syntax-Test
- [ ] `scripts/test_debug.sh` - Debug-Test
- [ ] `scripts/health_check.sh` - Health-Check

### 6.3 CI/CD
- [ ] GitHub Actions Workflow
- [ ] Automated Testing
- [ ] Linting
- [ ] Coverage Reports

**Validation:**
- [ ] Alle Tests grün
- [ ] Code Coverage >90%
- [ ] Keine Linter-Warnings
- [ ] CI/CD Pipeline funktioniert

---

## 📚 Phase 7: Dokumentation

### 7.1 Core Docs
- [x] `README.md` - Haupt-Dokumentation
- [ ] `CONTRIBUTING.md` - Contribution Guidelines
- [ ] `LICENSE` - MIT License
- [ ] `CHANGELOG.md` - Version History

### 7.2 Extended Docs
- [ ] `docs/SETUP.md` - Detaillierter Setup-Guide
- [ ] `docs/TROUBLESHOOTING.md` - Häufige Probleme
- [ ] `docs/LSP.md` - LSP Konfiguration
- [ ] `docs/DEBUGGING.md` - Debugging-Guide
- [ ] `docs/API.md` - API-Referenz
- [ ] `docs/CONTRIBUTING.md` - Entwickler-Guide

### 7.3 Examples
- [ ] `examples/hello_world.gd`
- [ ] `examples/player_controller.gd`
- [ ] `examples/shader_example.gdshader`
- [ ] `examples/debug_config/.zed/debug.json`

**Validation:**
- [ ] Alle Links funktionieren
- [ ] Code-Beispiele sind korrekt
- [ ] Screenshots aktuell
- [ ] Keine Typos

---

## 🚀 Phase 8: Release & Distribution

### 8.1 Package
- [ ] Version Tag erstellen
- [ ] Release Notes schreiben
- [ ] Package für Zed Extensions erstellen

### 8.2 Publishing
- [ ] Zed Extension Registry Submit
- [ ] GitHub Release
- [ ] Documentation auf GitHub Pages

**Validation:**
- [ ] Extension installierbar via Zed
- [ ] Alle Features funktionieren
- [ ] Dokumentation zugänglich

---

## 📊 Completeness Metrics (100% Ziel)

### Current Status

| Component | Status | Progress | Tests |
|-----------|--------|----------|-------|
| **Extension Config** | 🟢 Done | 100% | ✅ |
| **LSP Integration** | 🟡 In Progress | 20% | ⏳ |
| **Syntax Highlighting** | 🔴 Todo | 0% | ⏳ |
| **Debug Adapter** | 🔴 Todo | 0% | ⏳ |
| **Code Formatting** | 🔴 Todo | 0% | ⏳ |
| **Tests** | 🔴 Todo | 0% | ⏳ |
| **Documentation** | 🟡 In Progress | 40% | ⏳ |
| **CI/CD** | 🔴 Todo | 0% | ⏳ |

**Overall Progress: 20%**

### Validation Criteria (alle müssen ✅ sein)

#### Functional Requirements
- [ ] Extension loads in Zed without errors
- [ ] GDScript files are recognized (`.gd`)
- [ ] GDShader files are recognized (`.gdshader`)
- [ ] Godot Resource files recognized (`.tres`, `.tscn`)
- [ ] LSP connection etablishes automatically
- [ ] Autocomplete works for Godot API
- [ ] Syntax highlighting is correct
- [ ] Code folding works
- [ ] Symbol outline shows classes/functions
- [ ] Debugging works (launch & attach)
- [ ] Formatting with gdformat works
- [ ] No console errors

#### Performance Requirements
- [ ] Extension loads <500ms
- [ ] LSP connection <2s
- [ ] Autocomplete response <100ms
- [ ] Syntax highlighting realtime
- [ ] No memory leaks

#### Quality Requirements
- [ ] All tests pass
- [ ] Code coverage >90%
- [ ] No linter warnings
- [ ] Documentation complete
- [ ] No open critical bugs

---

## 🔄 Development Workflow

### 1. Feature Development
```bash
# Create feature branch
git checkout -b feature/lsp-integration

# Develop & test locally
./scripts/validate.sh

# Commit & push
git commit -m "feat: add LSP integration"
git push origin feature/lsp-integration
```

### 2. Testing
```bash
# Run all tests
cargo test

# Run validation
./scripts/validate.sh

# Test in Zed
ln -s $(pwd) ~/.config/zed/extensions/godot-enhanced
# Restart Zed
```

### 3. Release
```bash
# Update version
vim extension.toml  # bump version

# Create changelog
vim CHANGELOG.md

# Tag & release
git tag -a v1.0.0 -m "Release 1.0.0"
git push --tags
```

---

## 📞 Reference Resources

### Essential Links
- [Zed Extension Docs](https://zed.dev/docs/extensions)
- [Tree-sitter Docs](https://tree-sitter.github.io/tree-sitter/)
- [GDScript Reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/index.html)
- [Godot LSP](https://docs.godotengine.org/en/stable/tutorials/editor/external_editor.html)

### Reference Extensions
- [GDQuest zed-gdscript](https://github.com/GDQuest/zed-gdscript)
- [Zed Python Extension](https://github.com/zed-industries/zed/tree/main/extensions/python)
- [Zed Rust Extension](https://github.com/zed-industries/zed/tree/main/extensions/rust)

---

## 🎯 Next Actions (Priorität)

### High Priority (Woche 1)
1. ✅ Projekt-Setup abschließen
2. ⏳ LSP Integration implementieren
3. ⏳ Basis Syntax Highlighting

### Medium Priority (Woche 2)
4. ⏳ Debug Adapter implementieren
5. ⏳ Tests schreiben
6. ⏳ Dokumentation erweitern

### Low Priority (Woche 3+)
7. ⏳ CI/CD Setup
8. ⏳ Advanced Features
9. ⏳ Performance Optimization

---

**🎉 Ziel: 100% Vollständigkeit & messbare Validation bis Ende Woche 3!**
