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
| table, `--support-material` | 3916 moves, 327.9 mm (142.5 mm without support) | 977 moves, no support |

## Support material is broken in the C++ CLI

A table-shaped model (20 x 20 mm top on a 4 x 4 mm post) sliced with
`--support-material` gets no support: the log says `Empty contact_areas` and filament
use is unchanged. `src/test/libslic3r/test_support_material.cpp` is not part of the
test build; added by hand it passes, so it does not cover this. **Do not use the C++
CLI for prints that need support.** The Perl application uses its own
`lib/Slic3r/Print/SupportMaterial.pm`, which works (see above).

## Other findings

- The Perl application generates G-code and supports in Perl; the C++ CLI uses its
  own C++ versions. Output differs slightly; see the table above.
- Not found in the code: ironing, monotonic fill, fuzzy skin, M486, thumbnails,
  Klipper flavour (keyword search, not an audit).
- G2/G3 arc fitting exists in Perl but is disabled as incomplete
  (`lib/Slic3r/GCode/ArcFitting.pm`). Pressure advance and vibration limit filters
  also exist in Perl.
- `src/test/inputs/20mmbox.stl` is an 84-byte empty STL; use `test_cli/20mmbox.stl`.
- `src/CMakeLists.txt` has `target_compile_options(libslic3r -DBOOST_INCLUDE_NOWIDE)`
  behind a misspelled variable, so it never runs.
- Bundled third-party code (`admesh`, `clipper`, `expat`, `miniz`, `poly2tri`,
  parts of Boost) is old and due for review.
