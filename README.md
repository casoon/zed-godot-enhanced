# Zed Godot Enhanced Extension

Experimental Godot support for Zed Editor, based on GDQuest's GDScript extension.

This repository is currently in an alpha/prototype state. The core extension files are present, but release readiness still needs real Zed runtime validation, automated tests, CI, corrected install documentation, and a verified WebAssembly build workflow.

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
| Tests | `cargo test` currently runs 0 tests |
| CI | Not configured yet |
| Release packaging | Not verified yet |
| Documentation | Work in progress |

Track the open release-readiness work in the issue tracker:

- [#1 Add CI workflow for build, tests, and validation](https://github.com/casoon/zed-godot-enhanced/issues/1)
- [#2 Add real automated tests for extension behavior](https://github.com/casoon/zed-godot-enhanced/issues/2)
- [#3 Document and validate the correct Zed extension install path](https://github.com/casoon/zed-godot-enhanced/issues/3)
- [#4 Align README completeness claims with actual project state](https://github.com/casoon/zed-godot-enhanced/issues/4)
- [#5 Validate and document the Zed WASM extension build](https://github.com/casoon/zed-godot-enhanced/issues/5)
- [#6 Create missing documentation files referenced by README](https://github.com/casoon/zed-godot-enhanced/issues/6)
- [#7 Add missing validation scripts or remove stale references](https://github.com/casoon/zed-godot-enhanced/issues/7)
- [#8 Add end-to-end validation in Zed with Godot LSP and debugger](https://github.com/casoon/zed-godot-enhanced/issues/8)

---

## Features

### Implemented or scaffolded
- **GDScript Language Server command** - connects to Godot's language server through `nc`/`ncat`
- **Syntax highlighting files** - GDScript, GDShader, and Godot Resource query/config files are included
- **Debug adapter configuration** - basic Godot TCP debug adapter setup is present
- **Language configuration** - brackets, indentation, outlines, text objects, and file suffixes are configured where available
- **Local validation script** - `scripts/validate.sh` checks repository structure and host Rust build status

### Not yet proven release-ready
- End-to-end extension loading in Zed
- LSP autocomplete, hover, and go-to-definition against a running Godot project
- Debug launch/attach behavior
- Zed-compatible WebAssembly artifact build
- Automated test coverage
- CI/CD

---

## Requirements

- **Zed Editor** (latest version)
- **Godot Engine** 3.x or 4.x
- **Netcat** (`nc` or `ncat`) for LSP communication
- **Rust** for local development

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

This extension is not currently documented as published in the Zed extension registry. Use a local development install while the packaging and install-path work is being verified.

### Local development install

```bash
# Clone repository
git clone https://github.com/casoon/zed-godot-enhanced.git
cd zed-godot-enhanced

# Build the Rust extension locally
cargo build

# Link to the local Zed extensions directory used by your Zed installation.
# This path is under review in issue #3.
mkdir -p ~/.config/zed/extensions
ln -s $(pwd) ~/.config/zed/extensions/godot-enhanced

# Restart Zed
```

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

Current validation is limited. `scripts/validate.sh` checks required files and a local host Rust build. `cargo test` currently runs successfully but has no test cases.

```bash
# Validation script
./scripts/validate.sh

# Rust tests
cargo test
```

Missing validation scripts and stronger checks are tracked in [issue #7](https://github.com/casoon/zed-godot-enhanced/issues/7).

### Release-readiness checklist

- [ ] Extension loads in Zed
- [ ] GDScript files recognized
- [ ] LSP connection established
- [ ] Autocomplete works
- [ ] Syntax highlighting correct
- [ ] Debugging functional
- [ ] Formatting works
- [ ] Zed-compatible WebAssembly build verified
- [ ] Automated tests added
- [ ] CI workflow passing

---

## Contributing

Contribution guidelines have not been written yet. See [issue #6](https://github.com/casoon/zed-godot-enhanced/issues/6).

### Development Setup

```bash
# Clone repository
git clone https://github.com/casoon/zed-godot-enhanced.git
cd zed-godot-enhanced

# Install dependencies
cargo build

# Run tests
cargo test

# Validate extension
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

The previously linked `docs/*.md` files do not exist yet and are tracked in [issue #6](https://github.com/casoon/zed-godot-enhanced/issues/6).

---

## Credits

Based on [GDQuest's zed-gdscript](https://github.com/GDQuest/zed-gdscript) extension.

**Original Authors:**
- Mark Brand (@grndctrl)
- Richard Taylor (@moomerman)
- Radu Gafita (@radugaf)
- Nathan Lovato (@NathanLovato)

**Enhanced by:**
- Julian Seidel (@jseidel)

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
- [ ] Verify current Zed local extension install path
- [ ] Verify WebAssembly extension build
- [ ] Add real automated tests
- [ ] Add CI workflow
- [ ] Add LSP and debug smoke validation
- [ ] Complete contributor and setup documentation

---

Made for the Godot and Zed community.
