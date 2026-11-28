# Bazel build: plan

Written 2026-11-28. **Nothing is built yet**; the questions at the end come first.

Goal: build, test and package with Bazel, with the same programs and the same G-code as
today, and then one build system only.

## What the CMake build does today

| Piece | Today | In Bazel |
|---|---|---|
| `libslic3r`, 9 libraries in `third_party` | static libraries; third party built with `-w` | one `cc_library` each |
| Command line, GUI | one program, with or without wx (`Enable_GUI`) | two `cc_binary`: `slic3r-cli` (no wx) and `slic3r` (everything, as shipped) |
| `USE_WX` | also changes `PrintConfig.cpp` (`--autosave`, `--datadir`, ...) | define those options always, so there is one `libslic3r` |
| Boost 1.83 (thread, filesystem, nowide) | system, linked statically | system: `linkopts`, no repository rule |
| wxWidgets 3.2, OpenGL, GLU | `find_package` | `-lGL -lGLU`; wx needs a small repository rule around `wx-config` (it is not in the Bazel Central Registry) |
| Catch2 2.4.2 | downloaded at build time, MD5 checked | `http_file` of the one header, SHA-256 checked (the registry has 3.x only) |
| Compiler flags | `-O3 -DNDEBUG`, compiler default standard (gnu++17), `-DM_PI=...` and a few more | `.bazelrc`: `-c opt`, `-O3`, `-std=gnu++17` (Bazel's defaults differ) |
| Build commit in G-code and About box | `git rev-parse` at configure time | `--workspace_status_command` and a stamped header |
| `test_options.hpp` (path of the test inputs) | written into the source tree | generated header with a runfiles path |
| Quick tests (unit, golden, command line) | ctest label `quick` | `cc_test` and `sh_test`, tag `quick`, `timeout = "short"` (60 s) |
| GUI tests | ctest label `gui`, 300 s | `sh_test`, tag `gui`, `timeout = "moderate"` (300 s); each already has its own X display |
| Icons | the program looks in `../var` beside itself | copy `var/` to that place in `bazel-bin`; check `bazel run` |
| `utils/make_dist.sh` | calls CMake | same script and output, calls Bazel |
| CI | `debian:13` container, apt, two jobs | same container, Bazelisk with a pinned SHA-256, disk cache kept between runs |

Dropped with CMake: the MSVC, MinGW and macOS branches (Debian 13 is the only target),
`PROFILE`, `COVERAGE` (`bazel coverage` does it), `SLIC3R_STATIC`. `extrude-tin` becomes
a target of its own.

Layout: `MODULE.bazel`, `.bazelversion`, `.bazelrc` at the repository root; a
`BUILD.bazel` in `src`, `src/libslic3r`, `src/third_party`, `src/GUI`, `src/test`, `utils`.
Libraries stay as coarse as they are now; splitting `libslic3r` is a later question.

## Steps

CMake stays and stays authoritative until step 4. Each step is one or a few commits.

| Step | Work | Done when |
|---|---|---|
| 1 | Module files, third party, `libslic3r`, `slic3r-cli`, quick tests | `bazel test --test_tag_filters=quick //...` passes; golden G-code unchanged |
| 2 | wx rule, GUI library and program, `gui_unit`, GUI scripts | `bazel test --test_tag_filters=gui //...` passes |
| 3 | Build commit, `make_dist.sh`, CI jobs beside the CMake ones | CI green with both; the owner builds and starts the program on the desktop |
| 4 | Remove CMake, update `CLAUDE.md`, README, CI | no `CMakeLists.txt`; CI green |
| 5 | `.deb` with `rules_pkg` ([TODO.md](TODO.md)) | CI builds a package that installs and slices in a clean `debian:13` |

## Risks

- **Checking it here.** Bazel does not start in the Debian 13 test chroot (no `/proc`),
  and the development sandbox (Ubuntu) lacks the Boost and wx packages. Either they are
  installed there, which still is not Debian 13, or CI is the only check (slow).
- **Output differences.** Other flags can change floating point results. The golden files
  decide; compare with the CMake program on larger models too.
- **Debian dependencies of the `.deb`.** `rules_pkg` does not work them out from the
  binary; they are listed by hand and checked by installing.
- **Tests under Bazel's sandbox.** The GUI scripts start Xvfb and local servers and use
  pseudo terminals; expect some adjusting.

## Questions for the owner

| # | Question | Suggestion |
|---|---|---|
| 1 | Boost and friends from Debian (apt), or from the Bazel Central Registry (same output on any Linux, longer builds)? wx comes from apt either way | Debian: it is the target, and matches today's output |
| 2 | CMake: remove at parity (step 4), or keep both? | Remove: two build files drift apart |
| 3 | Which Bazel version, in `.bazelversion`? | Pin 9.3.3, what Bazelisk picks today |
| 4 | Two programs (`slic3r-cli` without wx, `slic3r`) as above, or the full one only? | Two: quick tests and servers need no wx |
| 5 | The `.deb` item: after Bazel (step 5), or now with CPack? | After: otherwise it is done twice |
| 6 | May the build packages be installed in the sandbox for checking? | Yes, else every step waits for CI |
