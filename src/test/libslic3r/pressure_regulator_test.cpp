#include <gtest/gtest.h>

#include <string>

#include "PressureRegulator.hpp"
#include "PrintConfig.hpp"

using namespace Slic3r;

namespace {

PrintConfig configuration(double advance) {
    PrintConfig config;
    config.pressure_advance.value = advance;
    return config;
}

} // namespace

TEST(PressureRegulator, PushesExtraBeforePrintingAndTakesItBackBeforeRetracting) {
    const PrintConfig config {configuration(10)};
    PressureRegulator regulator(config);
    const std::string out {regulator.process("G1 X10 E1 F1200\nG1 E-1 F2400\n", false)};
    const size_t advance {out.find("pressure advance")}, print {out.find("G1 X10 E1 F1200")},
        discharge {out.find("pressure discharge")}, retract {out.find("G1 E-1 F2400")};
    ASSERT_NE(advance, std::string::npos) << out;
    ASSERT_NE(discharge, std::string::npos) << out;
    EXPECT_LT(advance, print) << out;
    EXPECT_LT(print, discharge) << out;
    EXPECT_LT(discharge, retract) << out;
}

TEST(PressureRegulator, LeavesTravelMovesAlone) {
    const PrintConfig config {configuration(10)};
    PressureRegulator regulator(config);
    EXPECT_EQ(regulator.process("G1 X10 F3000\nM104 S200\n", false), "G1 X10 F3000\nM104 S200\n");
}
