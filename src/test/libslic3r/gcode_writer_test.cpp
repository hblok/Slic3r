// From test_gcodewriter.cpp, with the firmware retraction case of test_gcode_math.cpp.
#include <gtest/gtest.h>

#include <string>
#include <utility>
#include <vector>

#include "GCodeWriter.hpp"
#include "PrintConfig.hpp"

using namespace Slic3r;

namespace {

/// A writer set up from the test's configuration file, with one extruder.
struct LiftingWriter {
    GCodeWriter writer;
    LiftingWriter() {
        writer.config.set_defaults();
        writer.config.load("src/test/inputs/test_gcodewriter/config_lift_unlift.ini");
        writer.set_extruders(std::vector<unsigned int>{0});
        writer.set_extruder(0);
    }
    /// Lift at `z`, move by as much as the lift, come down again: nothing left to do.
    void lift_move_and_unlift(double z) {
        writer.travel_to_z(z);
        EXPECT_FALSE(writer.lift().empty()) << z;
        EXPECT_EQ(writer.travel_to_z(z + writer.config.retract_lift.values[0]), "") << z;
        EXPECT_EQ(writer.unlift(), "") << z;  // same height: no move
    }
};

} // namespace

TEST(GCodeWriter, LiftsAgainAfterUnlifting) {
    for (const double z : {203.0, 500003.0, 10.3}) {
        LiftingWriter lifting;
        lifting.lift_move_and_unlift(z);
        EXPECT_FALSE(lifting.writer.lift().empty()) << z;
    }
}

TEST(GCodeWriter, DoesNotLiftAgainAtAHugeZ) {
    // a known limit: at 2^53 mm the second lift writes nothing (the Catch test is marked
    // as expected to fail). If this starts to fail, the limit is gone.
    LiftingWriter lifting;
    lifting.lift_move_and_unlift(9007199254740992.0);
    EXPECT_EQ(lifting.writer.lift(), "");
}

TEST(GCodeWriter, WritesSpeedsWithThreeDecimals) {
    GCodeWriter writer;
    EXPECT_EQ(writer.set_speed(1.09321e+06), "G1 F1093210.000\n");
    EXPECT_EQ(writer.set_speed(1.0), "G1 F1.000\n");
    EXPECT_EQ(writer.set_speed(203.200022), "G1 F203.200\n");
    EXPECT_EQ(writer.set_speed(203.200522), "G1 F203.201\n");
}

TEST(GCodeWriter, RetractsByTheFirmware) {
    const std::pair<const char*, const char*> flavors[] {
        {"reprap", "G10 S1 ; retract for toolchange extruder 0"},
        {"repetier", "G10 S1 ; retract for toolchange extruder 0"},
        {"smoothie", "G10 ; retract for toolchange extruder 0"}};
    for (const auto &flavor : flavors) {
        PrintConfig config;
        config.use_firmware_retraction.value = true;
        config.gcode_flavor.deserialize(flavor.first);
        config.gcode_comments.value = true;
        GCodeWriter writer;
        writer.apply_print_config(config);
        writer.set_extruders(std::vector<unsigned int>{0});
        writer.set_extruder(0);
        const std::string gcode {writer.retract_for_toolchange()};
        EXPECT_EQ(gcode.substr(0, gcode.find('\n')), flavor.second);
    }
}
