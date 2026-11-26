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
| `src/GUI/` | C++ GUI: unfinished skeleton, many `//TODO` stubs |
| `lib/Slic3r/`, `slic3r.pl` | Perl application and the full GUI; has its **own** G-code and support generation |
| `xs/xsp/`, `xs/t/`, `t/` | Perl/C++ bindings and Perl tests |
| `package/` | Linux desktop entry only; packaging not built yet |

**Two pipelines:** a change to G-code or support generation in C++ does not
automatically affect the Perl GUI. Check both (`lib/Slic3r/Print/GCode.pm`,
`lib/Slic3r/Print/SupportMaterial.pm`).

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

Support material does not work in the C++ CLI (see `plan/baseline.md`).

## Rules

- License is AGPL-3.0 and stays so. Keep existing copyright and attribution.
- Code ported from another project: check the license is compatible, and record
  source repo, commit and license in the file header and the commit message.
- AI use is disclosed (README). Keep the `Co-Authored-By` trailer on AI-assisted commits.
- No upstreaming planned; upstream compatibility is not a constraint.
- Public repo: no secrets, personal paths or personal data in commits.
- Do not push, tag or release unless asked.
- Verify G-code changes by slicing and comparing output, not only by compiling.
