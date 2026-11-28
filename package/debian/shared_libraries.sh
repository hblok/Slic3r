#!/bin/sh
# The packages (with the oldest versions that will do) a program needs for the libraries
# it is linked with, as dpkg-shlibdeps works them out, on one line. Debian only: the
# names are those of the system it runs on.
# usage: shared_libraries.sh PROGRAM
set -eu
program=$(realpath "$1")
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
mkdir "$work/debian"
printf 'Source: slic3r\n\nPackage: slic3r\nArchitecture: any\n' >"$work/debian/control"
found=$(cd "$work" && dpkg-shlibdeps -O -e"$program")
case $found in
    shlibs:Depends=*) printf '%s\n' "${found#shlibs:Depends=}" ;;
    *) echo "dpkg-shlibdeps found no dependencies: $found" >&2; exit 1 ;;
esac
