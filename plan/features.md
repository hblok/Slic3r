# Feature candidates

Ranked by value for an Ender 5 Pro (220 x 220 x 300 mm, 0.4 mm nozzle, Bowden)
against effort. Effort is a first guess; nothing here is designed yet.

The printer runs unmodified stock firmware (an old Creality build of Marlin), so
features that need firmware support rank low. What it supports is not verified; read
it with `M115` and `M503` (phase 3).

## Depends on newer firmware (parked)

Linear advance (`M900`), arcs (`G2`/`G3`, check first), object cancel (`M486`),
Klipper flavour and Moonraker upload, input shaping, thumbnails on the printer screen.

## Wishlist from the owner (2026-11-26), with first research

Open for discussion; nothing here is decided.

| Wish | What the others do | Fit for this fork |
|---|---|---|
| Tree supports | PrusaSlicer 2.6 "organic supports" build on Thomas Rahm's improved version of Cura's tree supports; OrcaSlicer has tree supports from Bambu Studio. All AGPL-3.0 (CuraEngine too); check each file. | Large. C++ support generation works since 2026-11-26 (matches Perl), so tree supports can be added beside it in C++. Porting PrusaSlicer's organic supports is probably cheaper than writing our own, but it expects their geometry types. |
| Adaptive pressure advance | OrcaSlicer 2.2: calibrate PA at several flow rates and accelerations, fit a model, and the slicer emits a PA value per feature. | Needs pressure advance in the firmware (Marlin `M900` linear advance or Klipper). Stock Ender-5 Pro firmware (Creality Marlin 1.1.x) very likely lacks it; `M503` will tell (phase 3). Blocked unless the firmware changes. |
| GPU slicing and support generation | No mainstream open-source slicer does this. Research prototypes and a commercial kernel (Dyndrite) exist. | Low value: our slices take well under a second for test parts, and the expensive steps (polygon clipping, support area propagation) are branchy CPU work. Revisit only if a real model is slow; measure first, then multithreading before GPU. |
| Drop Perl, new GUI | PrusaSlicer, OrcaSlicer and Bambu Studio are C++ with wxWidgets; Cura uses Qt/QML with a Python front end. | Order matters: C++ support generation first (Perl is the only working one), then G-code export parity (golden check against Perl), then the GUI. GUI: the Perl GUI is 17,800 lines, the C++ skeleton in `src/GUI` is 7,500 with many stubs. A plater with 3D view, preview, preset editor and export is weeks, not days. |
| G-code metadata to get back to the project | PrusaSlicer and Orca write the full config as comments and a thumbnail; Orca also writes the 3MF project name. | Small. Full config and commit were already written; input file names, sizes and CRC-32 added 2026-11-26 (both pipelines). Missing: object placement from the GUI. No project format besides 3MF/AMF export. |

Sources: OrcaSlicer wiki (adaptive pressure advance calibration), Prusa help center
(organic supports), Marlin-E5P and DREMC firmware notes for the Ender-5 Pro.

## Small

| Feature | Why |
|---|---|
| Ender 5 Pro profiles | Everyone's starting point (phase 3) |
| Better time estimate in the G-code | Planning; an estimator exists |
| Fuzzy skin | Simple perimeter jitter |
| Calibration generators (flow, temperature, retraction) | Faster tuning, matters on a Bowden extruder |
| ~~Input files and their hashes in the G-code header~~ done 2026-11-26 | Find the model and settings again from a print. Still missing: object positions, rotations and scales set in the GUI |

## Medium

| Feature | Why |
|---|---|
| Monotonic top infill | Clearly better top surfaces |
| Ironing | Smooth top surfaces; check upstream `merill_ironing` first |
| Seam placement control, scarf seam | Visible quality |
| Adaptive cubic and lightning infill | Less filament and time |

## Large

| Feature | Why | Cost |
|---|---|---|
| Variable-width perimeters (Arachne) | Thin walls and fine detail | Touches the perimeter core and geometry libraries |
| ~~Working C++ support generation~~ done 2026-11-26 | Prerequisite for retiring Perl, see baseline | |
| Tree / organic supports | Less material, cleaner removal | Big module; two support pipelines today |
| STEP import | Common CAD exchange format | Heavy dependency (OpenCASCADE) |
| Paint-on supports and seams | Precise control | Mostly GUI work |

## Sources

PrusaSlicer, OrcaSlicer and CuraEngine are published under AGPL-3.0 and already
solve most of these. Their code has moved far from ours, so expect adapting, not
copying. Check the license of each ported file and credit it (see `CLAUDE.md`).
