# TODO

Open release-readiness work. See also the [issue tracker](https://github.com/casoon/zed-godot-enhanced/issues).

---

## In progress / planned

### CI and tests
- [ ] CI workflow passing on GitHub Actions (#1)
- [ ] Meaningful `cargo test` coverage (#2)

### Install and packaging
- [ ] Verify and document correct Zed local-dev extension path per platform (#3)
- [ ] Verify WASM extension artifact builds and Zed loads it (#5)
- [ ] Document where the compiled `.wasm` artifact goes and how Zed discovers it

### Documentation
- [ ] `CONTRIBUTING.md` with setup and workflow guide (#6)
- [ ] Consolidate scattered install docs (QUICKSTART, MANUAL_INSTALL, INSTALL_STEPS)

### Validation
- [ ] `scripts/validate.sh` — add WASM build to local check (needs `rustup target add wasm32-wasip1`)
- [ ] End-to-end smoke test with a running Godot project and Zed (#8)

---

## Done

- [x] Align README with actual project state (#4)
- [x] Fix README links and completeness claims
- [x] CI workflow skeleton (`.github/workflows/ci.yml`)
- [x] Unit tests for DAP request parsing (`cargo test`)
- [x] Rewrite `scripts/validate.sh` — removed stale script references and broken test logic

---

## Validation checklist (release gate)

- [ ] Extension loads in Zed without errors
- [ ] GDScript files recognized (`.gd`)
- [ ] GDShader files recognized (`.gdshader`)
- [ ] Godot Resource files recognized (`.tres`, `.tscn`)
- [ ] LSP connects to a running Godot editor (port 6005)
- [ ] Autocomplete works for Godot API
- [ ] Syntax highlighting correct
- [ ] Debugging functional (launch and attach)
- [ ] Formatting with `gdformat` works
- [ ] Zed-compatible WASM build verified
- [ ] Automated tests added and passing in CI
- [ ] CI workflow passing
