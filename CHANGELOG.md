# Changelog

All notable changes to the Zed Godot Enhanced extension will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-10-08

### Added
- Initial release of Zed Godot Enhanced
- Complete GDScript Language Server integration
- Syntax highlighting for GDScript, GDShader, and Godot Resources
- Tree-sitter grammar integration with highlights, indents, outlines, brackets, injections
- Debug adapter support for Godot debugging
- Code formatting support via gdformat
- Comprehensive test suite with fixtures
- Validation script with 24 automated tests (100% pass rate)
- Complete documentation (README, TODO, PROJECT_SUMMARY)
- MIT License
- Based on GDQuest's zed-gdscript v0.5.0

### Enhanced Features (vs. GDQuest original)
- Validation script for measurable completeness
- Test fixtures for GDScript syntax validation
- Extended documentation with setup guides
- Project summary with metrics dashboard
- Detailed TODO with 8 phases and validation criteria
- Cargo.toml updated with proper metadata

### Technical
- Rust source code (src/gdscript.rs)
- Cargo build system
- Language configs for 3 file types (GDScript, GDShader, Godot Resource)
- Debug adapter schema (godot.json)
- Tree-sitter grammar files from trusted sources:
  - tree-sitter-gdscript (Preston Knopp)
  - tree-sitter-godot-resource (Preston Knopp)
  - tree-sitter-gdshader (GodOfAvacyn)

### Documentation
- README.md with complete feature list and setup instructions
- TODO.md with 100% measurable validation criteria
- PROJECT_SUMMARY.md for quick reference
- CHANGELOG.md (this file)
- LICENSE (MIT)

## [Unreleased]

### Planned
- CI/CD integration via GitHub Actions
- Additional test coverage
- Performance benchmarks
- Advanced validation scripts
- Community contributions guidelines
