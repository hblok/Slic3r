#!/usr/bin/env python3
"""Add the weight and cost of the filament used to the G-code.

A post-processing script: rewrites the files it is given (--post-process), or filters
standard input.
"""
import fileinput
import re
import sys

# example densities (g/cm3) and prices (per g): adjust to your filament
PLA_DENSITY, ABS_DENSITY = 1.25, 1.05
PLA_PRICE, ABS_PRICE = 0.05, 0.02
CURRENCY = "EUR"

for line in fileinput.input(inplace=len(sys.argv) > 1, encoding="utf-8", errors="surrogateescape"):
    used = re.match(r"(;\s+filament\s+used\s+=\s.*\((\d+(?:\.\d+)?)cm3)\)", line)
    if used:
        pla = float(used.group(2)) * PLA_DENSITY
        abs_ = float(used.group(2)) * ABS_DENSITY
        line = "%s or %.2fg PLA/%.2fg ABS)\n" % (used.group(1), pla, abs_)
        line += "; costs = %s %.2f (PLA), %s %.2f (ABS)\n" % (CURRENCY, pla * PLA_PRICE, CURRENCY, abs_ * ABS_PRICE)
    sys.stdout.write(line)
