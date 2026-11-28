#include "Support/TreeModel.hpp"

#include <algorithm>
#include <cmath>

#include "ClipperUtils.hpp"

namespace Slic3r { namespace Support {

namespace {

Polygon
disc(const Point &centre, double radius /* mm */)
{
    // sides of about 0.8 mm: a printer takes only so many moves a second, and a thin tip
    // drawn finely asks for hundreds
    const int corners {std::max(6, std::min(24, static_cast<int>(std::lround(2 * PI * radius / 0.8))))};
    Polygon polygon;
    for (int i = 0; i < corners; ++i) {
        const double angle {2 * PI * i / corners};
        polygon.points.emplace_back(
            static_cast<coord_t>(centre.x + scale_(radius) * std::cos(angle)),
            static_cast<coord_t>(centre.y + scale_(radius) * std::sin(angle)));
    }
    return polygon;
}

} // namespace

TreeModel::TreeModel(const Settings &settings, std::unique_ptr<TipPlacer> tips, std::unique_ptr<Growth> growth)
    : settings(settings), tips(std::move(tips)), growth(std::move(growth))
{
}

/// Start branches on slab i under the roof of the slab above.
void
TreeModel::plant(std::vector<Node> &nodes, const std::vector<Slab> &slabs, size_t i, Obstacles &obstacles) const
{
    const Settings &s {this->settings};
    if (slabs[i + 1].roof.empty()) return;
    // where the roof above has nothing under it on this slab
    const float sliver = scale_(s.sliver);
    const Polygons underside {offset2(diff(slabs[i + 1].roof, slabs[i].roof), -sliver, +sliver)};
    for (const Point &wanted : this->tips->place(underside)) {
        const bool served {std::any_of(nodes.begin(), nodes.end(), [&](const Node &node) {
            return node.at.distance_to(wanted) <= scale_(s.tip_spacing / 2);
        })};
        if (served) continue;
        // beside the model if the spot itself is too close to it
        const Point at {nearest_outside(obstacles.collision(i, s.tip_radius), wanted)};
        if (at.distance_to(wanted) <= scale_(s.tip_spacing))
            nodes.push_back(Node {at, s.tip_radius});
    }
}

std::vector<Polygons>
TreeModel::base(const std::vector<Slab> &slabs) const
{
    std::vector<Polygons> base(slabs.size());
    if (slabs.size() < 2) return base;
    Obstacles obstacles(slabs, this->settings.gap, this->settings.slope);
    std::vector<Node> nodes;
    for (size_t i = slabs.size() - 1; i-- > 0;) {
        nodes = this->growth->step(nodes, i, slabs[i + 1].height, obstacles);
        this->plant(nodes, slabs, i, obstacles);
        const double foot {i == 0 ? this->settings.foot : 0};
        Polygons discs;
        for (const Node &node : nodes) discs.push_back(disc(node.at, node.radius + foot));
        base[i] = union_(discs);
    }
    return base;
}

}}
