// The motion planner case of test_primitives.cpp.
#include <gtest/gtest.h>


#include "ClipperUtils.hpp"
#include "ExPolygon.hpp"
#include "Line.hpp"
#include "MotionPlanner.hpp"

using namespace Slic3r;

namespace {

const Points square {Point(100, 100), Point(200, 100), Point(200, 200), Point(100, 200)};  // ccw
const Points hole_in_square {Point(140, 140), Point(140, 160), Point(160, 160), Point(160, 140)};  // cw

ExPolygon holed() { return ExPolygon(square, hole_in_square); }

} // namespace

TEST(MotionPlanner, GoesAroundHoles) {
    const double unit {1 / SCALING_FACTOR};
    ExPolygon island {holed()};
    island.contour.scale(unit);
    island.holes[0].scale(unit);
    auto at = [unit](coord_t x, coord_t y) { return Point(static_cast<coord_t>(x * unit), static_cast<coord_t>(y * unit)); };
    {
        MotionPlanner planner(ExPolygons{island});
        const Point from {at(120, 120)}, to {at(180, 180)};
        const Polyline path {planner.shortest_path(from, to)};
        EXPECT_TRUE(path.is_valid());
        EXPECT_GT(path.length(), Line(from, to).length());
        EXPECT_EQ(path.first_point(), from);
        EXPECT_EQ(path.last_point(), to);
        EXPECT_TRUE(island.contains(path));
    }
    {
        MotionPlanner planner(ExPolygons{island});
        const Point from {at(80, 100)}, to {at(220, 200)};  // outside the island
        const Polyline path {planner.shortest_path(from, to)};
        EXPECT_TRUE(path.is_valid());
        EXPECT_GT(path.length(), Line(from, to).length());
        EXPECT_EQ(path.first_point(), from);
        EXPECT_EQ(path.last_point(), to);
        EXPECT_TRUE(intersection_pl(Polylines{path}, to_polygons(island)).empty());
    }
    {
        ExPolygon second(island);
        second.translate(300 * unit, 0);
        MotionPlanner planner(ExPolygons{island, second});
        const Point from {at(120, 120)}, to {at(420, 120)};
        EXPECT_TRUE(island.contains(from));
        EXPECT_TRUE(second.contains(to));
        EXPECT_TRUE(planner.shortest_path(from, to).is_valid());
    }
    {
        const ExPolygons islands {
            ExPolygon(Points{Point(123800962, 89330311), Point(123959159, 89699438), Point(124000004, 89898430), Point(124000012, 110116427), Point(123946510, 110343065), Point(123767391, 110701303), Point(123284087, 111000001), Point(102585791, 111000009), Point(102000004, 110414223), Point(102000004, 89585787), Point(102585790, 89000000), Point(123300022, 88999993)}),
            ExPolygon(Points{Point(97800954, 89330311), Point(97959151, 89699438), Point(97999996, 89898430), Point(98000004, 110116427), Point(97946502, 110343065), Point(97767383, 110701303), Point(97284079, 111000001), Point(76585783, 111000009), Point(75999996, 110414223), Point(75999996, 89585787), Point(76585782, 89000000), Point(97300014, 88999993)})};
        MotionPlanner planner(islands);
        const Point from(79120520, 107839491), to(104664164, 108335852);
        EXPECT_TRUE(islands[1].contains(from));
        EXPECT_TRUE(islands[0].contains(to));
        EXPECT_TRUE(planner.shortest_path(from, to).is_valid());
    }
}
