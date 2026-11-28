// The option types themselves; what the print options make of them is in
// print_config_test.cpp.
#include <gtest/gtest.h>

#include <string>
#include <vector>

#include "ConfigBase.hpp"

using namespace Slic3r;

TEST(ConfigBase, ReadsAndWritesANumber) {
    ConfigOptionFloat option;
    ASSERT_TRUE(option.deserialize("0.35"));
    EXPECT_DOUBLE_EQ(option.value, 0.35);
    EXPECT_EQ(option.serialize(), "0.35");
    EXPECT_FALSE(option.deserialize("thick"));
}

TEST(ConfigBase, TellsAPercentageFromAValue) {
    ConfigOptionFloatOrPercent option;
    ASSERT_TRUE(option.deserialize("50%"));
    EXPECT_TRUE(option.percent);
    EXPECT_DOUBLE_EQ(option.get_abs_value(0.3), 0.15);
    EXPECT_THROW(option.getFloat(), BadOptionTypeException);
    ASSERT_TRUE(option.deserialize("50"));
    EXPECT_FALSE(option.percent);
    EXPECT_DOUBLE_EQ(option.get_abs_value(0.3), 50);
}

TEST(ConfigBase, GivesTheFirstValueBeyondTheEndOfAList) {
    ConfigOptionBools option;
    ASSERT_TRUE(option.deserialize("0,1,1"));
    EXPECT_TRUE(option.get_at(1));
    EXPECT_FALSE(option.get_at(9));
}

TEST(ConfigBase, QuotesStringsWhereNeeded) {
    ConfigOptionStrings written, read;
    written.values = {"plain", "two words;and a semicolon", "two\nlines", ""};
    ASSERT_TRUE(read.deserialize(written.serialize()));
    EXPECT_EQ(read.values, written.values);
}
