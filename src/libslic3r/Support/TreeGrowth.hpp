#ifndef slic3r_Support_TreeGrowth_hpp_
#define slic3r_Support_TreeGrowth_hpp_

#include <vector>

#include "Point.hpp"
#include "Support/TreeObstacles.hpp"

namespace Slic3r { namespace Support {

/// A branch where it crosses one slab.
struct Node {
    Point at;
    double radius;      ///< mm
    double length {0};  ///< mm of height below its farthest tip
};

/// How branches travel down.
class Growth {
public:
    virtual ~Growth() = default;
    /// The branches on slab i, given those on the slab above, which is `drop` mm of height
    /// further up. A branch that ends on the model is left out. For the branch above to
    /// stand on something, a node moves sideways no more than the obstacles' slope allows.
    virtual std::vector<Node> step(const std::vector<Node> &above, size_t i, double drop,
        Obstacles &obstacles) const = 0;
};

/// Branches lean towards their nearest neighbour, merge where they meet and thicken on the
/// way down. They stay where they can still reach the build plate, and come down on the
/// model where they cannot.
class MergingGrowth : public Growth {
public:
    struct Settings {
        double slope {0.84};       ///< sideways per height; the obstacles must agree
        double tip_radius {0.7};   ///< mm
        double max_radius {2.5};   ///< mm: trunks stop thickening here
        double thickening {0.09};  ///< radius gained per mm of height (about 5 degrees)
        double reach {10};         ///< mm: neighbours farther away are ignored
    };
    explicit MergingGrowth(const Settings &settings) : settings(settings) {}
    std::vector<Node> step(const std::vector<Node> &above, size_t i, double drop,
        Obstacles &obstacles) const override;

private:
    Settings settings;

    bool steer(const Point &from, Point &to, double radius, double move, size_t i, Obstacles &obstacles) const;
};

}}

#endif
