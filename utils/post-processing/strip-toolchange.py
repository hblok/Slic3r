#!/usr/bin/env python3
"""Remove all toolchange commands (and T# arguments) from G-code.

A post-processing script: rewrites the files it is given (--post-process), or filters
standard input.
"""
import fileinput
import re
import sys

for line in fileinput.input(inplace=len(sys.argv) > 1, encoding="utf-8", errors="surrogateescape"):
    if not re.match(r"T[0-9]", line):
        sys.stdout.write(re.sub(r"\s*T[0-9]", "", line, count=1))
