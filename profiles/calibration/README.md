# Calibration prints

Load them on top of the Ender 5 Pro presets (or your own). `make_models.py` writes
the models.

```sh
P=profiles
E="--load $P/printer/Ender-5-Pro.ini --load $P/filament/Ender-5-Pro-PLA.ini --load $P/print/Ender-5-Pro-0.20mm.ini"
```

`slic3r` below is the installed program (or `build/dist-gui/slic3r`).

## Temperature tower

Eight 5 mm sections, printed at 225, 220, ... 190 °C from the bottom up (the
`layer_gcode` sets the hotend by height; a groove marks each section).

```sh
slic3r -g $E --load $P/calibration/temperature-tower.ini $P/calibration/temperature-tower.stl
```

Pick the section with the best surface, overhang edges and least stringing, and set
`temperature` in the filament preset. For a range other than PLA's, change 225 and 5
in `temperature-tower.ini`.

## Flow (single wall)

A 20 mm cube printed as one spiral wall (spiral vase, no top, no infill).

```sh
slic3r -g $E --load $P/calibration/flow-single-wall.ini $P/calibration/flow-cube.stl
```

The G-code header gives the expected wall (`; external perimeters extrusion width = 0.44mm`).
Measure the wall with calipers in a few places and set
`extrusion_multiplier = old value * expected / measured` in the filament preset.

## Retraction

Not here yet: it needs a different retraction length per height. The slicer has one
length per extruder, and the stock firmware has no firmware retraction (`M207`).
Possible later as a slicer option (retraction by height range).
