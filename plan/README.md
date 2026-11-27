# Plan

Started 2026-11-26. Status: **phases 0 to 2 mostly done, only the GUI is Perl; phase 3 started, needs the printer**.
Target: Debian 13, unmodified Creality Ender 5 Pro.

| File | Content |
|---|---|
| [baseline.md](baseline.md) | What we found in the repo and what works today |
| [features.md](features.md) | Candidate features, ranked for the Ender 5 Pro |
| [DECISIONS.md](DECISIONS.md) | Settled decisions |

## Phases

Each phase ends with something that can be checked.

### 0. Housekeeping
- [x] `CLAUDE.md`, `plan/`
- [x] README: fork notice, AI disclosure, dead badges and download links removed
- [x] `CONTRIBUTING.md`, `CODEOWNERS` point to this fork
- [x] Dead CI, deploy and Windows/macOS packaging files deleted; upstream issue templates deleted
- [ ] GitHub repo description and homepage (homepage still says slic3r.org)
- [ ] Fetch upstream tags (the fork has none, so `git describe` fails)

### 1. C++ core builds, is verified, CI is ours (done 2026-11-26)
- [x] Build on current toolchain and Boost
- [x] Fix flaky test (uninitialised variable in the G-code writer)
- [x] GitHub Actions ([build.yml](../.github/workflows/build.yml)): build and test in a
      `debian:13` container, daily plus manual dispatch, not on every commit
- [x] Golden G-code check ([check.sh](../src/test/golden/check.sh)): box with default
      and tuned settings, and an overhang model; runs in CI
- [x] First green run on GitHub: 56 test cases (3 expected failures), golden check passes

### 2. The GUI runs (done 2026-11-26, in one session)
- [x] Build the Perl XS module on Debian 13 (unchanged)
- [x] Start the Perl GUI with distro packages (`libwx-perl`, `libwx-glcanvas-perl`, `libopengl-perl`)
- [x] Run the Perl tests (`t/`, `xs/t/`): all pass, see [baseline.md](baseline.md)
- [x] Stop the update check that calls slic3r.org (removed)
- [x] Load an STL, preview it, export G-code: [gui_smoke.sh](../utils/gui_smoke.sh) does
      this under Xvfb and checks the export equals the CLI output
- [x] CI: `perl` job in [build.yml](../.github/workflows/build.yml) (XS build and tests,
      Perl tests, GUI smoke test); steps verified in a fresh `debian:13` rootfs, not yet on GitHub
- [ ] Try it on a real desktop (Xvfb has no window manager, no GPU)
- Result: the Perl program works, including support material. Supports option A below.

### 3. Printer baseline
- [x] Ender 5 Pro profiles (printer, PLA, 0.20 mm): [profiles/](../profiles/README.md); values not yet checked on the machine
- [ ] Read the firmware version and capabilities from the printer (`M115`, `M503`)
- [x] Add the profiles to the golden check (`ender5pro_box`)
- [ ] Print one reference part on the real printer

### 4. Features
One at a time from [features.md](features.md), each with a test and a test print.

### 5. Packaging
- [ ] `.deb` for Debian 13, built by CI, published as a GitHub release

## Perl and the GUI path

| Part | Lines |
|---|---|
| GUI (`lib/Slic3r/GUI*`) | 17,800 |
| Logic (`lib/`, rest): support, G-code export, config, geometry, filters | 5,500 (2,200 since 2026-11-27) |
| CLI, utilities, build scripts | 2,200 |
| Tests (`t/`, `xs/t/`) | 7,800 |
| For comparison: C++ core | 35,500 |

| Option | For | Against |
|---|---|---|
| **A. Keep Perl now, replace it in stages** | Early usable program; Perl is the reference for each port | wxPerl is barely maintained; two pipelines for a while |
| B. Go straight to C++ | One language | No working GUI for a long time |
| C. New UI over the C++ CLI | Modern, testable | Largest change in look and feel |

Recommendation: **A**.
1. Get the Perl program running (phase 2).
2. Fix C++ support generation (done 2026-11-26: same output as Perl), compare the rest
   of the output with Perl (done 2026-11-27: 94 setups identical, `compare_perl.sh`;
   transforms, adaptive slicing, both Perl-only filters, several extruders and modifiers included),
   retire Perl logic (mostly done 2026-11-27, see below).
3. Finish the C++ GUI (or replace it), then remove Perl.

### Retiring Perl logic (step 2), status 2026-11-27

The Perl program now calls C++ (through `Print.xsp`) for slicing, support generation,
G-code export, SVG export and post-processing scripts. Deleted: `Print/GCode.pm`,
`Print/SupportMaterial.pm`, the Perl G-code filters, `MotionPlanner.pm`,
`Test/SectionCut.pm` and unused helpers. Non-GUI Perl in `lib/`: 5,500 -> 2,200 lines.

Still Perl outside the GUI, and what to do with it:

| Part | Lines | Next step |
|---|---|---|
| ~~`slic3r.pl` command line~~ | 645 -> 210 | Done 2026-11-27: with files, `slic3r.pl` hands its arguments to the C++ CLI (`--print-center` becomes `--center`, `-j` `--threads`, `-g` added when no other action is given). `compare_perl.sh` removed; six of its setups are golden files now; the GUI smoke test compares the GUI with the C++ CLI |
| `Print/Simple.pm`, `Print.pm`, `Print/Object.pm` | ~300 | Glue the GUI uses (quick slice, status messages); thin wrappers over C++ |
| `Config.pm`, `Model.pm`, `Slic3r.pm`, `Geometry.pm`, small wrappers | ~1,300 | Used by the GUI; they go with it |
| `Test.pm`, `SVG.pm`, `GCode/Reader.pm` | ~480 | Only for `t/`; `t/` tests the pipeline through Perl and goes when the GUI does (most cases have C++ ports) |

So only the UI uses Perl now: everything left is GUI glue or Perl tests. Next for Perl:
the C++ GUI (step 3).

### The C++ GUI (step 3), wxWidgets (DECISIONS.md, 2026-11-27)

Each step ends with something checked under Xvfb, like `utils/gui_smoke.sh` does for Perl.
The Perl GUI is the reference for behaviour and layout.

- [x] Builds with wxWidgets 3.2 (`cmake -DEnable_GUI=ON`; one fix, 2026-11-27)
- [x] Starts without wx assertions; `utils/cpp_gui_smoke.sh`; CI job `cpp-gui` (2026-11-27, CI run not seen yet)
- [x] Plater: models from the command line, 2D and 3D views (fit to objects), object info,
      more/fewer/rotate/arrange/delete, "Export G-code…" with the selected presets;
      `cpp_gui_smoke.sh`: export equals the CLI (2026-11-27). Still to do: slicing in the
      background with progress (it runs on the GUI thread), the "Add…" dialog untested
      under Xvfb, export STL/AMF/3MF, undo
- [ ] Presets: print/filament/printer editors and choosers, read and write the data directory
      (`~/.Slic3r`, same files as the Perl GUI)
- [ ] Preview: layers and toolpaths (3D and 2D)
- [ ] The rest of what the Perl GUI has and is worth keeping: object settings and
      modifiers, cut, rotate to face, wizard, preferences. Printer controller (USB) and
      SLA/projector: decide before porting
- [ ] Remove Perl: `lib/`, `slic3r.pl`, `xs/` (the XS bindings), `t/`; packaging deps

If phase 2 turns out to be hopeless, go to B. (It did not: see phase 2.)

## Open questions

None blocking. The firmware details are read from the printer in phase 3.
