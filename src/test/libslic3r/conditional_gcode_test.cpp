#include <gtest/gtest.h>

#include "ConditionalGCode.hpp"

using namespace Slic3r;

// From test_gcode_math.cpp. Its placeholder and firmware retraction cases need the
// configuration classes and follow with those targets.

TEST(ConditionalGcode, IfDropsTheLineWhenFalse) {
    EXPECT_EQ(apply_math("{if{3 == 4}} string"), "");
    EXPECT_EQ(apply_math("{if{3 == 4}} string\notherstring"), "otherstring");
}

TEST(ConditionalGcode, IfKeepsTheLineWhenTrue) {
    EXPECT_EQ(apply_math("{if{3 == 3}} string"), " string");
    EXPECT_EQ(apply_math("{if 3 > 2} string"), " string");
    EXPECT_EQ(apply_math("{if{3 == 3}}string"), "string");
}

TEST(ConditionalGcode, EvaluatesExpressions) {
    EXPECT_EQ(apply_math("M104 S{4*5}; Sets temp to {4*5}"), "M104 S20; Sets temp to 20");
}

TEST(ConditionalGcode, KeepsEscapedAndUnknownBraces) {
    EXPECT_EQ(apply_math("M104 S\\{a\\}; Sets temp to {4*5}"), "M104 S{a}; Sets temp to 20");
    EXPECT_EQ(apply_math("M104 S{a}; Sets temp to {4*5}"), "M104 S{a}; Sets temp to 20");
}
