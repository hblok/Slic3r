// The bridge angles of test_toolpaths.cpp.
#include <gtest/gtest.h>

#include <array>
#include <cmath>
#include <initializer_list>
#include <utility>

#include "BridgeDetector.hpp"
#include "ExPolygonCollection.hpp"
#include "Geometry.hpp"

using namespace Slic3r;

/// equal within the tolerance Catch's Approx used
#define EXPECT_APPROX(value, expected) EXPECT_NEAR(value, expected, 1.2e-5 * std::abs(expected))

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

void check_bridge(const ExPolygons &lower, const ExPolygon &bridge, double expected, double tolerance = -1,
        double coverage = -1, coord_t width = scale_(0.5)) {
    BridgeDetector detector(bridge, ExPolygonCollection(lower), width);
    if (tolerance < 0) tolerance = Geometry::rad2deg(detector.resolution) + 1e-4;
    ASSERT_TRUE(detector.detect_angle());
    double covered {0};
    for (const auto &polygon : detector.coverage()) covered += polygon.area();
    EXPECT_APPROX(covered, coverage < 0 ? bridge.area() : coverage);
    double delta {Geometry::rad2deg(detector.angle) - expected};
    if (delta >= 180 - 1e-4) delta -= 180;
    EXPECT_GE(detector.angle, 0);
    EXPECT_LT(std::abs(delta), tolerance);
}

} // namespace

TEST(BridgeDetector, AnglesAndCoverage) {
    // a ring below: the hole is the bridge
    for (const auto &ring : {std::array<double, 4>{{20, 10, 0, 90}}, std::array<double, 4>{{10, 20, 0, 0}},
            std::array<double, 4>{{20, 10, 45, 135}}, std::array<double, 4>{{20, 10, 135, 45}}}) {
        const double x {ring[0]}, y {ring[1]}, turn {ring[2]};
        ExPolygon lower(scaled({{-2, -2}, {x + 2, -2}, {x + 2, y + 2}, {-2, y + 2}}));
        lower.holes.push_back(scaled({{0, 0}, {0, y}, {x, y}, {x, 0}}));
        lower.translate(scale_(20), scale_(20));
        lower.rotate(Geometry::deg2rad(turn), Point(x / 2, y / 2));
        Polygon hole {lower.holes.front()};
        hole.reverse();
        check_bridge({lower}, ExPolygon(hole), ring[3], turn == 0 ? -1 : 20);
    }
    {
        ExPolygon bridge(scaled({{0, 0}, {20, 0}, {20, 10}, {0, 10}}));
        ExPolygon side(scaled({{-2, 0}, {0, 0}, {0, 10}, {-2, 10}}));
        bridge.translate(scale_(20), scale_(20));
        side.translate(scale_(20), scale_(20));
        ExPolygon other(side);
        other.translate(scale_(22), 0);
        check_bridge({side, other}, bridge, 0);
    }
    {
        ExPolygon bridge(scaled({{0, 0}, {20, 0}, {10, 10}, {0, 10}}));
        ExPolygon lower(scaled({{0, 0}, {0, 10}, {10, 10}, {10, 12}, {-2, 12}, {-2, -2}, {22, -2}, {22, 0}}));
        bridge.translate(scale_(20), scale_(20));
        lower.translate(scale_(20), scale_(20));
        check_bridge({lower}, bridge, 135);
    }
    {
        ExPolygon bridge(scaled({{10, 10}, {20, 10}, {20, 20}, {10, 20}}));
        ExPolygon lower(scaled({{10, 10}, {10, 20}, {20, 20}, {20, 30}, {0, 30}, {0, 10}}));
        bridge.translate(scale_(20), scale_(20));
        lower.translate(scale_(20), scale_(20));
        check_bridge({lower}, bridge, 45, -1, bridge.area() / 2);
    }
    {  // upstream issue 2477
        const ExPolygon bridge(raw({{30299990, 14299990}, {1500010, 14299990}, {1500010, 1500010}, {30299990, 1500010}}));
        ExPolygon lower(raw({{31800000, 15800000}, {0, 15800000}, {0, 0}, {31800000, 0}}));
        lower.holes.push_back(raw({{1499999, 1500000}, {1499999, 14300000}, {30300000, 14300000}, {30300000, 1500000}}));
        check_bridge({lower}, bridge, 90, -1, bridge.area(), 500000);
    }
}
