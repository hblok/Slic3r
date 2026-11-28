# Bazel build: plan

Written and revised 2026-11-28. Step 1 is done. Decisions: [DECISIONS.md](DECISIONS.md).

Goal: build, test and package with Bazel, then remove CMake.

## How we work

- Slowly, from the bottom up. One step adds one library target (as small as the code
  allows, often one `.cpp` and its header) and its own test target.
- A step is done when `bazel test //...` builds, runs and passes. Commit, push, then the
  next one.
- A test depends only on the target it tests.
- CMake stays unchanged and authoritative until Bazel matches it.
- We build inside a container (the development one for now; a build container later).

## What the code allows

Measured on 2026-11-28 from the `#include` lines and the symbols of the CMake objects.
`libslic3r` has 65 units (a `.cpp` with its header, or a lone file). Units that need
each other in a circle cannot be separate Bazel targets.

| Circle | Units | Lines | To split it |
|---|---|---|---|
| Geometry: Point, BoundingBox, Line, MultiPoint, Polyline, ClipperUtils, Polygon, ExPolygon, Geometry, ExPolygonCollection, PolylineCollection, SVG, Surface, TransformationMatrix, TriangleMesh | 15 | 7,700 | move the functions behind 13 references |
| Fill patterns | 7 | 1,700 | 8 references; putting the factory in its own file likely does it |
| Slicing core: Model, IO, Print, layers, GCode, support, ... | 15 | 10,900 | 19 references, some deep (Print and PrintObject) |
| ExtrusionEntity and its collection | 2 | 700 | keep as one |

All other units can be targets of their own. The headers are in good shape: the only
circle between headers is `Print.hpp` and `SupportMaterial.hpp`. So the geometry circle
is made by the `.cpp` files, and splitting it means moving function bodies:

| Today in | Needs | Function |
|---|---|---|
| Point | Line, MultiPoint | `Line::length`, `MultiPoint::first_point` |
| BoundingBox | Polygon | building a `Polygon` |
| Line | Polyline, Geometry | building a `Polyline`, `directions_parallel` |
| Polyline | ClipperUtils, ExPolygon, ExPolygonCollection | `offset`, `contains` |
| ClipperUtils | Polygon, ExPolygon, Geometry | conversions, `chained_path_items` |
| ExPolygon | Geometry | `MedialAxis::build` |

## Steps

| # | Library target | Needs | Test | State |
|---|---|---|---|---|
| 1 | none | Google Test | `minimal_test`: asserts true | done |
| 2 | `exception` (header) | nothing | new, small | next |
| 3 | `log` | Boost.Locale, Boost.Algorithm | the cases of `test_log.cpp` | the first Boost target |
| 4 | `conditional_gcode` | `exprtk` | new, small | |
| 5 | `bspline`, `libslic3r` (common header), `layer_height_spline` | Boost.Thread | new, small | |
| 6 | `utils` | `log` | new, small | |
| 7 | `gcode_sender` | Boost.Asio | new, with a pseudo terminal | |
| 8 | `miniz`, `miniz_extension` | Boost.Nowide | new, small | |
| 9 | geometry (question 1) with `clipper`, `admesh`, `poly2tri`, `polypartition` | Boost.Polygon | geometry, polygon, matrix tests | |
| 10 | bridge detector, motion planner, adaptive slicing, surfaces | geometry | per target | |
| 11 | config: base, print config, parser, G-code reader and writer, extruder, filters | geometry | config and G-code tests | |
| 12 | extrusion entities, flow, perimeters, fill | config | per target | |
| 13 | slicing core, then SLA and simple print | all above, `expat`, `Zip` | the tests that need whole prints | |
| 14 | `slic3r-cli`, a program without wxWidgets | core | golden G-code and command line checks | |
| 15 | GUI parts, bottom up, then `slic3r` | wxWidgets, OpenGL | unit tests per part, then the GUI scripts | |
| 16 | `utils/make_dist.sh` on Bazel, CI | | CI green; the owner tries the program | |
| 17 | remove CMake, update `CLAUDE.md` and README | | CI green | |
| later | `.deb` (`rules_pkg`), build container | | installs and slices in a clean `debian:13` | |

Steps 9 to 15 are split further when we get there: one target and one test per commit.

## Dependencies

Libraries come from the Bazel Central Registry.

- **Google Test** 1.18.0: in use.
- **Boost**: tried 2026-11-28 with Bazel 9.3.3 (thread, filesystem, polygon only).
  1.83.0, Debian 13's version, builds with `--incompatible_disallow_empty_glob=false`;
  1.90.0.bcr.1 builds as it is (question 3).
- **wxWidgets** is not in the registry (looked for `wxwidgets` and `wxwidget`). For step
  15 it comes from the system (installing build packages in the container is agreed), or
  Bazel builds it from source with `rules_foreign_cc`. Decided then.
- `src/third_party/boost` holds a copy of Boost.Nowide that comes before the system one
  on the include path. The Bazel build should use the registry's; removing the copy
  waits for step 17.

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

## Open questions

| # | Question | Suggestion |
|---|---|---|
| 1 | Geometry: split into 15 targets (moves about a dozen functions between files, no change in behaviour; CMake must still pass), or one coarse target? | Split, one function move per commit, checked with CMake and the golden files, before step 9 |
| 2 | The 101 existing test cases use Catch2 2.4.2. Port them to Google Test as their targets arrive, or run them with Catch? | Port, split to one file per target; the Catch files stay for CMake until step 17 |
| 3 | Boost 1.83.0 (with the flag) or 1.90? | 1.83.0 first, so results compare with CMake; upgrade as a step of its own |
| 4 | A Bazel job in CI now, or at step 16? | Now, while it is small |
