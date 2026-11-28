// The geometry cases of test_primitives.cpp; its extrusion, surface and motion planner
// cases are tested with those targets.
#include <gtest/gtest.h>

#include <algorithm>
#include <cmath>
#include <vector>

#include "BoundingBox.hpp"
#include "ClipperUtils.hpp"
#include "ExPolygon.hpp"
#include "Geometry.hpp"
#include "Line.hpp"
#include "Point.hpp"
#include "Polygon.hpp"
#include "Polyline.hpp"
#include "PolylineCollection.hpp"

using namespace Slic3r;

/// equal within the tolerance Catch's Approx used
#define EXPECT_APPROX(value, expected) EXPECT_NEAR(value, expected, 1.2e-5 * std::abs(expected))

namespace {

const Points square {Point(100, 100), Point(200, 100), Point(200, 200), Point(100, 200)};  // ccw
const Points hole_in_square {Point(140, 140), Point(140, 160), Point(160, 160), Point(160, 140)};  // cw

ExPolygon holed() { return ExPolygon(square, hole_in_square); }

std::vector<coord_t> ys(const Polylines &polylines) {
    std::vector<coord_t> out;
    for (const auto &p : polylines) for (const auto &point : p.points) out.push_back(point.y);
    return out;
}

std::vector<coord_t> xs(const Polylines &polylines) {
    std::vector<coord_t> out;
    for (const auto &p : polylines) for (const auto &point : p.points) out.push_back(point.x);
    return out;
}

} // namespace

TEST(Primitives, Points) {
    const Point point(10, 15);
    Point other(point);
    other.scale(2);
    EXPECT_EQ(other, Point(20, 30));
    other.translate(10, -15);
    EXPECT_EQ(other, Point(30, 15));
    EXPECT_FALSE(point.coincides_with(other));

    Point nearest;
    EXPECT_TRUE(point.nearest_point({other, Point(100, 200)}, &nearest));
    EXPECT_EQ(nearest, other);

    const Line line(Point(0, 0), Point(100, 0));
    EXPECT_EQ(Point(0, 0).distance_to(line), 0);
    EXPECT_EQ(Point(100, 0).distance_to(line), 0);
    EXPECT_EQ(Point(50, 0).distance_to(line), 0);
    EXPECT_EQ(Point(150, 0).distance_to(line), 50);
    EXPECT_EQ(Point(0, 50).distance_to(line), 50);
    EXPECT_EQ(Point(50, 50).distance_to(line), 50);
    EXPECT_EQ(Point(50, 50).perp_distance_to(line), 50);
    EXPECT_EQ(Point(150, 50).perp_distance_to(line), 50);
    EXPECT_EQ(Point(100, 0).distance_to(Line(Point(50, 50), Point(125, -25))), 0);
    // no overflow with large coordinates
    EXPECT_EQ(Point(1664161, 18335848).perp_distance_to(Line(Point(18335846, 18335845), Point(18335846, 1664160))), 16671685);
    EXPECT_LT(Point(76975850, 89989996).ccw(Point(76989990, 109989991), Point(76989987, 89989994)), 0);

    const Line base(Point(10, 10), Point(20, 10));
    EXPECT_EQ(Point(15, 15).projection_onto(base), Point(15, 10));
    EXPECT_EQ(Point(0, 15).projection_onto(base), Point(10, 10));
    EXPECT_EQ(Point(25, 15).projection_onto(base), Point(20, 10));
    EXPECT_EQ(Point(10, 10).projection_onto(base), Point(10, 10));
    EXPECT_EQ(Point(12, 10).projection_onto(base), Point(12, 10));
}

TEST(Primitives, Lines) {
    Line line(Point(100, 100), Point(200, 100));
    line.translate(10, -5);
    EXPECT_EQ(line.a, Point(110, 95));
    EXPECT_EQ(line.b, Point(210, 95));
    line.reverse();
    EXPECT_EQ(line.a, Point(210, 95));
    EXPECT_TRUE(Line(Point(0, 0), Point(200, 0)).parallel_to(Line(Point(200, 200), Point(0, 200))));

    for (const double angle : {0.0, PI / 4, PI / 2, PI}) {
        Line turned(Point(0, 0), Point(100, 0));
        turned.rotate(angle, Point(0, 0));
        Line reversed(turned);
        reversed.reverse();
        EXPECT_TRUE(turned.parallel_to(turned));
        EXPECT_TRUE(turned.parallel_to(reversed));
        EXPECT_TRUE(turned.parallel_to(turned.direction()));
        EXPECT_TRUE(turned.parallel_to(turned.direction() + PI));
        EXPECT_TRUE(turned.parallel_to(turned.direction() - PI));
        for (const double nudge : {1e-4 / 2, -1e-4 / 2}) {
            Line nudged(turned);
            nudged.rotate(nudge, Point(0, 0));
            EXPECT_TRUE(turned.parallel_to(nudged));
        }
    }

    Point crossing;
    EXPECT_TRUE(Line(Point(100, 0), Point(200, 0)).intersection_infinite(Line(Point(300, 300), Point(300, 100)), &crossing));
    EXPECT_EQ(crossing, Point(300, 0));
}

TEST(Primitives, Polylines) {
    const Points corner {Point(100, 100), Point(200, 100), Point(200, 200)};
    Polyline polyline;
    polyline.points = corner;
    ASSERT_EQ(polyline.lines().size(), 2u);
    EXPECT_EQ(polyline.length(), 200);

    Polyline doubled(polyline);
    doubled.append(polyline);
    ASSERT_EQ(doubled.points.size(), 6u);
    const double length {doubled.length()};
    doubled.clip_end(length / 3);
    EXPECT_LT(std::abs(doubled.length() - (length - length / 3)), 1);

    Polyline straight;
    straight.points = {Point(0, 0), Point(20, 0), Point(50, 0), Point(80, 0), Point(100, 0)};
    straight.simplify(2);
    EXPECT_EQ(straight.points, Points({Point(0, 0), Point(100, 0)}));
    Polyline zigzag;
    zigzag.points = {Point(0, 0), Point(50, 50), Point(100, 0), Point(125, -25), Point(150, 50)};
    zigzag.simplify(25);
    EXPECT_EQ(zigzag.points, Points({Point(0, 0), Point(50, 50), Point(125, -25), Point(150, 50)}));
    // Douglas-Peucker uses the distance to the segment, not to the line through it
    Polyline back;
    back.points = {Point(0, 0), Point(100, 0), Point(50, 10)};
    back.simplify(25);
    ASSERT_EQ(back.points.size(), 3u);

    Polyline extended(polyline);
    extended.extend_end(50);
    EXPECT_EQ(extended.length(), 250);
    extended.extend_start(50);
    EXPECT_EQ(extended.length(), 300);

    Polyline first, second;
    polyline.split_at(Point(150, 100), &first, &second);
    ASSERT_EQ(first.points.size(), 2u);
    ASSERT_EQ(second.points.size(), 3u);
    EXPECT_EQ(first.last_point(), Point(150, 100));
    EXPECT_EQ(second.first_point(), Point(150, 100));

    Polyline closed;
    closed.points = {corner[0], corner[1], corner[2], corner[0]};
    Polyline head, tail;
    closed.split_at(closed.first_point(), &head, &tail);
    ASSERT_EQ(head.points.size(), 1u);
    ASSERT_EQ(tail.points.size(), 4u);
}

TEST(Primitives, Polygons) {
    const Polygon polygon(square);
    Polygon clockwise(polygon);
    clockwise.reverse();
    EXPECT_TRUE(polygon.is_valid());
    ASSERT_EQ(polygon.lines().size(), 4u);
    EXPECT_EQ(polygon.split_at_first_point().points, Points({square[0], square[1], square[2], square[3], square[0]}));
    const Points from_third {square[2], square[3], square[0], square[1], square[2]};
    EXPECT_EQ(polygon.split_at_index(2).points, from_third);
    EXPECT_EQ(polygon.split_at_vertex(square[2]).points, from_third);
    EXPECT_EQ(polygon.area(), 100 * 100);
    EXPECT_TRUE(polygon.is_counter_clockwise());
    EXPECT_FALSE(clockwise.is_counter_clockwise());
    clockwise.make_counter_clockwise();
    EXPECT_TRUE(clockwise.is_counter_clockwise());
    clockwise.make_counter_clockwise();
    EXPECT_TRUE(clockwise.is_counter_clockwise());
    EXPECT_TRUE(polygon.contains(Point(150, 150)));
    clockwise.reverse();
    EXPECT_TRUE(clockwise.contains(Point(150, 150)));
    EXPECT_EQ(polygon.centroid(), Point(150, 150));

    Polygon hexagon;
    hexagon.points.push_back(Point(100, 0));
    for (int i = 1; i <= 5; ++i) {
        Point corner(100, 0);
        corner.rotate(PI / 3 * i, Point(0, 0));
        hexagon.points.push_back(corner);
    }
    Polygons triangles;
    hexagon.triangulate_convex(&triangles);
    ASSERT_EQ(triangles.size(), 4u);
    for (const auto &triangle : triangles) EXPECT_TRUE(triangle.is_counter_clockwise());

    const Polygon sliver(Points{Point(50000000, 100000000), Point(300000000, 102000000), Point(50000000, 104000000)});
    Point crossing;
    EXPECT_TRUE(sliver.intersection(Line(Point(175992032, 102000000), Point(47983964, 102000000)), &crossing));
    EXPECT_EQ(crossing, Point(50000000, 102000000));
}

TEST(Primitives, ExPolygons) {
    const ExPolygon expolygon {holed()};
    EXPECT_TRUE(expolygon.is_valid());
    EXPECT_EQ(expolygon.area(), 100 * 100 - 20 * 20);

    ExPolygon moved {holed()};
    moved.translate(10, -5);
    EXPECT_EQ(moved.contour.points.front(), Point(110, 95));
    EXPECT_EQ(moved.holes.front().points.front(), Point(150, 135));

    ExPolygon turned {holed()};
    turned.rotate(PI / 2, Point(150, 150));
    EXPECT_EQ(turned.contour.points, Points({square[1], square[2], square[3], square[0]}));
    EXPECT_EQ(turned.holes.front().points, Points({hole_in_square[3], hole_in_square[0], hole_in_square[1], hole_in_square[2]}));

    Polygons trapezoids;
    ExPolygon(Polygon(square)).get_trapezoids2(&trapezoids, PI / 2);
    ASSERT_EQ(trapezoids.size(), 1u);
    ASSERT_EQ(trapezoids.front().points.size(), 4u);

    trapezoids.clear();
    expolygon.get_trapezoids2(&trapezoids, PI / 2);
    ASSERT_EQ(trapezoids.size(), 4u);
    double covered {0};
    for (const auto &trapezoid : trapezoids) covered += trapezoid.area();
    EXPECT_APPROX(covered, expolygon.area());

    trapezoids.clear();
    ExPolygon(Points{Point(0, 100), Point(100, 0), Point(200, 0), Point(300, 100), Point(200, 200), Point(100, 200)})
        .get_trapezoids2(&trapezoids, PI / 2);
    ASSERT_EQ(trapezoids.size(), 3u);

    Polygons triangles;
    expolygon.triangulate_pp(&triangles);
    ASSERT_EQ(triangles.size(), 8u);
    covered = 0;
    for (const auto &triangle : triangles) covered += triangle.area();
    EXPECT_APPROX(covered, expolygon.area());
}

TEST(Primitives, ClippingAndOffsetting) {
    const Polygon outer(Points{Point(200, 100), Point(200, 200), Point(100, 200), Point(100, 100)});
    const Polygon hole(Points{Point(160, 140), Point(140, 140), Point(140, 160), Point(160, 160)});
    const ExPolygon expolygon(outer.points, hole.points);
    // grown or shrunk: a square ring, its sides 'by' further out
    auto ring = [](const ExPolygons &result, coord_t by) {
        ASSERT_EQ(result.size(), 1u);
        ASSERT_EQ(result[0].holes.size(), 1u);
        const BoundingBox contour {result[0].contour.bounding_box()}, inner {result[0].holes[0].bounding_box()};
        EXPECT_EQ(contour.min, Point(100 - by, 100 - by));
        EXPECT_EQ(contour.max, Point(200 + by, 200 + by));
        EXPECT_EQ(inner.min, Point(140 + by, 140 + by));
        EXPECT_EQ(inner.max, Point(160 - by, 160 - by));
    };
    // scale 1: the offsets are in the coordinates' own units
    ring(offset_ex(Polygons{outer, hole}, 5, 1), 5);
    ring(offset2_ex(Polygons{outer, hole}, 5, -2, 1), 3);

    const ExPolygon large(Points{Point(20000000, 20000000), Point(0, 20000000), Point(0, 0), Point(20000000, 0)},
        Points{Point(5000000, 15000000), Point(15000000, 15000000), Point(15000000, 5000000), Point(5000000, 5000000)});
    const ExPolygons reopened {offset2_ex(to_polygons(large), -1, +1, 1)};
    EXPECT_EQ(reopened.at(0).area(), large.area());

    Polygon filled(hole);
    filled.reverse();
    EXPECT_EQ(diff_ex(Polygons{outer}, Polygons{filled}).at(0).area(), expolygon.area());

    Polyline across;
    across.points = {Point(50, 150), Point(300, 150)};
    const Polylines inside {intersection_pl(Polylines{across}, Polygons{outer, hole})};
    ASSERT_EQ(inside.size(), 2u);
    for (const auto &line : inside) EXPECT_EQ(line.length(), 40);
    Polylines outside {diff_pl(Polylines{across}, Polygons{outer, hole})};
    ASSERT_EQ(outside.size(), 3u);
    std::vector<double> lengths;
    for (const auto &line : outside) lengths.push_back(line.length());
    std::sort(lengths.begin(), lengths.end());
    EXPECT_EQ(lengths, std::vector<double>({20, 50, 100}));

    // old Clipper bugs (upstream issue 2028 and Clipper 96, 122, 126)
    Polyline comb;
    comb.points = {Point(44735000, 31936670), Point(55270000, 31936670), Point(55270000, 25270000), Point(74730000, 25270000),
        Point(74730000, 44730000), Point(68063296, 44730000), Point(68063296, 55270000), Point(74730000, 55270000),
        Point(74730000, 74730000), Point(55270000, 74730000), Point(55270000, 68063296), Point(44730000, 68063296),
        Point(44730000, 74730000), Point(25270000, 74730000), Point(25270000, 55270000), Point(31936670, 55270000),
        Point(31936670, 44730000), Point(25270000, 44730000), Point(25270000, 25270000), Point(44730000, 25270000),
        Point(44730000, 31936670)};
    const Polygon corner_box(Points{Point(75200000, 45200000), Point(54800000, 45200000), Point(54800000, 24800000), Point(75200000, 24800000)});
    ASSERT_EQ(intersection_pl(Polylines{comb}, Polygons{corner_box}).size(), 1u);

    Polyline loop;
    loop.points = {Point(1975, 1975), Point(25, 1975), Point(25, 25), Point(1975, 25), Point(1975, 1975)};
    const Polylines clipped {intersection_pl(Polylines{loop}, Polygons{
        Polygon(Points{Point(2025, 2025), Point(-25, 2025), Point(-25, -25), Point(2025, -25)}),
        Polygon(Points{Point(525, 525), Point(525, 1475), Point(1475, 1475), Point(1475, 525)})})};
    ASSERT_EQ(clipped.size(), 1u);
    ASSERT_EQ(clipped[0].points.size(), 5u);

    Polyline whole;
    whole.points = {Point(200000, 19799999), Point(200000, 200000), Point(24304692, 200000), Point(15102879, 17506106),
        Point(13883200, 19799999), Point(200000, 19799999)};
    const Polylines kept {intersection_pl(Polylines{whole}, Polygons{Polygon(Points{Point(15257205, 18493894),
        Point(14350057, 20200000), Point(-200000, 20200000), Point(-200000, -200000), Point(25196917, -200000)})})};
    ASSERT_EQ(kept.size(), 1u);
    EXPECT_APPROX(kept[0].length(), whole.length());
}

TEST(Primitives, HullDirectionsArrangingBoxes) {
    ASSERT_EQ(Geometry::convex_hull(Points{Point(100, 100), Point(100, 200), Point(200, 200), Point(200, 100), Point(150, 150)})
        .points.size(), 4u);
    EXPECT_TRUE(Geometry::directions_parallel(0, 0, 0));
    EXPECT_TRUE(Geometry::directions_parallel(0, PI, 0));
    EXPECT_TRUE(Geometry::directions_parallel(0, 0, PI / 180));
    EXPECT_TRUE(Geometry::directions_parallel(0, PI, PI / 180));
    EXPECT_FALSE(Geometry::directions_parallel(PI / 2, PI, 0));
    EXPECT_FALSE(Geometry::directions_parallel(PI / 2, PI, PI / 180));
    Pointfs positions;
    EXPECT_TRUE(Geometry::arrange(4, Pointf(20, 20), 5, nullptr, positions));
    ASSERT_EQ(positions.size(), 4u);

    const BoundingBox box(Points{Point(100, 200), Point(500, -600)});
    EXPECT_EQ(box.min, Point(100, -600));
    EXPECT_EQ(box.max, Point(500, 200));
    BoundingBox one;
    one.merge(Point(10, 10));
    EXPECT_EQ(one.min, Point(10, 10));
    EXPECT_EQ(one.max, Point(10, 10));
}

TEST(Primitives, ChainsPolylines) {
    auto polyline = [](const Points &points) { Polyline p; p.points = points; return p; };
    const Polylines vertical {polyline({Point(0, 15), Point(0, 18), Point(0, 20)}), polyline({Point(0, 10), Point(0, 8), Point(0, 5)})};
    const Polylines horizontal {polyline({Point(15, 0), Point(10, 0), Point(4, 0)}), polyline({Point(10, 5), Point(15, 5), Point(20, 5)})};
    EXPECT_EQ(ys(PolylineCollection::chained_path_from(vertical, Point(0, 30))), std::vector<coord_t>({20, 18, 15, 10, 8, 5}));
    EXPECT_EQ(ys(PolylineCollection::chained_path(vertical)), std::vector<coord_t>({15, 18, 20, 10, 8, 5}));
    EXPECT_EQ(xs(PolylineCollection::chained_path_from(horizontal, Point(30, 0))), std::vector<coord_t>({20, 15, 10, 15, 10, 4}));

}
