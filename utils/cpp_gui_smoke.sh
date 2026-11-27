#!/bin/sh
# Smoke test for the C++ GUI (wxWidgets): start it under Xvfb with an empty data
# directory, check that it is still running after a few seconds and reported no wx
# assertions, and keep a screenshot. The Perl GUI has utils/gui_smoke.sh.
#
# Needs the GUI build (cmake -S src -B build-gui -DEnable_GUI=ON), Xvfb and ImageMagick.
# Usage: utils/cpp_gui_smoke.sh path/to/slic3r OUTDIR
set -eu
slicer=$(realpath "$1")
out=$(realpath -m "$2")
mkdir -p "$out"
export DISPLAY=":${SMOKE_DISPLAY:-98}"
export HOME="$out/home"  # the data directory (~/.Slic3r) starts empty
mkdir -p "$HOME"
gui= xvfb=
trap 'kill $gui $xvfb 2>/dev/null || :' EXIT

Xvfb "$DISPLAY" -screen 0 1280x900x24 >"$out/xvfb.log" 2>&1 & xvfb=$!
sleep 2
"$slicer" >"$out/gui.log" 2>&1 & gui=$!
sleep 10
import -window root "$out/started.png"
kill -0 "$gui" 2>/dev/null || { echo "FAIL: the GUI exited"; tail -20 "$out/gui.log"; exit 1; }
if grep -q "wx assertion" "$out/gui.log"; then
    echo "FAIL: wx assertions"; grep "wx assertion" "$out/gui.log" | sort | uniq -c; exit 1
fi
echo "ok   C++ GUI started (screenshot: $out/started.png)"
