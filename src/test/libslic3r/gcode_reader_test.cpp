#include <gtest/gtest.h>

#include <string>
#include <vector>

#include "GCodeReader.hpp"
#include "PrintConfig.hpp"

using namespace Slic3r;

TEST(GCodeReader, ReadsCommandsArgumentsAndComments) {
    GCodeReader reader;
    std::vector<std::string> commands;
    reader.parse("G1 X10 Y5.5 F600 ; first\nM104 S200\n", [&](GCodeReader&, const GCodeReader::GCodeLine& line) {
        commands.push_back(line.cmd);
        if (line.cmd == "G1") {
            EXPECT_EQ(line.comment, " first");
            EXPECT_DOUBLE_EQ(line.new_X(), 10);
            EXPECT_DOUBLE_EQ(line.new_Y(), 5.5);
            EXPECT_TRUE(line.travel());
        }
    });
    EXPECT_EQ(commands, (std::vector<std::string>{"G1", "M104"}));
    EXPECT_DOUBLE_EQ(reader.X, 10);
    EXPECT_DOUBLE_EQ(reader.F, 600);
}

TEST(GCodeReader, TellsExtrusionFromRetraction) {
    GCodeReader reader;
    std::string seen;
    reader.parse("G1 X1 E2\nG1 E1\nG92 E0\nG1 X2 E0.5\n", [&](GCodeReader&, const GCodeReader::GCodeLine& line) {
        seen += line.extruding() ? 'e' : line.retracting() ? 'r' : '-';
    });
    EXPECT_EQ(seen, "er-e");
}

TEST(GCodeReader, KnowsAnotherNameForTheExtrusionAxis) {
    PrintConfig config;
    config.extrusion_axis.value = "A";
    GCodeReader reader;
    reader.apply_config(config);
    reader.parse("G1 X1 A2\n", {});
    EXPECT_DOUBLE_EQ(reader.E, 2);
}

TEST(GCodeReader, ChangesAnArgumentOfALine) {
    GCodeReader reader;
    reader.parse("G1 X1 F100\n", [](GCodeReader&, const GCodeReader::GCodeLine& line) {
        GCodeReader::GCodeLine changed {line};
        changed.set('F', "50");
        EXPECT_EQ(changed.raw, "G1 X1 F50");
    });
}
