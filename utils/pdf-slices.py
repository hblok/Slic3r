#!/usr/bin/env python3
"""Turn the slices of a model into a PDF, one solid page per layer.

Usage: slic3r --export-svg -o slices.svg model.stl
       pdf-slices.py slices.svg [--output slices.pdf]
"""
import argparse
import re
import xml.etree.ElementTree as ElementTree

SVG = "{http://www.w3.org/2000/svg}"
POINTS = 72 / 25.4  # PDF units per mm

parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
parser.add_argument("svg")
parser.add_argument("--output", "-o")
args = parser.parse_args()

root = ElementTree.parse(args.svg).getroot()
width, height = float(root.get("width")), float(root.get("height"))
pages = []
for layer in root.iter(SVG + "g"):
    path = []
    for polygon in layer.iter(SVG + "polygon"):
        points = [tuple(float(v) for v in pair.split(",")) for pair in polygon.get("points").split()]
        # SVG's Y points down, PDF's up
        path += ["%.3f %.3f %s" % (x * POINTS, (height - y) * POINTS, "l" if i else "m")
                 for i, (x, y) in enumerate(points)]
        path.append("h")
    # even-odd filling leaves the holes open
    pages.append("0 0 0.55 rg\n" + "\n".join(path) + "\nf*\n" if path else "")

# objects: 1 catalog, 2 page tree, then a page and its content for each layer
objects = ["<< /Type /Catalog /Pages 2 0 R >>",
           "<< /Type /Pages /Count %d /Kids [%s] >>" % (len(pages), " ".join("%d 0 R" % (3 + 2 * i) for i in range(len(pages))))]
for i, content in enumerate(pages):
    objects.append("<< /Type /Page /Parent 2 0 R /MediaBox [0 0 %.3f %.3f] /Contents %d 0 R >>"
                   % (width * POINTS, height * POINTS, 4 + 2 * i))
    objects.append("<< /Length %d >>\nstream\n%sendstream" % (len(content), content))

pdf = b"%PDF-1.4\n"
offsets = []
for number, body in enumerate(objects, 1):
    offsets.append(len(pdf))
    pdf += ("%d 0 obj\n%s\nendobj\n" % (number, body)).encode("ascii")
table = len(pdf)
pdf += ("xref\n0 %d\n0000000000 65535 f \n" % (len(objects) + 1)).encode()
pdf += "".join("%010d 00000 n \n" % offset for offset in offsets).encode()
pdf += ("trailer\n<< /Size %d /Root 1 0 R >>\nstartxref\n%d\n%%%%EOF\n" % (len(objects) + 1, table)).encode()

output = args.output or re.sub(r"\.svg$", "", args.svg, flags=re.I) + ".pdf"
with open(output, "wb") as out:
    out.write(pdf)
print("PDF file written to " + output)
