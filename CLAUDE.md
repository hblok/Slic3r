# Slic3r (hblok fork)

Unofficial, independently maintained fork of [Slic3r](https://github.com/slic3r/Slic3r),
forked at `026c1380`. Goal: make it build on current systems and bring in useful
slicing features from the years since. Main target printer: Creality Ender 5 Pro.

Start at [plan/README.md](plan/README.md). Read [plan/DECISIONS.md](plan/DECISIONS.md)
before proposing a change of direction.

## Layout

| Path | What |
|---|---|
| `xs/src/libslic3r/` | C++ slicing core |
| `src/` | C++ CLI (`slic3r.cpp`), CMake build, Catch2 tests (`src/test/`) |
| `src/GUI/` | C++ GUI (wxWidgets 3.2), replacing the Perl GUI: builds with `-DEnable_GUI=ON` and starts (`utils/cpp_gui_smoke.sh`, `utils/cpp_gui_plate.sh`); what is missing is in plan/TODO.md |
| `lib/Slic3r/`, `slic3r.pl` | Perl GUI; slicing, support and G-code run in C++ through XS; command line use goes to the C++ CLI |
| `xs/xsp/`, `xs/t/`, `t/` | Perl/C++ bindings and Perl tests |
| `package/` | Linux desktop entry only; packaging not built yet |

**One pipeline** since 2026-11-27: the Perl program calls the C++ G-code export and
support generation (`Print.xsp`); their Perl ports are deleted. Goal: Perl only for the
GUI, then not at all (plan/README.md, "Perl and the GUI path").

## Build and test (C++ core)

Target is Debian 13:

```sh
sudo apt install cmake g++ libboost-dev libboost-thread-dev libboost-filesystem-dev libboost-nowide-dev
```

```sh
cmake -S src -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j$(nproc)
./build/slic3r_test
src/test/golden/check.sh build/slic3r
```

Run both the tests and the golden check before committing C++ changes. If the golden
output changes on purpose, run `check.sh build/slic3r --update` and review the diff.
Expected output is recorded on Debian 13.

The first build downloads Catch2. CMake writes `src/test/test_options.hpp`
(ignored by git).

`slic3r.pl` with files hands its arguments to the C++ CLI (`build/slic3r`, or
`slic3r-cli` in a run directory); only the GUI start is Perl. The former parity check
(`compare_perl.sh`, 94 setups identical) was removed with the Perl command line; some of
its setups live on in the golden check. The GUI smoke test compares the GUI's G-code
with the C++ CLI's.

## Build and test (Perl application and GUI)

Packages are listed in README and in the `perl` job of
[build.yml](.github/workflows/build.yml). The XS module compiles the same
`xs/src/libslic3r` sources, so C++ changes reach the Perl program after `./Build`.

After changing a header, run `./Build realclean` first: Module::Build only rebuilds a
`.cpp` newer than its `.o`, and objects built against an old class layout still link.

```sh
(cd xs && perl Build.PL && ./Build && ./Build test)
export PERL5LIB=$PWD/xs/blib/arch:$PWD/xs/blib/lib
prove -j$(nproc) t/
utils/gui_smoke.sh /tmp/gui-smoke   # needs xvfb xdotool imagemagick
```

`utils/make_dist.sh` builds a copyable run directory of the C++ program (no Perl) in
`build/dist-gui`; build it on Debian 13 (the chroot), it is tied to its wxWidgets and Boost.

The smoke test drives the GUI with clicks at fixed window coordinates (no window
manager under Xvfb). A layout change breaks it; check its screenshots, re-measure.

## Rules

- License is AGPL-3.0 and stays so. Keep existing copyright and attribution.
- Code ported from another project: check the license is compatible, and record
  source repo, commit and license in the file header and the commit message.
- AI use is disclosed (README). Keep the `Co-Authored-By` trailer on AI-assisted commits.
- No upstreaming planned; upstream compatibility is not a constraint.
- Public repo: no secrets, personal paths or personal data in commits.
- Commit each verified step and push it. Do not tag or release unless asked.
- Verify G-code changes by slicing and comparing output, not only by compiling.
