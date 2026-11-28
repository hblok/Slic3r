#!/usr/bin/env python3
"""Drop moves shorter than MIN_DISTANCE (a feedrate change on a dropped move is kept).

A post-processing script: rewrites the files it is given (--post-process; the original
is kept with "~" appended), or filters standard input.
"""
import fileinput
import re
import sys

MIN_DISTANCE = 0.33  # mm, over X, Y, Z and E
MIN_DISTANCE_Z = 0.005

last = dict.fromkeys("XYZEF", "10000")
pos = dict.fromkeys("XYZEF", "0")


def read_words(line, into):
    for letter, value, _ in re.findall(r"([XYZEF])(\d+(\.\d+)?)", line, re.I):
        into[letter.upper()] = value


for line in fileinput.input(inplace=len(sys.argv) > 1, backup="~" if len(sys.argv) > 1 else "",
                            encoding="utf-8", errors="surrogateescape"):
    if re.search(r"\bG[01]\b", line, re.I):
        read_words(line, pos)
        full = "X" in line and "Y" in line
        distance = sum((float(pos[a]) - float(last[a])) ** 2 for a in "XYZE")
        if (full and distance >= MIN_DISTANCE ** 2) or abs(float(pos["Z"]) - float(last["Z"])) > MIN_DISTANCE_Z or not full:
            sys.stdout.write(line)
            last.update(pos)
        elif float(pos["F"]) != float(last["F"]):
            sys.stdout.write("G1 F%s\n" % pos["F"])
            last["F"] = pos["F"]
    else:
        if re.search(r"\bG92\b", line, re.I):
            read_words(line, last)
        sys.stdout.write(line)
