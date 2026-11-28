#include <gtest/gtest.h>

#include "Extruder.hpp"
#include "PrintConfig.hpp"

using namespace Slic3r;

namespace {

GCodeConfig configuration(bool relative) {
    GCodeConfig config;
    config.set_defaults();
    config.use_relative_e_distances.value = relative;
    config.filament_diameter.values = {2.0};
    config.extrusion_multiplier.values = {1.0};
    return config;
}

} // namespace

TEST(Extruder, CountsTheFilamentUsed) {
    GCodeConfig config {configuration(false)};
    Extruder extruder(0, &config);
    extruder.extrude(10);
    extruder.extrude(5);
    EXPECT_DOUBLE_EQ(extruder.E, 15);
    EXPECT_DOUBLE_EQ(extruder.used_filament(), 15);
    EXPECT_NEAR(extruder.extruded_volume(), 15 * PI, 1e-9);  // 2 mm filament: pi mm3 per mm
    EXPECT_NEAR(extruder.e_per_mm(PI), 1, 1e-9);
}

TEST(Extruder, RetractsOnceAndGivesItBack) {
    GCodeConfig config {configuration(false)};
    Extruder extruder(0, &config);
    extruder.extrude(10);
    EXPECT_DOUBLE_EQ(extruder.retract(2, 0.5), 2);
    EXPECT_DOUBLE_EQ(extruder.retract(2, 0.5), 0);  // already retracted that far
    EXPECT_DOUBLE_EQ(extruder.E, 8);
    EXPECT_DOUBLE_EQ(extruder.used_filament(), 10);
    EXPECT_DOUBLE_EQ(extruder.unretract(), 2.5);  // with the extra
    EXPECT_DOUBLE_EQ(extruder.E, 10.5);
}

TEST(Extruder, StartsFromZeroForEachMoveWithRelativeDistances) {
    GCodeConfig config {configuration(true)};
    Extruder extruder(0, &config);
    extruder.extrude(10);
    extruder.extrude(5);
    EXPECT_DOUBLE_EQ(extruder.E, 5);
    EXPECT_DOUBLE_EQ(extruder.used_filament(), 15);
}
