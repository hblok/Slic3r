// The thin-wall centre lines of test_toolpaths.cpp.
#include <gtest/gtest.h>

#include <cmath>
#include <initializer_list>
#include <utility>

#include "ExPolygon.hpp"
#include "Polygon.hpp"
#include "Polyline.hpp"

using namespace Slic3r;

namespace {

Polygon scaled(std::initializer_list<std::pair<double, double>> points) {
    Polygon polygon;
    for (const auto &p : points) polygon.points.push_back(Point::new_scale(p.first, p.second));
    return polygon;
}

Polygon raw(std::initializer_list<std::pair<coord_t, coord_t>> points) {
    Polygon polygon;
    for (const auto &p : points) polygon.points.push_back(Point(p.first, p.second));
    return polygon;
}

Polylines axis(const ExPolygon &expolygon, double max_width, double min_width) {
    Polylines polylines;
    expolygon.medial_axis(max_width, min_width, &polylines);
    return polylines;
}

} // namespace

TEST(MedialAxis, OfThinAreas) {
    {
        ExPolygon square(scaled({{100, 100}, {200, 100}, {200, 200}, {100, 200}}));
        square.holes.push_back(scaled({{140, 140}, {140, 160}, {160, 160}, {160, 140}}));
        const Polylines lines {axis(square, scale_(40), scale_(0.5))};
        ASSERT_EQ(lines.size(), 1u);
        EXPECT_EQ(lines[0].first_point(), lines[0].last_point());
        EXPECT_GT(lines[0].length(), scale_(80));
        EXPECT_LT(lines[0].length(), scale_(400));
    }
    {
        const ExPolygon rectangle(scaled({{100, 100}, {120, 100}, {120, 200}, {100, 200}}));
        const Polylines lines {axis(rectangle, scale_(20), scale_(0.5))};
        ASSERT_EQ(lines.size(), 1u);
        EXPECT_GE(unscale(lines[0].length()), 80 - 1e-4);
    }
    {
        const ExPolygon trapezoid(scaled({{100, 100}, {120, 100}, {112, 200}, {108, 200}}));
        const Polylines lines {axis(trapezoid, scale_(20), scale_(0.5))};
        ASSERT_EQ(lines.size(), 1u);
        EXPECT_GE(unscale(lines[0].length()), 80 - 1e-4);
    }
    {
        const ExPolygon corner(scaled({{100, 100}, {120, 100}, {120, 180}, {200, 180}, {200, 200}, {100, 200}}));
        const Polylines lines {axis(corner, scale_(20), scale_(0.5))};
        ASSERT_EQ(lines.size(), 1u);
        const double length {unscale(lines[0].length()) + 20};  // the ends are 20 mm short
        EXPECT_GT(length, 160);
        EXPECT_LT(length, 200);
    }
    {
        const ExPolygon triangle(scaled({{50, 100}, {1000, 102}, {50, 104}}));
        const Polylines lines {axis(triangle, scale_(4), scale_(0.5))};
        ASSERT_EQ(lines.size(), 1u);
        EXPECT_GE(unscale(lines[0].length()), 80 - 1e-4);
    }
    {  // upstream issue 2474
        const ExPolygon sliver(raw({{91294454, 31032190}, {11294481, 31032190}, {11294481, 29967810}, {44969182, 29967810}, {89909960, 29967808}, {91294454, 29967808}}));
        Polylines lines {axis(sliver, 1871238, 500000)};
        ASSERT_EQ(lines.size(), 1u);
        Polyline &line {lines[0]};
        double y {0};
        for (const auto &p : line.points) y += p.y;
        EXPECT_LT(std::abs(y / line.points.size() - sliver.contour.bounding_box().center().y), SCALED_EPSILON);
        if (line.first_point().x > line.last_point().x) line.reverse();
        for (size_t i = 1; i < line.points.size(); ++i) EXPECT_LE(line.points[i - 1].x, line.points[i].x);
    }
}
