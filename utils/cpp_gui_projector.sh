#!/bin/sh
# Smoke test for the C++ GUI's DLP projector, under Xvfb: the SLA options, the projector
# screen showing a layer and going black, the SVG export, and, with a stand-in printer on
# a pseudo terminal (utils/fake_printer.py; left out without python3 or pseudo
# terminals), a print.
#
# No window manager: clicks are at fixed positions; see the screenshots when a layout
# changes.
#
# Needs the GUI build, Xvfb, xdotool and ImageMagick.
# Usage: utils/cpp_gui_projector.sh path/to/gui/slic3r path/to/cli/slic3r OUTDIR
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
export DISPLAY=":${SMOKE_DISPLAY:-91}"
export HOME="$out/home"
data=$out/data
mkdir -p "$HOME" "$data"
cp -r "$root/profiles/print" "$root/profiles/filament" "$root/profiles/printer" "$data/"
printf '[presets]\nprint = Ender-5-Pro-0.20mm\nfilament = Ender-5-Pro-PLA\nprinter = Ender-5-Pro\n' >"$data/slic3r.ini"
# short exposures; the bed moved right, clear of the dialog
printf 'exposure_time = 0.2\nbottom_exposure_time = 0.3\nsettle_time = 0.1\noffset = 60,0\n' >"$data/DLP.ini"
gui= xvfb= printer=
trap 'kill $gui $xvfb $printer 2>/dev/null || :' EXIT

shot() { import -window root "$out/$1.png"; }
fail() { echo "FAIL: $*"; shot fail; exit 1; }
ok() { echo "ok   $*"; }
click() { xdotool mousemove "$1" "$2" click 1; sleep 0.7; }
key() { xdotool key "$@"; sleep 0.5; }
fill() { click "$1" "$2"; key ctrl+a; xdotool type "$3"; sleep 0.5; }
# white pixels where the object is projected (right of the dialog, above the axes)
white() {
    shot "$1"
    convert "$out/$1.png" -crop 500x700+740+0 +repage -fill black +opaque white \
        -format '%[fx:round(mean*w*h)]' info:
}

log=$out/printer.log
if command -v python3 >/dev/null && python3 -c 'import os; os.openpty()' 2>/dev/null; then
    python3 -I "$root/utils/fake_printer.py" "$out/port" "$log" >"$out/printer.err" 2>&1 & printer=$!
    sleep 1
    printf 'serial_port = %s\nserial_speed = 115200\n' "$(cat "$out/port")" >>"$data/printer/Ender-5-Pro.ini"
fi

Xvfb "$DISPLAY" -screen 0 1280x900x24 >"$out/xvfb.log" 2>&1 & xvfb=$!
sleep 2
"$gui_bin" --datadir "$data" "$root/src/test/golden/table.stl" >"$out/gui.log" 2>&1 & gui=$!
sleep 8
kill -0 "$gui" 2>/dev/null || fail "the GUI did not start (see $out/gui.log)"

click 301 12; click 348 87; sleep 1                      # Window > DLP Projector
shot options
fill 425 39 1                                            # layer height
fill 425 77 1                                            # first layer height
click 502 608; sleep 3                                   # OK
shot projector
[ "$(white black)" -lt 50 ] || fail "something is projected before a layer is chosen"
click 394 498; click 416 498; click 416 498; sleep 1     # layer 1, 2, 3
[ "$(white layer)" -gt 100 ] || fail "layer 3 is not on the screen"
click 200 498; sleep 1                                   # "Stop/Black"
[ "$(white stopped)" -lt 50 ] || fail "Stop/Black leaves the layer on the screen"
ok "a layer on the projector screen, and black again"

click 69 569; sleep 2                                    # "Export SVG..."
key ctrl+a; xdotool type "$out/print.svg"; key Return; sleep 2
shot svg
[ -s "$out/print.svg" ] || fail "no SVG file"
grep -q '<g id="layer11"' "$out/print.svg" || fail "the SVG lacks layers"
ok "SVG export"

if [ -n "$printer" ]; then
    click 190 498; sleep 6                               # "Print"
    shot printing
    for i in $(seq 1 30); do grep -q 'M84' "$log" && break; sleep 1; done
    sleep 3
    shot printed
    grep -q 'G28\*' "$log" || fail "no start G-code"
    grep -q '\[first_layer' "$log" && fail "the start G-code has unfilled placeholders"
    grep -q 'G1 Z6\.00000 F480' "$log" || fail "no lift before the first layer"
    grep -q 'G1 Z12\.00000 F480' "$log" || fail "the last layer is not reached"
    grep -q 'M84' "$log" || fail "no end G-code"
    ok "a print: Z moves and custom G-code"
else
    echo "skip the print: no python3 or no pseudo terminals for the stand-in printer"
fi

click 672 569; sleep 2                                   # "Close"
shot closed
xdotool search --onlyvisible --name 'Slic3r' >/dev/null || fail "the main window did not come back"
grep -q '^offset = 60,0' "$data/DLP.ini" || fail "DLP.ini lost the offset"
kill -0 "$gui" 2>/dev/null || fail "the GUI exited (see $out/gui.log)"
if grep -q "wx assertion" "$out/gui.log"; then
    grep "wx assertion" "$out/gui.log" | sort | uniq -c
    fail "wx assertions"
fi
ok "closed, no wx assertions"
