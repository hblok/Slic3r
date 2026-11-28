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
| `src/` | the program (`slic3r.cpp`), tests (`src/test/`) |
| `src/GUI/` | GUI (wxWidgets 3.2) |
| `src/third_party/` | libraries from other projects (admesh, Clipper, poly2tri, expat, miniz, ...) |
| `utils/` | GUI test scripts and their stand-ins, `make_dist.sh`, post-processing scripts (Python) |
| `package/` | the Debian package (`//package:deb`), desktop entry |
| `bazel/` | wxWidgets from the system, tests under Xvfb |

All C++ since 2026-11-28. The Perl program (GUI, bindings, tests) is in git history; the
tag `perl-final` is the last commit with all of it.

## Build

Bazel only (CMake removed 2026-11-28; it is in git history). Target is Debian 13:

```sh
sudo apt install g++ libwxgtk3.2-dev libgl-dev libglu1-mesa-dev \
  xvfb xauth xdotool imagemagick libgl1-mesa-dri      # second line: the GUI tests
bazel run //src:slic3r                                # the program; //src:slic3r-cli has no GUI
utils/make_dist.sh                                    # a copyable run directory
```

Version in `.bazelversion` (Bazelisk fetches it), flags in `.bazelrc`, result links in
`build/bazel/`, libraries from the registry except wxWidgets and OpenGL (system packages,
`bazel/wx.bzl`). Programs need system libraries as new as the build machine's: build
what is to run on Debian 13 on Debian 13.

One target per file where the code allows; files that need each other are one target
([plan/bazel.md](plan/bazel.md)).

## Tests

| Command | What |
|---|---|
| `bazel test //...` | everything: unit tests, golden G-code, command line, GUI (about 4 min) |
| `bazel test --test_tag_filters=-gui --build_tag_filters=-gui //...` | without the GUI and wxWidgets |
| `bazel test //src/...` | one part; `//utils/...` are the GUI scripts |

Google Tests are `<name>_test.cpp`, one per target; a test depends on the target it tests.
GUI unit tests use `gui_test` (`bazel/gui_test.bzl`). Tests are `size` small or medium;
GUI ones are tagged `gui`. The GUI scripts kill themselves after 290 s. Never wait longer
than 5 minutes for a test: a run that gets there is stuck.

Run the non-GUI tests before committing C++ changes, the GUI ones after GUI changes.
If the golden G-code changes on purpose, run `src/test/golden/check.sh PROGRAM --update`
(a built `slic3r-cli`) and review the diff. Expected output is recorded on Debian 13.

The GUI scripts: `utils/cpp_gui_smoke.sh` (slicing, presets, preview, quit prompt),
`cpp_gui_presets.sh` (preset editors, shortcuts, several extruders, upload to a stand-in
print server), `cpp_gui_controller.sh` (the Controller tab with a stand-in printer on a
pseudo terminal), `cpp_gui_projector.sh` (DLP projector) and the four parts of
`cpp_gui_plate.sh` (plater, object operations, face and cut tools, File menu).
Screenshots are among the test outputs (`build/bazel/testlogs/utils/*/test.outputs/`).
They click at fixed positions and count menu entries: a new menu entry or layout change
needs the scripts adjusted. A part that nears 5 minutes gets split.

## Packages and releases

`.github/workflows/release.yml` builds the `.deb` on Debian 13, installs it on a clean
one, checks it (`package/debian/check_installed.sh`) and, only when asked (run with
"publish" ticked, or a `v*` tag), publishes a GitHub release. Without that it is a
rehearsal: `gh workflow run release.yml`.

## Rules

- License is AGPL-3.0 and stays so. Keep existing copyright and attribution.
- Code ported from another project: check the license is compatible, and record
  source repo, commit and license in the file header and the commit message.
- AI use is disclosed (README). Keep the `Co-Authored-By` trailer on AI-assisted commits.
- No upstreaming planned; upstream compatibility is not a constraint.
- Public repo: no secrets, personal paths or personal data in commits.
- Commit each verified step and push it. Do not tag or release unless asked.
- Verify G-code changes by slicing and comparing output, not only by compiling.
