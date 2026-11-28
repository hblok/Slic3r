#!/usr/bin/env python3
"""Put the current Z on every X/Y move that lacks one.

A post-processing script: rewrites the files it is given (--post-process), or filters
standard input.
"""
import fileinput
import re
import sys

z = "0"
for line in fileinput.input(inplace=len(sys.argv) > 1, encoding="utf-8", errors="surrogateescape"):
    found = re.search(r"Z\s*(\d+(\.\d+)?)", line)
    if found:
        z = found.group(1)
    if "Z" not in line and "X" in line and "Y" in line and float(z) > 0:
        # before the comment or the line end, if there is one
        tail = re.search(r"\s*([\r\n;(].*)", line, re.S)
        if tail:
            line = "%s Z%s %s" % (line[:tail.start()], z, tail.group(1))
    sys.stdout.write(line)
