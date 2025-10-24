# 🔧 Manuelle Installation - GDScript Support in Zed

Da lokale/dev Extensions in Zed die Tree-sitter Grammatiken nicht automatisch kompilieren, müssen wir einen anderen Ansatz wählen.

## ✅ Empfohlener Weg: Offizielle GDScript Extension

### Schritt 1: Extension über Zed installieren

1. Öffne Zed
2. Drücke `Cmd+Shift+P`
3. Tippe: `extensions`
4. Wähle: `zed: extensions`  
5. Suche nach: `GDScript` oder `Godot`
6. Installiere die offizielle Extension

### Schritt 2: Verifizieren

```bash
# Öffne eine .gd Datei
zed ~/GitHub/sporeguard-v2/scripts/enemies/enemy_controller.gd
```

**Prüfe:**
- Unten rechts sollte "GDScript" stehen
- Syntax Highlighting sollte funktionieren

---

## 🛠️ Alternative: Manuelle Grammatik-Kompilierung

Falls du unsere erweiterte Extension verwenden möchtest:

### 1. Installiere zuerst die offizielle Extension (siehe oben)

Das sorgt dafür, dass die Tree-sitter Grammatiken kompiliert werden.

### 2. Dann ersetze sie mit unserer Extension

```bash
# Backup der offiziellen Extension
mv ~/.config/zed/extensions/installed/gdscript ~/.config/zed/extensions/installed/gdscript.backup

# Verlinke unsere Extension
ln -sf /Users/jseidel/GitHub/zed-godot-enhanced ~/.config/zed/extensions/installed/gdscript

# Zed neu starten
killall -9 zed && zed
```

---

## 🎯 Was unsere Extension zusätzlich bietet

Sobald die Grammatiken funktionieren, bietet unsere Extension:

- ✅ **GDScript** - Vollständige Syntax-Unterstützung
- ✅ **GDShader** - Shader-Support (.gdshader Dateien)
- ✅ **Godot Resources** - Support für .tres und .tscn Dateien
- ✅ **Erweiterte Outline** - Bessere Symbol-Navigation
- ✅ **Custom Textobjects** - Für Vim-Mode
- ✅ **Debug-Support** - Godot Debugger-Schema

---

## 📝 Aktueller Status

**Problem:** Zed kompiliert Tree-sitter Grammatiken nicht automatisch für dev/lokale Extensions.

**Lösung:** Installiere erst die offizielle Extension, dann ersetze sie optional mit unserer.

**Langfristige Lösung:** Publiziere unsere Extension im Zed Extension Store.

---

## 🚀 Schnellstart (Empfohlen)

```bash
# 1. Starte Zed
zed

# 2. Installiere GDScript Extension
# Cmd+Shift+P → "extensions" → Suche "GDScript" → Install

# 3. Teste
zed ~/GitHub/sporeguard-v2/scripts/enemies/enemy_controller.gd
```

Das war's! 🎉

---

## 💡 Nächste Schritte

Sobald GDScript funktioniert:

1. **LSP einrichten** - Folge `TESTING_GUIDE.md`
2. **Godot Integration** - Folge `QUICKSTART.md`
3. **Unsere Extension testen** - Falls du die erweiterten Features willst

---

## 🐛 Troubleshooting

### Zed zeigt "Unknown" statt "GDScript"

```bash
# 1. Prüfe ob Extension installiert ist
ls -la ~/.config/zed/extensions/installed/

# 2. Falls leer, installiere über Zed UI
# Cmd+Shift+P → "extensions"

# 3. Zed neu starten
killall -9 zed && zed
```

### Extension zeigt nicht in Liste

Das ist normal für dev Extensions! Sie funktionieren trotzdem, wenn die Dateien korrekt sind.

### Syntax Highlighting funktioniert nicht

Die Tree-sitter Grammatiken wurden nicht kompiliert. Installiere die offizielle Extension zuerst.

---

**Brauche weitere Hilfe? Öffne ein Issue auf GitHub! 🙋‍♂️**
