# Quick Start

> **Status:** alpha. Core extension files are present; end-to-end validation in Zed is not yet complete. See [TODO.md](TODO.md).

---

## Requirements

- Zed Editor (latest)
- Godot Engine 3.x or 4.x (for LSP features)
- Netcat (`nc` or `ncat`) for LSP communication
- Rust + `wasm32-wasip1` target for building the extension

---

## Install as a dev extension

1. Clone the repository:

   ```bash
   git clone https://github.com/casoon/zed-godot-enhanced.git
   cd zed-godot-enhanced
   ```

2. Build:

   ```bash
   rustup target add wasm32-wasip1
   cargo build --release --target wasm32-wasip1
   ```

3. In Zed, open the Extensions panel (`Cmd+Shift+X` on macOS) and click **Install Dev Extension…**, then select this repository directory.

   Zed loads the extension directly from source. On macOS the managed extensions directory is `~/Library/Application Support/Zed/extensions/`; on Linux it is `~/.config/zed/extensions/`.

4. Restart Zed and open a `.gd` file. The status bar should show **GDScript**.

---

## Enable the Godot Language Server

For autocomplete, hover, and go-to-definition, Godot's built-in language server must be running:

1. Open Godot Editor.
2. Go to **Editor → Editor Settings → Network → Language Server**.
3. Enable **Language Server** and confirm host `127.0.0.1` and port `6005`.

The extension connects to `127.0.0.1:6005` by default. Override with Zed's LSP settings:

```json
{
  "lsp": {
    "gdscript": {
      "binary": {
        "arguments": ["127.0.0.1", "6005"]
      }
    }
  }
}
```

---

## Enable Godot as external editor (optional)

In Godot: **Editor → Editor Settings → Text Editor → External**

- Enable **Use External Editor**
- Exec Path: path to your `zed` binary (e.g. `/usr/local/bin/zed`)
- Exec Flags: `{project} {file}:{line}:{col}`

---

## Debugging

Create `.zed/debug.json` in your Godot project root:

```json
{
  "label": "Godot",
  "adapter": "godot",
  "request": "launch",
  "host": "127.0.0.1",
  "port": 6006
}
```

Press `F5` to start a debugging session. Requires Godot's remote debugger enabled and running.

Debugging support needs end-to-end validation. See [issue #8](https://github.com/casoon/zed-godot-enhanced/issues/8).

---

## Troubleshooting

**Extension not loading?**
- Check Zed logs: `Cmd+Shift+P` → "zed: open log", search for "godot".
- On macOS: `~/Library/Logs/Zed/Zed.log`

**No syntax highlighting?**
- Confirm the status bar shows "GDScript" (not "Plain Text") when a `.gd` file is open.
- Zed compiles tree-sitter grammars on first load; wait a few seconds after installing.

**LSP not connecting?**
- Confirm Godot is running with the language server enabled.
- Check port 6005 is open: `lsof -i :6005`
- Restart the language server in Zed: `Cmd+Shift+P` → "editor: restart language server"
