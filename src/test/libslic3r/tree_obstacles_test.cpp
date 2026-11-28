#include <gtest/gtest.h>

#include <vector>

#include "Support/TreeObstacles.hpp"

using namespace Slic3r;
using Support::Obstacles;
using Support::Slab;

namespace {

Point at(double x, double y) { return Point::new_scale(x, y); }

Polygons square(double x0, double y0, double x1, double y1) {
    return Polygons {Polygon({at(x0, y0), at(x1, y0), at(x1, y1), at(x0, y1)})};
}

/// 1 mm slabs; the given ones hold a 10 x 10 mm block at the origin.
std::vector<Slab> stack(size_t count, std::vector<size_t> with_block) {
    std::vector<Slab> slabs(count);
    for (size_t i = 0; i < count; ++i) {
        slabs[i].z = i + 1.0;
        slabs[i].height = 1;
    }
    for (size_t i : with_block) slabs[i].object = square(0, 0, 10, 10);
    return slabs;
}

} // namespace

TEST(TreeObstacles, NearestOutsideLeavesByTheClosestEdge) {
    const ExPolygons areas {ExPolygon(square(0, 0, 10, 10).front())};
    const Point out {Support::nearest_outside(areas, at(2, 5))};
    EXPECT_FALSE(Support::inside(areas, out));
    EXPECT_NEAR(unscale(out.x), 0, 0.05);
    EXPECT_NEAR(unscale(out.y), 5, 0.05);
    EXPECT_EQ(Support::nearest_outside(areas, at(20, 5)), at(20, 5));
}

TEST(TreeObstacles, CollisionIsTheModelGrownByGapAndRadius) {
    const auto slabs {stack(2, {1})};
    Obstacles obstacles(slabs, 0.5, 1.0, 0.5);
    EXPECT_TRUE(obstacles.collision(0, 1).empty());
    // grown by 0.5 + 1.0
    EXPECT_TRUE(Support::inside(obstacles.collision(1, 1), at(11.4, 5)));
    EXPECT_FALSE(Support::inside(obstacles.collision(1, 1), at(11.6, 5)));
    // radii are rounded up to the next step: 1.2 counts as 1.5
    EXPECT_TRUE(Support::inside(obstacles.collision(1, 1.2), at(11.9, 5)));
}

TEST(TreeObstacles, AvoidanceShrinksUpwardsByWhatABranchCanMove) {
    // a block on the second slab only, nothing above: 45 degrees, 1 mm per slab
    const auto slabs {stack(10, {1})};
    Obstacles obstacles(slabs, 0, 1.0);
    // the centre is 6 mm from the edge of the grown block (radius 1)
    EXPECT_TRUE(Support::inside(obstacles.avoidance(1, 1), at(5, 5)));
    EXPECT_TRUE(Support::inside(obstacles.avoidance(4, 1), at(5, 5)));
    // 6 slabs higher there is room to get past
    EXPECT_FALSE(Support::inside(obstacles.avoidance(8, 1), at(5, 5)));
    // close to the edge, two slabs are enough
    EXPECT_FALSE(Support::inside(obstacles.avoidance(4, 1), at(0.5, 5)));
    // below the block nothing is in the way
    EXPECT_TRUE(obstacles.avoidance(0, 1).empty());
}
