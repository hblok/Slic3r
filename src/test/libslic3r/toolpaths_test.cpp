// The cases of test_toolpaths.cpp about whole prints.
#include <gtest/gtest.h>

#include <cmath>
#include <map>
#include <regex>
#include <set>
#include <sstream>
#include <string>
#include <vector>

#include "BridgeDetector.hpp"
#include "ExPolygonCollection.hpp"
#include "GCode.hpp"
#include "GCode/CoolingBuffer.hpp"
#include "GCodeReader.hpp"
#include "PlaceholderParser.hpp"
#include "test_data.hpp"

using namespace Slic3r;
using namespace Slic3r::Test;

std::string sliced(std::initializer_list<TestMesh> meshes, config_ptr config) {
    Slic3r::Model model;
    auto print {init_print(meshes, model, config)};
    std::stringstream out;
    Slic3r::Test::gcode(out, print);
    return out.str();
}

bool near(double a, double b) { return std::abs(a - b) < 1e-3; }

std::string retraction_faults(const std::string &gcode, const PrintConfig &config, double layer_height) {
    std::string fault;
    auto fail = [&fault](const char* what, const GCodeReader::GCodeLine &line) {
        if (fault.empty()) fault = std::string(what) + ": " + line.raw;
    };
    int tool {0};
    std::map<int, int> uses;
    std::map<int, bool> retracted {{0, true}};  // the first travel from home is ignored
    std::map<int, double> length;
    bool lifted {false}, changed_tool {false}, waiting {false};
    double lift {0};
    GCodeReader reader;
    reader.parse(gcode, [&](GCodeReader &self, const GCodeReader::GCodeLine &line) {
        const bool move {line.cmd == "G1" || line.cmd == "G0"};
        if (line.cmd.size() > 1 && line.cmd[0] == 'T') {
            tool = std::atoi(line.cmd.c_str() + 1);
            changed_tool = true;
            waiting = false;
            ++uses[tool];
        } else if (move && !line.has('Z') && waiting) {
            fail("toolchange happens right after retraction", line);
        }
        const double dz {move ? line.dist_Z() : 0};
        if (!near(dz, 0)) {
            const double own {config.retract_lift.get_at(tool)};
            if (near(dz, own) || (own > 0 && near(dz, layer_height + own))) {
                if (!retracted[tool]) fail("lifting while not retracted", line);
                if (lifted) fail("double lift", line);
                lifted = true;
                lift = dz;
            }
            if (dz < 0) {
                if (!lifted) fail("going down without a lift", line);
                if (!near(dz, -lift) && !near(dz, -lift + layer_height)) fail("going down by another amount", line);
                lift = 0;
                lifted = false;
            }
            if (!near(line.has('F') ? line.new_F() : self.F, config.travel_speed.value * 60)) fail("Z move not at travel speed", line);
        }
        if (line.retracting()) {
            retracted[tool] = true;
            length[tool] += -line.dist_E();
            if (near(length[tool], config.retract_length.get_at(tool))) {
            } else if (near(length[tool], config.retract_length_toolchange.get_at(tool))) {
                waiting = true;
            } else {
                fail("retracted by another amount", line);
            }
        }
        if (line.extruding()) {
            if (lifted) fail("extruding while lifted", line);
            if (retracted[tool]) {
                double expected {length[tool] + config.retract_restart_extra.get_at(tool)};
                if (changed_tool && uses[tool] > 1) {
                    expected = config.retract_length_toolchange.get_at(tool) + config.retract_restart_extra_toolchange.get_at(tool);
                    changed_tool = false;
                }
                if (!near(line.dist_E(), expected)) fail("unretracted by another amount", line);
                retracted[tool] = false;
                length[tool] = 0;
            }
        }
        if (line.travel() && line.dist_XY() >= config.retract_before_travel.get_at(tool) && !retracted[tool])
            fail("long travel without retraction", line);
    });
    return fault;
}

// Cooling slows short layers and starts the fan
TEST(Toolpaths, CoolingSlowsShortLayersAndStartsTheFan) {
    auto filtered = [](double elapsed, const std::string &gcode) {
        PrintConfig config;
        config.disable_fan_first_layers.value = 0;
        GCode generator;
        generator.apply_print_config(config);
        generator.layer_count = 10;
        CoolingBuffer buffer(generator);
        generator.elapsed_time = elapsed;
        std::string out {buffer.append(gcode, "0", 0, 0.4)};
        return out + buffer.flush();
    };
    const PrintConfig defaults;
    const double slowdown = defaults.slowdown_below_layer_time, fan = defaults.fan_below_layer_time;
    EXPECT_NE(filtered(slowdown + 1, "G1 F3000;_EXTRUDE_SET_SPEED\nG1 X100 E1").find("F3000"), std::string::npos);
    const std::string slowed {filtered(slowdown - 1, "G1 X50 F2500\nG1 F3000;_EXTRUDE_SET_SPEED\nG1 X100 E1\nG1 E4 F400")};
    EXPECT_EQ(slowed.find("F3000"), std::string::npos);
    EXPECT_NE(slowed.find("F2500"), std::string::npos);  // travel moves keep their speed
    EXPECT_NE(slowed.find("F400"), std::string::npos);   // so do moves of the extruder alone
    EXPECT_EQ(filtered(fan + 1, "G1 X100 E1 F3000").find("M106"), std::string::npos);
}

// Cooling: the fan runs at bridge speed only for bridges
TEST(Toolpaths, CoolingTheFanRunsAtBridgeSpeedOnlyForBridges) {
    auto config {Slic3r::Config::new_from_defaults()};
    config->set("cooling", "1");
    config->set("bridge_fan_speed", "100");
    config->set("fan_below_layer_time", "0");
    config->set("slowdown_below_layer_time", "0");
    config->set("bridge_speed", "99");
    config->set("top_solid_layers", "1");
    config->set("bottom_solid_layers", "1");
    config->set("vibration_limit", "30");  // the fan also with another G-code filter
    int fan {0}, wrong_speed {0}, fan_elsewhere {0}, bridge_without {0};
    GCodeReader reader;
    reader.parse(sliced({TestMesh::overhang}, config), [&](GCodeReader &self, const GCodeReader::GCodeLine &line) {
        if (line.cmd == "M106") {
            fan = line.has('S') ? static_cast<int>(line.get_float('S')) : 0;
            if (fan != 255) ++wrong_speed;
        } else if (line.cmd == "M107") {
            fan = 0;
        } else if (line.extruding() && line.dist_XY() > 0) {
            const bool bridge {near(line.has('F') ? line.new_F() : self.F, 99 * 60)};
            if (fan > 0 && !bridge) ++fan_elsewhere;
            if (fan == 0 && bridge) ++bridge_without;
        }
    });
    EXPECT_EQ(wrong_speed, 0);
    EXPECT_EQ(fan_elsewhere, 0);
    EXPECT_EQ(bridge_without, 0);
}

// Retraction and lift through a print
TEST(Toolpaths, RetractionAndLiftThroughAPrint) {
    auto config {Slic3r::Config::new_from_defaults()};
    config->set("first_layer_height", config->config().serialize("layer_height"));
    config->set("first_layer_speed", "100%");
    config->set("start_gcode", "");
    config->set("retract_length", "1.5");
    config->set("retract_before_travel", "3");
    config->set("only_retract_when_crossing_perimeters", "0");
    auto check = [&config](int copies) {
        Slic3r::Model model;
        auto print {copies == 1 ? init_print({TestMesh::cube_20x20x20}, model, config)
            : init_print({TestMesh::cube_20x20x20, TestMesh::cube_20x20x20}, model, config)};
        std::stringstream out;
        Slic3r::Test::gcode(out, print);
        return retraction_faults(out.str(), print->config, config->getFloat("layer_height"));
    };
    auto variants = [&config, &check](int copies) {
        config->set("retract_restart_extra", "0");
        config->set("retract_lift", "0");
        EXPECT_EQ(check(copies), "");
        config->set("retract_restart_extra", "1");
        EXPECT_EQ(check(copies), "");
        config->set("retract_restart_extra", "-1");
        EXPECT_EQ(check(copies), "");
        config->set("retract_lift", "1,2");
        EXPECT_EQ(check(copies), "");
    };
    variants(1);
    variants(2);
    config->set("infill_extruder", "2");
    config->set("skirts", "4");
    config->set("skirt_height", "3");
    variants(1);
}

// No retraction or lift when the length is zero
TEST(Toolpaths, NoRetractionOrLiftWhenTheLengthIsZero) {
    auto config {Slic3r::Config::new_from_defaults()};
    config->set("start_gcode", "");
    config->set("retract_length", "0");
    config->set("retract_layer_change", "0");
    config->set("retract_lift", "0.2");
    int retractions {0}, drops {0};
    GCodeReader reader;
    reader.parse(sliced({TestMesh::cube_20x20x20}, config), [&](GCodeReader &self, const GCodeReader::GCodeLine &line) {
        if (line.retracting()) ++retractions;
        if (line.cmd == "G1" && line.has('Z') && line.new_Z() < self.Z) ++drops;
    });
    EXPECT_EQ(retractions, 0);
    EXPECT_EQ(drops, 0);
}

// Firmware retraction alternates, also with a length of zero
TEST(Toolpaths, FirmwareRetractionAlternatesAlsoWithALengthOfZero) {
    for (const char* length : {"2", "0"}) {
        auto config {Slic3r::Config::new_from_defaults()};
        config->set("use_firmware_retraction", "1");
        config->set("retract_length", length);
        bool retracted {false};
        int count {0}, doubled {0};
        GCodeReader reader;
        reader.parse(sliced({TestMesh::cube_20x20x20}, config), [&](GCodeReader &, const GCodeReader::GCodeLine &line) {
            if (line.cmd == "G10") { doubled += retracted; retracted = true; ++count; }
            if (line.cmd == "G11") { doubled += !retracted; retracted = false; }
        });
        EXPECT_GT(count, 0);
        EXPECT_EQ(doubled, 0);
    }
}

// Custom G-code and its placeholders
TEST(Toolpaths, CustomGCodeAndItsPlaceholders) {
    {
        auto config {Slic3r::Config::new_from_defaults()};
        config->set("start_gcode", "_MY_CUSTOM_START_GCODE_");
        config->set("layer_gcode", "_MY_CUSTOM_LAYER_GCODE_");
        std::istringstream lines(sliced({TestMesh::cube_20x20x20}, config));
        bool rose {false};
        int misplaced {0};
        GCodeReader reader;
        reader.parse_stream(lines, [&](GCodeReader &, const GCodeReader::GCodeLine &line) {
            if (line.cmd.empty()) return;
            if (rose != (line.cmd == "_MY_CUSTOM_LAYER_GCODE_")) ++misplaced;
            rose = line.cmd == "G1" && line.dist_Z() > 0;
        });
        EXPECT_EQ(misplaced, 0);
    }
    {
        auto config {Slic3r::Config::new_from_defaults()};
        PlaceholderParser parser;
        parser.apply_config(config->config());
        parser.set("foo", "0");
        const std::string first {config->config().serialize("temperature")};
        EXPECT_EQ(parser.process("[temperature_[foo]]"), first.substr(0, first.find(',')));
    }
    {
        auto config {Slic3r::Config::new_from_defaults()};
        config->set("output_filename_format", "ts_[travel_speed]_lh_[layer_height].gcode");
        config->set("start_gcode", "TRAVEL:[travel_speed] HEIGHT:[layer_height]\n");
        const std::string travel {config->config().serialize("travel_speed")}, height {config->config().serialize("layer_height")};
        Slic3r::Model model;
        auto print {init_print({TestMesh::cube_20x20x20}, model, config)};
        const std::string name {print->output_filepath("")};
        EXPECT_NE(name.find("ts_" + travel + "_"), std::string::npos);
        EXPECT_NE(name.find("lh_" + height + "."), std::string::npos);
        std::stringstream out;
        Slic3r::Test::gcode(out, print);
        EXPECT_NE(out.str().find("TRAVEL:" + travel), std::string::npos);
        EXPECT_NE(out.str().find("HEIGHT:" + height), std::string::npos);
    }
    {
        auto config {Slic3r::Config::new_from_defaults()};
        config->set("perimeter_extruder", "2");
        config->set("infill_extruder", "2");
        config->set("solid_infill_extruder", "2");
        config->set("support_material_extruder", "2");
        config->set("support_material_interface_extruder", "2");
        config->set("first_layer_temperature", "200,205");
        const std::string single {sliced({TestMesh::cube_20x20x20}, config)};
        EXPECT_NE(single.find("M104 S205 T1"), std::string::npos);
        EXPECT_FALSE(std::regex_search(single, std::regex("M104 S\\d+ T0")));
        config->set("infill_extruder", "1");
        config->set("start_gcode", "\n;__temp0:[first_layer_temperature_0]__\n;__temp1:[first_layer_temperature_1]__\n;__temp2:[first_layer_temperature_2]__\n");
        const std::string both {sliced({TestMesh::cube_20x20x20}, config)};
        EXPECT_NE(both.find("M104 S200 T0"), std::string::npos);
        EXPECT_NE(both.find("M104 S205 T1"), std::string::npos);
        EXPECT_NE(both.find("temp0:200"), std::string::npos);
        EXPECT_NE(both.find("temp1:205"), std::string::npos);
        EXPECT_NE(both.find("temp2:200"), std::string::npos);  // unused extruder: the first value
    }
    {
        auto config {Slic3r::Config::new_from_defaults()};
        config->set("before_layer_gcode", ";BEFORE [layer_num]");
        config->set("layer_gcode", ";CHANGE [layer_num]");
        config->set("support_material", "1");
        config->set("layer_height", "0.2");
        std::istringstream lines(sliced({TestMesh::overhang}, config));
        std::vector<int> before, change;
        const std::regex marker("^;(BEFORE|CHANGE) (\\d+)");
        for (std::string line; std::getline(lines, line); ) {
            std::smatch found;
            if (std::regex_search(line, found, marker)) (found[1] == "BEFORE" ? before : change).push_back(std::stoi(found[2]));
        }
        EXPECT_FALSE(change.empty());
        EXPECT_EQ(before, change);
        for (size_t i = 1; i < change.size(); ++i) EXPECT_EQ(change[i], change[i - 1] + 1);
    }
    {
        auto config {Slic3r::Config::new_from_defaults()};
        config->set("complete_objects", "1");
        config->set("between_objects_gcode", "_MY_CUSTOM_GCODE_");
        const std::string gcode {sliced({TestMesh::cube_20x20x20, TestMesh::cube_20x20x20, TestMesh::cube_20x20x20}, config)};
        const std::regex marker("(^|\n)_MY_CUSTOM_GCODE_");
        EXPECT_EQ(std::distance(std::sregex_iterator(gcode.begin(), gcode.end(), marker), std::sregex_iterator()), 2);
    }
}
