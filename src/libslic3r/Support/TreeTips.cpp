#include "Support/TreeTips.hpp"

#include <algorithm>

#include "BoundingBox.hpp"
#include "ClipperUtils.hpp"
#include "ExPolygon.hpp"

namespace Slic3r { namespace Support {

namespace {

/// the first grid line at or after `value`
coord_t
grid_line(coord_t value, coord_t spacing)
{
    coord_t line {value / spacing * spacing};
    if (line < value) line += spacing;
    return line;
}

/// A point inside the area: the middle of the longest stretch of it that a horizontal
/// line through its middle crosses.
bool
point_inside(const ExPolygon &area, Point &point)
{
    const BoundingBox box {area.bounding_box()};
    const coord_t y {box.min.y + (box.max.y - box.min.y) / 2};
    std::vector<double> crossings;
    for (const Polygon &ring : Polygons(area))
        for (const Line &edge : ring.lines())
            if ((edge.a.y > y) != (edge.b.y > y))
                crossings.push_back(edge.a.x
                    + static_cast<double>(edge.b.x - edge.a.x) * (y - edge.a.y) / (edge.b.y - edge.a.y));
    std::sort(crossings.begin(), crossings.end());
    double longest {0};
    for (size_t i = 0; i + 1 < crossings.size(); i += 2)
        if (crossings[i + 1] - crossings[i] > longest) {
            longest = crossings[i + 1] - crossings[i];
            point = Point(static_cast<coord_t>((crossings[i] + crossings[i + 1]) / 2), y);
        }
    return longest > 0;
}

} // namespace

GridTips::GridTips(double spacing)
    : spacing(std::max<coord_t>(scale_(spacing), scale_(0.5)))
{
}

Points
GridTips::place(const Polygons &area) const
{
    Points tips;
    for (const ExPolygon &part : union_ex(area)) {
        const BoundingBox box {part.bounding_box()};
        const size_t before {tips.size()};
        for (coord_t x = grid_line(box.min.x, this->spacing); x <= box.max.x; x += this->spacing)
            for (coord_t y = grid_line(box.min.y, this->spacing); y <= box.max.y; y += this->spacing)
                if (part.contains(Point(x, y))) tips.emplace_back(x, y);
        Point lone;
        if (tips.size() == before && point_inside(part, lone)) tips.push_back(lone);
    }
    return tips;
}

}}
