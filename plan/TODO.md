# TODO

Open items as of 2026-11-27. Background and what is done: [README.md](README.md).
Feature candidates (not scheduled): [features.md](features.md).

## C++ GUI

- [ ] Preview: layers and toolpaths (3D and 2D) — next
- [ ] Preset editors: the Perl GUI's page layouts, rules that enable/disable dependent
      options, several extruders, wizard, preset compatibility
- [ ] Plater: background slicing on changes (`background_processing`), export
      STL/AMF/3MF, undo; test the "Add…" dialog under Xvfb
- [ ] Object settings and modifiers, cut, rotate to face, preferences
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

## Repo and release

- [ ] GitHub repo description and homepage (still slic3r.org)
- [ ] Fetch upstream tags (none in the fork, so `git describe` fails)
- [ ] `.deb` for Debian 13, built by CI, published as a GitHub release
