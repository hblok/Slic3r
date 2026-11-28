#include "Support/TreeGrowth.hpp"

#include <algorithm>
#include <cmath>

namespace Slic3r { namespace Support {

namespace {

/// `from` moved towards `to` by no more than `distance` (scaled)
Point
towards(const Point &from, const Point &to, double distance)
{
    const double length {from.distance_to(to)};
    if (length <= distance) return to;
    const double part {distance / length};
    return Point(static_cast<coord_t>(from.x + (to.x - from.x) * part),
                 static_cast<coord_t>(from.y + (to.y - from.y) * part));
}

} // namespace

/// Bend a step from `from` to `to` around the model; false if the branch cannot go on.
bool
MergingGrowth::steer(const Point &from, Point &to, double radius, double move, size_t i, Obstacles &obstacles) const
{
    const ExPolygons &avoidance {obstacles.avoidance(i, radius)};
    if (inside(avoidance, to)) {
        const Point out {nearest_outside(avoidance, from)};
        // out of reach: the plate is lost, so it will come down on the model
        if (from.distance_to(out) <= 2 * move) to = towards(from, out, move);
    }
    const ExPolygons &collision {obstacles.collision(i, radius)};
    if (inside(collision, to))  // out, or a step towards room for all of it
        to = towards(from, nearest_outside(collision, from), move);
    // where there is no room yet, the model trims the branch; a thin one must fit
    const ExPolygons &thin {obstacles.collision(i, this->settings.tip_radius)};
    if (inside(thin, to)) {
        const Point out {nearest_outside(thin, from)};  // `from` itself if it is free
        if (from.distance_to(out) > move) return false;
        to = out;
    }
    return true;
}

std::vector<Node>
MergingGrowth::step(const std::vector<Node> &above, size_t i, double drop, Obstacles &obstacles) const
{
    const Settings &s {this->settings};
    const double move {scale_(s.slope * drop)};

    std::vector<Node> moved;
    for (size_t a = 0; a < above.size(); ++a) {
        Node node {above[a]};
        // towards the nearest neighbour, meeting half way
        // ponytail: compares every pair; a grid of buckets if large models slice slowly
        double nearest {scale_(s.reach)};
        const Node *partner {nullptr};
        for (size_t b = 0; b < above.size(); ++b) {
            const double distance {node.at.distance_to(above[b].at)};
            if (b != a && distance < nearest) {
                nearest = distance;
                partner = &above[b];
            }
        }
        Point to {partner ? towards(node.at, partner->at, std::min(move, nearest / 2)) : node.at};

        node.length += drop;
        node.radius = std::max(node.radius, std::min(s.max_radius, s.tip_radius + node.length * s.thickening));
        if (!this->steer(node.at, to, node.radius, move, i, obstacles)) continue;
        node.at = to;
        moved.push_back(node);
    }

    // merge branches that have come together: the thicker one stays where it is, once it
    // covers (nearly) all of the other, so that nothing above is left hanging
    std::stable_sort(moved.begin(), moved.end(), [](const Node &a, const Node &b) { return a.radius > b.radius; });
    std::vector<Node> merged;
    for (const Node &node : moved) {
        // as much cross section as both had
        const auto both = [&s, &node](const Node &other) {
            return std::max(other.radius, std::min(s.max_radius, std::hypot(other.radius, node.radius)));
        };
        auto host = std::find_if(merged.begin(), merged.end(), [&](const Node &other) {
            return other.at.distance_to(node.at) <= scale_(both(other) - node.radius) + move / 2;
        });
        if (host == merged.end()) {
            merged.push_back(node);
        } else {
            host->radius = both(*host);
            host->length = std::max(host->length, node.length);
        }
    }
    return merged;
}

}}
