// From test_gcode.cpp and test_gcode_math.cpp.
#include <gtest/gtest.h>

#include "PlaceholderParser.hpp"
#include "PrintConfig.hpp"

using namespace Slic3r;

TEST(PlaceholderParser, KeepsFractionalNumbers) {
    PlaceholderParser parser;
    parser.set("layer_z", 0.2);  // was cut to "0"
    parser.set("count", 3);
    parser.set("extruder", 1u);
    EXPECT_EQ(parser.process("[layer_z] [count] [extruder]"), "0.2 3 1");
}

TEST(PlaceholderParser, PrintsNumbersAsPerlDid) {
    PlaceholderParser parser;
    parser.set("layer_z", 0.30000000000000004);
    EXPECT_EQ(parser.process("[layer_z]"), "0.3");
}

TEST(PlaceholderParser, FillsInTheConfiguration) {
    DynamicPrintConfig config;
    config.set_deserialize("infill_extruder", "2");
    PlaceholderParser parser;
    parser.apply_config(config);
    EXPECT_EQ(parser.process("{if [infill_extruder] == 2}M104 S210"), "{if 2 == 2}M104 S210");
}
