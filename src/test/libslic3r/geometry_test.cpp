// From test_geometry.cpp (without its commented-out cases of functions that only the
// Perl program had).
#include <gtest/gtest.h>

#include <algorithm>
#include <cmath>
#include <vector>

#include "BoundingBox.hpp"
#include "ClipperUtils.hpp"
#include "Geometry.hpp"
#include "Line.hpp"
#include "Point.hpp"
#include "Polygon.hpp"
#include "Polyline.hpp"

using namespace Slic3r;

namespace {

/// Seven points on a half circle of radius 6 around `center`.
Pointfs half_circle(const Pointf& center) {
    Pointfs points {Pointf(6.0, 0), Pointf(5.1961524, 3), Pointf(3, 5.1961524), Pointf(0, 6.0),
        Pointf(3, 5.1961524), Pointf(-5.1961524, 3), Pointf(-6.0, 0)};
    std::transform(points.begin(), points.end(), points.begin(), [center](const Pointf& a) { return a + center; });
    return points;
}

size_t concave(const Polygon& polygon) { return polygon.concave_points(PI * 4 / 3).size(); }
size_t convex(const Polygon& polygon) { return polygon.convex_points(PI * 2 / 3).size(); }

} // namespace

TEST(Geometry, PolygonContainsAPoint) {
    // this failed on Windows (upstream issue 1950)
    const Polygon polygon({Point(207802834, -57084522), Point(196528149, -37556190), Point(173626821, -25420928),
        Point(171285751, -21366123), Point(118673592, -21366123), Point(116332562, -25420928),
        Point(93431208, -37556191), Point(82156517, -57084523), Point(129714478, -84542120),
        Point(160244873, -84542120)});
    EXPECT_TRUE(polygon.contains(Point(95706562, -57294774)));
}

TEST(Geometry, IntersectsLinesWithIntegerCoordinates) {
    const Line horizontal(Point(5, 15), Point(30, 15)), vertical(Point(10, 20), Point(10, 10));
    Point point;
    horizontal.intersection(vertical, &point);
    EXPECT_EQ(point, Point(10, 15));
}

TEST(Geometry, IntersectsLinesWithScaledCoordinates) {
    const Line line1(Point(73.6310778185108 / 0.0000001, 371.74239268924 / 0.0000001),
        Point(73.6310778185108 / 0.0000001, 501.74239268924 / 0.0000001));
    const Line line2(Point(75 / 0.0000001, 437.9853 / 0.0000001), Point(62.7484 / 0.0000001, 440.4223 / 0.0000001));
    Point point;
    EXPECT_TRUE(line1.intersection(line2, &point));
}

TEST(Geometry, MakesTheLinesOfAPolyline) {
    Polyline polyline;
    polyline.points = {Point(0, 0), Point(10, 0), Point(20, 0)};
    const Lines lines {polyline.lines()};
    EXPECT_EQ(lines.at(0).a, Point(0, 0));
    EXPECT_EQ(lines.at(0).b, Point(10, 0));
    EXPECT_EQ(lines.at(1).a, Point(10, 0));
    EXPECT_EQ(lines.at(1).b, Point(20, 0));
}

TEST(Geometry, SplitsAPolygonIntoAPolyline) {
    const Polygon polygon({Point(0, 0), Point(10, 0), Point(5, 5)});
    const Polyline split {polygon.split_at_index(1)};
    ASSERT_EQ(split.points.size(), 4u);
    EXPECT_EQ(split.points[0], Point(10, 0));
    EXPECT_EQ(split.points[1], Point(5, 5));
    EXPECT_EQ(split.points[2], Point(0, 0));
    EXPECT_EQ(split.points[3], Point(10, 0));
}

TEST(Geometry, ScalesABoundingBox) {
    BoundingBox box(std::vector<Point>{Point(0, 1), Point(10, 2), Point(20, 2)});
    box.scale(2);
    EXPECT_EQ(box.min, Point(0, 2));
    EXPECT_EQ(box.max, Point(40, 4));
}

TEST(Geometry, OffsetsALineIntoAPolygon) {
    const Polyline line(Line(Point(10, 10), Point(20, 10)));
    const Polygon area {offset(line, 5).at(0)};
    EXPECT_EQ(area.area(), Polygon({Point(10, 5), Point(20, 5), Point(20, 15), Point(10, 15)}).area());
}

TEST(Geometry, FitsACircleToPointsInMillimetres) {
    // all points, the first four, the middle four
    for (const Pointf& center : {Pointf(-6, 0), Pointf(-3, 9)}) {
        const Pointfs points {half_circle(center)};
        EXPECT_EQ(Geometry::circle_taubin_newton(points), center);
        EXPECT_EQ(Geometry::circle_taubin_newton(points.cbegin(), points.cbegin() + 4), center);
        EXPECT_EQ(Geometry::circle_taubin_newton(points.cbegin() + 2, points.cbegin() + 6), center);
    }
}

TEST(Geometry, FitsACircleToScaledPoints) {
    const Point center {Point::new_scale(-3, 9)};
    Points points {Point::new_scale(6.0, 0), Point::new_scale(5.1961524, 3), Point::new_scale(3, 5.1961524),
        Point::new_scale(0, 6.0), Point::new_scale(3, 5.1961524), Point::new_scale(-5.1961524, 3),
        Point::new_scale(-6.0, 0)};
    std::transform(points.begin(), points.end(), points.begin(), [center](const Point& a) { return a + center; });
    EXPECT_TRUE(Point(Geometry::circle_taubin_newton(points)).coincides_with_epsilon(center));
    EXPECT_TRUE(Point(Geometry::circle_taubin_newton(points.cbegin(), points.cbegin() + 4)).coincides_with_epsilon(center));
    EXPECT_TRUE(Point(Geometry::circle_taubin_newton(points.cbegin() + 2, points.cbegin() + 6)).coincides_with_epsilon(center));
}

TEST(Geometry, ChainsPointsWithoutDiagonals) {
    // a grid of 26 units: every step of a good chain is 26 long
    const std::vector<Point> points {Point(26, 26), Point(52, 26), Point(0, 26), Point(26, 52),
        Point(26, 0), Point(0, 52), Point(52, 52), Point(52, 0)};
    std::vector<Points::size_type> order;
    Geometry::chained_path(points, order);
    ASSERT_EQ(order.size(), points.size());
    for (size_t i = 0; i + 1 < order.size(); ++i)
        EXPECT_NEAR(points.at(order[i]).distance_to(points.at(order[i + 1])), 26, Geometry::epsilon);
}

TEST(Geometry, MeasuresDistancesToALine) {
    const Line line(Point(0, 0), Point(20, 0));
    EXPECT_EQ(Point(0, 0).distance_to(line), 0);
    EXPECT_EQ(Point(20, 0).distance_to(line), 0);
    EXPECT_EQ(Point(10, 0).distance_to(line), 0);
    EXPECT_EQ(Point(10, 10).distance_to(line), 10);
    EXPECT_EQ(Point(50, 0).distance_to(line), 30);
}

TEST(Geometry, FindsTheCornersOfASquare) {
    Polygon square({Point(100, 100), Point(200, 100), Point(200, 200), Point(100, 200)});
    EXPECT_EQ(concave(square), 0u);
    EXPECT_EQ(convex(square), 4u);
    square.make_clockwise();
    EXPECT_EQ(concave(square), 4u);
    EXPECT_EQ(convex(square), 0u);
}

TEST(Geometry, IgnoresACollinearPointOfASquare) {
    for (const Polygon& square : {
            Polygon({Point(150, 100), Point(200, 100), Point(200, 200), Point(100, 200), Point(100, 100)}),
            Polygon({Point(200, 200), Point(100, 200), Point(100, 100), Point(150, 100), Point(200, 100)})}) {
        EXPECT_EQ(concave(square), 0u);
        EXPECT_EQ(convex(square), 4u);
    }
}

TEST(Geometry, FindsTheCornersOfATriangle) {
    const Polygon triangle({Point(16000170, 26257364), Point(714223, 461012), Point(31286371, 461008)});
    EXPECT_EQ(concave(triangle), 0u);
    EXPECT_EQ(convex(triangle), 3u);
    const Polygon with_collinear_point({Point(16000170, 26257364), Point(714223, 461012),
        Point(20000000, 461012), Point(31286371, 461012)});
    EXPECT_EQ(concave(with_collinear_point), 0u);
    EXPECT_EQ(convex(with_collinear_point), 3u);
}

TEST(Geometry, FindsConcaveCornersOfExactlyFourThirdsPi) {
    // two of the concave corners have exactly that angle: this fails without a tolerance
    const Polygon polygon({
        Point(60246458, 14802768), Point(64477191, 12360001), Point(63727343, 11060995), Point(64086449, 10853608),
        Point(66393722, 14850069), Point(66034704, 15057334), Point(65284646, 13758387), Point(61053864, 16200839),
        Point(69200258, 30310849), Point(62172547, 42483120), Point(61137680, 41850279), Point(67799985, 30310848),
        Point(51399866, 1905506), Point(38092663, 1905506), Point(38092663, 692699), Point(52100125, 692699)});
    EXPECT_EQ(concave(polygon), 6u);
    EXPECT_EQ(convex(polygon), 10u);
}

TEST(Geometry, SimplifiesATriangleToNoFewerThanThreePoints) {
    const Polygon triangle({Point(16000170, 26257364), Point(714223, 461012), Point(31286371, 461008)});
    EXPECT_EQ(triangle.simplify(250000).at(0).points.size(), 3u);
}
