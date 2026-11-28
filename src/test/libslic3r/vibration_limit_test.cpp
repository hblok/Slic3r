#include <gtest/gtest.h>

#include <string>

#include "PrintConfig.hpp"
#include "VibrationLimit.hpp"

using namespace Slic3r;

namespace {

/// Out, back, out again: 1 mm each way at 6000 mm/min, 10 ms per move.
const std::string shaking {"G1 X1 F6000\nG1 X0\nG1 X1\n"};

std::string limited(double hertz, const std::string& gcode) {
    PrintConfig config;
    config.vibration_limit.value = hertz;
    VibrationLimit limit(config);
    return limit.process(gcode);
}

} // namespace

TEST(VibrationLimit, PausesWhenAnAxisTurnsTooSoon) {
    // 10 Hz: 100 ms between changes of direction, 10 ms have passed
    EXPECT_NE(limited(10, shaking).find("G4 P"), std::string::npos) << limited(10, shaking);
}

TEST(VibrationLimit, LeavesSlowChangesAlone) {
    EXPECT_EQ(limited(1000, shaking), shaking);
}
