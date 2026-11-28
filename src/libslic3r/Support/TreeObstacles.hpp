#ifndef slic3r_Support_TreeObstacles_hpp_
#define slic3r_Support_TreeObstacles_hpp_

#include <map>
#include <vector>

#include "ExPolygon.hpp"
#include "Support/Model.hpp"

namespace Slic3r { namespace Support {

/// Whether the point is in one of the areas.
bool inside(const ExPolygons &areas, const Point &point);

/// The point just outside the areas that is nearest to `point` (itself if it is outside
/// already). The areas must not overlap each other.
Point nearest_outside(const ExPolygons &areas, const Point &point);

/// Where the centre of a branch may not be. Radii are rounded up to a step, and what has
/// been worked out is kept.
class Obstacles {
public:
    /// gap: space left between branch and model, mm. slope: how far a branch can move
    /// sideways per mm of height. The slabs are only referred to: keep them alive.
    Obstacles(const std::vector<Slab> &slabs, double gap, double slope, double radius_step = 0.5);

    /// On slab i, a branch of this radius would touch the model.
    const ExPolygons &collision(size_t i, double radius);
    /// From these places on slab i, a branch cannot get past the model to the build plate.
    const ExPolygons &avoidance(size_t i, double radius);

private:
    const std::vector<Slab> &slabs;
    double gap, slope, radius_step;
    std::map<int, std::vector<ExPolygons>> collisions, avoidances;  // by radius step

    int step_of(double radius) const;
};

}}

#endif
