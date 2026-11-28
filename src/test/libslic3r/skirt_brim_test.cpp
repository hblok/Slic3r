// From test_skirt_brim.cpp.
#include <gtest/gtest.h>

#include <cmath>
#include <regex>
#include <sstream>
#include <string>
#include <vector>

#include "test_data.hpp"
#include "GCodeReader.hpp"
#include "Config.hpp"
#include "Geometry.hpp"

using namespace Slic3r::Test;
using namespace Slic3r;

/// equal within the tolerance Catch's Approx used
#define EXPECT_APPROX(value, expected) EXPECT_NEAR(value, expected, 1.2e-5 * std::abs(expected))
[[maybe_unused]] bool approximately(double a, double b, double margin = -1) {
    return std::abs(a - b) <= (margin < 0 ? 1.2e-5 * std::abs(b) : margin);
}

/// Helper method to find the tool used for the brim (always the first extrusion)
int get_brim_tool(std::stringstream& gcode, Slic3r::GCodeReader& parser) {
    int brim_tool = -1;
    std::regex tool_regex("^T(\\d+)");
    std::smatch m;
    int tool = -1;

    parser.parse_stream(gcode, [&tool, &brim_tool, &m, tool_regex] (Slic3r::GCodeReader& self, const Slic3r::GCodeReader::GCodeLine& line)
        {
            // if the command is a T command, set the the current tool
            if (std::regex_match(line.cmd, m, tool_regex)) {
                tool = std::stoi(m[1].str());
            } else if (line.cmd == "G1" && line.extruding() && line.dist_XY() > 0 && brim_tool < 0) {
                brim_tool = tool;
                }
        });

    return brim_tool;
}

// Skirt height is honored; printing a single object
TEST(SkirtBrim, PrintingASingleObject) {
    auto config {Config::new_from_defaults()};
    config->set("skirts", 1);
    config->set("skirt_height", 5);
    config->set("perimeters", 0);
    config->set("support_material_speed", 99);

    // avoid altering speeds unexpectedly
    config->set("cooling", false);
    config->set("first_layer_speed", "100%");
    auto support_speed = config->get<ConfigOptionFloat>("support_material_speed") * MM_PER_MIN;

    std::map<double, bool> layers_with_skirt;
    auto gcode {std::stringstream("")};
    gcode.clear();
    auto parser {Slic3r::GCodeReader()};
    Slic3r::Model model;
    {  // section: printing a single object
        auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
        Slic3r::Test::gcode(gcode, print);
    }
    parser.parse_stream(gcode, [&layers_with_skirt, &support_speed] (Slic3r::GCodeReader& self, const Slic3r::GCodeReader::GCodeLine& line)
    {
        if (line.extruding() && approximately(self.F, support_speed)) {
            layers_with_skirt[self.Z] = 1;
        }
    });

    ASSERT_EQ(layers_with_skirt.size(), (size_t)config->getInt("skirt_height"));
}

// Skirt height is honored; printing multiple objects
TEST(SkirtBrim, PrintingMultipleObjects) {
    auto config {Config::new_from_defaults()};
    config->set("skirts", 1);
    config->set("skirt_height", 5);
    config->set("perimeters", 0);
    config->set("support_material_speed", 99);

    // avoid altering speeds unexpectedly
    config->set("cooling", false);
    config->set("first_layer_speed", "100%");
    auto support_speed = config->get<ConfigOptionFloat>("support_material_speed") * MM_PER_MIN;

    std::map<double, bool> layers_with_skirt;
    auto gcode {std::stringstream("")};
    gcode.clear();
    auto parser {Slic3r::GCodeReader()};
    Slic3r::Model model;
    {  // section: printing multiple objects
        auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20, TestMesh::cube_20x20x20}, model, config)};
        Slic3r::Test::gcode(gcode, print);
    }
    parser.parse_stream(gcode, [&layers_with_skirt, &support_speed] (Slic3r::GCodeReader& self, const Slic3r::GCodeReader::GCodeLine& line)
    {
        if (line.extruding() && approximately(self.F, support_speed)) {
            layers_with_skirt[self.Z] = 1;
        }
    });

    ASSERT_EQ(layers_with_skirt.size(), (size_t)config->getInt("skirt_height"));
}

// Original Slic3r Skirt/Brim tests; A default configuration; Brim width is set to 5
TEST(SkirtBrim, BrimWidthIsSetTo5) {
    auto parser {Slic3r::GCodeReader()};
    Slic3r::Model model;
    auto gcode {std::stringstream("")};
    gcode.clear();
    {  // given: A default configuration
        auto config {Config::new_from_defaults()};
        config->set("support_material_speed", 99);
        config->set("first_layer_height", 0.3);
        config->set("gcode_comments", true);

        // avoid altering speeds unexpectedly
        config->set("cooling", false);
        config->set("first_layer_speed", "100%");
        // remove noise from top/solid layers
        config->set("top_solid_layers", 0);
        config->set("bottom_solid_layers", 1);
        {  // when: Brim width is set to 5
            config->set("perimeters", 0);
            config->set("skirts", 0);
            config->set("brim_width", 5);
            {  // then: Brim is generated
                auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
                Slic3r::Test::gcode(gcode, print);
                bool brim_generated = false;
                auto support_speed = config->get<ConfigOptionFloat>("support_material_speed") * MM_PER_MIN;
                parser.parse_stream(gcode, [&brim_generated, support_speed] (Slic3r::GCodeReader& self, const Slic3r::GCodeReader::GCodeLine& line)
                    {
                        if (approximately(self.Z, 0.3) || approximately(line.new_Z(), 0.3)) {
                            if (line.extruding() && approximately(self.F, support_speed)) {
                                brim_generated = true;
                            }
                        }
                    });
                EXPECT_TRUE(brim_generated);
            }
        }
    }
}

// Original Slic3r Skirt/Brim tests; A default configuration; Skirt area is smaller than the brim
TEST(SkirtBrim, SkirtAreaIsSmallerThanTheBrim) {
    auto parser {Slic3r::GCodeReader()};
    Slic3r::Model model;
    auto gcode {std::stringstream("")};
    gcode.clear();
    {  // given: A default configuration
        auto config {Config::new_from_defaults()};
        config->set("support_material_speed", 99);
        config->set("first_layer_height", 0.3);
        config->set("gcode_comments", true);

        // avoid altering speeds unexpectedly
        config->set("cooling", false);
        config->set("first_layer_speed", "100%");
        // remove noise from top/solid layers
        config->set("top_solid_layers", 0);
        config->set("bottom_solid_layers", 1);
        {  // when: Skirt area is smaller than the brim
            config->set("skirts", 1);
            config->set("brim_width", 10);
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            {  // then: Gcode generates
                Slic3r::Test::gcode(gcode, print);
                auto exported {gcode.str()};
                EXPECT_GT(exported.size(), 0u);
            }
        }
    }
}

// Original Slic3r Skirt/Brim tests; A default configuration; Skirt height is 0 and skirts > 0
TEST(SkirtBrim, SkirtHeightIs0AndSkirts0) {
    auto parser {Slic3r::GCodeReader()};
    Slic3r::Model model;
    auto gcode {std::stringstream("")};
    gcode.clear();
    {  // given: A default configuration
        auto config {Config::new_from_defaults()};
        config->set("support_material_speed", 99);
        config->set("first_layer_height", 0.3);
        config->set("gcode_comments", true);

        // avoid altering speeds unexpectedly
        config->set("cooling", false);
        config->set("first_layer_speed", "100%");
        // remove noise from top/solid layers
        config->set("top_solid_layers", 0);
        config->set("bottom_solid_layers", 1);
        {  // when: Skirt height is 0 and skirts > 0
            config->set("skirts", 2);
            config->set("skirt_height", 0);

            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            {  // then: Gcode generates
                Slic3r::Test::gcode(gcode, print);
                auto exported {gcode.str()};
                EXPECT_GT(exported.size(), 0u);
            }
        }
    }
}

// Original Slic3r Skirt/Brim tests; A default configuration; Perimeter extruder = 2 and support extruders = 3
TEST(SkirtBrim, PerimeterExtruder2AndSupportExtruders3) {
    auto parser {Slic3r::GCodeReader()};
    Slic3r::Model model;
    auto gcode {std::stringstream("")};
    gcode.clear();
    {  // given: A default configuration
        auto config {Config::new_from_defaults()};
        config->set("support_material_speed", 99);
        config->set("first_layer_height", 0.3);
        config->set("gcode_comments", true);

        // avoid altering speeds unexpectedly
        config->set("cooling", false);
        config->set("first_layer_speed", "100%");
        // remove noise from top/solid layers
        config->set("top_solid_layers", 0);
        config->set("bottom_solid_layers", 1);
        {  // when: Perimeter extruder = 2 and support extruders = 3
            config->set("skirts", 0);
            config->set("brim_width", 5);
            config->set("perimeter_extruder", 2);
            config->set("support_material_extruder", 3);
            {  // then: Brim is printed with the extruder used for the perimeters of first object
                auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
                Slic3r::Test::gcode(gcode, print);
                int tool = get_brim_tool(gcode, parser);
                EXPECT_EQ(tool, config->getInt("perimeter_extruder") - 1);
            }
        }
    }
}

// Original Slic3r Skirt/Brim tests; A default configuration; Perimeter extruder = 2, support extruders = 3, raft is enabled
TEST(SkirtBrim, PerimeterExtruder2SupportExtruders3RaftIsEnabled) {
    auto parser {Slic3r::GCodeReader()};
    Slic3r::Model model;
    auto gcode {std::stringstream("")};
    gcode.clear();
    {  // given: A default configuration
        auto config {Config::new_from_defaults()};
        config->set("support_material_speed", 99);
        config->set("first_layer_height", 0.3);
        config->set("gcode_comments", true);

        // avoid altering speeds unexpectedly
        config->set("cooling", false);
        config->set("first_layer_speed", "100%");
        // remove noise from top/solid layers
        config->set("top_solid_layers", 0);
        config->set("bottom_solid_layers", 1);
        {  // when: Perimeter extruder = 2, support extruders = 3, raft is enabled
            config->set("skirts", 0);
            config->set("brim_width", 5);
            config->set("perimeter_extruder", 2);
            config->set("support_material_extruder", 3);
            config->set("raft_layers", 1);
            {  // then: brim is printed with same extruder as skirt
                auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
                Slic3r::Test::gcode(gcode, print);
                int tool = get_brim_tool(gcode, parser);
                EXPECT_EQ(tool, config->getInt("support_material_extruder") - 1);
            }
        }
    }
}

// Original Slic3r Skirt/Brim tests; A default configuration; brim width to 1 with layer_width of 0.5
TEST(SkirtBrim, BrimWidthTo1WithLayerWidthOf05) {
    auto parser {Slic3r::GCodeReader()};
    Slic3r::Model model;
    auto gcode {std::stringstream("")};
    gcode.clear();
    {  // given: A default configuration
        auto config {Config::new_from_defaults()};
        config->set("support_material_speed", 99);
        config->set("first_layer_height", 0.3);
        config->set("gcode_comments", true);

        // avoid altering speeds unexpectedly
        config->set("cooling", false);
        config->set("first_layer_speed", "100%");
        // remove noise from top/solid layers
        config->set("top_solid_layers", 0);
        config->set("bottom_solid_layers", 1);
        {  // when: brim width to 1 with layer_width of 0.5
            config->set("skirts", 0);
            config->set("first_layer_extrusion_width", 0.5);
            config->set("brim_width", 1);
            config->set("brim_ears", false);
            {  // then: 2 brim lines
                Slic3r::Model model;
                auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
                print->process();
                ASSERT_EQ(print->brim.size(), 2u);
            }
        }
    }
}

// Original Slic3r Skirt/Brim tests; A default configuration; brim ears on a square
TEST(SkirtBrim, BrimEarsOnASquare) {
    auto parser {Slic3r::GCodeReader()};
    Slic3r::Model model;
    auto gcode {std::stringstream("")};
    gcode.clear();
    {  // given: A default configuration
        auto config {Config::new_from_defaults()};
        config->set("support_material_speed", 99);
        config->set("first_layer_height", 0.3);
        config->set("gcode_comments", true);

        // avoid altering speeds unexpectedly
        config->set("cooling", false);
        config->set("first_layer_speed", "100%");
        // remove noise from top/solid layers
        config->set("top_solid_layers", 0);
        config->set("bottom_solid_layers", 1);
        {  // when: brim ears on a square
            config->set("skirts", 0);
            config->set("first_layer_extrusion_width", 0.5);
            config->set("brim_width", 1);
            config->set("brim_ears", true);
            config->set("brim_ears_max_angle", 91);

            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            print->process();
            {  // then: Four brim ears
                ASSERT_EQ(print->brim.size(), 4u);
            }
        }
    }
}

// Original Slic3r Skirt/Brim tests; A default configuration; brim ears on a square but with a too small max angle
TEST(SkirtBrim, BrimEarsOnASquareButWithATooSmallMaxAngle) {
    auto parser {Slic3r::GCodeReader()};
    Slic3r::Model model;
    auto gcode {std::stringstream("")};
    gcode.clear();
    {  // given: A default configuration
        auto config {Config::new_from_defaults()};
        config->set("support_material_speed", 99);
        config->set("first_layer_height", 0.3);
        config->set("gcode_comments", true);

        // avoid altering speeds unexpectedly
        config->set("cooling", false);
        config->set("first_layer_speed", "100%");
        // remove noise from top/solid layers
        config->set("top_solid_layers", 0);
        config->set("bottom_solid_layers", 1);
        {  // when: brim ears on a square but with a too small max angle
            config->set("skirts", 0);
            config->set("first_layer_extrusion_width", 0.5);
            config->set("brim_width", 1);
            config->set("brim_ears", true);
            config->set("brim_ears_max_angle", 89);
            {  // then: no brim
                Slic3r::Model model;
                auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
                print->process();
                ASSERT_EQ(print->brim.size(), 0u);
            }
        }
    }
}

// Original Slic3r Skirt/Brim tests; A default configuration; Object is plated with overhang support and a brim
TEST(SkirtBrim, ObjectIsPlatedWithOverhangSupportAndABrim) {
    auto parser {Slic3r::GCodeReader()};
    Slic3r::Model model;
    auto gcode {std::stringstream("")};
    gcode.clear();
    {  // given: A default configuration
        auto config {Config::new_from_defaults()};
        config->set("support_material_speed", 99);
        config->set("first_layer_height", 0.3);
        config->set("gcode_comments", true);

        // avoid altering speeds unexpectedly
        config->set("cooling", false);
        config->set("first_layer_speed", "100%");
        // remove noise from top/solid layers
        config->set("top_solid_layers", 0);
        config->set("bottom_solid_layers", 1);
        {  // when: Object is plated with overhang support and a brim
            config->set("layer_height", 0.4);
            config->set("first_layer_height", 0.4);
            config->set("skirts", 1);
            config->set("skirt_distance", 0);
            config->set("support_material_speed", 99);
            config->set("perimeter_extruder", 1);
            config->set("support_material_extruder", 2);
            config->set("cooling", false);                     // to prevent speeds to be altered
            config->set("first_layer_speed", "100%");      // to prevent speeds to be altered

            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::overhang}, model, config)};
            print->process();

            // as in t/skirt_brim.t: enable support after the skirt has been generated
            config->set("support_material", true);
            print->apply_config(config);
            {  // then: skirt length is large enough to contain object with support
                double skirt_length = 0.0;
                Points extrusion_points;
                int tool = -1;
                std::regex tool_regex("^T(\\d+)");
                std::smatch m;

                Slic3r::Test::gcode(gcode, print);

                auto support_speed = config->get<ConfigOptionFloat>("support_material_speed") * MM_PER_MIN;
                parser.parse_stream(gcode, [tool_regex, &m, config, &extrusion_points, &tool, &skirt_length, support_speed] (Slic3r::GCodeReader& self, const Slic3r::GCodeReader::GCodeLine& line)
                    {
                        if (std::regex_match(line.cmd, m, tool_regex)) {
                            tool = std::stoi(m[1].str());
                        } else if (approximately(self.Z, config->get<ConfigOptionFloat>("first_layer_height").value)) {
                            // on first layer
                            if (line.extruding() && line.dist_XY() > 0) {
                                const double speed = line.new_F();  // as Perl: this line's F, else the current one
                                if (approximately(speed, support_speed) && tool == config->getInt("perimeter_extruder") - 1) {
                                    // Skirt uses first material extruder, support material speed.
                                    skirt_length += line.dist_XY();
                                } else {
                                    extrusion_points.push_back(Slic3r::Point::new_scale(line.new_X(), line.new_Y()));
                                }
                            }
                        }
                    });
                auto convex_hull = Slic3r::Geometry::convex_hull(extrusion_points);
                auto hull_perimeter = unscale(convex_hull.split_at_first_point().length());
                EXPECT_GT(skirt_length, hull_perimeter);
            }
        }
    }
}

// Original Slic3r Skirt/Brim tests; A default configuration; Large minimum skirt length is used.
TEST(SkirtBrim, LargeMinimumSkirtLengthIsUsed) {
    auto parser {Slic3r::GCodeReader()};
    Slic3r::Model model;
    auto gcode {std::stringstream("")};
    gcode.clear();
    {  // given: A default configuration
        auto config {Config::new_from_defaults()};
        config->set("support_material_speed", 99);
        config->set("first_layer_height", 0.3);
        config->set("gcode_comments", true);

        // avoid altering speeds unexpectedly
        config->set("cooling", false);
        config->set("first_layer_speed", "100%");
        // remove noise from top/solid layers
        config->set("top_solid_layers", 0);
        config->set("bottom_solid_layers", 1);
        {  // when: Large minimum skirt length is used.
            config->set("min_skirt_length", 20);
            auto gcode {std::stringstream("")};
            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            {  // then: Gcode generation doesn't crash
                Slic3r::Test::gcode(gcode, print);
                auto exported {gcode.str()};
                EXPECT_GT(exported.size(), 0u);
            }
        }
    }
}
