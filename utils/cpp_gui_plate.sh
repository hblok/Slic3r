#!/bin/sh
# Second smoke test for the C++ GUI, under Xvfb: the plater's object operations and the
# File menu, driven with the menus and checked on the exported files (with the command
# line's --info). cpp_gui_smoke.sh covers slicing, presets and preview.
#
# No window manager: clicks and menu positions are fixed; see the screenshots when a
# layout or a menu changes.
#
# Needs the GUI and CLI builds, Xvfb, xdotool and ImageMagick.
# It is in four parts, each with its own start of the program, to stay well under the
# time limit.
# Usage: utils/cpp_gui_plate.sh path/to/gui/slic3r path/to/cli/slic3r OUTDIR PART
#        PART: plate | objects | tools | files
set -eu
# hang guard: after 290 s the whole run is killed, Xvfb and the program included
[ "${GUI_TEST_GUARD:-}" = "$0" ] || GUI_TEST_GUARD=$0 exec timeout -v -k 5 290 "$0" "$@"
gui_bin=$(realpath "$1")
cli_bin=$(realpath "$2")
out=$(realpath -m "$3")
part=${4:-}
case $part in
    plate) display=97 ;;
    objects) display=96 ;;
    files) display=95 ;;
    tools) display=94 ;;
    *) echo "usage: $0 GUI CLI OUTDIR plate|objects|tools|files" >&2; exit 2 ;;
esac
cd "$(dirname "$0")/.."
root=$PWD
# an earlier run's files break the next one (the save dialogs ask to replace them):
# start clean, but only ever remove a directory that a test run made
if [ -e "$out/.gui-test" ]; then
    rm -rf "$out"
elif [ -n "$(ls -A "$out" 2>/dev/null)" ]; then
    echo "$out is not empty and not from a test run; not touching it" >&2; exit 2
fi
mkdir -p "$out"; : >"$out/.gui-test"
export DISPLAY=":${SMOKE_DISPLAY:-$display}"
export HOME="$out/home"
mkdir -p "$HOME" "$out/data"
cp "$root/src/test/golden/table.stl" "$out/part.stl"
: >"$out/data/slic3r.ini"                                # not a first start: no wizard
gui= xvfb=
trap 'kill $gui $xvfb 2>/dev/null || :' EXIT

shot() { import -window root "$out/$1.png"; }
fail() { echo "FAIL: $*"; shot fail; exit 1; }
ok() { echo "ok   $*"; }
alive() { kill -0 "$gui" 2>/dev/null || fail "$1: the GUI exited (see $out/gui.log)"; }

Xvfb "$DISPLAY" -screen 0 1280x900x24 >"$out/xvfb.log" 2>&1 & xvfb=$!
sleep 2
"$gui_bin" --datadir "$out/data" "$out/part.stl" >"$out/gui.log" 2>&1 & gui=$!
sleep 8
alive start
main=$(xdotool search --onlyvisible --name Slic3r | head -1)

click() { xdotool mousemove --window "$main" "$1" "$2" click 1; sleep 1; }
key() { xdotool key "$@"; sleep 1; }
presses() { i=0; while [ "$i" -lt "$2" ]; do xdotool key "$1"; sleep 0.1; i=$((i + 1)); done; }
# menu X N [M]: the Nth entry of the menu at X in the menu bar; with M, the Mth entry of
# its submenu (separators do not count). A negative N counts from the bottom: greyed
# entries are skipped, so a count that passes some depends on what can be used just then.
menu() {
    click "$1" 12
    case $2 in
        -*) presses Up "${2#-}" ;;
        *) presses Down "$2" ;;
    esac
    if [ -n "${3:-}" ]; then xdotool key Right; sleep 0.3; presses Down $(($3 - 1)); fi
    key Return
    sleep 1
}
file_menu() { menu 19 "$@"; }
plater_menu() { menu 66 "$@"; }
object_menu() { menu 121 "$@"; }
# answer a file dialog (or a text entry) by typing
answer() { sleep 1; key ctrl+a; xdotool type "$1"; sleep 0.5; key Return; sleep 2; }
# A dialog that opens a file also needs the keyboard handed to it (there is no window
# manager to do it), or its inline completion mangles the typed path.
answer_open() { sleep 1; xdotool search --onlyvisible --name "^(Choose|Select) " windowfocus; answer "$1"; }

info() { sed -n "s/^$2 = *//p" "$out/$1.info"; }
near() { # name key value
    got=$(info "$1" "$2")
    awk -v a="${got:-nan}" -v b="$3" 'BEGIN { exit !(a != "nan" && a - b < 0.01 && b - a < 0.01) }' \
        || fail "$1: $2 is '$got', expected $3"
}
export_plate() { # name: "Export plate as STL"
    plater_menu -3
    answer "$out/$1.stl"
    alive "$1"
    [ -s "$out/$1.stl" ] || fail "$1: no STL exported"
    "$cli_bin" --info "$out/$1.stl" >"$out/$1.info"
}
export_object() {
    object_menu 18
    answer "$out/$1.stl"
    alive "$1"
    [ -s "$out/$1.stl" ] || fail "$1: no STL exported"
    "$cli_bin" --info "$out/$1.stl" >"$out/$1.info"
}
# without a window manager the keyboard may be left nowhere after a dialog
shortcut() {
    xdotool mousemove --window "$main" 700 450
    xdotool windowfocus "$main" 2>/dev/null || :
    sleep 0.3
    key "$@"
}
select_first() { plater_menu -8; }                   # "Select Next Object"
# the menu works wherever the keyboard focus went
undo() { plater_menu 2; }

if [ "$part" = plate ]; then
export_plate loaded
near loaded number_of_facets 24
near loaded size_z 12
ok "load and export the plate"

select_first
click 421 88; sleep 1                                   # "More"
export_plate more
near more number_of_facets 48
shortcut ctrl+z
export_plate undo
near undo number_of_facets 24
shortcut ctrl+shift+z
export_plate redo
near redo number_of_facets 48
undo
ok "copies, undo, redo"

object_menu 10 1; answer 200                            # Scale > Uniformly
export_plate scaled
near scaled size_x 40
near scaled size_z 24
undo
object_menu 10 4; answer 50                             # Scale > Along Z
export_plate flat
near flat size_x 20
near flat size_z 6
ok "scale uniformly and along an axis"

object_menu 12                                          # Split
shot split
select_first
export_object part1
near part1 number_of_facets 12
undo
ok "split"
fi

if [ "$part" = objects ]; then
select_first
object_menu 10 4; answer 50                             # half the height to start with
export_plate flat
near flat size_z 6

object_menu 13                                          # Cut at half the height, keep both
shot cut-dialog
xdotool mousemove 293 101 click 1; sleep 1              # height "+": 3.5
shot cut-dialog-raised
xdotool mousemove 258 101 click 1; sleep 1              # height "-": back to 3
xdotool mousemove 255 427 click 1; sleep 2              # "Perform cut" 
shot cut
export_plate cut
near cut size_z 3
near cut volume "$(info flat volume)"
undo
select_first
object_menu 13                                          # Cut across Y, at half the depth
xdotool mousemove 210 61 click 1; sleep 0.5; key Up; key Up; key Return
shot cut-y-dialog
xdotool mousemove 255 427 click 1; sleep 2
select_first
export_object half
near half size_x 20
near half size_y 10
undo
ok "cut"

select_first
object_menu 9 1                                         # Mirror > X
export_plate mirrored
near mirrored size_x 20
near mirrored volume "$(info flat volume)"
cp "$root/src/test/inputs/test_cli/20mmbox.stl" "$out/part.stl"
select_first
object_menu 17                                          # Reload from Disk
shot reload-options
key Return; sleep 1                                     # OK: keeping the transformations
export_plate reloaded
near reloaded size_z 5                                  # the box is 20 x 20 x 10, scaled as before
near reloaded size_x 20
near reloaded number_of_facets 12
ok "mirror and reload from disk, transformations kept"

select_first
object_menu 16                                          # Settings: a modifier with a setting
xdotool mousemove 140 391 click 1; sleep 2              # "Load modifier…"
answer_open "$root/src/test/inputs/test_cli/20mmbox.stl"
xdotool mousemove 530 26 click 1; sleep 1               # "Add setting": the third one
xdotool mousemove 100 570                               # off the list: the keys count from its top
key Down; key Down; key Down; key Return; sleep 1
shot object-settings
xdotool mousemove 1046 572 click 1; sleep 1             # "Close"
object_menu 19; answer "$out/modified.amf"              # Export object and modifiers as AMF
grep -q 'type="slic3r.modifier">1<' "$out/modified.amf" || fail "no modifier in modified.amf"
grep -q 'type="slic3r.bridge_flow_ratio"' "$out/modified.amf" || fail "the modifier's setting is not in modified.amf"
undo
select_first
object_menu 19; answer "$out/unmodified.amf"
! grep -q 'slic3r.modifier' "$out/unmodified.amf" || fail "undo kept the modifier"
ok "object settings: modifier with a setting, undo"

file_menu -2                                            # Preferences
xdotool mousemove 388 137 click 1; sleep 1              # "Background processing"
shot preferences
xdotool mousemove 552 500 click 1; sleep 1              # "OK"
grep -q '^background_processing = 1' "$out/data/slic3r.ini" || fail "the preference is not in slic3r.ini"
ok "preferences"
fi

if [ "$part" = tools ]; then
export_plate loaded
select_first
object_menu 14                                          # Rotate face to plane
xdotool mousemove 502 200 click 1; sleep 1              # the top face
shot face-selected
xdotool mousemove 190 88 click 1; sleep 0.5; key Down; key Return    # plane XZ
xdotool mousemove 214 427 click 1; sleep 2              # "Rotate to plane"
export_plate faced
near faced size_z 20                                    # the table stands on its side
near faced size_y 12
near faced volume "$(info loaded volume)"
undo
ok "rotate face to plane"

# yellow (the object, lit) pixels in the cut dialog's picture
object_pixels() { # name
    shot "$1"
    convert "$out/$1.png" -crop 420x420+321+35 +repage -fx '(r-b>0.15 && g-b>0.15)?1:0' \
        -format '%[fx:round(mean*w*h)]' info: | tail -n 1
}
select_first
object_menu 13                                          # Cut, keeping only the lower part
both=$(object_pixels cut-both)
xdotool mousemove 123 133 click 1; sleep 2              # not the "Upper part"
lower=$(object_pixels cut-preview)
[ "$both" -gt 5000 ] && [ "$lower" -lt $((both * 3 / 4)) ] \
    || fail "cut preview: $both pixels of the object, $lower with only the lower part"
ok "cut preview ($both pixels, $lower with the lower part only)"
xdotool mousemove 175 243 click 1; key ctrl+a; xdotool type 10    # tile width X
xdotool mousemove 175 282 click 1; key ctrl+a; xdotool type 10    # tile width Y
xdotool mousemove 210 321 click 1; sleep 2              # "Cut by grid"
export_plate tiles
near tiles size_x 25                                    # 2 x 2 tiles, 5 mm apart
near tiles size_y 25
near tiles volume "$(info loaded volume)"
undo
ok "cut by grid"

# the number of layers in an export of the plate
export_layers() { # name
    plater_menu -4; answer "$out/$1.gcode"                 # "Export G-code..."
    for i in $(seq 1 30); do [ -s "$out/$1.gcode" ] && break; sleep 1; done
    grep -c '^G1 Z' "$out/$1.gcode"
}
standard=$(export_layers standard)
select_first
object_menu 15; sleep 1                                 # Layer heights
# right button: the thinnest layers (left edge) over the whole height
xdotool mousemove 640 375 mousedown 3 mousemove 640 200 mousemove 494 16 mouseup 3; sleep 1
shot layers-curve
xdotool mousemove 925 542 click 1; sleep 2              # "OK"
drawn=$(export_layers drawn)
[ "$drawn" -gt $((standard * 3 / 2)) ] || fail "layer curve: $drawn layers, $standard before"
undo
select_first
object_menu 15; sleep 1
xdotool mousemove 850 300 click 1; xdotool type "0 6 0.15"; shot layers-range    # a height range
xdotool mousemove 925 542 click 1; sleep 2
ranged=$(export_layers ranged)
[ "$ranged" -gt $((standard * 5 / 4)) ] && [ "$ranged" -lt "$drawn" ] \
    || fail "height range: $ranged layers ($standard standard, $drawn drawn)"
undo
ok "layer heights: curve ($standard to $drawn layers) and range ($ranged)"

select_first
object_menu 16; sleep 1                                 # Settings
xdotool mousemove 140 430 click 1; sleep 1              # "Create modifier…": a slab
xdotool mousemove 560 253 click 1; key ctrl+a; xdotool type 3.25    # "Thickness"
xdotool mousemove 620 385 click 1; sleep 1              # "OK"
xdotool mousemove 226 528 click 1; key ctrl+a; xdotool type 5.5; key Tab    # its position: Z
shot modifier-created
xdotool mousemove 1046 572 click 1; sleep 1             # "Close"
object_menu 19; answer "$out/created.amf"               # Export object and modifiers as AMF
grep -q 'type="slic3r.modifier">1<' "$out/created.amf" || fail "no created modifier in created.amf"
grep -q '<z>5.5</z>' "$out/created.amf" && grep -q '<z>8.75</z>' "$out/created.amf" \
    || fail "the created modifier is not 3.25 mm thick at Z 5.5"
undo
ok "create a modifier and place it"
fi

# "... was successfully sliced.": close it
sliced() {
    dialog=$(xdotool search --onlyvisible --name '^Slicing Done!$') || fail "$1: no message"
    xdotool windowfocus "$dialog"; sleep 0.3; key Return
}

# ---- the File menu ----
if [ "$part" = files ]; then
file_menu 4; answer "$out/exported.ini"                 # Export Config
grep -q '^layer_height = 0.3' "$out/exported.ini" || fail "exported.ini lacks the default layer height"
sed 's/^layer_height = .*/layer_height = 0.25/' "$out/exported.ini" >"$out/loaded-config.ini"
file_menu 3; answer_open "$out/loaded-config.ini"            # Load Config
shot config-loaded
file_menu 8; answer_open "$out/part.stl"; sleep 3            # Quick Slice
[ -s "$out/part.gcode" ] || fail "quick slice wrote nothing"
sliced "quick slice"
"$cli_bin" -g --load "$out/loaded-config.ini" "$out/part.stl" -o "$out/part.cli.gcode" >"$out/cli.log" 2>&1
for f in part part.cli; do
    grep -v -e '^; generated by ' -e '^; Git Commit: ' "$out/$f.gcode" >"$out/$f.cmp"
done
cmp -s "$out/part.cmp" "$out/part.cli.cmp" || fail "quick slice differs from the CLI (diff $out/part.cmp $out/part.cli.cmp)"
ok "export and load a configuration, quick slice equals the CLI"

file_menu 11; answer_open "$out/part.stl"; answer "$out/part.svg"; sleep 2            # Slice to SVG: input, output
grep -q '<svg' "$out/part.svg" || fail "no SVG"
sliced "slice to SVG"
file_menu 12; answer_open "$out/part.stl"; answer "$out/repaired.obj"; key Return   # Repair STL
grep -q '^v ' "$out/repaired.obj" || fail "no repaired OBJ"
file_menu 7; answer_open "$out/part.gcode"; sleep 2            # Import Config from G-code
grep -q '^layer_height = 0.25' "$out/part.ini" || fail "import from G-code: layer height missing"
ok "SVG, repair, configuration from G-code"

click 230 43                                            # "Print Settings": Spiral vase asks
xdotool mousemove 431 382 click 1; sleep 2
shot spiral-vase-question
key Return; sleep 1                                     # yes, adjust the other settings
shot spiral-vase
click 40 43
file_menu 4; answer "$out/vase.ini"
for line in 'spiral_vase = 1' 'perimeters = 1' 'top_solid_layers = 0' 'fill_density = 0'; do
    grep -q "^$line" "$out/vase.ini" || fail "vase.ini lacks '$line'"
done
ok "preset editor: the spiral vase rule"

menu 358 1; sleep 1                                     # Help > Configuration Wizard
shot wizard
i=0
while [ "$i" -lt 8 ]; do                                 # "Next >" on every page, then "Finish"
    xdotool mousemove 899 646 click 1; sleep 0.7; i=$((i + 1))
    [ "$i" -ne 2 ] || shot wizard-bed
done
sleep 1
shot wizard-done
for group in print printer filament; do
    [ -s "$out/data/$group/My Settings.ini" ] || fail "wizard: no $group preset"
done
grep -q '^bed_shape = 0x0,200' "$out/data/printer/My Settings.ini" || fail "wizard: bed shape"
grep -q '^selected\|^printer = My Settings' "$out/data/slic3r.ini" || fail "wizard: preset not selected"
ok "configuration wizard"

# a bundle with a preset of the user's name: kept unless the user says to overwrite it
mine="$out/data/print/My Settings.ini"
printf '[print:My Settings]\nlayer_height = 0.17\n' >"$out/bundle.ini"
import_bundle() { # key for the question
    file_menu 5; answer_open "$out/bundle.ini"
    dialog=$(xdotool search --onlyvisible --name '^Existing presets$') || fail "bundle: no question"
    xdotool windowfocus "$dialog"; sleep 0.3; shot "bundle-question-$1"; key "$1"; sleep 1
    dialog=$(xdotool search --onlyvisible --name '^Config Bundle$') || fail "bundle: no summary"
    xdotool windowfocus "$dialog"; sleep 0.3; key Return
}
import_bundle Return                                    # the default: No
! grep -q '^layer_height = 0.17' "$mine" || fail "bundle: a preset was overwritten unasked"
import_bundle alt+y                                     # Yes
grep -q '^layer_height = 0.17' "$mine" || fail "bundle: the preset was not overwritten"
ok "config bundle: overwrite only when asked for"
fi

alive end
if grep -q "wx assertion" "$out/gui.log"; then
    grep "wx assertion" "$out/gui.log" | sort | uniq -c
    fail "wx assertions"
fi
echo "ok   no wx assertions"
