# Feature candidates

Ranked by value for an Ender 5 Pro (220 x 220 x 300 mm, 0.4 mm nozzle, Bowden)
against effort. Effort is a first guess; nothing here is designed yet.

The printer runs unmodified stock firmware (an old Creality build of Marlin), so
features that need firmware support rank low. What it supports is not verified; read
it with `M115` and `M503` (phase 3).

## Depends on newer firmware (parked)

Linear advance (`M900`), arcs (`G2`/`G3`, check first), object cancel (`M486`),
Klipper flavour and Moonraker upload, input shaping, thumbnails on the printer screen.

## Small

| Feature | Why |
|---|---|
| Ender 5 Pro profiles | Everyone's starting point (phase 3) |
| Better time estimate in the G-code | Planning; an estimator exists |
| Fuzzy skin | Simple perimeter jitter |
| Calibration generators (flow, temperature, retraction) | Faster tuning, matters on a Bowden extruder |

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
| Working C++ support generation | Prerequisite for retiring Perl, see baseline | Debugging an unfinished port |
| Tree / organic supports | Less material, cleaner removal | Big module; two support pipelines today |
| STEP import | Common CAD exchange format | Heavy dependency (OpenCASCADE) |
| Paint-on supports and seams | Precise control | Mostly GUI work |

## Sources

PrusaSlicer, OrcaSlicer and CuraEngine are published under AGPL-3.0 and already
solve most of these. Their code has moved far from ours, so expect adapting, not
copying. Check the license of each ported file and credit it (see `CLAUDE.md`).
