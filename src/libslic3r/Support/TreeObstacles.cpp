#include "Support/TreeObstacles.hpp"

#include <algorithm>
#include <cmath>
#include <limits>

#include "ClipperUtils.hpp"

namespace Slic3r { namespace Support {

bool
inside(const ExPolygons &areas, const Point &point)
{
    for (const auto &area : areas)
        if (area.contains(point)) return true;
    return false;
}

Point
nearest_outside(const ExPolygons &areas, const Point &point)
{
    if (!inside(areas, point)) return point;
    Point nearest {point};
    double best {std::numeric_limits<double>::max()};
    for (const auto &area : areas)
        for (const Polygon &ring : Polygons(area))
            for (const Line &edge : ring.lines()) {
                const Point on_edge {point.projection_onto(edge)};
                const double distance {point.distance_to(on_edge)};
                if (distance < best) {
                    best = distance;
                    nearest = on_edge;
                }
            }
    // a little past the edge, so that it counts as outside
    const double past {scale_(0.01)};
    const double length {std::max(best, 1.0)};
    return Point(static_cast<coord_t>(std::llround(nearest.x + (nearest.x - point.x) / length * past)),
                 static_cast<coord_t>(std::llround(nearest.y + (nearest.y - point.y) / length * past)));
}

Obstacles::Obstacles(const std::vector<Slab> &slabs, double gap, double slope, double radius_step)
    : slabs(slabs), gap(gap), slope(slope), radius_step(radius_step)
{
}

int
Obstacles::step_of(double radius) const
{
    return static_cast<int>(std::ceil(radius / this->radius_step - EPSILON));
}

const ExPolygons &
Obstacles::collision(size_t i, double radius)
{
    const int step {this->step_of(radius)};
    auto &layers = this->collisions[step];
    if (layers.empty()) {
        const float grow = scale_(this->gap + step * this->radius_step);
        for (const Slab &slab : this->slabs)
            layers.push_back(slab.object.empty() ? ExPolygons() : offset_ex(slab.object, grow));
    }
    return layers.at(i);
}

const ExPolygons &
Obstacles::avoidance(size_t i, double radius)
{
    const int step {this->step_of(radius)};
    auto &layers = this->avoidances[step];
    if (layers.empty()) {
        // bottom up: shut in here is whatever a branch cannot leave on its way down
        for (size_t j = 0; j < this->slabs.size(); ++j) {
            Polygons shut;
            if (j > 0 && !layers[j - 1].empty()) {
                const float reach = scale_(this->slope * this->slabs[j].height);
                shut = offset(to_polygons(layers[j - 1]), -reach);
            }
            append_to(shut, to_polygons(this->collision(j, radius)));
            layers.push_back(union_ex(shut));
        }
    }
    return layers.at(i);
}

}}
