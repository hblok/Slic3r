#!/bin/sh
# Run a program under an X server of its own. The server picks a free display and says
# which, so tests that run at the same time cannot take each other's.
set -eu
export HOME="${TEST_TMPDIR:?}" NO_AT_BRIDGE=1
display="$TEST_TMPDIR/display"
: >"$display"
Xvfb -displayfd 3 -screen 0 1280x900x24 -nolisten tcp 3>"$display" >"$TEST_TMPDIR/xvfb.log" 2>&1 &
server=$!
trap 'kill "$server" 2>/dev/null || :' EXIT
tries=0
until [ -s "$display" ]; do
    kill -0 "$server" 2>/dev/null || { echo "Xvfb did not start:"; cat "$TEST_TMPDIR/xvfb.log"; exit 1; }
    tries=$((tries + 1))
    [ "$tries" -lt 100 ] || { echo "Xvfb gave no display in 10 s"; exit 1; }
    sleep 0.1
done
DISPLAY=":$(cat "$display")" "$@"
