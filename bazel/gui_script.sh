#!/bin/sh
# Run one of the GUI scripts (utils/cpp_gui_*.sh) on the program Bazel built.
# usage: gui_script.sh PROGRAM SCRIPT NAME [PART]
set -eu
program=$1 script=$2 name=$3
shift 3
# Work on real copies: the runfiles are links into the source tree, and what the scripts
# write to their copies of the profiles must never get there.
tree=${TEST_TMPDIR:?}/tree
mkdir -p "$tree/bin"
cp -rL profiles src utils var "$tree/"
# the program looks for its icons in ../var, so it is laid out as utils/make_dist.sh does
cp -L "$program" "$tree/bin/slic3r"
# the screenshots stay with the test's other outputs
NO_AT_BRIDGE=1 exec "$tree/$script" "$tree/bin/slic3r" "$tree/bin/slic3r" \
    "${TEST_UNDECLARED_OUTPUTS_DIR:?}/$name" "$@"
