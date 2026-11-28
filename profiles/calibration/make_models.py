#!/usr/bin/env python3
"""Write the calibration models (binary STL) next to this script.

temperature-tower.stl  8 sections of 5 mm, 20 x 10 mm, with a 0.6 mm deep groove
                       between them so the sections are easy to tell apart.
flow-cube.stl          20 mm cube for the single-wall flow test.
support-test.stl       a 30 x 30 mm cap on a post, 24 mm up, with a ledge under one
                       side: overhangs to support down to the bed and down to the model.
"""
import os
import struct

HERE = os.path.dirname(os.path.abspath(__file__))


def box(x0, y0, z0, x1, y1, z1):
    """12 outward-facing triangles of an axis-aligned box"""
    v = [(x, y, z) for z in (z0, z1) for y in (y0, y1) for x in (x0, x1)]
    faces = [(0, 2, 1), (1, 2, 3), (4, 5, 6), (5, 7, 6), (0, 1, 4), (1, 5, 4),
             (2, 6, 3), (3, 6, 7), (0, 4, 2), (2, 4, 6), (1, 3, 5), (3, 7, 5)]
    return [(v[a], v[b], v[c]) for a, b, c in faces]


def write_stl(name, triangles):
    with open(os.path.join(HERE, name), "wb") as f:
        f.write(name.encode().ljust(80, b" "))
        f.write(struct.pack("<I", len(triangles)))
        for t in triangles:
            f.write(struct.pack("<3f", 0, 0, 0))  # normals are recomputed on load
            for p in t:
                f.write(struct.pack("<3f", *p))
            f.write(b"\0\0")


# Separate boxes that overlap by 0.01 mm: the slicer unions each layer.
tower = []
for i in range(8):
    z = i * 5.0
    tower += box(0, 0, z, 20, 10, z + 4.4 + 0.01)                 # section
    top = z + 5.0 + (0.01 if i < 7 else 0)                        # tower ends at 40 mm
    tower += box(0.6, 0.6, z + 4.4, 19.4, 9.4, top)                # groove
write_stl("temperature-tower.stl", tower)
write_stl("flow-cube.stl", box(0, 0, 0, 20, 20, 20))
write_stl("support-test.stl",
          box(-5, -5, 0, 5, 5, 24.01)                              # post
          + box(4.99, -5, 0, 15, 5, 8)                             # ledge, towards +X
          + box(-15, -15, 24, 15, 15, 26))                         # cap
