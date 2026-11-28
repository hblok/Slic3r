#!/bin/sh
# Checks of the command line that the unit and golden tests do not cover, and of the
# Python scripts in utils/ (the expected post-processing output came from the Perl
# scripts they replace).
# Usage: src/test/cli/check.sh path/to/slic3r
set -eu
slic3r=$(realpath "$1")
here=$(dirname "$(realpath "$0")")
root=$(realpath "$here/../../..")
out=$(mktemp -d)
trap 'rm -rf "$out"' EXIT
cd "$out"
fail() { echo "FAIL: $*"; exit 1; }
cp "$here/../golden/table.stl" .

[ -n "$("$slic3r" --version)" ] || fail "--version"
"$slic3r" --save defaults.ini
grep -q '^layer_height = ' defaults.ini || fail "--save alone writes the defaults"
"$slic3r" --layer_height 0.3 --save one.ini
grep -qx 'layer_height = 0.3' one.ini || fail "--layer_height"
printf 'M117 from a file\n' >start.gcode
"$slic3r" -g --start-gcode start.gcode -j 1 --print-center 50,60 -o table.gcode table.stl >log
grep -q '^M117 from a file' table.gcode || fail "--start-gcode FILE"
"$slic3r" --estimate-gcode-time table.gcode | grep -q '^Time: .*[0-9]s' || fail "--estimate-gcode-time"
"$slic3r" --export-stl --ascii -o ascii.stl table.stl >log
head -n1 ascii.stl | grep -q '^solid' || fail "--export-stl --ascii"
grep -q 'facet normal' ascii.stl || fail "--export-stl --ascii"
"$slic3r" --no-gui table.stl || fail "--no-gui"
# the material summary: volume in cm3, and the cost (here twice the weight) as a cost
"$slic3r" -g --filament-density 1.25 --filament-cost 2000 -o summary.gcode table.stl >log
grep -Eqx '; material used = [0-9]+\.[0-9]{2}mm \([0-9]+\.[0-9]{2}cm3\)' summary.gcode || fail "material summary: length and volume"
awk '/^; material used = [0-9.]+g$/ { weight = $5 + 0 } /^; material cost = [0-9.]+$/ { cost = $5 + 0 }
     END { exit !(weight > 0 && cost > 1.9 * weight && cost < 2.1 * weight) }' summary.gcode || fail "material summary: weight and cost"
echo "ok   command line"

if ! command -v python3 >/dev/null; then
    echo "skip the Python scripts: no python3"
    exit 0
fi
for script in decimate filament-weight flowrate strip-toolchange z-every-line; do
    cp "$here/input.gcode" "$script.gcode"
    SLIC3R_FILAMENT_DIAMETER=1.75,2.85 python3 -I "$root/utils/post-processing/$script.py" "$script.gcode"
    cmp "$script.gcode" "$here/expected/$script.gcode" || fail "$script.py"
done
cp "$here/input.gcode" fan.gcode
python3 -I "$root/utils/post-processing/fan_kickstart.py" fan.gcode
[ "$(grep -c '^M106 S255' fan.gcode_fixed)" = 1 ] || fail "fan_kickstart.py"
"$slic3r" -g --post-process "$root/utils/post-processing/flowrate.py" -o post.gcode table.stl >log
grep -q 'volspeed' post.gcode || fail "a script run by --post-process"
python3 -I "$root/utils/post-processing/filament-weight.py" summary.gcode
grep -q '^; material used = .*cm3 or [0-9.]*g PLA/' summary.gcode || fail "filament-weight.py on sliced G-code"
"$slic3r" --export-svg -o table.svg table.stl >log
python3 -I "$root/utils/pdf-slices.py" table.svg >log
head -c8 table.pdf | grep -q '%PDF-1.4' || fail "pdf-slices.py"
printf '[presets]\nprint = A.ini\nfilament = B\nprinter = C\n[print:A]\nlayer_height = 0.3\n[filament:B]\ntemperature = 210\n[printer:C]\nz_offset = 1\n' >bundle.ini
python3 -I "$root/utils/config-bundle-to-config.py" --output active.ini bundle.ini
grep -qx 'temperature = 210' active.ini && grep -qx 'layer_height = 0.3' active.ini || fail "config-bundle-to-config.py"
echo "ok   Python scripts"
