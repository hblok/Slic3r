#!/usr/bin/env python3
"""Write the AMF test models for compare_perl.sh (run from this directory).

modifier.amf    20x20x10 box; a modifier over the left half sets 80% rectilinear
                infill and 1 perimeter.
two_parts.amf   two 10x10x10 boxes side by side in one object; the second part
                prints with extruder 2.
"""


def box(x0, y0, z0, x1, y1, z1):
    v = [(x, y, z) for z in (z0, z1) for y in (y0, y1) for x in (x0, x1)]
    # outward-facing triangles (counter-clockwise seen from outside)
    t = [(0, 2, 1), (1, 2, 3), (4, 5, 6), (5, 7, 6),   # bottom, top
         (0, 1, 4), (1, 5, 4), (2, 6, 3), (3, 6, 7),   # front, back
         (0, 4, 2), (2, 4, 6), (1, 3, 5), (3, 7, 5)]   # left, right
    return v, t


def amf(path, volumes):
    """volumes: list of (box, {metadata})"""
    verts, vols = [], []
    for (v, t), meta in volumes:
        base = len(verts)
        verts += v
        vols.append(([(a + base, b + base, c + base) for a, b, c in t], meta))
    with open(path, "w") as f:
        f.write('<?xml version="1.0" encoding="UTF-8"?>\n<amf unit="millimeter">\n'
                '  <object id="0">\n    <mesh>\n      <vertices>\n')
        for x, y, z in verts:
            f.write(f"        <vertex><coordinates><x>{x}</x><y>{y}</y><z>{z}</z></coordinates></vertex>\n")
        f.write("      </vertices>\n")
        for tris, meta in vols:
            f.write("      <volume>\n")
            for k, val in meta.items():
                f.write(f'        <metadata type="slic3r.{k}">{val}</metadata>\n')
            for a, b, c in tris:
                f.write(f"        <triangle><v1>{a}</v1><v2>{b}</v2><v3>{c}</v3></triangle>\n")
            f.write("      </volume>\n")
        f.write("    </mesh>\n  </object>\n</amf>\n")


amf("modifier.amf", [
    (box(0, 0, 0, 20, 20, 10), {}),
    (box(-1, -1, -1, 10, 21, 11), {"modifier": 1, "fill_density": "80%",
                                    "fill_pattern": "rectilinear", "perimeters": 1}),
])
amf("two_parts.amf", [
    (box(0, 0, 0, 10, 10, 10), {}),
    (box(10, 0, 0, 20, 10, 10), {"extruder": 2}),
])
