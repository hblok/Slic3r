# TODO

Open items as of 2026-11-28. Background and what is done: [README.md](README.md).
Feature candidates (not scheduled): [features.md](features.md).

## GUI

Perl is gone; the GUI has been checked only under Xvfb.

- [ ] Not tried against hardware or real servers: the serial and OctoPrint "Test"
      buttons, "Browse…" (needs `avahi-browse`), the DLP projector

Differences from the Perl GUI, to fix if they matter:

- "Layer heights…" shows layer lines in its 3D view, not toolpaths
- The Solarized colour scheme keeps the default toolbar icons

## Bugs

- [ ] `Config::set` with text that is not a number throws, but leaves 0 in the option
      (found 2026-11-28 porting the tests; `config_test.cpp`)

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
- [ ] Drag a model from the file manager onto the plater (works under Xvfb from a test
      window, tried 2026-11-28 on the 2D view, the 3D view and the side panel)

## Repo and release

- [ ] Upstream version tags are not on GitHub, so `git describe` in a fresh clone only
      finds `perl-final`. A clone with the `upstream` remote gets them with
      `git fetch upstream --tags` (done in the working copy 2026-11-28:
      `git describe --match '[0-9]*'` says 1.3.0-…). Push them to the fork? Owner's call
- [ ] Publish a first release: `gh workflow run release.yml -f publish=true` (builds and
      checks the `.deb` first; the owner says when)

