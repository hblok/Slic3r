#include <gtest/gtest.h>

#include "ExPolygon.hpp"
#include "Support/TreeTips.hpp"

using namespace Slic3r;
using Support::GridTips;

namespace {

Point at(double x, double y) { return Point::new_scale(x, y); }

Polygon square(double x0, double y0, double x1, double y1) {
    return Polygon({at(x0, y0), at(x1, y0), at(x1, y1), at(x0, y1)});
}

bool in(const ExPolygon &area, const Points &points) {
    for (const Point &point : points)
        if (!area.contains(point)) return false;
    return true;
}

} // namespace

TEST(TreeTips, CoversAnAreaWithAGrid) {
    const Polygon area {square(0.5, 0.5, 9.5, 9.5)};
    const Points tips {GridTips(3).place({area})};
    EXPECT_EQ(tips.size(), 9u);  // 3, 6 and 9 each way
    EXPECT_TRUE(in(ExPolygon(area), tips));
}

TEST(TreeTips, TheGridDoesNotMoveWithTheArea) {
    const Points here {GridTips(3).place({square(0.5, 0.5, 3.5, 3.5)})};
    const Points shifted {GridTips(3).place({square(1.5, 1.5, 4.5, 4.5)})};
    ASSERT_EQ(here.size(), 1u);
    EXPECT_EQ(here, shifted);
}

TEST(TreeTips, LeavesHolesOut) {
    ExPolygon ring(square(-0.5, -0.5, 12.5, 12.5));
    Polygon hole {square(1, 1, 11, 11)};
    hole.make_clockwise();
    ring.holes.push_back(hole);
    const Points tips {GridTips(3).place(Polygons(ring))};
    EXPECT_FALSE(tips.empty());
    EXPECT_TRUE(in(ring, tips));
}

TEST(TreeTips, GivesAPartTheGridMissesOneTipInsideIt) {
    // a strip between the grid lines, and an L whose middle is outside it
    const Polygon strip {square(1, 1, 8, 1.4)};
    const Polygon corner({at(20.2, 0.2), at(22.8, 0.2), at(22.8, 0.6), at(20.6, 0.6), at(20.6, 2.8), at(20.2, 2.8)});
    for (const Polygon &area : {strip, corner}) {
        const Points tips {GridTips(30).place({area})};
        ASSERT_EQ(tips.size(), 1u);
        EXPECT_TRUE(in(ExPolygon(area), tips));
    }
}

TEST(TreeTips, NothingForNoArea) {
    EXPECT_TRUE(GridTips(3).place({}).empty());
}
