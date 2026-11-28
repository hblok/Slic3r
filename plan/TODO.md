# TODO

Open items as of 2026-11-28. Background and what is done: [README.md](README.md).
Feature candidates (not scheduled): [features.md](features.md).

## GUI

Perl is gone; the GUI has been checked only under Xvfb.

- [ ] Try drag and drop (the "Add…" dialog was tried once, 2026-11-28)
- [ ] Not tried against hardware or real servers: the serial and OctoPrint "Test"
      buttons, "Browse…" (needs `avahi-browse`), the DLP projector

Differences from the Perl GUI, to fix if they matter:

- "Layer heights…" shows layer lines in its 3D view, not toolpaths
- No Growl notification when slicing is done (it needed an optional Perl module)
- Importing a config bundle never overwrites an existing preset
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

- [ ] Upstream version tags are not on GitHub, so `git describe` in a fresh clone only
      finds `perl-final`. A clone with the `upstream` remote gets them with
      `git fetch upstream --tags` (done in the working copy 2026-11-28:
      `git describe --match '[0-9]*'` says 1.3.0-…). Push them to the fork? Owner's call
- [ ] `.deb` for Debian 13, built by CI, published as a GitHub release

## Later

- [ ] Build with Bazel
