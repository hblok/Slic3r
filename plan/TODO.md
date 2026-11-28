# TODO

Open items as of 2026-11-28. Background and what is done: [README.md](README.md).
Feature candidates (not scheduled): [features.md](features.md).

## GUI

Perl is gone; the GUI has been checked only under Xvfb.

- [ ] Try drag and drop (the "Add…" dialog was tried once, 2026-11-28)
- [ ] Not tried against hardware or real servers: the serial and OctoPrint "Test"
      buttons, "Browse…" (needs `avahi-browse`), the DLP projector

Differences from the Perl GUI, to fix if they matter:

- Menu entries that cannot be used are not greyed out
- "Layer heights…" shows layer lines in its 3D view, not toolpaths
- No Growl notification when slicing is done (it needed an optional Perl module)
- Importing a config bundle never overwrites an existing preset
- The conflict rules of the preset editors run on a change, not when a preset is loaded
- `--load` does not look beside the program for a file that is not found
- The Solarized colour scheme keeps the default toolbar icons

## Needs the printer

- [ ] Controller tab on the real printer: connect, temperatures, manual moves, a print,
      pause and resume (so far only against `utils/fake_printer.py`)
- [ ] Read firmware version and capabilities (`M115`, `M503`)
- [ ] Check the [profile values](../profiles/README.md#not-verified-yet)
- [ ] Print one reference part
- [ ] Print the [temperature tower and flow test](../profiles/calibration/README.md)
- [ ] Test prints: time estimate, fuzzy skin, monotonic infill, ironing, pressure advance

## Needs a real desktop

- [ ] Try the C++ GUI with a window manager and GPU (`utils/make_dist.sh`, so far Xvfb only)

## Repo and release

- [ ] Look at the first CI run after 2026-11-27 afternoon (new preview checks and the
      `cpp_gui_plate.sh` step have not run on GitHub)
- [ ] GitHub repo description and homepage (still slic3r.org)
- [ ] Fetch upstream tags (no version tags in the fork, so `git describe` fails)
- [ ] `.deb` for Debian 13, built by CI, published as a GitHub release

## Later

- [ ] Build with Bazel
