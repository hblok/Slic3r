#include <gtest/gtest.h>

#include <string>
#include <vector>

#include "utils.hpp"

// What utils.cpp defines, and some of the helpers in the header. (utils.hpp declares more
// than is defined anywhere.)

TEST(Utils, SplitsAtARegularExpression) {
    EXPECT_EQ(split_at_regex("1,2;3", "[,;]"), (std::vector<std::string>{"1", "2", "3"}));
    EXPECT_EQ(split_at_regex("one", ","), (std::vector<std::string>{"one"}));
}

TEST(Utils, TrimsTrailingZeroes) {
    EXPECT_EQ(trim_zeroes("1.500000"), "1.5");
    EXPECT_EQ(trim_zeroes("2.000000"), "2.0");
    EXPECT_EQ(_trim_zeroes("0.250"), "0.25");
}

TEST(Utils, ConfessLogsWhereItWasCalled) {
    testing::internal::CaptureStderr();  // the log writes to std::clog
    CONFESS("broken");
    const std::string logged {testing::internal::GetCapturedStderr()};
    EXPECT_NE(logged.find("ERR: Error in function"), std::string::npos) << logged;
    EXPECT_NE(logged.find("utils_test.cpp"), std::string::npos) << logged;
    EXPECT_NE(logged.find("broken"), std::string::npos) << logged;
}

TEST(Utils, FormatsDurations) {
    EXPECT_EQ(Slic3r::get_time_dhms(90061), "1d 1h 1m 1s");
    EXPECT_EQ(Slic3r::get_time_dhm(3600), "1h 0m");
    EXPECT_EQ(Slic3r::short_time("1h 59m 30s"), "2h0m");
}

TEST(Utils, WrapsIndices) {
    const std::vector<int> three {10, 20, 30};
    EXPECT_EQ(Slic3r::next_value_modulo(2, three), 10);
    EXPECT_EQ(Slic3r::prev_value_modulo(0, three), 30);
}
