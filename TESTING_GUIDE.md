# 🧪 Local Testing Guide

## Quick Start

```bash
# Run test script
./scripts/test_local.sh
```

Dies öffnet automatisch eine Test-Datei in Zed!

---

## ✅ Was zu prüfen ist

### 1. Extension Installation ✓

**Check:** Extension ist geladen
```bash
ls -la ~/.config/zed/extensions/godot-enhanced
```

**Sollte zeigen:** Symlink zu deinem Projekt

**In Zed prüfen:**
- `Cmd+Shift+P` → Type: "extensions"
- "Godot Enhanced" sollte in der Liste sein
- Status: "Installed" (grün)

---

### 2. Syntax Highlighting ✓

**Test File:** `tests/fixtures/test_gdscript.gd`

**Was zu sehen sein sollte:**
- ✅ **Keywords** (`func`, `var`, `class`, `extends`) → **farb-highlighted**
- ✅ **Strings** → anderes Farbe
- ✅ **Comments** (`#`) → gedimmt/grau
- ✅ **Numbers** → eigene Farbe
- ✅ **Types** (`int`, `float`, `String`) → highlighted

**Wenn nicht:** Extension lädt nicht → Zed neu starten

---

### 3. File Type Recognition ✓

**Check:** Bottom-right corner in Zed

**Sollte zeigen:**
- ✅ "GDScript" (wenn .gd file)
- ✅ "GDShader" (wenn .gdshader file)
- ❌ NICHT "Plain Text"

**Wenn Plain Text:**
- Extension nicht geladen
- Zed neu starten: `killall zed && zed`

---

### 4. Code Folding ✓

**Test:**
1. Gehe zu einer Funktion (z.B. `func _ready()`)
2. Klicke auf den kleinen Pfeil links
3. Funktion sollte kollabieren/expandieren

**Sollte funktionieren bei:**
- ✅ Funktionen (`func`)
- ✅ Klassen (`class`)
- ✅ If-Statements
- ✅ For-Loops

---

### 5. Symbol Outline ✓

**Test:**
- `Cmd+Shift+O` (Outline öffnen)

**Sollte zeigen:**
- ✅ `TestScript` (Class)
- ✅ `GameMode` (Enum)
- ✅ Alle Funktionen (`_ready`, `take_damage`, etc.)
- ✅ Signals
- ✅ Variables

**Navigation:**
- Klicke auf Symbol → springt zur Definition

---

### 6. Bracket Matching ✓

**Test:**
1. Cursor auf `(` oder `{` oder `[`
2. Matching bracket sollte highlighted sein

**Sollte funktionieren:**
- ✅ `()` Parentheses
- ✅ `{}` Braces
- ✅ `[]` Brackets

---

### 7. LSP / Autocomplete (Optional)

**Requirement:** Godot muss laufen!

**Setup:**
```bash
# Terminal 1: Start Godot
godot ~/GitHub/sporeguard-v2/project.godot &

# Wait 5 seconds (LSP server starts)

# Terminal 2: Open Zed with Sporeguard project
zed ~/GitHub/sporeguard-v2/scripts/
```

**Test in Zed:**
1. Öffne `player_controller.gd`
2. In einer Funktion, type: `Input.`
3. Autocomplete-Menü sollte erscheinen
4. Zeigt: `Input.is_action_pressed()`, etc.

**Hover Test:**
- Hover über `Vector2` → sollte Dokumentation zeigen

**Go to Definition:**
- `Cmd+Click` auf Godot-API → sollte zu Definition springen

---

## 🐛 Troubleshooting

### Extension lädt nicht

**Symptome:**
- Kein Syntax Highlighting
- File Type zeigt "Plain Text"
- Extension nicht in Liste

**Lösungen:**

1. **Extension neu linken:**
```bash
rm ~/.config/zed/extensions/godot-enhanced
ln -sf /Users/jseidel/GitHub/zed-godot-enhanced ~/.config/zed/extensions/godot-enhanced
```

2. **Zed neu starten:**
```bash
killall zed
zed
```

3. **Extension neu builden:**
```bash
cd /Users/jseidel/GitHub/zed-godot-enhanced
cargo build --release
```

4. **Zed Logs checken:**
```bash
# Zed Console öffnen: Cmd+Shift+P → "zed: open log"
# Suche nach Errors related zu "godot"
```

---

### LSP verbindet nicht

**Symptome:**
- Kein Autocomplete
- Keine Hover-Tooltips
- Keine Errors/Warnings

**Lösungen:**

1. **Godot LSP aktivieren:**
   - In Godot: `Editor → Editor Settings → Network → Language Server`
   - ✅ Enable "Language Server"
   - Host: `127.0.0.1`
   - Port: `6005`

2. **LSP Server neu starten:**
   - In Zed: `Cmd+Shift+P` → "editor: restart language server"

3. **Netcat installieren (falls fehlt):**
```bash
brew install netcat
```

4. **Port prüfen:**
```bash
lsof -i :6005
# Sollte Godot zeigen wenn LSP läuft
```

---

### Syntax Highlighting fehlerhaft

**Symptome:**
- Einige Keywords nicht highlighted
- Farben komplett falsch

**Lösungen:**

1. **Tree-sitter Grammar neu laden:**
   - In Zed: `Cmd+Shift+P` → "zed: reload window"

2. **Grammar-Files prüfen:**
```bash
ls -la /Users/jseidel/GitHub/zed-godot-enhanced/languages/gdscript/
# Sollte highlights.scm, indents.scm, etc. zeigen
```

3. **Theme wechseln:**
   - In Zed: `Cmd+K` → `Cmd+T` (Theme selector)
   - Verschiedene Themes testen

---

## 📊 Test Checklist

Gehe durch diese Liste:

- [ ] Extension in `~/.config/zed/extensions` gelinkt
- [ ] Zed neu gestartet
- [ ] Test-File geöffnet (`test_gdscript.gd`)
- [ ] File Type zeigt "GDScript" (nicht "Plain Text")
- [ ] Syntax Highlighting funktioniert (Keywords colored)
- [ ] Code Folding funktioniert (Pfeile bei Funktionen)
- [ ] Symbol Outline funktioniert (`Cmd+Shift+O`)
- [ ] Bracket Matching funktioniert
- [ ] Extension in Extensions-Liste sichtbar
- [ ] (Optional) LSP Autocomplete funktioniert (wenn Godot läuft)

**Wenn alle ✅ → Extension funktioniert perfekt! 🎉**

---

## 🚀 Advanced Testing

### Test mit echtem Projekt

```bash
# Öffne Sporeguard V2 Projekt
zed ~/GitHub/sporeguard-v2

# Öffne Player Controller
# File: scripts/player/player_controller.gd

# Test Features:
# - Syntax Highlighting
# - Symbol Outline
# - Code Navigation
# - (mit Godot) LSP Autocomplete
```

### Test verschiedene File-Typen

```bash
# GDScript
zed tests/fixtures/test_gdscript.gd

# GDShader (shader files)
# Erstelle test.gdshader und öffne

# Godot Resource (.tscn, .tres)
# Öffne eine .tscn Datei aus Godot Projekt
```

---

## 📝 Reporting Issues

Wenn etwas nicht funktioniert:

1. **Logs sammeln:**
```bash
# Zed Console
Cmd+Shift+P → "zed: open log"

# Terminal Output
./scripts/validate.sh > validation_log.txt
```

2. **System Info:**
```bash
# Zed Version
zed --version

# macOS Version
sw_vers

# Extension Status
ls -la ~/.config/zed/extensions/
```

3. **Screenshots:**
- Extension Liste
- File mit/ohne Highlighting
- Error Messages

---

## ✅ Success Criteria

Extension ist **vollständig funktional** wenn:

- ✅ Alle 9 Checklist-Items erfüllt
- ✅ Syntax Highlighting funktioniert
- ✅ Navigation funktioniert (Outline, Go to Definition)
- ✅ File Type korrekt erkannt
- ✅ Keine Errors in Console

---

**Happy Testing! 🧪✨**
