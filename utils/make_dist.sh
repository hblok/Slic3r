#!/bin/sh
# Build a run directory you can copy anywhere: the Perl program with its GUI, the
# compiled XS module, the C++ CLI and the printer profiles. Not a package; the
# runtime libraries come from Debian 13 (listed in the README written below).
#
# Usage: utils/make_dist.sh [output dir]   (default: build/dist, ignored by git)
# Needs the build packages from README.md.
set -eu
root=$(cd "$(dirname "$0")/.." && pwd)
out=$(realpath -m "${1:-$root/build/dist}")
cd "$root"

if [ -e "$out" ] && [ ! -e "$out/slic3r.pl" ]; then
    echo "$out exists and is not a Slic3r run directory; not touching it" >&2
    exit 1
fi

cmake -S src -B build -DCMAKE_BUILD_TYPE=Release >/dev/null
cmake --build build -j"$(nproc)" --target slic3r
(cd xs && perl Build.PL >/dev/null && ./Build >/dev/null)

rm -rf "$out"
mkdir -p "$out"
cp -r slic3r.pl lib var profiles LICENSE "$out/"
# slic3r.pl puts its own lib/ on @INC, and DynaLoader finds auto/ there
cp -r xs/blib/lib/. "$out/lib/"
cp -r xs/blib/arch/auto "$out/lib/"
cp build/slic3r "$out/slic3r-cli"
strip --strip-unneeded "$out/slic3r-cli" "$out/lib/auto/Slic3r/XS/XS.so"  # 118 MB -> ~15 MB

cat >"$out/README.md" <<EOF
# Slic3r (hblok fork), run directory

Built $(date -u +%Y-%m-%d) from commit $(git rev-parse --short HEAD 2>/dev/null || echo unknown).

    ./slic3r.pl              # GUI
    ./slic3r.pl --help       # Perl command line
    ./slic3r-cli --help      # C++ command line

Ender 5 Pro profiles are in \`profiles/\` (File > Load Config in the GUI).
Settings are stored in ~/.Slic3r.

Runtime packages (Debian 13):

    sudo apt install perl libmoo-perl libencode-locale-perl \\
      libio-stringy-perl libclass-xsaccessor-perl libclass-accessor-perl libwww-perl \\
      libwx-perl libwx-glcanvas-perl libopengl-perl \\
      libboost-thread1.83.0 libboost-filesystem1.83.0

The compiled parts are tied to Debian 13's Perl (5.40) and Boost (1.83). On another
system, run utils/make_dist.sh there instead of copying this directory.
EOF
echo "run directory: $out"
