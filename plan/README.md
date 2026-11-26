# Plan

Started 2026-11-26. Status: **phase 1 in progress**.
Target: Debian 13, unmodified Creality Ender 5 Pro.

| File | Content |
|---|---|
| [baseline.md](baseline.md) | What we found in the repo and what works today |
| [features.md](features.md) | Candidate features, ranked for the Ender 5 Pro |
| [DECISIONS.md](DECISIONS.md) | Settled decisions |

## Phases

Each phase ends with something that can be checked.

### 0. Housekeeping
- [x] `CLAUDE.md`, `plan/`
- [x] README: fork notice, AI disclosure, dead badges and download links removed
- [x] `CONTRIBUTING.md`, `CODEOWNERS` point to this fork
- [x] Dead CI, deploy and Windows/macOS packaging files deleted; upstream issue templates deleted
- [ ] GitHub repo description and homepage (homepage still says slic3r.org)
- [ ] Fetch upstream tags (the fork has none, so `git describe` fails)

### 1. C++ core builds, is verified, CI is ours
- [x] Build on current toolchain and Boost
- [x] Fix flaky test (uninitialised variable in the G-code writer)
- [x] GitHub Actions ([build.yml](../.github/workflows/build.yml)): build and test in a
      `debian:13` container, daily plus manual dispatch, not on every commit
- [x] Golden G-code check ([check.sh](../src/test/golden/check.sh)): box with default
      and tuned settings, and an overhang model; runs in CI
- [ ] Push, merge `modernize` into `master`, enable Actions for the fork, run it once
- Done when: a clean CI run is green (56 test cases, 3 expected failures) and the
  golden check passes

### 2. The GUI runs
The biggest unknown. Time-box it to one or two sessions.
- [ ] Build the Perl XS module on Debian 13
- [ ] Start the Perl GUI with distro packages (`libwx-perl`, `libwx-glcanvas-perl`, `libopengl-perl`)
- [ ] Run the Perl tests (`t/`, `xs/t/`) and record failures
- [ ] Stop the update check that calls slic3r.org (`lib/Slic3r/GUI.pm`)
- Done when: load an STL, preview it, export G-code. Then confirm the GUI path (below).

### 3. Printer baseline
- [ ] Ender 5 Pro config bundle (printer, filament, print profiles)
- [ ] Read the firmware version and capabilities from the printer (`M115`, `M503`)
- [ ] Add the profiles to the golden check
- [ ] Print one reference part on the real printer

### 4. Features
One at a time from [features.md](features.md), each with a test and a test print.

### 5. Packaging
- [ ] `.deb` for Debian 13, built by CI, published as a GitHub release

## Perl and the GUI path

| Part | Lines |
|---|---|
| GUI (`lib/Slic3r/GUI*`) | 17,800 |
| Logic (`lib/`, rest): support, G-code export, config, geometry, filters | 5,500 |
| CLI, utilities, build scripts | 2,200 |
| Tests (`t/`, `xs/t/`) | 7,800 |
| For comparison: C++ core | 35,500 |

| Option | For | Against |
|---|---|---|
| **A. Keep Perl now, replace it in stages** | Early usable program; Perl is the reference for each port | wxPerl is barely maintained; two pipelines for a while |
| B. Go straight to C++ | One language | No working GUI for a long time; supports are broken in C++ |
| C. New UI over the C++ CLI | Modern, testable | Largest change in look and feel; supports still broken |

Recommendation: **A**.
1. Get the Perl program running (phase 2).
2. Fix C++ support generation, compare output with Perl, retire Perl logic.
3. Finish the C++ GUI (or replace it), then remove Perl.

If phase 2 turns out to be hopeless, go to B.

## Open questions

None blocking. The firmware details are read from the printer in phase 3.
