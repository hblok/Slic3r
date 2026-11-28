#!/bin/sh
# Build a run directory you can copy anywhere: the program (GUI and command line in one),
# its icons and the printer profiles. Not a package; the runtime libraries come from
# Debian 13 (listed in the README written below).
#
# Usage: utils/make_dist.sh [output dir]   (default: build/dist-gui, ignored by git)
# Needs the build packages from README.md plus libwxgtk3.2-dev libgl-dev libglu1-mesa-dev.
# Files from an earlier run are overwritten; nothing is removed.
set -eu
root=$(cd "$(dirname "$0")/.." && pwd)
out=$(realpath -m "${1:-$root/build/dist-gui}")
cd "$root"

if [ -e "$out" ] && [ ! -e "$out/bin/slic3r" ]; then
    echo "$out exists and is not a Slic3r run directory; not touching it" >&2
    exit 1
fi

cmake -S src -B build-gui -DCMAKE_BUILD_TYPE=Release -DEnable_GUI=ON >/dev/null
cmake --build build-gui -j"$(nproc)" --target slic3r

mkdir -p "$out/bin"
cp build-gui/slic3r "$out/bin/slic3r"
strip --strip-unneeded "$out/bin/slic3r"
# the program looks for its icons in ../var, seen from the directory it is in
cp -r var profiles LICENSE "$out/"

cat >"$out/slic3r" <<'EOT'
#!/bin/sh
# without files or options this opens the GUI; --help lists the command line
exec "$(dirname "$(readlink -f "$0")")/bin/slic3r" "$@"
EOT
chmod +x "$out/slic3r"

cat >"$out/README.md" <<EOF2
# Slic3r (hblok fork), run directory

Built $(date -u +%Y-%m-%d) from commit $(git rev-parse --short HEAD 2>/dev/null || echo unknown).

    ./slic3r                      # GUI
    ./slic3r model.stl            # GUI with a model on the plate
    ./slic3r -g model.stl         # slice on the command line
    ./slic3r --help

Settings and presets are in ~/.Slic3r (the same files the Perl program used). For the
Ender-5 Pro presets: cp -r profiles/print profiles/filament profiles/printer ~/.Slic3r/

Runtime packages (Debian 13):

    sudo apt install libwxgtk3.2-1t64 libwxgtk-gl3.2-1t64 libglu1-mesa libopengl0 libglx0

If the 3D views stay empty on Wayland, try: GDK_BACKEND=x11 ./slic3r
EOF2
echo "run directory: $out"
