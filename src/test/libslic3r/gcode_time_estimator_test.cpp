// From test_gcode.cpp.
#include <gtest/gtest.h>

#include <cmath>
#include <string>

#include "GCodeTimeEstimator.hpp"

using namespace Slic3r;

namespace {
const std::string move {"G1 X100 F3000\n"};  // 100 mm at 50 mm/s
} // namespace

TEST(GCodeTimeEstimator, WritesHoursMinutesAndSeconds) {
    EXPECT_EQ(GCodeTimeEstimator::format_time(59.6), "1m 0s");
    EXPECT_EQ(GCodeTimeEstimator::format_time(3725), "1h 2m 5s");
    EXPECT_EQ(GCodeTimeEstimator::format_time(7), "7s");
}

TEST(GCodeTimeEstimator, TakesLongerWithLessAcceleration) {
    GCodeTimeEstimator slow(500), fast(9000);
    slow.parse(move);
    fast.parse(move);
    EXPECT_NEAR(fast.time, 2.0, 0.1);  // the distance over the speed, and a little
    EXPECT_GT(slow.time, fast.time);
}

TEST(GCodeTimeEstimator, FollowsTheAccelerationSetInTheGcode) {
    GCodeTimeEstimator told(500), fast(9000);
    told.parse("M204 S9000\n" + move);
    fast.parse(move);
    EXPECT_NEAR(told.time, fast.time, 1.2e-5 * std::abs(fast.time));
}
