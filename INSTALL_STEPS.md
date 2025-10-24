# 🎯 GDScript in Zed - Schnelle Installation

## ✅ Methode 1: Extension Store (EMPFOHLEN - 30 Sekunden)

### In Zed:

1. **Öffne Extension Store**
   - Drücke: `Cmd+Shift+X` ODER
   - Drücke: `Cmd+Shift+P` → Tippe "extensions"

2. **Suche GDScript**
   - Suchfeld: Tippe `gdscript` oder `godot`
   - Du solltest eine Extension sehen

3. **Installiere**
   - Klicke auf **"Install"**
   - Warte 5-10 Sekunden

4. **Teste**
   - Öffne eine `.gd` Datei
   - Unten rechts sollte **"GDScript"** stehen
   - Keywords sollten farbig sein

### Test-Befehl:
```bash
zed ~/GitHub/sporeguard-v2/scripts/enemies/enemy_controller.gd
```

---

## 🛠️ Methode 2: Dev Extension (Falls Methode 1 nicht funktioniert)

### Problem mit "Install Dev Extension":

Der Button funktioniert nur, wenn:
- ✅ `extension.toml` vorhanden
- ✅ Rust-Code kompiliert
- ✅ Korrekte Verzeichnisstruktur

### Lösung: Manuelle Installation

```bash
# 1. Zed beenden
killall -9 zed

# 2. Extension verlinken
rm -rf ~/.config/zed/extensions/godot-enhanced
ln -sf ~/GitHub/zed-godot-enhanced ~/.config/zed/extensions/godot-enhanced

# 3. Zed starten
zed

# 4. Warte 10 Sekunden (Grammatiken werden kompiliert)

# 5. Test
zed ~/GitHub/sporeguard-v2/scripts/enemies/enemy_controller.gd
```

---

## 🔍 Debug: Prüfe ob Extension geladen wird

### In Zed:

1. **Öffne Developer Console**
   - `Cmd+Shift+P` → "zed: open log"
   
2. **Suche nach "godot" oder "extension"**
   - `Cmd+F` → Tippe "godot"
   
3. **Prüfe auf Fehler**
   - Suche nach "ERROR" oder "failed"

### Im Terminal:

```bash
# Prüfe Symlink
ls -la ~/.config/zed/extensions/ | grep godot

# Prüfe Extension-Dateien
ls -la ~/.config/zed/extensions/godot-enhanced/

# Prüfe ob Binary existiert
ls -la ~/GitHub/zed-godot-enhanced/target/release/*.dylib
```

---

## ❓ Was machst du wenn...

### "Install Dev Extension" macht nichts

**Ursache:** Zed erwartet möglicherweise ein anderes Format.

**Lösung:** Verwende **Methode 1** (Extension Store) oder manuelle Installation.

### Extension erscheint nicht in Liste

**Das ist normal!** Dev Extensions erscheinen nicht in der Liste, funktionieren aber trotzdem.

**Prüfe:** Öffne eine `.gd` Datei - steht unten rechts "GDScript"?

### "Unknown" statt "GDScript"

**Ursache:** Tree-sitter Grammatiken nicht kompiliert.

**Lösung:**
```bash
# Option A: Extension Store verwenden (empfohlen)
# In Zed: Cmd+Shift+X → Suche "GDScript" → Install

# Option B: Warte länger
# Nach Installation: Warte 30-60 Sekunden
# Zed kompiliert im Hintergrund

# Option C: Zed neu starten
killall -9 zed && zed
```

### Kein Syntax Highlighting

**Ursache:** Grammatiken fehlen oder nicht kompiliert.

**Lösung:**
1. Installiere über Extension Store (Methode 1)
2. Falls das nicht hilft, prüfe Logs (siehe oben)

---

## 🎯 Empfohlener Workflow

### Für schnelle Nutzung:

```bash
# 1. In Zed Extension Store → Installiere "GDScript"
# 2. Teste:
zed ~/GitHub/sporeguard-v2
```

### Für Entwicklung an der Extension:

```bash
# 1. Installiere zuerst aus Store (für Grammatiken)
# 2. Dann ersetze mit Dev Version:
ln -sf ~/GitHub/zed-godot-enhanced ~/.config/zed/extensions/godot-enhanced
killall -9 zed && zed
```

---

## 💡 Nächste Schritte

Sobald GDScript funktioniert:

1. ✅ **Syntax Highlighting** - Sollte direkt funktionieren
2. 🔧 **LSP Setup** - Siehe `TESTING_GUIDE.md`
3. 🎮 **Godot Integration** - Siehe `QUICKSTART.md`

---

## 📞 Noch Probleme?

```bash
# Debug-Script ausführen
~/GitHub/zed-godot-enhanced/scripts/debug_zed_extension.sh

# Logs prüfen
tail -f ~/Library/Logs/Zed/Zed.log | grep -i godot
```

**Oder:** Screenshot vom Extension Store schicken 📸
