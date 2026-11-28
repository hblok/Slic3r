#include <gtest/gtest.h>

#include <memory>
#include <vector>

#include "ClipperUtils.hpp"
#include "ExPolygon.hpp"
#include "Support/TreeModel.hpp"

using namespace Slic3r;
using Support::GridTips;
using Support::MergingGrowth;
using Support::Slab;
using Support::TipPlacer;
using Support::TreeModel;

namespace {

constexpr double drop {0.3};  // mm per slab

Point at(double x, double y) { return Point::new_scale(x, y); }

Polygons square(double x0, double y0, double x1, double y1) {
    return Polygons {Polygon({at(x0, y0), at(x1, y0), at(x1, y1), at(x0, y1)})};
}

/// Empty slabs with a 20 x 20 mm roof on the top one.
std::vector<Slab> under_a_roof(size_t count) {
    std::vector<Slab> slabs(count);
    for (size_t i = 0; i < count; ++i) {
        slabs[i].height = drop;
        slabs[i].z = (i + 1) * drop;
    }
    slabs.back().roof = square(0, 0, 20, 20);
    return slabs;
}

TreeModel tree(std::unique_ptr<TipPlacer> tips = std::make_unique<GridTips>(3)) {
    return TreeModel({}, std::move(tips), std::make_unique<MergingGrowth>(MergingGrowth::Settings {}));
}

double area(const Polygons &polygons) {
    double sum {0};
    for (const ExPolygon &part : union_ex(polygons)) sum += part.area();
    return sum * SCALING_FACTOR * SCALING_FACTOR;  // mm²
}

/// Nothing on a slab sticks out farther over the slab below than a branch can lean.
void expect_every_layer_to_stand_on_the_one_below(const std::vector<Polygons> &base) {
    const float lean = scale_(1.5 * 0.84 * drop + 0.05);
    for (size_t i = 0; i + 2 < base.size(); ++i)
        EXPECT_LT(area(diff(base[i + 1], offset(base[i], lean))), 0.05) << "slab " << i + 1;
}

} // namespace

TEST(TreeModel, NoRoofNoSupport) {
    auto slabs {under_a_roof(10)};
    slabs.back().roof.clear();
    for (const Polygons &layer : tree().base(slabs)) EXPECT_TRUE(layer.empty());
}

TEST(TreeModel, GrowsFromUnderTheRoofToTheBuildPlate) {
    const auto slabs {under_a_roof(100)};
    const auto base {tree().base(slabs)};
    ASSERT_EQ(base.size(), slabs.size());
    EXPECT_TRUE(base.back().empty());  // the roof's own slab
    for (size_t i = 0; i + 1 < base.size(); ++i) EXPECT_FALSE(base[i].empty()) << "slab " << i;
    expect_every_layer_to_stand_on_the_one_below(base);
}

TEST(TreeModel, TipsCoverTheRoofAndTrunksUseLessMaterial) {
    const auto base {tree().base(under_a_roof(100))};
    const Polygons &tips {base[98]};
    EXPECT_GE(union_ex(tips).size(), 36u);  // a 3 mm grid over 20 x 20 mm
    EXPECT_LT(union_ex(base[1]).size(), union_ex(tips).size() / 3);
    // nowhere under the roof farther than the tip spacing from a tip
    EXPECT_LT(area(diff(square(1, 1, 19, 19), offset(tips, scale_(3)))), 0.01);
    // a column under the whole roof would be 400 mm² on every layer
    EXPECT_LT(area(base[50]), 200);
}

TEST(TreeModel, WidensTheFeetOnTheFirstLayer) {
    const auto base {tree().base(under_a_roof(100))};
    EXPECT_GT(area(base[0]), 1.5 * area(base[1]));
}

TEST(TreeModel, KeepsClearOfTheModelOnTheWayDown) {
    // a post under the middle of the roof, from the plate up to just below it
    auto slabs {under_a_roof(100)};
    for (size_t i = 0; i < 80; ++i) slabs[i].object = square(7, 7, 13, 13);
    const auto base {tree().base(slabs)};
    EXPECT_FALSE(base.front().empty());
    // lower down, the trunks have had room to move away (the first layer's feet are wider)
    for (size_t i = 1; i < 40; ++i)
        EXPECT_LT(area(intersection(base[i], slabs[i].object)), 0.01) << "slab " << i;
}

TEST(TreeModel, AWideModelUnderTheRoofCarriesTheTree) {
    // a table top over everything up to 6 mm: nothing can reach the plate
    auto slabs {under_a_roof(60)};
    for (size_t i = 0; i < 20; ++i) slabs[i].object = square(-40, -40, 60, 60);
    const auto base {tree().base(slabs)};
    EXPECT_FALSE(base[21].empty());
    for (size_t i = 0; i < 20; ++i) EXPECT_TRUE(base[i].empty()) << "slab " << i;
}

TEST(TreeModel, DrawsThinBranchesWithoutTinyMoves) {
    const auto base {tree().base(under_a_roof(100))};
    for (const ExPolygon &tip : union_ex(base[98])) EXPECT_LE(tip.contour.points.size(), 8u);
    for (const ExPolygon &trunk : union_ex(base[1])) EXPECT_GE(trunk.contour.points.size(), 16u);
}

TEST(TreeModel, PrintsBranchesAsTubes) {
    EXPECT_FALSE(tree().infill());
}

TEST(TreeModel, TakesAnotherTipPlacer) {
    struct OneTip : TipPlacer {
        Points place(const Polygons &underside) const override {
            return underside.empty() ? Points() : Points {at(10, 10)};
        }
    };
    const auto base {tree(std::make_unique<OneTip>()).base(under_a_roof(30))};
    for (size_t i = 1; i < 29; ++i) EXPECT_EQ(union_ex(base[i]).size(), 1u) << "slab " << i;
}
