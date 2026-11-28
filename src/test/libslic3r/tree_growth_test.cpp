#include <gtest/gtest.h>

#include <vector>

#include "Support/TreeGrowth.hpp"

using namespace Slic3r;
using Support::MergingGrowth;
using Support::Node;
using Support::Obstacles;
using Support::Slab;

namespace {

constexpr double drop {0.5};  // mm per slab

Point at(double x, double y) { return Point::new_scale(x, y); }

std::vector<Slab> empty_slabs(size_t count) {
    std::vector<Slab> slabs(count);
    for (size_t i = 0; i < count; ++i) {
        slabs[i].height = drop;
        slabs[i].z = (i + 1) * drop;
    }
    return slabs;
}

void add_block(std::vector<Slab> &slabs, size_t from, size_t to, double x0, double x1) {
    for (size_t i = from; i < to; ++i)
        slabs[i].object = {Polygon({at(x0, -20), at(x1, -20), at(x1, 20), at(x0, 20)})};
}

/// Walk the nodes from the top slab to the bottom one; the nodes on each slab.
std::vector<std::vector<Node>> grow(const std::vector<Slab> &slabs, std::vector<Node> top,
        const MergingGrowth::Settings &settings = {}) {
    Obstacles obstacles(slabs, 0.5, settings.slope);
    const MergingGrowth growth(settings);
    std::vector<std::vector<Node>> levels(slabs.size());
    levels.back() = std::move(top);
    for (size_t i = slabs.size() - 1; i-- > 0;)
        levels[i] = growth.step(levels[i + 1], i, slabs[i + 1].height, obstacles);
    return levels;
}

/// every node of a level is within a step of one on the level above
void expect_gentle(const std::vector<std::vector<Node>> &levels, double slope) {
    for (size_t i = 0; i + 1 < levels.size(); ++i)
        for (const Node &node : levels[i]) {
            double nearest {1e30};
            for (const Node &up : levels[i + 1]) nearest = std::min(nearest, node.at.distance_to(up.at));
            EXPECT_LE(unscale(static_cast<coord_t>(nearest)), slope * drop + 0.02) << "slab " << i;
        }
}

} // namespace

TEST(TreeGrowth, ALoneBranchComesStraightDownAndThickensToTheLimit) {
    const auto levels {grow(empty_slabs(100), {Node {at(1, 2), 0.7}})};
    ASSERT_EQ(levels.front().size(), 1u);
    EXPECT_EQ(levels.front()[0].at, at(1, 2));
    EXPECT_NEAR(levels[89][0].radius, 0.7 + 5 * 0.09, 1e-9);  // 5 mm below the tip
    EXPECT_DOUBLE_EQ(levels.front()[0].radius, 2.5);
}

TEST(TreeGrowth, NeighboursLeanTogetherAndMerge) {
    const auto levels {grow(empty_slabs(20), {Node {at(0, 0), 0.7}, Node {at(6, 0), 0.7}})};
    EXPECT_EQ(levels[18].size(), 2u);
    ASSERT_EQ(levels.front().size(), 1u);
    EXPECT_NEAR(unscale(levels.front()[0].at.x), 3, 3.0);
    EXPECT_GT(levels.front()[0].radius, levels[18][0].radius);
    expect_gentle(levels, 0.84);
}

TEST(TreeGrowth, BranchesOutOfReachStayApart) {
    const auto levels {grow(empty_slabs(20), {Node {at(0, 0), 0.7}, Node {at(30, 0), 0.7}})};
    ASSERT_EQ(levels.front().size(), 2u);
    EXPECT_EQ(levels.front()[0].at, at(0, 0));
}

TEST(TreeGrowth, GoesAroundTheModelToTheBuildPlate) {
    // a wall 8 mm wide, from the plate up to 5 mm; the branch starts 25 mm up over its edge
    auto slabs {empty_slabs(50)};
    add_block(slabs, 0, 10, -8, 0);
    const auto levels {grow(slabs, {Node {at(-1, 0), 0.7}})};
    ASSERT_EQ(levels.front().size(), 1u);
    Obstacles obstacles(slabs, 0.5, 0.84);
    for (size_t i = 0; i < 10; ++i) {
        ASSERT_EQ(levels[i].size(), 1u) << "slab " << i;
        EXPECT_FALSE(Support::inside(obstacles.collision(i, levels[i][0].radius), levels[i][0].at)) << "slab " << i;
    }
    expect_gentle(levels, 0.84);
}

TEST(TreeGrowth, ComesDownOnTheModelWhereThereIsNoWayAround) {
    // a floor 60 mm wide at 5 mm; the branch starts 2.5 mm above its middle
    auto slabs {empty_slabs(15)};
    add_block(slabs, 0, 10, -30, 30);
    const auto levels {grow(slabs, {Node {at(0, 0), 0.7}})};
    EXPECT_EQ(levels[10].size(), 1u);
    EXPECT_TRUE(levels[9].empty());
}

TEST(TreeGrowth, ABranchBesideAWallLivesOnAsItThickens) {
    auto slabs {empty_slabs(80)};
    add_block(slabs, 0, 80, -8, 0);
    const auto levels {grow(slabs, {Node {at(1.25, 0), 0.7}})};  // gap 0.5 + radius 0.7
    ASSERT_EQ(levels.front().size(), 1u);
    EXPECT_GT(unscale(levels.front()[0].at.x), 1.0);
}
