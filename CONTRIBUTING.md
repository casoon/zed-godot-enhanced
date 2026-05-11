# Contributing

## Prerequisites

- Rust stable toolchain (`rustup default stable`)
- WASM target for Zed extensions: `rustup target add wasm32-wasip1`
- Optional: `jq` for JSON validation in `scripts/validate.sh`

## Local development setup

```bash
git clone https://github.com/casoon/zed-godot-enhanced.git
cd zed-godot-enhanced

# Build the native host binary (for development)
cargo build

# Build the Zed-compatible WASM artifact
cargo build --release --target wasm32-wasip1

# Run tests
cargo test
```

## Installing the extension in Zed (dev mode)

Open Zed, then go to **Extensions → Install Dev Extension…** and select this repository directory. Zed loads the extension directly from the source tree during development.

On macOS the extensions directory is `~/Library/Application Support/Zed/extensions/`. On Linux it is `~/.config/zed/extensions/`. Prefer the "Install Dev Extension" UI over manual symlinks; the path may change between Zed versions.

## Validation

```bash
# Run all local checks (file structure, JSON, tests, WASM build)
bash scripts/validate.sh
```

The CI workflow (`.github/workflows/ci.yml`) runs the same checks on every push and pull request.

## Submitting changes

1. Fork the repository and create a branch from `master`.
2. Make your changes and run `cargo fmt`, `cargo clippy`, `cargo test`, and `scripts/validate.sh` locally.
3. Open a pull request. The CI will verify build and tests automatically.

## Project structure

```
extension.toml              — Zed extension manifest
Cargo.toml / src/gdscript.rs — Rust extension code
languages/
  gdscript/                 — GDScript tree-sitter queries and config
  gdshader/                 — GDShader tree-sitter queries and config
  godot_resource/           — Godot Resource (.tres/.tscn) config
debug_adapter_schemas/      — DAP schema for Godot debugger
scripts/validate.sh         — Local validation script
tests/fixtures/             — Test input files
.github/workflows/ci.yml    — CI definition
```
