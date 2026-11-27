#!/bin/sh
# Parity check: slice the same models with the C++ CLI and with the Perl program
# (slic3r.pl) and compare the G-code, comments and blank lines left out. Any
# difference is a place where the C++ pipeline does not yet do what Perl does.
#
# Needs a built C++ CLI and a built XS module (xs/blib), see CLAUDE.md.
# Usage: compare_perl.sh path/to/slic3r [name...]   (names: run only these setups)
# All 74 setups take about 20 seconds.
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
m=models  # meshes from lib/Slic3r/Test.pm, written with TriangleMesh::write_binary
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
for mesh in cube_with_hole bridge overhang gt2_teeth ipadstand sloping_hole two_hollow_squares step pyramid; do
    compare "mesh_$mesh" $m/$mesh.stl
done
for f in rectilinear grid alignedrectilinear triangles stars cubic concentric honeycomb 3dhoneycomb \
        gyroid hilbertcurve archimedeanchords octagramspiral; do
    compare "fill_$f" --fill-pattern $f $m/sloping_hole.stl
done
compare fill_density0 --fill-density 0% $box
compare perimeters1 --perimeters 1 $m/cube_with_hole.stl
compare perimeters5 --perimeters 5 $m/cube_with_hole.stl
compare skirts0 --skirts 0 $box
compare brim3 --brim-width 3 $box
compare retract_lift --retract-lift 0.5 $box
compare wipe --wipe $m/cube_with_hole.stl
compare relative_e --use-relative-e-distances $box
compare firmware_retraction --use-firmware-retraction $box
for g in repetier teacup makerware sailfish mach3 machinekit smoothie no-extrusion; do
    compare "flavor_$g" --gcode-flavor $g $box
done
compare external_perimeters_first --external-perimeters-first $m/cube_with_hole.stl
compare thin_walls --thin-walls $m/gt2_teeth.stl
compare infill_every_layers2 --infill-every-layers 2 $box
compare solid_infill_every_layers3 --solid-infill-every-layers 3 $box
compare infill_first --infill-first $box
compare seam_random --seam-position random $box
compare seam_nearest --seam-position nearest $m/cube_with_hole.stl
compare seam_rear --seam-position rear $box
compare z_offset --z-offset 0.1 $box
compare no_cooling --no-cooling $box
compare spiral_vase --spiral-vase --perimeters 1 --top-solid-layers 0 --fill-density 0 $box
compare support_buildplate_only --support-material --support-material-buildplate-only $m/overhang.stl
compare support_enforce_layers3 --support-material-enforce-layers 3 $m/overhang.stl
compare support_overhang --support-material $m/overhang.stl
compare support_ipadstand --support-material $m/ipadstand.stl
compare support_bridges --support-material --no-dont-support-bridges $m/bridge.stl
compare support_threshold45 --support-material --support-material-threshold 45 $m/overhang.stl
compare complete_objects --complete-objects --duplicate 2 $box
compare no_overhangs --no-overhangs $m/bridge.stl
compare first_layer_width --first-layer-extrusion-width 0.8 $box
compare end_gcode_plain --end-gcode M84 $box
compare start_gcode_plain --start-gcode G28 --first-layer-bed-temperature 60 --bed-temperature 55 \
    --first-layer-temperature 210 --temperature 205 $box
compare box_with_support --support-material $box
compare scale2 --scale 2 $box
compare duplicate_grid --duplicate-grid 2,3 $box
}
# Known difference, not in the list: --rotate, --rotate-x, --rotate-y. C++ rotates the
# mesh, Perl the instance (Z) or the mesh after applying the instance (X, Y); E differs
# in the last digit, and a 45 degree Y rotation of overhang.stl orders one layer's
# infill differently. Same toolpaths otherwise.
# Known difference, not in the list: --avoid-crossing-perimeters (Perl detects a new
# object copy by memory address, see commit 30d45e10).

[ -n "${KEEP:-}" ] && [ $failed -ne 0 ] && echo "outputs kept in $tmp"
exit $failed
