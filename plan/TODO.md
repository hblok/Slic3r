# TODO

Open items as of 2026-11-27. Background and what is done: [README.md](README.md).
Feature candidates (not scheduled): [features.md](features.md).

## C++ GUI

Done on 2026-11-27 and checked only under Xvfb: preview, plater operations and menus,
preferences, editor rules, object settings and modifiers, a one-page wizard.

Missing, compared with the Perl GUI:

- [ ] Layer heights (adaptive spline dialog), rotate to face, cut by grid, live cut preview
- [ ] "Create modifier" (box, cylinder, slab) and moving parts in Object > Settings;
      layer height ranges
- [ ] Preset editors: hand-made page layouts, several extruders (extruder count),
      compatible printers, bed shape dialog
- [ ] Wizard on first start; remember loaded config files; reload options (keep
      transformations, added parts)
- [ ] Preview: colour by extruder, greyed overlapping layers, camera shared with the 3D
      plater
- [ ] Printer controller (USB); the Controller tab is empty
- [ ] SLA/projector (lower priority); the DLP/SLA tab is empty
- [ ] Prompt about unsaved preset changes when closing (they are lost silently now)
- [ ] Try the "Add…" dialog and drag and drop

Order: the unsaved-changes prompt, the missing features and the USB controller, then:

## Removing Perl (only when nothing would be lost)

- [ ] Port what only the Perl scripts do (`utils/*.pl`, `utils/post-processing/`) and the
      C++ command line lacks
- [ ] Port the tests only Perl has: no C++ test file for points, lines, polylines,
      clipper or the motion planner (`xs/t/`), and check `t/` case by case
- [ ] Tag the last commit with Perl (`perl-final`)
- [ ] Move the C++ core out of `xs/` (`LIBDIR` in `src/CMakeLists.txt`, keep
      `xs/src/slic3r/GUI/3DScene.*`), drop the `NO_PERL` conditional
- [ ] Delete `lib/`, `t/`, the bindings, `slic3r.pl`, `Build.PL`, `utils/gui_smoke.sh`,
      the CI `perl` job; update docs and packaging dependencies

## Needs the printer

- [ ] Read firmware version and capabilities (`M115`, `M503`)
- [ ] Check the [profile values](../profiles/README.md#not-verified-yet)
- [ ] Print one reference part
- [ ] Print the [temperature tower and flow test](../profiles/calibration/README.md)
- [ ] Test prints: time estimate, fuzzy skin, monotonic infill, ironing, pressure advance

## Needs a real desktop

- [ ] Try the C++ GUI with a window manager and GPU (`utils/make_dist.sh`, so far Xvfb only)

## Bugs

- [ ] `sequential_print_priority` is ignored: the sort in
      `xs/src/libslic3r/PrintGCode.cpp` compares `a` with itself
- [ ] With `-DEnable_GUI=ON`, building every target fails: `slic3r_test` does not find
      `ColorScheme/ColorSchemeBase.hpp` (CI builds only the `slic3r` target there)

## Repo and release

- [ ] Look at the first CI run after 2026-11-27 afternoon (new preview checks and the
      `cpp_gui_plate.sh` step have not run on GitHub)
- [ ] GitHub repo description and homepage (still slic3r.org)
- [ ] Fetch upstream tags (none in the fork, so `git describe` fails)
- [ ] `.deb` for Debian 13, built by CI, published as a GitHub release

## Later

- [ ] Build with Bazel
