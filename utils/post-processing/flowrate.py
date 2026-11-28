#!/usr/bin/env python3
"""Comment each extruding move with its flow rate.

A post-processing script: rewrites the files it is given (--post-process), or filters
standard input. Needs SLIC3R_FILAMENT_DIAMETER, which Slic3r sets for these scripts.
"""
import fileinput
import math
import os
import re
import sys

diameters = [float(d) for d in os.environ.get("SLIC3R_FILAMENT_DIAMETER", "").split(",") if d]
e = 0.0
tool = 0
x = y = None
feedrate = 0.0
for line in fileinput.input(inplace=len(sys.argv) > 1, encoding="utf-8", errors="surrogateescape"):
    found = re.match(r"G1.*? F([0-9.]+)", line)
    if found:
        feedrate = float(found.group(1))
    move = re.match(r"G1 X([0-9.-]+) Y([0-9.-]+).*? E([0-9.-]+)", line)
    if move:
        to_x, to_y, to_e = (float(v) for v in move.groups())
        length = to_e - e
        if length > 0 and x is not None:
            distance = math.hypot(to_x - x, to_y - y)
            if distance > 0:
                per_mm = length / distance
                diameter = diameters[tool] if tool < len(diameters) else 0
                volume = diameter ** 2 * math.pi / 4 * per_mm
                comment = (" ; dXY = %.3fmm ; dE = %.5fmm ; dE/XY = %.5fmm/mm; volspeed = %.5fmm^3/sec"
                           % (distance, length, per_mm, feedrate / 60 * volume))
                line = re.sub(r"([\r\n]+)", lambda end: comment + end.group(1), line, count=1)
        e, x, y = to_e, to_x, to_y
    found = re.match(r"G1 X([0-9.]+) Y([0-9.]+)", line)
    if found:
        x, y = float(found.group(1)), float(found.group(2))
    found = re.match(r"G1.*? E([0-9.]+)", line)
    if found:
        e = float(found.group(1))
    if line.startswith("G92 E0"):
        e = 0.0
    found = re.match(r"T(\d+)", line)
    if found:
        tool = int(found.group(1))
    sys.stdout.write(line)
