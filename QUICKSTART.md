# ⚡ Quick Start - Get Running in 2 Minutes!

## 🚀 Fastest Path to Success

### 1. Run Setup (30 seconds)
```bash
cd /Users/jseidel/GitHub/zed-godot-enhanced
./scripts/setup_godot_integration.sh
```

This automatically:
- ✅ Links extension to Zed
- ✅ Configures Zed settings (if needed)
- ✅ Checks prerequisites
- ✅ Shows what's working

### 2. Restart Zed (5 seconds)
```bash
killall zed && zed
```

### 3. Test It! (30 seconds)
```bash
./scripts/test_local.sh
```

This opens a test file in Zed with full syntax highlighting!

---

## ✅ What Should Work Immediately

### Without Godot Running:
- ✅ **Syntax Highlighting** - Keywords, strings, comments colored
- ✅ **File Type Recognition** - Shows "GDScript" not "Plain Text"
- ✅ **Code Folding** - Collapse/expand functions
- ✅ **Symbol Outline** (`Cmd+Shift+O`) - Navigate classes/functions
- ✅ **Bracket Matching** - Highlighting matching brackets

### With Godot Running:
- ✅ **LSP Autocomplete** - Type `Input.` and see suggestions
- ✅ **Hover Tooltips** - Hover over Godot APIs
- ✅ **Go to Definition** - `Cmd+Click` on symbols
- ✅ **Error Detection** - Real-time syntax errors

---

## 🎮 Quick Test Workflow

### Test #1: Basic Features (No Godot)
```bash
# Open test file
zed /Users/jseidel/GitHub/zed-godot-enhanced/tests/fixtures/test_gdscript.gd

# Check:
# ✅ Keywords are colored
# ✅ Bottom-right shows "GDScript"
# ✅ Can fold functions (click arrows)
```

### Test #2: Real Project (No Godot)
```bash
# Open Sporeguard project
zed ~/GitHub/sporeguard-v2/scripts/player/player_controller.gd

# Check:
# ✅ Syntax highlighting works
# ✅ Cmd+Shift+O shows outline
# ✅ Navigation works
```

### Test #3: LSP Features (With Godot)
```bash
# Terminal 1: Start Godot
godot ~/GitHub/sporeguard-v2/project.godot &

# Wait 5 seconds for LSP to start

# Terminal 2: Open Zed
zed ~/GitHub/sporeguard-v2/scripts/player/player_controller.gd

# In Zed:
# - Type: Input.
# - Should see autocomplete!
# - Hover over Vector2 → shows docs
```

---

## 📊 Success Checklist

Run through this in 60 seconds:

- [ ] Extension linked: `ls -la ~/.config/zed/extensions/godot-enhanced`
- [ ] Zed shows extension: `Cmd+Shift+P` → "extensions" → See "Godot Enhanced"
- [ ] Open .gd file shows "GDScript" in bottom-right
- [ ] Keywords are syntax highlighted
- [ ] Can fold functions (arrows visible)
- [ ] `Cmd+Shift+O` shows outline

**If all ✅ → You're ready to code!**

---

## 🐛 Quick Fixes

### Extension not loading?
```bash
# Re-link and restart
rm ~/.config/zed/extensions/godot-enhanced
ln -sf /Users/jseidel/GitHub/zed-godot-enhanced ~/.config/zed/extensions/godot-enhanced
killall zed && zed
```

### No syntax highlighting?
```bash
# Rebuild and restart
cd /Users/jseidel/GitHub/zed-godot-enhanced
cargo build --release
killall zed && zed
```

### LSP not working?
```bash
# Check Godot is running
ps aux | grep godot

# Check port is open
lsof -i :6005

# Restart LSP in Zed
# Cmd+Shift+P → "editor: restart language server"
```

---

## 📚 Next Steps

### Learn More:
- **TESTING_GUIDE.md** - Comprehensive testing instructions
- **README.md** - Complete documentation
- **TODO.md** - Roadmap & validation criteria

### Use It:
```bash
# Edit Sporeguard V2
zed ~/GitHub/sporeguard-v2

# Start Godot for LSP
godot ~/GitHub/sporeguard-v2/project.godot &
```

---

## 🎯 Advanced: Full Integration

Want the complete experience?

### 1. Install gdformat (Optional)
```bash
pip3 install gdformat
```

### 2. Configure Godot External Editor
1. Open Godot
2. `Editor → Editor Settings → Text Editor → External`
3. Enable "Use External Editor"
4. Exec Path: `/usr/local/bin/zed` (or `which zed`)
5. Exec Flags: `{project} {file}:{line}:{col}`

### 3. Enable Godot LSP
1. Still in Editor Settings
2. `Network → Language Server`
3. Enable "Language Server"
4. Host: `127.0.0.1`
5. Port: `6005`

### 4. Enjoy!
Now when you click errors in Godot, it opens in Zed at the exact line! 🎉

---

## 💡 Pro Tips

### Shortcuts:
- `Cmd+Shift+O` - Symbol Outline
- `Cmd+P` - Quick File Open
- `Cmd+Shift+P` - Command Palette
- `Cmd+Click` - Go to Definition
- `Cmd+/` - Toggle Comment

### Workflow:
1. Keep Godot running in background (LSP)
2. Edit code in Zed (fast, modern)
3. Test in Godot (F5)
4. Iterate! 🔄

---

**⏱️ Time to productivity: ~2 minutes!**

**🎉 You're ready to code with Godot + Zed!**
