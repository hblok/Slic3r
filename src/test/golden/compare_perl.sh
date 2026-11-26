#!/bin/sh
# Parity check: slice the same models with the C++ CLI and with the Perl program
# (slic3r.pl) and compare the G-code, comments and blank lines left out. Any
# difference is a place where the C++ pipeline does not yet do what Perl does.
#
# Needs a built C++ CLI and a built XS module (xs/blib), see CLAUDE.md.
# Usage: compare_perl.sh path/to/slic3r [name...]   (names: run only these setups)
# Differing outputs are kept in $KEEP (default: a temporary directory, removed).
set -u

slicer=$(realpath "$1")
shift
cd "$(dirname "$0")"
root=$(realpath ../../..)
export PERL5LIB="$root/xs/blib/arch:$root/xs/blib/lib${PERL5LIB:+:$PERL5LIB}"
tmp=${KEEP:-$(mktemp -d)}
mkdir -p "$tmp"
[ -n "${KEEP:-}" ] || trap 'rm -rf "$tmp"' EXIT
failed=0

box=../inputs/test_cli/20mmbox.stl
p=$root/profiles
ender="--load $p/printer/Ender-5-Pro.ini --load $p/filament/Ender-5-Pro-PLA.ini --load $p/print/Ender-5-Pro-0.20mm.ini"

compare() { # name options... (the C++ and Perl option names must be the same)
    name=$1
    shift
    if [ -n "$only" ] && ! echo " $only " | grep -q " $name "; then return; fi
    "$slicer" -g --threads 4 "$@" -o "$tmp/$name.cpp.gcode" >"$tmp/$name.cpp.log" 2>&1
    perl "$root/slic3r.pl" --threads 4 "$@" -o "$tmp/$name.perl.gcode" >"$tmp/$name.perl.log" 2>&1
    for side in cpp perl; do
        [ -s "$tmp/$name.$side.gcode" ] || { echo "FAIL $name: $side slicing failed"; cat "$tmp/$name.$side.log"; failed=1; return; }
        grep -v -e '^;' -e '^$' "$tmp/$name.$side.gcode" >"$tmp/$name.$side.cmp"
    done
    n=$(diff "$tmp/$name.cpp.cmp" "$tmp/$name.perl.cmp" | grep -c '^[<>]')
    if [ "$n" -eq 0 ]; then
        echo "same $name"
    else
        echo "DIFF $name: $n of $(wc -l <"$tmp/$name.perl.cmp") lines"
        failed=1
    fi
}

only="$*"
# shellcheck disable=SC2086 # $ender is a list of options
{
compare box $box
compare table --support-material table.stl
compare ender_box $ender $box
compare ender_table $ender --support-material table.stl
compare ender_table_rectilinear $ender --support-material --support-material-pattern rectilinear table.stl
compare ender_table_honeycomb $ender --support-material --support-material-pattern honeycomb table.stl
compare two_boxes --duplicate 2 $box
compare raft2 --raft-layers 2 table.stl
compare raft4 --raft-layers 4 table.stl
compare ender_raft3 $ender --raft-layers 3 --support-material table.stl
compare contact_distance0 --support-material --support-material-contact-distance 0 table.stl
compare interface_layers0 --support-material --support-material-interface-layers 0 table.stl
}

[ -n "${KEEP:-}" ] && [ $failed -ne 0 ] && echo "outputs kept in $tmp"
exit $failed
