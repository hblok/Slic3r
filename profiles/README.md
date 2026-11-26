# Profiles

Presets for the stock Creality Ender-5 Pro (220 x 220 x 300 mm, 0.4 mm nozzle,
1.75 mm filament, Bowden, Creality Marlin). The layout is that of a Slic3r data
directory, one preset per file:

| File | Content |
|---|---|
| [printer/Ender-5-Pro.ini](printer/Ender-5-Pro.ini) | bed, nozzle, retraction, start and end G-code |
| [filament/Ender-5-Pro-PLA.ini](filament/Ender-5-Pro-PLA.ini) | PLA: 205/200 °C, bed 60 °C, fan from layer 2 |
| [print/Ender-5-Pro-0.20mm.ini](print/Ender-5-Pro-0.20mm.ini) | 0.2 mm layers, speeds for the stock machine |

Only settings that differ from the Slic3r defaults are listed. The files have no
comments: the C++ loader accepts only `;` comments and the Perl loader only `#`.

## Use

GUI: copy the folders into the data directory (`~/.Slic3r` unless `--datadir` is given),
then pick the presets in the plater.

```sh
cp -r profiles/print profiles/filament profiles/printer ~/.Slic3r/
```

Command line (Perl or C++):

```sh
perl slic3r.pl --load profiles/printer/Ender-5-Pro.ini --load profiles/filament/Ender-5-Pro-PLA.ini \
  --load profiles/print/Ender-5-Pro-0.20mm.ini model.stl
```

## Not verified yet

These are first values from the printer's specification and common practice, not
from this machine. Check them in phase 3 (`M115`, `M503`, a test print):

- Axis orientation: the purge line runs along X = 2, Y = 20 to 200. It is on an edge
  whichever side X = 0 is, but confirm it is the left.
- Retraction 5 mm at 40 mm/s is a usual Bowden value; tune with a retraction test.
- The start G-code heats while homing, then waits (`M190`, `M109`) before the purge
  line. Slic3r adds no temperature commands of its own when the start G-code has them.
- The end G-code lowers the bed 10 mm (relative move) and leaves Z powered.
