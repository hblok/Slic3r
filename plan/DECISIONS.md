# Decisions

## 2026-11-26
- Maintain this as an independent fork. No plan to contribute back upstream.
- Public repository, AGPL-3.0, unchanged from the original.
- AI assistance in maintenance and development is disclosed.
- Replace upstream CI and service references with ones we maintain.
- Plan before code: setup and `plan/` first.
- Target Debian 13 (apt). Other platforms are not a goal; their source code stays.
- Printer: Creality Ender 5 Pro, unmodified stock.
- Keep the name Slic3r for now; a new logo is possible later.
- Delete cruft. Done the same day: Travis and AppVeyor config, deploy scripts and
  keys, `package/` except the desktop entry, upstream issue templates.
- Failure is affordable (experimental fork), provided slicing output is verified.

## 2026-11-27
- The GUI becomes C++ with wxWidgets (3.2, as in Debian 13), finishing the C++ skeleton
  in `src/GUI`. Port the Perl GUI screen by screen; it uses the same widgets. Code from
  PrusaSlicer and OrcaSlicer (AGPL, also wxWidgets) may be borrowed with attribution.
  Not chosen: Qt 6 (full rewrite, no reuse), a web UI over the CLI (a different program).
- Goal: no Perl at all. The Perl GUI stays usable until the C++ one does what it does.
- No functionality is dropped on the way away from Perl: the C++ GUI gets it all before
  the Perl code is deleted. The USB printer controller is wanted. SLA/projector is lower
  priority.
- Commit and push as the work goes.

## 2026-11-28
- Perl is removed ("get rid of the Perl code, feature parity first"). Already broken
  scripts were dropped rather than ported: `wireframe.pl`, `gcode_sectioncut.pl`.
- The translation files (`translation/`, `share/locale/`) are removed: neither program
  loaded them. For translations later, start from those at the tag `perl-final`.
- Move to Bazel (9.3.3, the latest): libraries such as Boost come from the Bazel Central
  Registry; CMake goes once Bazel matches it; two programs, with and without the GUI; a
  `.deb` much later. Builds run in a container (a build container later); installing
  build packages in the development container is fine.
- Bazel step by step: first an empty test, then small isolated targets (down to one
  file) with a test each, built up one by one, the GUI after the core. See
  [bazel.md](bazel.md).
- No code restructuring just for tests: files that need each other are one Bazel target.
  Existing C++ tests are ported to Google Test. Boost: whichever version is most
  convenient (1.90, see [bazel.md](bazel.md)). Bazel in CI later.
- Continue with the Bazel steps without waiting after each; CMake to be phased out soon.

