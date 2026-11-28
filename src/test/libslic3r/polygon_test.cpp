// remove_collinear_points, from test_polygon.cpp; the rest of Polygon is in geometry_test.cpp
// and in test_primitives.cpp (not ported yet).
#include <gtest/gtest.h>

#include "Point.hpp"
#include "Polygon.hpp"

using namespace Slic3r;

TEST(Polygon, RemovesCollinearPoints) {
    Polygon polygon({
        Point::new_scale(0, 0),    // 3 collinear points at the beginning
        Point::new_scale(10, 0),
        Point::new_scale(20, 0),
        Point::new_scale(30, 10),
        Point::new_scale(40, 20),  // 2 collinear points
        Point::new_scale(40, 30),
        Point::new_scale(30, 40),  // 3 collinear points
        Point::new_scale(20, 40),
        Point::new_scale(10, 40),
        Point::new_scale(-10, 20),
        Point::new_scale(-20, 10),
        Point::new_scale(-20, 0),  // 3 collinear points at the end
        Point::new_scale(-10, 0),
        Point::new_scale(-5, 0),
    });
    polygon.remove_collinear_points();
    ASSERT_EQ(polygon.points.size(), 7u);
    EXPECT_EQ(polygon.points.front(), Point::new_scale(20, 0));
    EXPECT_EQ(polygon.points.back(), Point::new_scale(-20, 0));
}
