#!/usr/bin/env python3
"""Run the fan at full power for a moment before each slower speed, so that it starts.

Writes the result beside the input, as FILE_fixed.
"""
import re
import sys

with open(sys.argv[1], errors="surrogateescape") as source, \
        open(sys.argv[1] + "_fixed", "w", errors="surrogateescape") as out:
    for line in source:
        out.write(re.sub(r"M106 S[1-9]+[0-9]*", r"M106 S255\n\g<0>", line))
