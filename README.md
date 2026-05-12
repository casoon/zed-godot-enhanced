# Zed Godot Enhanced Extension

Experimental Godot support for Zed Editor, based on GDQuest's GDScript extension.

This repository is currently in an alpha/prototype state. The core extension files are present, CI and tests are wired up, but end-to-end validation in a live Zed + Godot environment is still pending.

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/casoon/zed-godot-enhanced)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

---

## Status

| Area | Current state |
|------|---------------|
| Extension manifest | Present |
| Rust extension code | Present, builds locally |
| GDScript LSP command | Implemented via `nc`/`ncat`, needs runtime validation in Zed |
| Godot debug adapter | Basic TCP adapter implementation present, needs runtime validation |
| Tree-sitter language files | Present for GDScript, GDShader, and Godot Resource files |
| Tests | 4 unit tests for DAP request parsing (`cargo test`) |
| CI | GitHub Actions workflow present (fmt, clippy, test, WASM build, validate.sh) |
| Release packaging | WASM build target documented; Zed loading not yet validated |
| Documentation | CONTRIBUTING.md, QUICKSTART.md, install guides present |

Open release-readiness work:

- [#8 Add end-to-end validation in Zed with Godot LSP and debugger](https://github.com/casoon/zed-godot-enhanced/issues/8)

---

## Features

### Implemented or scaffolded
- **GDScript Language Server command** - connects to Godot's language server through `nc`/`ncat`
- **Syntax highlighting files** - GDScript, GDShader, and Godot Resource query/config files are included
- **Debug adapter configuration** - basic Godot TCP debug adapter setup is present
- **Language configuration** - brackets, indentation, outlines, text objects, and file suffixes are configured where available
- **Local validation script** - `scripts/validate.sh` checks repository structure, tests, and WASM build
- **CI** - GitHub Actions runs fmt, clippy, tests, and WASM build on every push

### Not yet proven release-ready
- End-to-end extension loading in Zed
- LSP autocomplete, hover, and go-to-definition against a running Godot project
- Debug launch/attach behavior
- Zed-compatible WebAssembly artifact verified to load in Zed

---

## Requirements

- **Zed Editor** (latest version)
- **Godot Engine** 3.x or 4.x
- **Netcat** (`nc` or `ncat`) for LSP communication
- **Rust** with `wasm32-wasip1` target (`rustup target add wasm32-wasip1`)

### Installing Netcat

```bash
# macOS
brew install netcat

# Ubuntu/Debian
sudo apt install netcat

# Fedora
sudo dnf install nmap-ncat
```

---

## Installation

This extension is not published in the Zed extension registry. Install as a local dev extension:

```bash
git clone https://github.com/casoon/zed-godot-enhanced.git
cd zed-godot-enhanced

rustup target add wasm32-wasip1
cargo build --release --target wasm32-wasip1
```

Then in Zed: **Extensions → Install Dev Extension…** and select this directory.

- macOS managed path: `~/Library/Application Support/Zed/extensions/installed/`
- Linux managed path: `~/.config/zed/extensions/installed/`

See [INSTALL_STEPS.md](INSTALL_STEPS.md) and [MANUAL_INSTALL.md](MANUAL_INSTALL.md) for details.

---

## Configuration

### 1. Enable Godot Language Server

In **Godot Editor**:
1. `Editor → Editor Settings → Network → Language Server`
2. ✅ Enable "Enable Language Server"
3. Host: `127.0.0.1`
4. Port: `6005` (default)

### 2. Configure Zed

Add to your `~/.config/zed/settings.json`:

```json
{
  "lsp": {
    "gdscript": {
      "binary": {
        "path": "nc",
        "arguments": ["127.0.0.1", "6005"]
      }
    }
  },
  "languages": {
    "GDScript": {
      "tab_size": 4,
      "hard_tabs": false,
      "formatter": {
        "external": {
          "command": "gdformat",
          "arguments": ["-"]
        }
      }
    }
  }
}
```

### 3. Open Files in Zed from Godot

In **Godot Editor**:
1. `Editor → Editor Settings → Text Editor → External`
2. ✅ Enable "Use External Editor"
3. **Exec Path**: `/Applications/Zed.app/Contents/MacOS/zed`
4. **Exec Flags**: `{project} {file}:{line}:{col}`

---

## Debugging

Create `.zed/debug.json` in your project root:

```json
[
  {
    "adapter": "godot",
    "label": "Godot (Launch)",
    "request": "launch"
  },
  {
    "adapter": "godot",
    "label": "Godot (Attach)",
    "request": "attach"
  }
]
```

Press `F4` to start debugging session.

Debugging support still needs end-to-end validation against a running Godot project. See [issue #8](https://github.com/casoon/zed-godot-enhanced/issues/8).

---

## Features in Detail

### Language Server Protocol (LSP)

The extension starts `nc`/`ncat` against Godot's language server on `127.0.0.1:6005` by default. In practice, the following editor features depend on a running Godot editor with the language server enabled:

**Autocomplete:**
- Classes, methods, properties
- Godot API references
- Project-specific symbols
- Built-in constants

**Go to Definition:**
- `Cmd+Click` on symbols
- Jump to class/function definitions

**Hover Information:**
- API documentation
- Type information
- Parameter hints

### Syntax Highlighting

- **Keywords**: `class`, `extends`, `func`, `var`, `signal`
- **Built-ins**: `Vector2`, `Node`, `Input`
- **Comments**: Single and multi-line
- **Strings**: String interpolation
- **Numbers**: Int, float, hex, binary

### Code Formatting

Formatting is configured through Zed settings and an external `gdformat` command. It is not provided by the Rust extension itself.

```bash
# Install gdformat
pip install gdformat

# Format on save (in settings.json)
"format_on_save": "on"
```

---

## Testing & Validation

```bash
# Repository structure, tests, and WASM build
./scripts/validate.sh

# Unit tests only
cargo test
```

`scripts/validate.sh` checks file structure, runs `cargo test`, and attempts a `wasm32-wasip1` build. The CI workflow runs the same checks automatically.

### Release-readiness checklist

- [ ] Extension loads in Zed
- [ ] GDScript files recognized
- [ ] LSP connection established
- [ ] Autocomplete works
- [ ] Syntax highlighting correct
- [ ] Debugging functional
- [ ] Formatting works
- [ ] Zed-compatible WebAssembly artifact verified to load in Zed
- [x] Automated tests added (`cargo test`)
- [x] CI workflow passing

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for setup, build, and workflow instructions.

```bash
git clone https://github.com/casoon/zed-godot-enhanced.git
cd zed-godot-enhanced

rustup target add wasm32-wasip1
cargo test
./scripts/validate.sh
```

---

## Documentation

The repository currently contains these docs:

- [Quickstart](QUICKSTART.md)
- [Manual install notes](MANUAL_INSTALL.md)
- [Install steps](INSTALL_STEPS.md)
- [Testing guide](TESTING_GUIDE.md)
- [Project summary](PROJECT_SUMMARY.md)
- [TODO](TODO.md)


---

## Credits

Based on [GDQuest's zed-gdscript](https://github.com/GDQuest/zed-gdscript) extension.

**Original Authors:**
- Mark Brand (@grndctrl)
- Richard Taylor (@moomerman)
- Radu Gafita (@radugaf)
- Nathan Lovato (@NathanLovato)

**Enhanced by:**
- Jörn Seidel (@casoon)

---

## License

MIT License - see [LICENSE](LICENSE) file.

---

## Links

- **GitHub**: https://github.com/casoon/zed-godot-enhanced
- **Issues**: https://github.com/casoon/zed-godot-enhanced/issues
- **Zed Editor**: https://zed.dev
- **Godot Engine**: https://godotengine.org

---

## Roadmap

- [x] Correct README and project status claims
- [x] Document Zed local extension install path (macOS + Linux)
- [x] Add real automated tests (`cargo test`)
- [x] Add CI workflow (fmt, clippy, test, WASM build)
- [x] CONTRIBUTING.md and install documentation
- [ ] Verify WebAssembly artifact loads in Zed
- [ ] LSP and debug end-to-end smoke validation

---

Made for the Godot and Zed community.
