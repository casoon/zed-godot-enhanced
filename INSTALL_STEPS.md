# Install steps

For the full guide, see [QUICKSTART.md](QUICKSTART.md).

## Recommended: Install Dev Extension (Zed UI)

1. Build the extension:
   ```bash
   rustup target add wasm32-wasip1
   cargo build --release --target wasm32-wasip1
   ```

2. In Zed, open the Extensions panel (`Cmd+Shift+X`) and click **Install Dev Extension…**.
   Select this repository directory.

3. Restart Zed and open a `.gd` file. The status bar should show **GDScript**.

## Alternative: symlink

See [MANUAL_INSTALL.md](MANUAL_INSTALL.md) for platform-specific symlink instructions.

## Troubleshooting

- Check Zed logs: `Cmd+Shift+P` → "zed: open log", search for "godot" or "error".
- macOS log file: `~/Library/Logs/Zed/Zed.log`
- Run `bash scripts/validate.sh` to check that all required files are present and tests pass.
