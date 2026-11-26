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
