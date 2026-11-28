# Tree supports

Started 2026-11-28. Own, simple tree model first; built so that other tree models, or
single parts of this one, can be swapped in later (see [DECISIONS.md](DECISIONS.md)).
PrusaSlicer's organic supports were the other route: about 10,300 lines plus mesh
slicing, search trees and TBB that this core does not have.

## Where it plugs in

`SupportMaterial::generate()` keeps what works: overhang and contact detection, interface
layers, support layer heights, gap to the model, toolpaths. Only the **base** (what
stands under the interface) comes from the chosen support style:

```
contact, interface  -->  base per layer  -->  clip to model  -->  toolpaths
                         ^ style normal: the grid/pillar code as before
                           style tree:   Support::Model
```

The toolpath stage draws a wall around every base area above the first layer, so a
branch cross-section needs nothing special.

## Parts

In `src/libslic3r/Support/`, one Bazel target and test each. They work on plain polygons,
one `Slab` per support layer; none of them knows about `Print` or `PrintObject`.

| Part | Question it answers | Swap by |
|---|---|---|
| `Model` (interface) | which areas to print as base, per layer | a new class and one line in `Models.cpp` |
| `TipPlacer`, default `GridTips` | where under an overhang do branches start | another `TipPlacer` |
| `Growth`, default `MergingGrowth` | how branches move, merge and thicken on the way down | another `Growth` |
| `Obstacles` | where may a branch centre not be; from where can it still reach the plate | one implementation so far |
| `TreeModel` | puts the three together and draws circles | |
| `Models` | support style setting to model | |

`GridTips`, `MergingGrowth` and `Obstacles` make the first tree: branches start on a grid
under the overhang, lean towards their neighbours by at most the branch angle, merge,
thicken, go around the model where they can, and rest on it where they cannot.

## Settings

| Option | Default | |
|---|---|---|
| `support_material_style` | `normal` | `tree` selects the tree model; more values later |
| `support_material_tree_angle` | 40° | how far from vertical a branch may lean |
| `support_material_tree_branch_diameter` | 5 mm | trunks stop thickening here |
| `support_material_tree_tip_spacing` | 3 mm | distance between branch tips under an overhang |

Contact distance, interface layers, threshold, speed, extruder and pattern work as for
normal support (the pattern fills thick branches; `pillars` counts as rectilinear).
Normal support output does not change: golden G-code differs only by the new settings in
the header comments.

## Steps

- [x] `Model`, `Obstacles`
- [x] `GridTips`
- [ ] `MergingGrowth`
- [ ] `TreeModel`
- [ ] Settings, `Models`, use in `SupportMaterial`, GUI, golden G-code
- [ ] Look at the result; compare filament with normal support
- [ ] Test print (needs the printer)
