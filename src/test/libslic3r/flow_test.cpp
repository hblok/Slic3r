// The flow mathematics of test_flow.cpp, and the solid spacing case of test_fill.cpp; the
// cases about whole prints follow with the slicing core.
#include <gtest/gtest.h>

#include <cmath>

#include "Flow.hpp"

using namespace Slic3r;

/// equal within the tolerance Catch's Approx used
#define EXPECT_APPROX(value, expected) EXPECT_NEAR(value, expected, 1.2e-5 * std::abs(expected))

namespace {

constexpr float nozzle {0.4}, layer {0.5};
const ConfigOptionFloatOrPercent automatic(0, false), one_millimetre(1.0, false);

Flow flow_for(FlowRole role, const ConfigOptionFloatOrPercent& width, float nozzle_diameter = nozzle,
        float layer_height = layer, float bridge_flow_ratio = 0) {
    return Flow::new_from_config_width(role, width, nozzle_diameter, layer_height, bridge_flow_ratio);
}

} // namespace

TEST(Flow, SpacesExternalPerimetersAtAFixedFactorOfTheNozzle) {
    EXPECT_APPROX(flow_for(frExternalPerimeter, automatic).spacing(), (1.1 * nozzle) - layer * (1.0 - PI / 4.0));
}

TEST(Flow, SpacesInternalPerimetersAtTheMinimum) {
    EXPECT_APPROX(flow_for(frPerimeter, automatic).spacing(), (1.05 * nozzle) - layer * (1.0 - PI / 4.0));
}

TEST(Flow, SpacesAGivenWidth) {
    for (const FlowRole role : {frExternalPerimeter, frPerimeter})
        EXPECT_APPROX(flow_for(role, one_millimetre).spacing(), one_millimetre.value - layer * (1.0 - PI / 4.0));
}

TEST(Flow, HasAMaximumAndAMinimumWidth) {
    EXPECT_APPROX(flow_for(frPerimeter, automatic, 0.25, 0.15f).width, 1.4 * 0.25);
    EXPECT_APPROX(flow_for(frPerimeter, automatic, 0.25, 0.3f).width, 1.05 * 0.25);
}

TEST(Flow, KeepsSolidSpacingAboveZero) {
    // upstream issue 4654
    EXPECT_GT(Flow::new_from_spacing(1.0, 0.4, 0.3, false).solid_spacing(2.0, 0.414159), 0);
}

TEST(Flow, AdjustsTheSpacingToFillAWidthExactly) {
    const int width {250}, spacing {Flow::solid_spacing(width, 47)};
    EXPECT_APPROX(spacing, 50);
    EXPECT_EQ(width % spacing, 0);
}

TEST(Flow, BridgesWithAThreadAsWideAsTheNozzle) {
    for (const FlowRole role : {frExternalPerimeter, frInfill, frPerimeter, frSupportMaterial}) {
        const Flow flow {flow_for(role, one_millimetre, nozzle, layer, 1.0)};
        EXPECT_APPROX(flow.width, nozzle);
        EXPECT_APPROX(flow.spacing(), nozzle + BRIDGE_EXTRA_SPACING);
    }
}
