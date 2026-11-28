# Plan

Started 2026-11-26. Status: **phases 0 to 2 mostly done, only the GUI is Perl; phase 3 started, needs the printer**.
Target: Debian 13, unmodified Creality Ender 5 Pro.

| File | Content |
|---|---|
| [TODO.md](TODO.md) | Open items |
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
      `cpp_gui_smoke.sh`: export equals the CLI (2026-11-27). The export slices in the
      background (own copy of the model and Print) with progress and Cancel in the status
      bar; checked by hand with a 640,000-facet model (edits while slicing, cancel leaves no
      file, export again). Still to do: background slicing on changes (Perl's
      background_processing setting), the "Add…" dialog untested under Xvfb, export
      STL/AMF/3MF, undo
- [ ] Presets: print/filament/printer editors and choosers, read and write the data directory
      (`~/.Slic3r`, same files as the Perl GUI). Done 2026-11-27: presets from the data
      directory, the selection read from and written to `slic3r.ini` (Perl format, other
      keys kept), slicing with them equals the CLI (`cpp_gui_smoke.sh`, Ender presets).
      Editors (2026-11-27): Print/Material/Printer Settings tabs, pages built from the
      option definitions (one per category); edits go into the preset's unsaved state and
      into the next export; save as / delete; editor and plater choosers follow each
      other; smoke-tested (edit, export equals the CLI, save as). Open: the Perl GUI's
      hand-made page layouts and the rules that enable/disable dependent options,
      several extruders, the wizard, preset compatibility
- [x] Preview: "Preview" (3D) and "Toolpaths" (2D, wheel zoom, drag) tabs with a layer
      slider (2026-11-27). Opening one slices in the background; a change of the plate or
      the settings slices again. `cpp_gui_smoke.sh` counts the drawn pixels. The 3D canvas
      had no depth buffer (what was drawn last covered the rest); fixed. Left out: colour by
      extruder, greying thicker layers that overlap the shown one (2D), a camera shared
      with the 3D plater. An export waits until a preview has finished slicing
- [x] Plater and menus (2026-11-27, `cpp_gui_plate.sh`): copies, rotate, mirror, scale,
      split, cut (plane preview, no live cut), undo/redo (whole copies of the plate),
      reload from disk, export plate/object as STL/AMF/3MF, drag and drop (not tried);
      File menu: load/export config and bundles, config from G-code, quick slice, SVG,
      repair STL; Settings and View menus. A loaded config file lasts until the presets
      are read again. Reload loses changes made to the mesh (X/Y rotation, mirror,
      per-axis scale)
- [x] Preferences, editor rules, Object > Settings (parts, modifiers, own settings),
      configuration wizard (2026-11-27)
- [x] Rotate face to plane, cut by grid, live cut preview (2026-11-27, `cpp_gui_plate.sh`
      part `tools`). The preview leaves out the Perl GUI's section outline
- [x] Object > "Layer heights…" (2026-11-27): the curve to drag and height ranges. Slicing
      now keeps drawn heights on a fresh print, as long as the object keeps its height.
      Left out: the Perl dialog's 3D preview beside the curve and its quality slider
      (`adaptive_slicing_quality` is an object setting). Ranges and curves are not saved
      in AMF/3MF files
- [x] Object > Settings: "Create modifier…" (slab, box, cylinder, sphere, centred on the
      object) and the position of a part in mm (2026-11-27)
- [x] Preset editors as in Perl (2026-11-27): hand-made pages with its controls, extruder
      count and a page per extruder, one material chooser per extruder (merged as Perl
      does; a material's overrides apply to its extruder only), compatible printers, bed
      shape dialog, filament overrides, shortcuts, asking before a modified preset is
      left, serial/OctoPrint test and Bonjour browse (`cpp_gui_presets.sh`)
- [x] Wizard as in Perl, on the first start too; `.init_bundle.ini`; loaded config files
      stay in the preset lists; reload from disk keeps transformations and added parts
      (its dialog); "Open 2.5D TIN mesh"; window positions; every Perl preference
      (editors in windows, controller tab, colour scheme) (2026-11-27)
- [x] Plater (2026-11-28): print summary, "Export STL…", "Send to printer" (OctoPrint and
      Duet, with its dialog; checked against `utils/fake_print_server.py`), "Rotate face"
      and optional 90° buttons, 180° rotations, `--load`, print options, `--threads` and
      `--autosave` for the GUI, preset names as placeholders, "successfully sliced"
      message, re-centering on a new bed shape, WASD nudging, drop targets on the views
- [x] Previews and 3D (2026-11-28): colour by filament (View menu), thicker layers above
      greyed in the 2D toolpaths, U/D keys, one camera for the 3D plater and preview,
      right and double click in the 3D plater, the section outline in the cut preview
- [x] Object dialogs (2026-11-28): a 3D view of the parts in "Settings" (click to select)
      and scale/rotate of a single part from the list's menu; "Layer heights" has the
      adaptive quality slider and a 3D view with a line at each layer (the Perl dialog
      showed the toolpaths there)
- [x] Controller tab (2026-11-28): printer panels, connect, temperatures, print queue with
      pause/resume/abort, log, manual control; "Print…" on the plater queues the G-code.
      `cpp_gui_controller.sh` drives it with `utils/fake_printer.py` on a pseudo
      terminal (skipped where there are none); not tried on a real printer
- [x] SLA/DLP projector (2026-11-28): Window > "DLP Projector…": the SLA options, the
      full-screen layer view, `DLP.ini` (same file as Perl), manual control, the print
      sequence and SVG export (`cpp_gui_projector.sh`; the print part needs pseudo
      terminals). Not tried with a projector. Custom G-code now has its placeholders filled
- [ ] The rest of what the Perl GUI has and is worth keeping, listed in [TODO.md](TODO.md)
- [x] The Perl utility scripts (2026-11-28): post-processing, config bundle and PDF slices
      are Python now (same output, checked against Perl; `src/test/cli/check.sh`); the
      command line got what only Perl had (`--version`, `--save` of the defaults,
      `--layer_height` spelling, `-j`, `--print-center`, G-code options from files,
      `--ascii`, `--estimate-gcode-time`, `--no-gui`, `--debug`). Dropped: `wireframe.pl`,
      `gcode_sectioncut.pl`, `split_stl.pl`, `stl-to-amf.pl` (already broken; `--split` and
      `--export-amf` cover the last two), the two viewers (the GUI), `dump-stl.pl` (for the
      Perl tests)
- [ ] Remove Perl: `lib/`, `slic3r.pl`, `xs/` (the XS bindings), `t/`; packaging deps

If phase 2 turns out to be hopeless, go to B. (It did not: see phase 2.)

## Open questions

None blocking. The firmware details are read from the printer in phase 3.
