#include <catch.hpp>

#include <regex>
#include "test_data.hpp"
#include <test_options.hpp>
#include "libslic3r.h"
#include "GCodeReader.hpp"

using namespace Slic3r::Test;
using namespace Slic3r;

std::regex perimeters_regex("G1 X[-0-9.]* Y[-0-9.]* E[-0-9.]* ; perimeter");
std::regex infill_regex("G1 X[-0-9.]* Y[-0-9.]* E[-0-9.]* ; infill");
std::regex skirt_regex("G1 X[-0-9.]* Y[-0-9.]* E[-0-9.]* ; skirt");

SCENARIO( "PrintGCode basic functionality") {
    GIVEN("A default configuration and a print test object") {
        auto config {Slic3r::Config::new_from_defaults()};
        auto gcode {std::stringstream("")};

        WHEN("the output is executed with no support material") {
            config->set("first_layer_extrusion_width", 0);
            config->set("gcode_comments", true);
            config->set("start_gcode", "");
            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            print->process();
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            THEN("Some text output is generated.") {
                REQUIRE(exported.size() > 0);
            }
            THEN("Exported text contains slic3r version") {
                REQUIRE(exported.find(SLIC3R_VERSION) != std::string::npos);
            }
            THEN("Exported text contains git commit id") {
                REQUIRE(exported.find("; Git Commit") != std::string::npos);
                REQUIRE(exported.find(BUILD_COMMIT) != std::string::npos);
            }
            THEN("Exported text contains extrusion statistics.") {
                REQUIRE(exported.find("; external perimeters extrusion width") != std::string::npos);
                REQUIRE(exported.find("; perimeters extrusion width") != std::string::npos);
                REQUIRE(exported.find("; infill extrusion width") != std::string::npos);
                REQUIRE(exported.find("; solid infill extrusion width") != std::string::npos);
                REQUIRE(exported.find("; top solid infill extrusion width") != std::string::npos);
                REQUIRE(exported.find("; support material extrusion width") == std::string::npos);
                REQUIRE(exported.find("; first layer extrusion width") == std::string::npos);
            }
            THEN("Exported text does not contain cooling markers (they were consumed)") {
                REQUIRE(exported.find(";_EXTRUDE_SET_SPEED") == std::string::npos);
            }

            THEN("GCode preamble is emitted.") {
                REQUIRE(exported.find("G21 ; set units to millimeters") != std::string::npos);
            }

            THEN("Config options emitted for print config, default region config, default object config") {
                REQUIRE(exported.find("; first_layer_temperature") != std::string::npos);
                REQUIRE(exported.find("; layer_height") != std::string::npos);
                REQUIRE(exported.find("; fill_density") != std::string::npos);
            }
            THEN("Infill is emitted.") {
                std::smatch has_match;
                REQUIRE(std::regex_search(exported, has_match, infill_regex));
            }
            THEN("Perimeters are emitted.") {
                std::smatch has_match;
                REQUIRE(std::regex_search(exported, has_match, perimeters_regex));
            }
            THEN("Skirt is emitted.") {
                std::smatch has_match;
                REQUIRE(std::regex_search(exported, has_match, skirt_regex));
            }
            THEN("final Z height is ~20mm") {
                double final_z {0.0};
                auto reader {GCodeReader()};
                reader.apply_config(print->config);
                reader.parse(exported, [&final_z] (GCodeReader& self, const GCodeReader::GCodeLine& line) 
                {
                    final_z = std::max(final_z, static_cast<double>(self.Z)); // record the highest Z point we reach
                });
                REQUIRE(final_z == Approx(20.15));
            }
        }
        WHEN("output is executed with complete objects and two differently-sized meshes") {
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
            THEN("Some text output is generated.") {
                REQUIRE(exported.size() > 0);
            }
            THEN("Infill is emitted.") {
                std::smatch has_match;
                REQUIRE(std::regex_search(exported, has_match, infill_regex));
            }
            THEN("Perimeters are emitted.") {
                std::smatch has_match;
                REQUIRE(std::regex_search(exported, has_match, perimeters_regex));
            }
            THEN("Skirt is emitted.") {
                std::smatch has_match;
                REQUIRE(std::regex_search(exported, has_match, skirt_regex));
            }
            THEN("Between-object-gcode is emitted.") {
                REQUIRE(exported.find("; between-object-gcode") != std::string::npos);
            }
            THEN("final Z height is ~27mm") {
                double final_z {0.0};
                auto reader {GCodeReader()};
                reader.apply_config(print->config);
                reader.parse(exported, [&final_z] (GCodeReader& self, const GCodeReader::GCodeLine& line) 
                {
                    final_z = std::max(final_z, static_cast<double>(self.Z)); // record the highest Z point we reach
                });
                REQUIRE(final_z == Approx(30).margin(0.1)); // close enough
            }
            THEN("Z height resets on object change") {
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
                REQUIRE(reset == true);
            }
            THEN("Shorter object is printed before taller object.") {
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
                REQUIRE(reset == true);
            }
        }
        WHEN("the output is executed with support material") {
            Slic3r::Model model;
            config->set("first_layer_extrusion_width", 0);
            config->set("support_material", true);
            config->set("raft_layers", 3);
            config->set("gcode_comments", true);
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            THEN("Some text output is generated.") {
                REQUIRE(exported.size() > 0);
            }
            THEN("Exported text contains extrusion statistics.") {
                REQUIRE(exported.find("; external perimeters extrusion width") != std::string::npos);
                REQUIRE(exported.find("; perimeters extrusion width") != std::string::npos);
                REQUIRE(exported.find("; infill extrusion width") != std::string::npos);
                REQUIRE(exported.find("; solid infill extrusion width") != std::string::npos);
                REQUIRE(exported.find("; top solid infill extrusion width") != std::string::npos);
                REQUIRE(exported.find("; support material extrusion width") != std::string::npos);
                REQUIRE(exported.find("; first layer extrusion width") == std::string::npos);
            }
            THEN("Raft is emitted.") {
                REQUIRE(exported.find("; raft") != std::string::npos);
            }
        }
        WHEN("the output is executed with a separate first layer extrusion width") {
            Slic3r::Model model;
            config->set("first_layer_extrusion_width", 0.5);
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            THEN("Some text output is generated.") {
                REQUIRE(exported.size() > 0);
            }
            THEN("Exported text contains extrusion statistics.") {
                REQUIRE(exported.find("; external perimeters extrusion width") != std::string::npos);
                REQUIRE(exported.find("; perimeters extrusion width") != std::string::npos);
                REQUIRE(exported.find("; infill extrusion width") != std::string::npos);
                REQUIRE(exported.find("; solid infill extrusion width") != std::string::npos);
                REQUIRE(exported.find("; top solid infill extrusion width") != std::string::npos);
                REQUIRE(exported.find("; support material extrusion width") == std::string::npos);
                REQUIRE(exported.find("; first layer extrusion width") != std::string::npos);
            }
        }
        WHEN("Cooling is enabled and the fan is disabled.") {
            config->set("cooling", true);
            config->set("disable_fan_first_layers", 5);
            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            THEN("GCode to disable fan is emitted."){
                REQUIRE(exported.find("M107") != std::string::npos);
            }
        }
        WHEN("a bed temperature is set and the start and end gcode do not set it") {
            config->set("first_layer_bed_temperature", 60);
            config->set("bed_temperature", 60);
            config->set("start_gcode", "G28");
            config->set("end_gcode", "M84");
            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            THEN("the bed is heated before the start gcode and switched off after the end gcode") {
                REQUIRE(exported.find("M190 S60") != std::string::npos);
                REQUIRE(exported.find("M190 S60") < exported.find("G28"));
                REQUIRE(exported.find("M140 S0") != std::string::npos);
                REQUIRE(exported.find("M140 S0") > exported.find("M84"));
            }
        }
        WHEN("the start and end gcode set the bed temperature themselves") {
            config->set("first_layer_bed_temperature", 60);
            config->set("bed_temperature", 60);
            config->set("start_gcode", "M190 S55");
            config->set("end_gcode", "M140 S0 ; own");
            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            THEN("no bed temperature commands are added") {
                REQUIRE(exported.find("M190 S60") == std::string::npos);
                REQUIRE(exported.find("M140 S0 ; set bed temperature") == std::string::npos);
            }
        }
        WHEN("two objects come from the same input file") {
            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20, TestMesh::cube_20x20x20}, model, config)};
            for (auto* object : model.objects) object->input_file = testfile("test_cli/20mmbox.stl");
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};
            THEN("the file is named once, with its size and CRC-32") {
                const auto first = exported.find("; input_file = ");
                REQUIRE(first != std::string::npos);
                REQUIRE(exported.find("; input_file = ", first + 1) == std::string::npos);
                REQUIRE(exported.find("20mmbox.stl\n; input_file_size = 3053\n; input_file_crc32 = af1f8c2f\n") != std::string::npos);
            }
        }
        WHEN("end_gcode exists with layer_num and layer_z") {
            config->set("end_gcode", "; Layer_num [layer_num]\n; Layer_z [layer_z]");
            config->set("layer_height", 0.1);
            config->set("first_layer_height", 0.1);

            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            Slic3r::Test::gcode(gcode, print);

            auto exported {gcode.str()};
            THEN("layer_num and layer_z are processed in the end gcode") {\
                REQUIRE(exported.find("; Layer_num 199") != std::string::npos);
                REQUIRE(exported.find("; Layer_z 20") != std::string::npos);
            }
        }
        WHEN("current_extruder exists in start_gcode") {
            config->set("start_gcode", "; Extruder [current_extruder]");
            {
                Slic3r::Model model;
                auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
                Slic3r::Test::gcode(gcode, print);
                auto exported {gcode.str()};
                THEN("current_extruder is processed in the start gcode and set for first extruder") {
                    REQUIRE(exported.find("; Extruder 0") != std::string::npos);
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
                THEN("current_extruder is processed in the start gcode and set for second extruder") {
                    REQUIRE(exported.find("; Extruder 1") != std::string::npos);
                }
            }
        }

        WHEN("layer_num represents the layer's index from z=0") {
            config->set("layer_gcode", ";Layer:[layer_num] ([layer_z] mm)");
            config->set("layer_height", 1.0);
            config->set("first_layer_height", 1.0);

            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20,TestMesh::cube_20x20x20}, model, config)};
            Slic3r::Test::gcode(gcode, print);

            auto exported {gcode.str()};
            int count = 2;            
            for(int pos = 0; pos != std::string::npos; count--) 
                pos = exported.find(";Layer:38 (20 mm)", pos+1);

            THEN("layer_num and layer_z are processed in the end gcode") {\
                REQUIRE(count == -1);
            }
        }

        gcode.clear();
    }
}
