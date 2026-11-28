# Slic3r (hblok fork)

Unofficial, independently maintained fork of [Slic3r](https://github.com/slic3r/Slic3r),
forked at `026c1380`. Goal: make it build on current systems and bring in useful
slicing features from the years since. Main target printer: Creality Ender 5 Pro.

Start at [plan/README.md](plan/README.md). Read [plan/DECISIONS.md](plan/DECISIONS.md)
before proposing a change of direction.

## Layout

| Path | What |
|---|---|
| `src/libslic3r/` | C++ slicing core |
| `src/` | command line program (`slic3r.cpp`), CMake build, Catch2 tests (`src/test/`) |
| `src/GUI/` | GUI (wxWidgets 3.2): builds with `-DEnable_GUI=ON` |
| `src/third_party/` | libraries from other projects (admesh, Clipper, poly2tri, expat, miniz, ...) |
| `utils/` | GUI test scripts and their stand-ins, `make_dist.sh`, post-processing scripts (Python) |
| `package/` | Linux desktop entry only; packaging not built yet |

All C++ since 2026-11-28. The Perl program (GUI, bindings, tests) is in git history; the
tag `perl-final` is the last commit with all of it.

## Tests: two labelled sets

| Set | Command | What | Limit |
|---|---|---|---|
| `quick` | `ctest --test-dir build -L quick -j8 --output-on-failure` | unit and functional tests, golden G-code, command line (about 6 s) | 2 min each |
| `gui` | `ctest --test-dir build-gui -L gui -j5 --output-on-failure` | full C++ GUI under Xvfb (about 3 min) | 5 min each |

Build first (below). Run `quick` while working, `gui` after GUI changes. A new test gets
one of the two labels and a `TIMEOUT` in `src/CMakeLists.txt`. The GUI scripts also kill
themselves after 290 s, run by hand or in CI. Never wait longer than 5 minutes for a test:
a run that gets there is stuck.

## Build and test (C++ core)

Target is Debian 13:

```sh
sudo apt install cmake g++ libboost-dev libboost-thread-dev libboost-filesystem-dev libboost-nowide-dev
```

```sh
cmake -S src -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j$(nproc)
ctest --test-dir build -L quick -j8 --output-on-failure   # slic3r_test, golden/check.sh, cli/check.sh
```

Run the quick set before committing C++ changes. If the golden
output changes on purpose, run `check.sh build/slic3r --update` and review the diff.
Expected output is recorded on Debian 13.

The first build downloads Catch2. CMake writes `src/test/test_options.hpp`
(ignored by git).

## Build and test (C++ GUI)

Also needs `libwxgtk3.2-dev libgl-dev libglu1-mesa-dev xvfb xdotool imagemagick`.

```sh
cmake -S src -B build-gui -DCMAKE_BUILD_TYPE=Release -DEnable_GUI=ON
cmake --build build-gui -j$(nproc)
ctest --test-dir build-gui -L gui -j5 --output-on-failure
```

That runs `utils/cpp_gui_smoke.sh` (slicing, presets, preview, quit prompt),
`utils/cpp_gui_presets.sh` (preset editors, shortcuts, several extruders, upload to a
stand-in print server; that step needs python3), `utils/cpp_gui_controller.sh` (the
Controller tab with a stand-in printer on a pseudo terminal; skipped where there are
none, as in the chroot), `utils/cpp_gui_projector.sh` (DLP projector; without pseudo
terminals it leaves out the print) and the four
parts of `utils/cpp_gui_plate.sh` (plater, object operations, face and cut tools, File
menu); screenshots end
up in `build-gui/gui-*`. A part that nears 5 minutes gets split.
Run it after GUI changes. They click at fixed positions and count menu entries: a new
menu entry or layout change needs the scripts adjusted (see their screenshots).

`utils/make_dist.sh` builds a copyable run directory of the program in
`build/dist-gui`; build it on Debian 13 (the chroot), it is tied to its wxWidgets and Boost.

## Rules

- License is AGPL-3.0 and stays so. Keep existing copyright and attribution.
- Code ported from another project: check the license is compatible, and record
  source repo, commit and license in the file header and the commit message.
- AI use is disclosed (README). Keep the `Co-Authored-By` trailer on AI-assisted commits.
- No upstreaming planned; upstream compatibility is not a constraint.
- Public repo: no secrets, personal paths or personal data in commits.
- Commit each verified step and push it. Do not tag or release unless asked.
- Verify G-code changes by slicing and comparing output, not only by compiling.
