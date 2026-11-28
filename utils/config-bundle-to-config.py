#!/usr/bin/env python3
"""Extract the active settings from a config bundle (users who report problems often
attach a bundle rather than a plain config).

Usage: config-bundle-to-config.py --output config.ini bundle.ini
"""
import argparse
import re
import sys

parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
parser.add_argument("--output", required=True)
parser.add_argument("bundle")
args = parser.parse_args()

sections = {}
current = ""
with open(args.bundle, encoding="utf-8") as bundle:
    for line in bundle:
        line = line.rstrip("\r\n")
        header = re.match(r"\[(.+?)\]$", line)
        option = re.match(r"(\w+) *= *(.*)", line)
        if header:
            current = header.group(1)
        elif option:
            sections.setdefault(current, {})[option.group(1)] = option.group(2)

config = {}
for group in ("print", "filament", "printer"):
    name = re.sub(r"\.ini$", "", sections.get("presets", {}).get(group, ""))
    preset = sections.get("%s:%s" % (group, name))
    if preset is None:
        sys.exit("Failed to find the %s preset '%s' in the bundle" % (group, name))
    config.update(preset)

with open(args.output, "w", encoding="utf-8") as out:
    out.write("# generated from %s\n" % args.bundle.replace("\n", " "))
    out.writelines("%s = %s\n" % item for item in sorted(config.items()))
