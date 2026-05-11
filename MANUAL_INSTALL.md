# Manual install notes

See [QUICKSTART.md](QUICKSTART.md) for the recommended install path (Zed's "Install Dev Extension" UI).

If you prefer a manual symlink approach:

## macOS

```bash
EXTENSION_DIR="$(pwd)"
ZED_EXTENSIONS_DIR="$HOME/Library/Application Support/Zed/extensions/installed"
mkdir -p "$ZED_EXTENSIONS_DIR"
ln -sf "$EXTENSION_DIR" "$ZED_EXTENSIONS_DIR/godot-enhanced"
```

## Linux

```bash
EXTENSION_DIR="$(pwd)"
ZED_EXTENSIONS_DIR="$HOME/.config/zed/extensions/installed"
mkdir -p "$ZED_EXTENSIONS_DIR"
ln -sf "$EXTENSION_DIR" "$ZED_EXTENSIONS_DIR/godot-enhanced"
```

Then restart Zed.

> **Note:** The exact local-dev extension path may change between Zed versions. If the symlink approach stops working, use "Install Dev Extension…" from the Zed Extensions panel instead. See [issue #3](https://github.com/casoon/zed-godot-enhanced/issues/3) for tracking.

## Verify

```bash
bash scripts/verify_installation.sh
```
