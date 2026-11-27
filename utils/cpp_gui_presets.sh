#!/bin/sh
# Third smoke test for the C++ GUI, under Xvfb: the preset editors and the plater's
# preset panel. A shortcut changed on the plater is saved; a second extruder gets its own
# material and its values reach the G-code; the bed shape dialog and a material's override
# of a printer setting end up in the saved presets; leaving a modified preset asks.
#
# No window manager: clicks are at fixed positions; see the screenshots when a layout
# changes.
#
# Needs the GUI build, Xvfb, xdotool and ImageMagick.
# Usage: utils/cpp_gui_presets.sh path/to/gui/slic3r path/to/cli/slic3r OUTDIR
set -eu
# hang guard: after 290 s the whole run is killed, Xvfb and the program included
[ "${GUI_TEST_GUARD:-}" = "$0" ] || GUI_TEST_GUARD=$0 exec timeout -v -k 5 290 "$0" "$@"
gui_bin=$(realpath "$1")
out=$(realpath -m "$3")
cd "$(dirname "$0")/.."
root=$PWD
# start clean, but only ever remove a directory that a test run made
if [ -e "$out/.gui-test" ]; then
    rm -rf "$out"
elif [ -n "$(ls -A "$out" 2>/dev/null)" ]; then
    echo "$out is not empty and not from a test run; not touching it" >&2; exit 2
fi
mkdir -p "$out"; : >"$out/.gui-test"
export DISPLAY=":${SMOKE_DISPLAY:-93}"
export HOME="$out/home"
data=$out/data
mkdir -p "$HOME" "$data"
cp -r "$root/profiles/print" "$root/profiles/filament" "$root/profiles/printer" "$data/"
print=$data/print/Ender-5-Pro-0.20mm.ini
echo "shortcuts = fill_density;support_material" >>"$print"
cp "$print" "$data/print/Draft.ini"
sed "s/^temperature = .*/temperature = 215/" "$data/filament/Ender-5-Pro-PLA.ini" >"$data/filament/PLA-green.ini"
printf '[presets]\nprint = Ender-5-Pro-0.20mm\nfilament = Ender-5-Pro-PLA\nprinter = Ender-5-Pro\n' >"$data/slic3r.ini"
gui= xvfb=
trap 'kill $gui $xvfb 2>/dev/null || :' EXIT

shot() { import -window root "$out/$1.png"; }
fail() { echo "FAIL: $*"; shot fail; exit 1; }
ok() { echo "ok   $*"; }
has() { grep -q "^$2" "$1" || fail "$(basename "$1") lacks '$2'"; }
click() { xdotool mousemove "$1" "$2" click 1; sleep 1; }
key() { xdotool key "$@"; sleep 0.5; }
fill() { click "$1" "$2"; key ctrl+a; xdotool type "$3"; key Return; }
tab_plater() { click 40 43; }
tab_print() { click 230 43; }
tab_material() { click 361 43; }
tab_printer() { click 498 43; }
save_as() { click 167 85; sleep 1; xdotool type "$1"; key Return; sleep 2; }

Xvfb "$DISPLAY" -screen 0 1280x900x24 >"$out/xvfb.log" 2>&1 & xvfb=$!
sleep 2
"$gui_bin" --datadir "$data" -o "$out/two.gcode" "$root/src/test/golden/table.stl" >"$out/gui.log" 2>&1 & gui=$!
sleep 8
kill -0 "$gui" 2>/dev/null || fail "the GUI did not start (see $out/gui.log)"

shot shortcuts
fill 688 308 50                                          # "Fill density" beside the plate
shot shortcut-changed
has "$print" 'fill_density = 50%'
ok "a shortcut changed beside the plate is saved"

tab_printer
click 525 219; sleep 1                                   # "Extruders" +
shot two-extruders
click 449 106; sleep 1                                   # "Bed shape: Set…"
click 199 159; key ctrl+a; xdotool type 250; key Tab      # Size X
shot bed-shape
click 620 394                                            # OK
save_as Two
has "$data/printer/Two.ini" 'nozzle_diameter = 0.4,0.4'
has "$data/printer/Two.ini" 'retract_length = 5,5'
has "$data/printer/Two.ini" 'bed_shape = 0x0,250x0,250x220,0x220'
ok "two extruders and the bed shape saved"

tab_material
click 75 212                                             # "Overrides" page
click 223 224; sleep 1                                   # add: Retraction > Lift Z
key Down; key Down; key Right; key Down; key Return
shot override-added
fill 695 246 0.4
save_as OverMat
has "$data/filament/OverMat.ini" 'retract_lift = 0.4$'
ok "a material's override of a printer setting saved"

tab_plater
click 618 214; click 560 275                            # second extruder's material
shot second-material
has "$data/slic3r.ini" 'filament = OverMat'
has "$data/slic3r.ini" 'filament_1 = PLA-green'
tab_print
click 103 235                                            # "Multiple extruders" page
fill 470 148 2                                           # infill extruder
tab_plater
click 686 283                                            # "Export G-code…"
for i in $(seq 1 40); do [ -s "$out/two.gcode" ] && break; sleep 1; done
sleep 1
shot exported
[ -s "$out/two.gcode" ] || fail "nothing exported"
grep -q '^M104 S215 T1' "$out/two.gcode" || fail "the second extruder lacks its material's temperature"
grep -q '^M104 S200 T0' "$out/two.gcode" || fail "the first extruder's temperature"
grep -q '^T1' "$out/two.gcode" || fail "the infill is not printed with the second extruder"
grep -q '^G1 Z0.600' "$out/two.gcode" || fail "the first extruder does not lift Z (the override)"
ok "each extruder slices with its material"

# the print preset is modified (infill extruder): choosing another asks; "Discard"
click 618 144; sleep 0.5; shot print-list
key Up; key Return; sleep 1                              # "Draft" is above
shot leave-question
dialog=$(xdotool search --onlyvisible --name '^Unsaved Changes$') || fail "leaving a modified preset: no question"
xdotool windowfocus "$dialog"; sleep 0.3
xdotool mousemove --window "$dialog" 74 131 click 1; sleep 2
shot left
has "$data/slic3r.ini" 'print = Draft'
grep -q '^infill_extruder = 2' "$print" && fail "Discard saved the change"
ok "leaving a modified preset asks"

kill -0 "$gui" 2>/dev/null || fail "the GUI exited (see $out/gui.log)"
if grep -q "wx assertion" "$out/gui.log"; then
    grep "wx assertion" "$out/gui.log" | sort | uniq -c
    fail "wx assertions"
fi

# the first start, with an empty data directory: the configuration wizard
kill "$gui" 2>/dev/null || :
wait "$gui" 2>/dev/null || :
mkdir -p "$out/data-new"
"$gui_bin" --datadir "$out/data-new" >"$out/first.log" 2>&1 & gui=$!
sleep 7
shot first-start
xdotool search --onlyvisible --name '^Configuration Assistant$' >/dev/null || fail "no wizard on the first start"
ok "the wizard on the first start"
