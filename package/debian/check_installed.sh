#!/bin/sh
# Check an installed slic3r package from a checkout of the sources: first with nothing
# but what the package pulled in, then the GUI under Xvfb. Run as root on a clean
# Debian 13 with the package installed; installs the test tools itself.
# usage: package/debian/check_installed.sh VERSION_COMMIT OUTDIR
set -eu
commit=$1
out=$(realpath -m "$2")
cd "$(dirname "$0")/../.."
slicer=$(command -v slic3r)
fail() { echo "FAIL: $*"; exit 1; }

echo "== the command line, with the package's own dependencies only"
slic3r --help | head -n 1 | grep -F "build commit: $commit" || fail "not the build of $commit"
src/test/golden/check.sh "$slicer"
for file in /usr/share/applications/slic3r.desktop /usr/share/icons/hicolor/192x192/apps/slic3r.png \
        /usr/share/doc/slic3r/copyright /usr/share/slic3r/profiles/printer/Ender-5-Pro.ini; do
    [ -s "$file" ] || fail "$file is missing"
done

echo "== the GUI"
apt-get install -y --no-install-recommends xvfb xauth xdotool imagemagick libgl1-mesa-dri >/dev/null
utils/cpp_gui_smoke.sh "$slicer" "$slicer" "$out/gui-smoke"
echo "ok   installed package"
