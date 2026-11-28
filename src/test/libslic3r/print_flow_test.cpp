// The cases of test_flow.cpp about whole prints.
#include <gtest/gtest.h>

#include <cmath>
#include <numeric>
#include <sstream>
#include <string>
#include <vector>

#include "test_data.hpp"
#include "Config.hpp"
#include "Model.hpp"
#include "ConfigBase.hpp"
#include "GCodeReader.hpp"
#include "Flow.hpp"
#include "libslic3r.h"

using namespace Slic3r::Test;
using namespace Slic3r;

/// equal within the tolerance Catch's Approx used
#define EXPECT_APPROX(value, expected) EXPECT_NEAR(value, expected, 1.2e-5 * std::abs(expected))
[[maybe_unused]] bool approximately(double a, double b, double margin = -1) {
    return std::abs(a - b) <= (margin < 0 ? 1.2e-5 * std::abs(b) : margin);
}

/// Test the expected behavior for auto-width, 
/// spacing, etc


/// Spacing, width calculation for bridge extrusions

// Extrusion width specifics; A config with a skirt, brim, some fill density, 3 perimeters, and 1 bottom solid layer and a 20mm cube mesh; first layer width set to 2mm
TEST(PrintFlow, FirstLayerWidthSetTo2mm) {
    {  // given: A config with a skirt, brim, some fill density, 3 perimeters, and 1 bottom solid layer and a 20mm cube mesh
        // this is a sharedptr
        auto config {Slic3r::Config::new_from_defaults()};
        config->set("skirts", 1);
        config->set("brim_width", 2);
        config->set("perimeters", 3);
        config->set("fill_density", 40);
        config->set("bottom_solid_layers", 1);
        config->set("first_layer_height", "100%");
        {  // when: first layer width set to 2mm
            Slic3r::Model model;
            config->set("first_layer_extrusion_width", 2.0);
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};

            std::vector<double> E_per_mm_bottom;
            auto gcode {std::stringstream("")};
            Slic3r::Test::gcode(gcode, print);
            auto parser {Slic3r::GCodeReader()};
            const auto layer_height { config->getFloat("layer_height") };
            parser.parse_stream(gcode, [&E_per_mm_bottom, layer_height] (Slic3r::GCodeReader& self, const Slic3r::GCodeReader::GCodeLine& line)
            {
                if (approximately(self.Z, layer_height, 0.01)) { // only consider first layer
                    if (line.extruding() && line.dist_XY() > 0) {
                        E_per_mm_bottom.emplace_back(line.dist_E() / line.dist_XY());
                    }
                }
            });
            {  // then:  First layer width applies to everything on first layer.
                EXPECT_GT(E_per_mm_bottom.size(), 0u); // make sure it actually passed because of extrusion
                const double avg_E {std::accumulate(E_per_mm_bottom.cbegin(), E_per_mm_bottom.cend(), 0.0) / E_per_mm_bottom.size()};
                // as Perl: some tolerance because solid rectilinear infill might be adjusted/stretched
                for (const double E : E_per_mm_bottom)
                    EXPECT_NEAR(E, avg_E, 0.015);
            }
        }
    }
}

namespace {

/// The overhang model printed at bridge speed 99: E per mm of every move at that speed.
std::vector<double> bridge_extrusion(const config_ptr& config) {
    Slic3r::Model model;
    auto print {Slic3r::Test::init_print({TestMesh::overhang}, model, config)};
    auto gcode {std::stringstream("")};
    Slic3r::Test::gcode(gcode, print);
    std::vector<double> E_per_mm;
    const double bridge_F {config->getFloat("bridge_speed") * 60};
    Slic3r::GCodeReader().parse_stream(gcode, [&E_per_mm, bridge_F](Slic3r::GCodeReader&, const Slic3r::GCodeReader::GCodeLine& line) {
        if (line.extruding() && line.dist_XY() > 0 && approximately(line.new_F(), bridge_F))
            E_per_mm.push_back(line.dist_E() / line.dist_XY());
    });
    return E_per_mm;
}

} // namespace

TEST(PrintFlow, ExtrudesBridgesAsRoundThreads) {
    for (const double extrusion_width : {0.0, 0.4}) {
        for (const double ratio : {1.0, 0.5, 2.0}) {
            SCOPED_TRACE("extrusion width " + std::to_string(extrusion_width) + ", bridge_flow_ratio " + std::to_string(ratio));
            auto config {Slic3r::Config::new_from_defaults()};
            config->set("bridge_speed", 99);
            config->set("cooling", false);              // to prevent speeds from being altered
            config->set("first_layer_speed", "100%");   // to prevent speeds from being altered
            config->set("extrusion_width", extrusion_width);
            config->set("bridge_flow_ratio", ratio);
            const double nozzle {config->get<ConfigOptionFloats>("nozzle_diameter").values.front()};
            const double filament {config->get<ConfigOptionFloats>("filament_diameter").values.front()};
            const double mm3_per_mm {nozzle * nozzle * PI / 4 * config->getFloat("bridge_flow_ratio")};
            const double expected {mm3_per_mm / ((filament / 2) * (filament / 2) * PI)};
            const std::vector<double> E_per_mm {bridge_extrusion(config)};
            ASSERT_GT(E_per_mm.size(), 0u);
            for (const double E : E_per_mm) EXPECT_NEAR(E, expected, 0.01);
        }
    }
}
