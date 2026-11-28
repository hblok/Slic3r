#ifndef slic3r_Support_TreeTips_hpp_
#define slic3r_Support_TreeTips_hpp_

#include "Polygon.hpp"

namespace Slic3r { namespace Support {

/// Where branches start.
class TipPlacer {
public:
    virtual ~TipPlacer() = default;
    /// Points in `area`: the underside of a roof, with nothing under it yet.
    virtual Points place(const Polygons &area) const = 0;
};

/// Tips on a square grid that is the same on every layer, so that the tips under a slope
/// line up. A part of the area that the grid misses gets one tip.
class GridTips : public TipPlacer {
public:
    explicit GridTips(double spacing /* mm */);
    Points place(const Polygons &area) const override;

private:
    coord_t spacing;
};

}}

#endif
