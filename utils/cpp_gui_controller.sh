#!/bin/sh
# Smoke test for the C++ GUI's Controller tab, under Xvfb, with a stand-in printer on a
# pseudo terminal (utils/fake_printer.py): "Print..." queues the G-code, the panel
# connects and shows the temperature, prints (pause, resume), and the manual control
# sends its commands. Skipped (exit 77) without python3 or pseudo terminals.
#
# No window manager: clicks are at fixed positions; see the screenshots when a layout
# changes.
#
# Needs the GUI build, Xvfb, xdotool, ImageMagick and python3.
# Usage: utils/cpp_gui_controller.sh path/to/gui/slic3r path/to/cli/slic3r OUTDIR
set -eu
# hang guard: after 290 s the whole run is killed, Xvfb and the program included
[ "${GUI_TEST_GUARD:-}" = "$0" ] || GUI_TEST_GUARD=$0 exec timeout -v -k 5 290 "$0" "$@"
gui_bin=$(realpath "$1")
out=$(realpath -m "$3")
cd "$(dirname "$0")/.."
root=$PWD
if ! command -v python3 >/dev/null || ! python3 -c 'import os; os.openpty()' 2>/dev/null; then
    echo "skip: no python3 or no pseudo terminals for the stand-in printer"
    exit 77
fi
# start clean, but only ever remove a directory that a test run made
if [ -e "$out/.gui-test" ]; then
    rm -rf "$out"
elif [ -n "$(ls -A "$out" 2>/dev/null)" ]; then
    echo "$out is not empty and not from a test run; not touching it" >&2; exit 2
fi
mkdir -p "$out"; : >"$out/.gui-test"
export DISPLAY=":${SMOKE_DISPLAY:-92}"
export HOME="$out/home"
data=$out/data
mkdir -p "$HOME" "$data"
cp -r "$root/profiles/print" "$root/profiles/filament" "$root/profiles/printer" "$data/"
printf '[presets]\nprint = Ender-5-Pro-0.20mm\nfilament = Ender-5-Pro-PLA\nprinter = Ender-5-Pro\n' >"$data/slic3r.ini"
gui= xvfb= printer=
trap 'kill $gui $xvfb $printer 2>/dev/null || :' EXIT

shot() { import -window root "$out/$1.png"; }
fail() { echo "FAIL: $*"; shot fail; exit 1; }
ok() { echo "ok   $*"; }
click() { xdotool mousemove "$1" "$2" click 1; sleep 1; }
log=$out/printer.log
# received AWK-PATTERN: the printer got such a line
received() { grep -Eq "$1" "$log" || fail "the printer did not get '$1'"; }
lines() { grep -c . "$log"; }

# about 2400 lines at 3 ms each: long enough to pause it
python3 -I "$root/utils/fake_printer.py" "$out/port" "$log" 0.003 >"$out/printer.err" 2>&1 & printer=$!
sleep 1
port=$(cat "$out/port")
printf 'serial_port = %s\nserial_speed = 115200\n' "$port" >>"$data/printer/Ender-5-Pro.ini"

Xvfb "$DISPLAY" -screen 0 1280x900x24 >"$out/xvfb.log" 2>&1 & xvfb=$!
sleep 2
"$gui_bin" --datadir "$data" "$root/src/test/golden/table.stl" >"$out/gui.log" 2>&1 & gui=$!
sleep 8
kill -0 "$gui" 2>/dev/null || fail "the GUI did not start (see $out/gui.log)"

shot plater
click 724 283; sleep 4                                   # "Print..."
shot queued
click 94 231; sleep 5                                    # "Connect to printer"
shot connected
received 'M105'
ok "print queues the G-code, connect asks for the temperature"

click 622 167; sleep 2                                   # "Print This"
shot printing
click 622 167; sleep 2                                   # "Pause" (where "Delete" was)
shot paused
before=$(lines)
sleep 6                                                  # only temperature requests now
after=$(lines)
[ $((after - before)) -le 3 ] || fail "paused, but $((after - before)) lines went out"
[ "$before" -lt 2000 ] || fail "nothing left to pause after $before lines"
click 622 167                                            # "Resume"
for i in $(seq 1 60); do grep -q 'M84' "$log" && break; sleep 1; done
sleep 3
shot printed
received '^N[0-9]+ G28'
received '^N[0-9]+ M84'
[ "$(grep -c ' G1 .*E' "$log")" -gt 1500 ] || fail "the moves did not all arrive"
ok "print, pause, resume to the end"

click 78 358; sleep 1                                    # "Manual control"
shot manual
click 50 317                                             # home XYZ
click 410 317                                            # X +10
click 626 62; xdotool type 215; click 710 58             # extruder temperature, "Set"
click 595 186; xdotool type M114; xdotool key Return; sleep 2
received 'G28\*'
received 'G91\*'
received 'G1 X10\.0 F7800'
received 'M104 S215'
received 'M114'
ok "manual control"
click 678 448                                            # "Close"
click 230 179; sleep 2                                   # "Disconnect"
shot disconnected

kill -0 "$gui" 2>/dev/null || fail "the GUI exited (see $out/gui.log)"
if grep -q "wx assertion" "$out/gui.log"; then
    grep "wx assertion" "$out/gui.log" | sort | uniq -c
    fail "wx assertions"
fi
ok "no wx assertions"
