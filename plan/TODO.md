# TODO

Open items as of 2026-11-27. Background and what is done: [README.md](README.md).
Feature candidates (not scheduled): [features.md](features.md).

## C++ GUI

- [ ] Preview extras: colour by extruder, greyed overlapping layers (2D), camera shared
      with the 3D plater
- [ ] Preset editors: the Perl GUI's page layouts, rules that enable/disable dependent
      options, several extruders, wizard, preset compatibility
- [ ] Plater: background slicing on changes (`background_processing`), cut by grid,
      rotate to face, layer heights, reload with the Perl GUI's options; remember loaded
      config files; test drag and drop and the "Add…" dialog
- [ ] Object settings and modifiers, preferences
- [ ] Decide before porting: printer controller (USB), SLA/projector
- [ ] Remove Perl: `lib/`, `slic3r.pl`, `xs/`, `t/`; packaging dependencies

## Needs the printer

- [ ] Read firmware version and capabilities (`M115`, `M503`)
- [ ] Check the [profile values](../profiles/README.md#not-verified-yet)
- [ ] Print one reference part
- [ ] Print the [temperature tower and flow test](../profiles/calibration/README.md)
- [ ] Test prints: time estimate, fuzzy skin, monotonic infill, ironing, pressure advance

## Needs a real desktop

- [ ] Try the GUI with a window manager and GPU (so far Xvfb only)

## Bugs

- [ ] `sequential_print_priority` is ignored: the sort in
      `xs/src/libslic3r/PrintGCode.cpp` compares `a` with itself
- [ ] With `-DEnable_GUI=ON`, building every target fails: `slic3r_test` does not find
      `ColorScheme/ColorSchemeBase.hpp` (CI builds only the `slic3r` target there)

## Repo and release

- [ ] GitHub repo description and homepage (still slic3r.org)
- [ ] Fetch upstream tags (none in the fork, so `git describe` fails)
- [ ] `.deb` for Debian 13, built by CI, published as a GitHub release
