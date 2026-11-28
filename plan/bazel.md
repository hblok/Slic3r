# Bazel build: plan

Written 2026-11-28, last revised with the owner's answers the same day. Decisions: [DECISIONS.md](DECISIONS.md).

Goal: build, test and package with Bazel, then remove CMake.

## How we work

- Slowly, from the bottom up. One step adds one library target (as small as the code
  allows, often one `.cpp` and its header) and its own test target.
- A step is done when `bazel test //...` builds, runs and passes. Commit, push, then the
  next one.
- A test depends only on the target it tests (and Google Test), and is `size = "small"`
  unless it cannot be. `//src/test:minimal_test` stays: it checks the setup itself.
- The code is not reshaped for the sake of tests: files that need each other make one
  target.
- The existing Catch tests are ported to Google Test as their targets arrive, to
  `<name>_test.cpp` beside them; the `test_*.cpp` files stay for CMake until it goes.
- CMake stays authoritative until Bazel matches it, and is then removed soon.
- We build inside a container (the development one for now; a build container later).

## What the code allows

Measured on 2026-11-28 from the `#include` lines and the symbols of the CMake objects.
`libslic3r` has 65 units (a `.cpp` with its header, or a lone file). Most can be a target
of their own. Four groups need each other in a circle, and each becomes one target:

| Target | Units | Lines |
|---|---|---|
| geometry: Point, BoundingBox, Line, MultiPoint, Polyline, ClipperUtils, Polygon, ExPolygon, Geometry, ExPolygonCollection, PolylineCollection, SVG, Surface, TransformationMatrix, TriangleMesh | 15 | 7,700 |
| fill patterns | 7 | 1,700 |
| slicing core: Model, IO, Print, layers, GCode, support, ... | 15 | 10,900 |
| ExtrusionEntity and its collection | 2 | 700 |

## Steps

| # | Library target | Needs | Test | State |
|---|---|---|---|---|
| 1 | none | Google Test | `minimal_test`: asserts true | done |
| 2 | `exception` (header) | nothing | `exception_test` (new) | done |
| 3 | `log` | Boost.Locale, Boost.Algorithm | `log_test`: ported from `test_log.cpp` (its 80 checks less 3 repeats) | done |
| 4 | `conditional_gcode` | `exprtk` | `conditional_gcode_test`: the `apply_math` checks of `test_gcode_math.cpp` | done |
| 5 | `bspline`, `libslic3r` (common header), `layer_height_spline` | Boost.Thread | `layer_height_spline_test` (new) | done |
| 6 | `utils` | `log` | `utils_test` (new) | done |
| 7 | `gcode_sender` | Boost.Asio | new, with a pseudo terminal | next |
| 8 | `miniz`, `miniz_extension` | Boost.Nowide | new, small | |
| 9 | `geometry` (15 units), after `clipper`, `admesh`, `poly2tri`, `polypartition` | Boost.Polygon | geometry, polygon, matrix tests | |
| 10 | bridge detector, motion planner, adaptive slicing, surfaces | geometry | per target | |
| 11 | config: base, print config, parser, G-code reader and writer, extruder, filters | geometry | config and G-code tests | |
| 12 | extrusion entities, flow, perimeters, `fill` (7 units) | config | per target | |
| 13 | slicing core, then SLA and simple print | all above, `expat`, `Zip` | the tests that need whole prints | |
| 14 | `slic3r-cli`, a program without wxWidgets | core | golden G-code and command line checks | |
| 15 | GUI parts, bottom up, then `slic3r` | wxWidgets, OpenGL | unit tests per part, then the GUI scripts | |
| 16 | `utils/make_dist.sh` on Bazel, a Bazel job in CI | | CI green; the owner tries the program | |
| 17 | remove CMake, update `CLAUDE.md` and README | | CI green | |
| later | `.deb` (`rules_pkg`), build container | | installs and slices in a clean `debian:13` | |

Steps 9 to 15 are split further when we get there: one target (or one test) per commit.

## Dependencies

Libraries come from the Bazel Central Registry.

- **Google Test** 1.18.0: in use.
- **Boost** 1.90.0.bcr.1, one module per library as targets need them. Bazel builds it
  from source and links it into the programs, so the installed Boost is not used. CMake
  uses Debian's 1.83; 1.83 is no choice for Bazel (the registry has no Boost.Nowide that
  old). Checked 2026-11-28 with Debian 13's compiler and the CMake flags: the whole
  program and all tests built against 1.90 give identical golden G-code, pass the command
  line checks and the 101 test cases. One change is needed: `ConfigBase.cpp` includes
  `boost/nowide/cstdlib.hpp` instead of `cenv.hpp` (step 11).
- **Where to build.** A program Bazel builds needs only the C and C++ runtime of the
  system (and wxWidgets for the GUI), but those must be as new as the build machine's:
  build releases on Debian 13 (later: the build container). Test programs are linked
  against files in Bazel's output tree and run through `bazel test`.
- **wxWidgets** is not in the registry (looked for `wxwidgets` and `wxwidget`). For step
  15 it comes from the system (installing build packages in the container is agreed), or
  Bazel builds it from source with `rules_foreign_cc`. Decided then.
- `src/third_party/boost` holds an old copy of Boost.Nowide that comes before the system
  one on the CMake include path (it is where `cenv.hpp` comes from). Bazel uses the
  registry's; removing the copy waits for step 17.

## To solve when we get there

| Topic | Note |
|---|---|
| Compiler flags | CMake: `-O3 -DNDEBUG`, gnu++17 (compiler default), `-DM_PI=...` and a few more. Bazel's defaults differ; the golden G-code decides |
| `USE_WX` | changes `PrintConfig.cpp` (`--autosave`, `--datadir`, ...): define those options always, so there is one library |
| Build commit in G-code and About box | `--workspace_status_command` and a stamped header |
| `test_options.hpp` | paths of test inputs become runfiles |
| Icons | the program looks in `../var` beside itself; check `bazel run` |
| Test time limits | quick tests `size = "small"` (60 s), GUI tests 300 s |
| `.deb` dependencies | `rules_pkg` does not work them out; list them and check by installing |
| Checking GUI steps | the container is Ubuntu; CI and the target are Debian 13 |
