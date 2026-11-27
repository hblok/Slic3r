# Baseline, 2026-11-26

## Upstream

- Fork point `026c1380` (2022-10-28), identical to upstream `master` on this date.
- Last release: 1.3.0 (2018-05-10). Version string in the code: `1.3.1-dev`.
- Upstream has unmerged branches that may be worth mining, e.g. `merill_ironing`,
  `merill_thinwall`, `new-support2`. Not examined yet.

## Size (lines)

| Part | Lines |
|---|---|
| C++ core `xs/src/libslic3r` | 35,500 |
| Perl application `lib` | 23,300 |
| C++ GUI `src/GUI` | 7,500 |
| C++ tests `src/test` | 7,900 |
| Perl tests `t`, `xs/t` | 7,800 |

## Build

Unmodified upstream failed at CMake configure. Fixed:

| Problem | Fix |
|---|---|
| Boost `system` component removed | dropped from `find_package` |
| `io_service`, `io.post`, `io.reset` removed from Boost.Asio | `io_context`, `boost::asio::post`, `restart` |
| missing `<fstream>` in `src/slic3r.cpp` | included |
| Catch 2.4.2 signal handler does not compile with current glibc | `CATCH_CONFIG_NO_POSIX_SIGNALS` (a crashing test gets no Catch report; replace when Catch is upgraded) |
| `GCode::_extrusion_length` uninitialised; centre-of-gravity test failed about half the time | initialised to 0 |

Verified with the GUI off:

| System | Compiler, Boost | Result |
|---|---|---|
| Debian 13.8 (chroot) | GCC 14.2, 1.83 | builds, tests as below, golden G-code recorded here |
| Ubuntu 26.04 | GCC 15.2, 1.90 | builds, tests as below, golden check matches Debian's output |
| GitHub Actions, `debian:13` | as Debian 13 | green |

Tests: 56 cases, 53 pass and 3 fail as expected.

Not verified: GCodeSender against a serial port (changed), C++ GUI
(`-DEnable_GUI=ON`).

The G-code records the thread count, which defaults to the number of cores; the golden
check passes `--threads 4`.

## Perl application (phase 2, 2026-11-26)

Debian 13 chroot and a fresh `debian:13` rootfs running the CI job steps; distro packages
only (Perl 5.40, wxPerl 0.9932, wxGTK 3.2), no CPAN.

| Check | Result |
|---|---|
| XS module (`xs/Build.PL`, `./Build`) | builds unchanged, no compiler warnings |
| XS tests (`xs/t`) | 24 files, 578 tests, all pass |
| Perl tests (`t/`) | 35 files, 593 tests, all pass; `slice.t` skipped upstream ("temporarily disabled") |
| Perl CLI (`slic3r.pl`) | slices; support material works |
| GUI (`slic3r.pl --gui`) under Xvfb, software OpenGL | starts, wizard, load STL, 3D view, preview, export |
| GUI export vs Perl CLI, table model with support | identical apart from the timestamp |

Fixed:

| Problem | Fix |
|---|---|
| GUI called `https://slic3r.org/updatecheck` daily (off for `-dev` builds, on for releases) | check, menu item and preference removed |
| `Duplicate specification` warnings on every start; `--threads`, `-j` defined twice, winner in hash order | option table skips names already taken |
| Preferences dialog: `uninitialized value` warnings, empty Color Scheme | `colorscheme` default `getDefault` |

Seen, not fixed:
- Three `Gtk-CRITICAL gtk_combo_box_text_insert` messages at start: the preset
  `Wx::BitmapComboBox`es in wxGTK 3.2. They work.
- `dconf` and `/proc/mounts` warnings in the chroot only (no D-Bus, no `/proc`).

Perl and C++ output, default settings:

| Model | Perl | C++ |
|---|---|---|
| 20 mm box | 1142 extrusion moves, 339.3 mm filament | 1142 moves; coordinates differ in the third decimal |
| table, `--support-material` | 3916 moves, 327.9 mm (142.5 mm without support) | 977 moves, no support (fixed since: same filament as Perl) |

## C++ temperature commands (fixed 2026-11-26)

`PrintGCode.cpp` had four inverted checks: it added the bed temperature before the
start G-code, and bed and hotend temperatures between objects, only when the custom
G-code *already* set them, and switched the bed off after an end G-code that did so
itself. Profiles with a heated bed got no `M190` at all. Now as in Perl; covered by
`test_printgcode.cpp` and the `ender5pro_box` golden output.

Still different from Perl in sequential printing (`complete_objects`), not fixed: C++
never writes `between_objects_gcode`, and its sort by `sequential_print_priority`
compares an object with itself.

## C++ support material (fixed 2026-11-26)

Until this date the C++ CLI printed no support at all. Twelve bugs between contact
detection and export, each found by comparing a stage with
`lib/Slic3r/Print/SupportMaterial.pm`; listed in commit `62d63148`. Now, on the table
model (20 x 20 mm top on a 4 x 4 mm post), C++ and Perl extrude the same filament per
role for all three patterns:

| Pattern | Total filament | Support | Interface |
|---|---|---|---|
| pillars (default) | 327.9 mm | 116.2 mm | 67.1 mm |
| rectilinear | 379.9 mm | 155.7 mm | 79.5 mm |
| honeycomb | 413.5 mm | 189.3 mm | 79.5 mm |

## C++ and Perl G-code: identical (2026-11-27)

`src/test/golden/compare_perl.sh build/slic3r` slices 74 setups with both pipelines
and compares the G-code without comments: all 74 are identical. They cover the 9 test
meshes of `lib/Slic3r/Test.pm`, all 13 infill patterns, perimeters, retraction, all
G-code flavors, seams, cooling, spiral vase, rafts, the support options and patterns,
sequential printing, custom G-code and the Ender-5 Pro profiles.

Getting there took about 40 fixes in C++, in 19 commits since phase 1. Besides plain bugs
(support layers never printed, a constructor ignoring its arguments, inverted checks,
loops over copies) many were numeric: integer division and `scale_()` truncation where
Perl keeps fractions, `float` where Perl has `double`, and heights as hash keys, which
Perl compares at 15 significant digits (`z_key` in `SupportMaterial.cpp`).

Also found on the way, in code both pipelines share: an out-of-bounds read in the move
inwards after a loop made G-code differ from run to run (bridge mesh); fixed.

Known, deliberate difference: with `avoid_crossing_perimeters` Perl uses the external
motion planner for the first travel of almost every layer, because it detects a new
object copy by the memory address of a Point (commit `30d45e10`). C++ compares
positions.

Different option names: `--center` in C++ is `--print-center` in Perl.

Second sweep (scratch, not in the script yet): AMF, 3MF, multi-object AMF, layer
G-code, top/bottom patterns, speed limits, retraction and fan options are identical.
Open:
- ~~C++ CLI crashes with `--scale`, `--rotate*`, `--scale-to-fit`, `--duplicate-grid`~~
  fixed 2026-11-27: `raw_bounding_box()` works without instances, and the CLI read
  `--duplicate-grid` with the wrong option type. `--scale` and `--duplicate-grid` are
  identical to Perl; rotations differ in the last digit of E (C++ rotates the mesh,
  Perl the instance) and are in the golden check instead.
- ~~`--adaptive-slicing` differs from Perl~~ fixed 2026-11-27: `SimplePrint` aligned
  objects to z = 0 with a bounding box that is empty before instances exist, so a
  model not already on z = 0 was not moved. Slicing aligns its own copy, so only
  adaptive slicing (it reads the model meshes) saw it. Same bug in `--cut` (cut height
  counted from the mesh origin, not the bed); both now equal Perl.
- ~~Differ from Perl: `--vibration-limit`, `--pressure-advance`~~ ported to C++
  2026-11-27 (`GCode/VibrationLimit`, `GCode/PressureRegulator`); output equals Perl.
  `GCodeReader` now keeps coordinates as double, like Perl.
- ~~Not compared: several extruders, modifier volumes~~ compared 2026-11-27 with
  generated AMF models (`models/make_amf.py`) and `two_extruders.ini` (an ini reads the
  same in both; the command lines take per-extruder lists differently): identical.
  `--ooze-prevention` placed no standby points in C++ (a `TODO: PORT THIS` block in
  `PrintGCode.cpp`); ported, now identical.
- Not compared yet: GUI-only steps. `--gcode-arcs` is refused by Perl as incomplete.

`src/test/libslic3r/test_support_material.cpp` is still not part of the test build;
the golden `table_support` output covers the default case.

## Other findings

- The Perl application generates G-code and supports in Perl; the C++ CLI uses its
  own C++ versions. Output differs slightly; see the table above.
- Not found in the code: ironing, monotonic fill, fuzzy skin, M486, thumbnails,
  Klipper flavour (keyword search, not an audit).
- G2/G3 arc fitting exists in Perl but is disabled as incomplete
  (`lib/Slic3r/GCode/ArcFitting.pm`); not ported.
- ~~The C++ CLI aborts on `--merge` (or `-m`) with an unreadable `UnknownOptionException`~~
  fixed 2026-11-27: it read `--dont-arrange` without a default, and the config
  exceptions returned a pointer into a destroyed string from `what()`. Output equals Perl.
- `src/test/inputs/20mmbox.stl` is an 84-byte empty STL; use `test_cli/20mmbox.stl`.
- `src/CMakeLists.txt` has `target_compile_options(libslic3r -DBOOST_INCLUDE_NOWIDE)`
  behind a misspelled variable, so it never runs.
- Bundled third-party code (`admesh`, `clipper`, `expat`, `miniz`, `poly2tri`,
  parts of Boost) is old and due for review.
