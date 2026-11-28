# Bazel build

Planned and carried out 2026-11-28; CMake is removed (in git history). Decisions:
[DECISIONS.md](DECISIONS.md).

## Rules for targets

- One library target is as small as the code allows, often one `.cpp` and its header, with
  its own test target.
- A test depends only on the target it tests (and Google Test), and is `size = "small"`
  unless it cannot be. `//src/test:minimal_test` stays: it checks the setup itself.
- The code is not reshaped for the sake of tests: files that need each other make one
  target.

## What the code allows

Measured on 2026-11-28 from the `#include` lines and the symbols of the object files.
`libslic3r` has 65 units (a `.cpp` with its header, or a lone file). Most can be a target
of their own. Four groups need each other in a circle, and each is one target:

| Target | Units | Lines |
|---|---|---|
| geometry: Point, BoundingBox, Line, MultiPoint, Polyline, ClipperUtils, Polygon, ExPolygon, Geometry, ExPolygonCollection, PolylineCollection, SVG, Surface, TransformationMatrix, TriangleMesh | 15 | 7,700 |
| fill patterns | 7 | 1,700 |
| slicing core: Model, IO, Print, layers, GCode, support, ... | 15 | 10,900 |
| ExtrusionEntity and its collection | 2 | 700 |

In the GUI nearly every file is a target; the main window, plater, controller and preset
editors need each other (`//src/GUI:application`).

## Steps

| # | Library target | Needs | Test | State |
|---|---|---|---|---|
| 1 | none | Google Test | `minimal_test`: asserts true | done |
| 2 | `exception` (header) | nothing | `exception_test` (new) | done |
| 3 | `log` | Boost.Locale, Boost.Algorithm | `log_test`: ported from `test_log.cpp` (its 80 checks less 3 repeats) | done |
| 4 | `conditional_gcode` | `exprtk` | `conditional_gcode_test`: the `apply_math` checks of `test_gcode_math.cpp` | done |
| 5 | `bspline`, `libslic3r` (common header), `layer_height_spline` | Boost.Thread | `layer_height_spline_test` (new) | done |
| 6 | `utils` | `log` | `utils_test` (new) | done |
| 7 | `gcode_sender` | Boost.Asio | `gcode_sender_test` (new): a pseudo terminal as the printer | done |
| 8 | `miniz`, `miniz_extension` | `exception` | `miniz_extension_test` (new): a zip file there and back | done |
| 9 | `geometry` (15 units), after `clipper`, `admesh`, `poly2tri`, `polypartition` | Boost.Polygon | `geometry_test`, `polygon_test`, `transformation_matrix_test`: ported from the three Catch files | done |
| 10 | bridge detector, motion planner, adaptive slicing, surfaces | geometry | `primitives`, `medial_axis`, `bridge_detector`, `motion_planner`, `surface_collection`, `slicing_adaptive` tests | done |
| 11 | `config_base`, `print_config`, `config`, `placeholder_parser`, `extruder`, `gcode_reader`, `gcode_writer`, `gcode_time_estimator`, `pressure_regulator`, `vibration_limit` | geometry | 11 new and ported tests, one per target (`config_base` ... `vibration_limit`) | done |
| 12 | `extrusion_entity` (2 units), `flow`, `perimeter_generator`, `fill` (7 units) | config | `extrusion_entity`, `flow`, `perimeter_generator`, `fill` tests | done |
| 13 | `slicing_core` (15 units), `sla_print`, `simple_print` | all above, `expat`, `Zip` | `print`, `model`, G-code, support, mesh and file format tests, ported; `sla_print`, `simple_print` (new) | done |
| 14 | `slic3r-cli`, a program without wxWidgets | core | `command_line_test` (ported), `golden_test`, `command_line_script_test` | done |
| 15 | GUI parts, bottom up, then `slic3r` | wxWidgets, OpenGL | unit tests per part, then the GUI scripts | done |
| 16 | `utils/make_dist.sh` on Bazel, a Bazel job in CI | | CI green | done |
| 17 | remove CMake, the Catch tests and the old Boost.Nowide copy | | CI green | done |
| 18 | `//package:deb` (`rules_pkg`), release workflow | `dpkg-dev` | installs, slices and starts in a clean `debian:13` | done |
| later | build container | | | |

## Dependencies

Libraries come from the Bazel Central Registry.

- **Google Test** 1.18.0: in use.
- **Boost** 1.90.0.bcr.1, one module per library as targets need them. Bazel builds it
  from source and links it into the programs, so the installed Boost is not used. Debian
  has 1.83, which is no choice for Bazel (the registry has no Boost.Nowide that
  old). Checked 2026-11-28 with Debian 13's compiler and the same flags: the whole
  program and all tests built against 1.90 give identical golden G-code, pass the command
  line checks and the 101 test cases. One change is needed: `ConfigBase.cpp` includes
  `boost/nowide/cstdlib.hpp` instead of `cenv.hpp` (done in step 11).
- **Where to build.** A program Bazel builds needs only the C and C++ runtime of the
  system (and wxWidgets for the GUI), but those must be as new as the build machine's:
  build releases on Debian 13 (the release workflow does; later also a build container).
  Seen 2026-11-28: `slic3r-cli` built in the Ubuntu development container asks for glibc
  2.43 and does not start on Debian 13 (2.41). Test programs are linked against files in
  Bazel's output tree and run through `bazel test`.
- **wxWidgets** is not in the registry (looked for `wxwidgets` and `wxwidget`): it and
  OpenGL come from the system, found through `wx-config` (`bazel/wx.bzl`).

## Packages

`//package:deb` puts the program and icons in `/usr/lib/slic3r`, a link in `/usr/bin`, the
profiles in `/usr/share/slic3r`. `dpkg-shlibdeps` names the dependencies from the build
machine, so a package is for the Debian it was built on.
`.github/workflows/release.yml` builds it, installs it with
`--no-install-recommends` in a clean `debian:13`, compares golden G-code and runs the GUI
smoke script on the installed program, and publishes a release only when asked.

## Not carried over from CMake

- Windows and macOS settings (the target is Debian 13).
- `-Wall`: add it when the warnings are to be worked through.
- Options: for debug output `--copt=-DSLIC3R_DEBUG`, for coverage `bazel coverage`.
