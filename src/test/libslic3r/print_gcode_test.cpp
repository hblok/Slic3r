// From test_printgcode.cpp.
#include <gtest/gtest.h>

#include <cmath>
#include <regex>
#include <sstream>
#include <string>
#include <vector>

#include "test_data.hpp"
#include "libslic3r.h"
#include "GCodeReader.hpp"

using namespace Slic3r::Test;
using namespace Slic3r;

/// equal within the tolerance Catch's Approx used
#define EXPECT_APPROX(value, expected) EXPECT_NEAR(value, expected, 1.2e-5 * std::abs(expected))
[[maybe_unused]] bool approximately(double a, double b, double margin = -1) {
    return std::abs(a - b) <= (margin < 0 ? 1.2e-5 * std::abs(b) : margin);
}

/// the files the tests read (data of the test target)
const std::string testfile_dir {"src/test/inputs/"};
std::string testfile(const std::string& name) { return testfile_dir + name; }

std::regex perimeters_regex("G1 X[-0-9.]* Y[-0-9.]* E[-0-9.]* ; perimeter");
std::regex infill_regex("G1 X[-0-9.]* Y[-0-9.]* E[-0-9.]* ; infill");
std::regex skirt_regex("G1 X[-0-9.]* Y[-0-9.]* E[-0-9.]* ; skirt");

// PrintGCode basic functionality; A default configuration and a print test object; the output is executed with no support material
TEST(PrintGCode, TheOutputIsExecutedWithNoSupportMaterial) {
    {  // given: A default configuration and a print test object
        auto config {Slic3r::Config::new_from_defaults()};
        auto gcode {std::stringstream("")};
        {  // when: the output is executed with no support material
            config->set("first_layer_extrusion_width", 0);
            config->set("gcode_comments", true);
            config->set("start_gcode", "");
            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            print->process();
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            {  // then: Some text output is generated.
                EXPECT_GT(exported.size(), 0u);
            }
            {  // then: Exported text contains slic3r version
                EXPECT_NE(exported.find(SLIC3R_VERSION), std::string::npos);
            }
            {  // then: Exported text contains git commit id
                EXPECT_NE(exported.find("; Git Commit"), std::string::npos);
                EXPECT_NE(exported.find(BUILD_COMMIT), std::string::npos);
            }
            {  // then: Exported text contains extrusion statistics.
                EXPECT_NE(exported.find("; external perimeters extrusion width"), std::string::npos);
                EXPECT_NE(exported.find("; perimeters extrusion width"), std::string::npos);
                EXPECT_NE(exported.find("; infill extrusion width"), std::string::npos);
                EXPECT_NE(exported.find("; solid infill extrusion width"), std::string::npos);
                EXPECT_NE(exported.find("; top solid infill extrusion width"), std::string::npos);
                EXPECT_EQ(exported.find("; support material extrusion width"), std::string::npos);
                EXPECT_EQ(exported.find("; first layer extrusion width"), std::string::npos);
            }
            {  // then: Exported text does not contain cooling markers (they were consumed)
                EXPECT_EQ(exported.find(";_EXTRUDE_SET_SPEED"), std::string::npos);
            }
            {  // then: GCode preamble is emitted.
                EXPECT_NE(exported.find("G21 ; set units to millimeters"), std::string::npos);
            }
            {  // then: Config options emitted for print config, default region config, default object config
                EXPECT_NE(exported.find("; first_layer_temperature"), std::string::npos);
                EXPECT_NE(exported.find("; layer_height"), std::string::npos);
                EXPECT_NE(exported.find("; fill_density"), std::string::npos);
            }
            {  // then: Infill is emitted.
                std::smatch has_match;
                EXPECT_TRUE(std::regex_search(exported, has_match, infill_regex));
            }
            {  // then: Perimeters are emitted.
                std::smatch has_match;
                EXPECT_TRUE(std::regex_search(exported, has_match, perimeters_regex));
            }
            {  // then: Skirt is emitted.
                std::smatch has_match;
                EXPECT_TRUE(std::regex_search(exported, has_match, skirt_regex));
            }
            {  // then: final Z height is ~20mm
                double final_z {0.0};
                auto reader {GCodeReader()};
                reader.apply_config(print->config);
                reader.parse(exported, [&final_z] (GCodeReader& self, const GCodeReader::GCodeLine& line)
                {
                    final_z = std::max(final_z, static_cast<double>(self.Z)); // record the highest Z point we reach
                });
                EXPECT_APPROX(final_z, 20.15);
            }
        }
        gcode.clear();
    }
}

// PrintGCode basic functionality; A default configuration and a print test object; output is executed with complete objects and two differently-sized meshes
TEST(PrintGCode, OutputIsExecutedWithCompleteObjectsAndTwoDifferentlySizedMeshes) {
    {  // given: A default configuration and a print test object
        auto config {Slic3r::Config::new_from_defaults()};
        auto gcode {std::stringstream("")};
        {  // when: output is executed with complete objects and two differently-sized meshes
            Slic3r::Model model;
            config->set("first_layer_extrusion_width", 0);
            config->set("first_layer_height", 0.3);
            config->set("support_material", false);
            config->set("raft_layers", 0);
            config->set("complete_objects", true);
            config->set("gcode_comments", true);
            config->set("between_objects_gcode", "; between-object-gcode");
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20, TestMesh::ipadstand}, model, config)};
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            {  // then: Some text output is generated.
                EXPECT_GT(exported.size(), 0u);
            }
            {  // then: Infill is emitted.
                std::smatch has_match;
                EXPECT_TRUE(std::regex_search(exported, has_match, infill_regex));
            }
            {  // then: Perimeters are emitted.
                std::smatch has_match;
                EXPECT_TRUE(std::regex_search(exported, has_match, perimeters_regex));
            }
            {  // then: Skirt is emitted.
                std::smatch has_match;
                EXPECT_TRUE(std::regex_search(exported, has_match, skirt_regex));
            }
            {  // then: Between-object-gcode is emitted.
                EXPECT_NE(exported.find("; between-object-gcode"), std::string::npos);
            }
            {  // then: final Z height is ~27mm
                double final_z {0.0};
                auto reader {GCodeReader()};
                reader.apply_config(print->config);
                reader.parse(exported, [&final_z] (GCodeReader& self, const GCodeReader::GCodeLine& line)
                {
                    final_z = std::max(final_z, static_cast<double>(self.Z)); // record the highest Z point we reach
                });
                EXPECT_NEAR(final_z, 30, 0.1); // close enough
            }
            {  // then: Z height resets on object change
                double final_z {0.0};
                bool reset {false};
                auto reader {GCodeReader()};
                reader.apply_config(print->config);
                reader.parse(exported, [&final_z, &reset] (GCodeReader& self, const GCodeReader::GCodeLine& line)
                {
                    if (final_z > 0 && std::abs(self.Z - 0.3) < 0.01 ) { // saw higher Z before this, now it's lower
                        reset = true;
                    } else {
                        final_z = std::max(final_z, static_cast<double>(self.Z)); // record the highest Z point we reach
                    }
                });
                EXPECT_EQ(reset, true);
            }
            {  // then: Shorter object is printed before taller object.
                double final_z {0.0};
                bool reset {false};
                auto reader {GCodeReader()};
                reader.apply_config(print->config);
                reader.parse(exported, [&final_z, &reset] (GCodeReader& self, const GCodeReader::GCodeLine& line)
                {
                    if (final_z > 0 && std::abs(self.Z - 0.3) < 0.01 ) {
                        reset = (final_z > 20.0);
                    } else {
                        final_z = std::max(final_z, static_cast<double>(self.Z)); // record the highest Z point we reach
                    }
                });
                EXPECT_EQ(reset, true);
            }
        }
        gcode.clear();
    }
}

// PrintGCode basic functionality; A default configuration and a print test object; complete objects, and the shorter object has the larger priority number
TEST(PrintGCode, CompleteObjectsAndTheShorterObjectHasTheLargerPriorityNumber) {
    {  // given: A default configuration and a print test object
        auto config {Slic3r::Config::new_from_defaults()};
        auto gcode {std::stringstream("")};
        {  // when: complete objects, and the shorter object has the larger priority number
            Slic3r::Model model;
            config->set("first_layer_height", 0.3);
            config->set("complete_objects", true);
            config->set("between_objects_gcode", "; between-object-gcode");
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20, TestMesh::ipadstand}, model, config)};
            for (auto* object : print->objects)
                if (object->size.z < scale_(25)) object->config.sequential_print_priority.value = 1;
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            {  // then: The taller object is printed first.
                const auto between {exported.find("; between-object-gcode\n")};
                EXPECT_NE(between, std::string::npos);
                double first_height {0.0};
                auto reader {GCodeReader()};
                reader.apply_config(print->config);
                reader.parse(exported.substr(0, between), [&first_height] (GCodeReader& self, const GCodeReader::GCodeLine&)
                {
                    first_height = std::max(first_height, static_cast<double>(self.Z));
                });
                EXPECT_GT(first_height, 25.0);
            }
        }
        gcode.clear();
    }
}

// PrintGCode basic functionality; A default configuration and a print test object; the output is executed with support material
TEST(PrintGCode, TheOutputIsExecutedWithSupportMaterial) {
    {  // given: A default configuration and a print test object
        auto config {Slic3r::Config::new_from_defaults()};
        auto gcode {std::stringstream("")};
        {  // when: the output is executed with support material
            Slic3r::Model model;
            config->set("first_layer_extrusion_width", 0);
            config->set("support_material", true);
            config->set("raft_layers", 3);
            config->set("gcode_comments", true);
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            {  // then: Some text output is generated.
                EXPECT_GT(exported.size(), 0u);
            }
            {  // then: Exported text contains extrusion statistics.
                EXPECT_NE(exported.find("; external perimeters extrusion width"), std::string::npos);
                EXPECT_NE(exported.find("; perimeters extrusion width"), std::string::npos);
                EXPECT_NE(exported.find("; infill extrusion width"), std::string::npos);
                EXPECT_NE(exported.find("; solid infill extrusion width"), std::string::npos);
                EXPECT_NE(exported.find("; top solid infill extrusion width"), std::string::npos);
                EXPECT_NE(exported.find("; support material extrusion width"), std::string::npos);
                EXPECT_EQ(exported.find("; first layer extrusion width"), std::string::npos);
            }
            {  // then: Raft is emitted.
                EXPECT_NE(exported.find("; raft"), std::string::npos);
            }
        }
        gcode.clear();
    }
}

// PrintGCode basic functionality; A default configuration and a print test object; the output is executed with a separate first layer extrusion width
TEST(PrintGCode, TheOutputIsExecutedWithASeparateFirstLayerExtrusionWidth) {
    {  // given: A default configuration and a print test object
        auto config {Slic3r::Config::new_from_defaults()};
        auto gcode {std::stringstream("")};
        {  // when: the output is executed with a separate first layer extrusion width
            Slic3r::Model model;
            config->set("first_layer_extrusion_width", 0.5);
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            {  // then: Some text output is generated.
                EXPECT_GT(exported.size(), 0u);
            }
            {  // then: Exported text contains extrusion statistics.
                EXPECT_NE(exported.find("; external perimeters extrusion width"), std::string::npos);
                EXPECT_NE(exported.find("; perimeters extrusion width"), std::string::npos);
                EXPECT_NE(exported.find("; infill extrusion width"), std::string::npos);
                EXPECT_NE(exported.find("; solid infill extrusion width"), std::string::npos);
                EXPECT_NE(exported.find("; top solid infill extrusion width"), std::string::npos);
                EXPECT_EQ(exported.find("; support material extrusion width"), std::string::npos);
                EXPECT_NE(exported.find("; first layer extrusion width"), std::string::npos);
            }
        }
        gcode.clear();
    }
}

// PrintGCode basic functionality; A default configuration and a print test object; Cooling is enabled and the fan is disabled.
TEST(PrintGCode, CoolingIsEnabledAndTheFanIsDisabled) {
    {  // given: A default configuration and a print test object
        auto config {Slic3r::Config::new_from_defaults()};
        auto gcode {std::stringstream("")};
        {  // when: Cooling is enabled and the fan is disabled.
            config->set("cooling", true);
            config->set("disable_fan_first_layers", 5);
            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            {  // then: GCode to disable fan is emitted.
                EXPECT_NE(exported.find("M107"), std::string::npos);
            }
        }
        gcode.clear();
    }
}

// PrintGCode basic functionality; A default configuration and a print test object; a bed temperature is set and the start and end gcode do not set it
TEST(PrintGCode, ABedTemperatureIsSetAndTheStartAndEndGcodeDoNotSetIt) {
    {  // given: A default configuration and a print test object
        auto config {Slic3r::Config::new_from_defaults()};
        auto gcode {std::stringstream("")};
        {  // when: a bed temperature is set and the start and end gcode do not set it
            config->set("first_layer_bed_temperature", 60);
            config->set("bed_temperature", 60);
            config->set("start_gcode", "G28");
            config->set("end_gcode", "M84");
            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            {  // then: the bed is heated before the start gcode and switched off after the end gcode
                EXPECT_NE(exported.find("M190 S60"), std::string::npos);
                EXPECT_LT(exported.find("M190 S60"), exported.find("G28"));
                EXPECT_NE(exported.find("M140 S0"), std::string::npos);
                EXPECT_GT(exported.find("M140 S0"), exported.find("M84"));
            }
        }
        gcode.clear();
    }
}

// PrintGCode basic functionality; A default configuration and a print test object; the start and end gcode set the bed temperature themselves
TEST(PrintGCode, TheStartAndEndGcodeSetTheBedTemperatureThemselves) {
    {  // given: A default configuration and a print test object
        auto config {Slic3r::Config::new_from_defaults()};
        auto gcode {std::stringstream("")};
        {  // when: the start and end gcode set the bed temperature themselves
            config->set("first_layer_bed_temperature", 60);
            config->set("bed_temperature", 60);
            config->set("start_gcode", "M190 S55");
            config->set("end_gcode", "M140 S0 ; own");
            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            {  // then: no bed temperature commands are added
                EXPECT_EQ(exported.find("M190 S60"), std::string::npos);
                EXPECT_EQ(exported.find("M140 S0 ; set bed temperature"), std::string::npos);
            }
        }
        gcode.clear();
    }
}

// PrintGCode basic functionality; A default configuration and a print test object; two objects come from the same input file
TEST(PrintGCode, TwoObjectsComeFromTheSameInputFile) {
    {  // given: A default configuration and a print test object
        auto config {Slic3r::Config::new_from_defaults()};
        auto gcode {std::stringstream("")};
        {  // when: two objects come from the same input file
            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20, TestMesh::cube_20x20x20}, model, config)};
            for (auto* object : model.objects) object->input_file = testfile("test_cli/20mmbox.stl");
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            {  // then: the file is named once, with its size and CRC-32
                const auto first = exported.find("; input_file = ");
                EXPECT_NE(first, std::string::npos);
                EXPECT_EQ(exported.find("; input_file = ", first + 1), std::string::npos);
                EXPECT_NE(exported.find("20mmbox.stl\n; input_file_size = 3053\n; input_file_crc32 = af1f8c2f\n"), std::string::npos);
            }
        }
        gcode.clear();
    }
}

// PrintGCode basic functionality; A default configuration and a print test object; end_gcode exists with layer_num and layer_z
TEST(PrintGCode, EndGcodeExistsWithLayerNumAndLayerZ) {
    {  // given: A default configuration and a print test object
        auto config {Slic3r::Config::new_from_defaults()};
        auto gcode {std::stringstream("")};
        {  // when: end_gcode exists with layer_num and layer_z
            config->set("end_gcode", "; Layer_num [layer_num]\n; Layer_z [layer_z]");
            config->set("layer_height", 0.1);
            config->set("first_layer_height", 0.1);

            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            Slic3r::Test::gcode(gcode, print);

            auto exported {gcode.str()};
            {  // then: layer_num and layer_z are processed in the end gcode
                \
                                EXPECT_NE(exported.find("; Layer_num 199"), std::string::npos);
                                EXPECT_NE(exported.find("; Layer_z 20"), std::string::npos);
            }
        }
        gcode.clear();
    }
}

// PrintGCode basic functionality; A default configuration and a print test object; current_extruder exists in start_gcode
TEST(PrintGCode, CurrentExtruderExistsInStartGcode) {
    {  // given: A default configuration and a print test object
        auto config {Slic3r::Config::new_from_defaults()};
        auto gcode {std::stringstream("")};
        {  // when: current_extruder exists in start_gcode
            config->set("start_gcode", "; Extruder [current_extruder]");
            {
                Slic3r::Model model;
                auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
                Slic3r::Test::gcode(gcode, print);
                auto exported {gcode.str()};
                /* then: current_extruder is processed in the start gcode and set for first extruder */ {
                    EXPECT_NE(exported.find("; Extruder 0"), std::string::npos);
                }
            }
            config->set("solid_infill_extruder", 2);
            config->set("support_material_extruder", 2);
            config->set("infill_extruder", 2);
            config->set("perimeter_extruder", 2);
            {
                Slic3r::Model model;
                auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
                Slic3r::Test::gcode(gcode, print);
                auto exported {gcode.str()};
                /* then: current_extruder is processed in the start gcode and set for second extruder */ {
                    EXPECT_NE(exported.find("; Extruder 1"), std::string::npos);
                }
            }
        }
        gcode.clear();
    }
}

// PrintGCode basic functionality; A default configuration and a print test object; layer_num counts the layer changes (as t/custom_gcode.t)
TEST(PrintGCode, LayerNumCountsTheLayerChangesAsTCustomGcodeT) {
    {  // given: A default configuration and a print test object
        auto config {Slic3r::Config::new_from_defaults()};
        auto gcode {std::stringstream("")};
        {  // when: layer_num counts the layer changes (as t/custom_gcode.t)
            config->set("layer_gcode", ";Layer:[layer_num] ([layer_z] mm)");
            config->set("layer_height", 1.0);
            config->set("first_layer_height", 1.0);

            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20,TestMesh::cube_20x20x20}, model, config)};
            Slic3r::Test::gcode(gcode, print);

            std::vector<int> layer_nums;
            std::string line;
            std::istringstream lines(gcode.str());
            while (std::getline(lines, line))
                if (line.rfind(";Layer:", 0) == 0) layer_nums.push_back(std::stoi(line.substr(7)));
            {  // then: it grows by one per layer change, two objects per height
                // layer height is capped at the 0.5 mm nozzle: 39 layers per cube
                ASSERT_EQ(layer_nums.size(), 2 * 39);
                for (size_t i = 0; i < layer_nums.size(); ++i)
                    EXPECT_EQ(layer_nums[i], int(i));
                EXPECT_NE(gcode.str().find(";Layer:77 (20 mm)"), std::string::npos);
            }
        }
        gcode.clear();
    }
}
