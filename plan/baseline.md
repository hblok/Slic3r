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

Tests: 56 cases, 53 pass and 3 fail as expected.

Not verified: the GitHub Actions run itself, GCodeSender against a
serial port (changed), Perl XS build, Perl GUI, Perl tests, C++ GUI
(`-DEnable_GUI=ON`).

## Support material is broken in the C++ CLI

A table-shaped model (20 x 20 mm top on a 4 x 4 mm post) sliced with
`--support-material` gets no support: the log says `Empty contact_areas` and filament
use is unchanged. `src/test/libslic3r/test_support_material.cpp` is not part of the
test build; added by hand it passes, so it does not cover this. **Do not use the C++
CLI for prints that need support.** The Perl application uses its own
`lib/Slic3r/Print/SupportMaterial.pm` (not yet run).

## Other findings

- The Perl application generates G-code and supports in Perl; the C++ CLI uses its
  own C++ versions. Output may differ between the two.
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
