// Bridge angles, thin-wall centre lines, cooling, retraction and custom G-code: ported
// from the Perl tests (t/bridges.t, thin.t, cooling.t, retraction.t, custom_gcode.t).
#include <catch.hpp>

#include <map>
#include <regex>
#include <set>
#include <sstream>

#include "BridgeDetector.hpp"
#include "ExPolygonCollection.hpp"
#include "GCode.hpp"
#include "GCode/CoolingBuffer.hpp"
#include "GCodeReader.hpp"
#include "PlaceholderParser.hpp"
#include "test_data.hpp"

using namespace Slic3r;
using namespace Slic3r::Test;

namespace {

Polygon scaled(std::initializer_list<std::pair<double, double>> points) {
    Polygon polygon;
    for (const auto &p : points) polygon.points.push_back(Point::new_scale(p.first, p.second));
    return polygon;
}

Polygon raw(std::initializer_list<std::pair<coord_t, coord_t>> points) {
    Polygon polygon;
    for (const auto &p : points) polygon.points.push_back(Point(p.first, p.second));
    return polygon;
}

void check_bridge(const ExPolygons &lower, const ExPolygon &bridge, double expected, double tolerance = -1,
        double coverage = -1, coord_t width = scale_(0.5)) {
    BridgeDetector detector(bridge, ExPolygonCollection(lower), width);
    if (tolerance < 0) tolerance = Geometry::rad2deg(detector.resolution) + 1e-4;
    REQUIRE(detector.detect_angle());
    double covered {0};
    for (const auto &polygon : detector.coverage()) covered += polygon.area();
    REQUIRE(covered == Approx(coverage < 0 ? bridge.area() : coverage));
    double delta {Geometry::rad2deg(detector.angle) - expected};
    if (delta >= 180 - 1e-4) delta -= 180;
    REQUIRE(detector.angle >= 0);
    REQUIRE(std::abs(delta) < tolerance);
}

Polylines axis(const ExPolygon &expolygon, double max_width, double min_width) {
    Polylines polylines;
    expolygon.medial_axis(max_width, min_width, &polylines);
    return polylines;
}

std::string sliced(std::initializer_list<TestMesh> meshes, config_ptr config) {
    Slic3r::Model model;
    auto print {init_print(meshes, model, config)};
    std::stringstream out;
    Slic3r::Test::gcode(out, print);
    return out.str();
}

bool near(double a, double b) { return std::abs(a - b) < 1e-3; }

/// The rules retraction and Z lift must follow through a whole print; returns the first
/// broken one, or nothing.
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

} // namespace

TEST_CASE("Bridge angles and coverage") {
    // a ring below: the hole is the bridge
    for (const auto &ring : {std::array<double, 4>{{20, 10, 0, 90}}, std::array<double, 4>{{10, 20, 0, 0}},
            std::array<double, 4>{{20, 10, 45, 135}}, std::array<double, 4>{{20, 10, 135, 45}}}) {
        const double x {ring[0]}, y {ring[1]}, turn {ring[2]};
        ExPolygon lower(scaled({{-2, -2}, {x + 2, -2}, {x + 2, y + 2}, {-2, y + 2}}));
        lower.holes.push_back(scaled({{0, 0}, {0, y}, {x, y}, {x, 0}}));
        lower.translate(scale_(20), scale_(20));
        lower.rotate(Geometry::deg2rad(turn), Point(x / 2, y / 2));
        Polygon hole {lower.holes.front()};
        hole.reverse();
        check_bridge({lower}, ExPolygon(hole), ring[3], turn == 0 ? -1 : 20);
    }
    {
        ExPolygon bridge(scaled({{0, 0}, {20, 0}, {20, 10}, {0, 10}}));
        ExPolygon side(scaled({{-2, 0}, {0, 0}, {0, 10}, {-2, 10}}));
        bridge.translate(scale_(20), scale_(20));
        side.translate(scale_(20), scale_(20));
        ExPolygon other(side);
        other.translate(scale_(22), 0);
        check_bridge({side, other}, bridge, 0);
    }
    {
        ExPolygon bridge(scaled({{0, 0}, {20, 0}, {10, 10}, {0, 10}}));
        ExPolygon lower(scaled({{0, 0}, {0, 10}, {10, 10}, {10, 12}, {-2, 12}, {-2, -2}, {22, -2}, {22, 0}}));
        bridge.translate(scale_(20), scale_(20));
        lower.translate(scale_(20), scale_(20));
        check_bridge({lower}, bridge, 135);
    }
    {
        ExPolygon bridge(scaled({{10, 10}, {20, 10}, {20, 20}, {10, 20}}));
        ExPolygon lower(scaled({{10, 10}, {10, 20}, {20, 20}, {20, 30}, {0, 30}, {0, 10}}));
        bridge.translate(scale_(20), scale_(20));
        lower.translate(scale_(20), scale_(20));
        check_bridge({lower}, bridge, 45, -1, bridge.area() / 2);
    }
    {  // upstream issue 2477
        const ExPolygon bridge(raw({{30299990, 14299990}, {1500010, 14299990}, {1500010, 1500010}, {30299990, 1500010}}));
        ExPolygon lower(raw({{31800000, 15800000}, {0, 15800000}, {0, 0}, {31800000, 0}}));
        lower.holes.push_back(raw({{1499999, 1500000}, {1499999, 14300000}, {30300000, 14300000}, {30300000, 1500000}}));
        check_bridge({lower}, bridge, 90, -1, bridge.area(), 500000);
    }
}

TEST_CASE("Centre lines of thin areas") {
    {
        ExPolygon square(scaled({{100, 100}, {200, 100}, {200, 200}, {100, 200}}));
        square.holes.push_back(scaled({{140, 140}, {140, 160}, {160, 160}, {160, 140}}));
        const Polylines lines {axis(square, scale_(40), scale_(0.5))};
        REQUIRE(lines.size() == 1);
        REQUIRE(lines[0].first_point() == lines[0].last_point());
        REQUIRE(lines[0].length() > scale_(80));
        REQUIRE(lines[0].length() < scale_(400));
    }
    {
        const ExPolygon rectangle(scaled({{100, 100}, {120, 100}, {120, 200}, {100, 200}}));
        const Polylines lines {axis(rectangle, scale_(20), scale_(0.5))};
        REQUIRE(lines.size() == 1);
        REQUIRE(unscale(lines[0].length()) >= 80 - 1e-4);
    }
    {
        const ExPolygon trapezoid(scaled({{100, 100}, {120, 100}, {112, 200}, {108, 200}}));
        const Polylines lines {axis(trapezoid, scale_(20), scale_(0.5))};
        REQUIRE(lines.size() == 1);
        REQUIRE(unscale(lines[0].length()) >= 80 - 1e-4);
    }
    {
        const ExPolygon corner(scaled({{100, 100}, {120, 100}, {120, 180}, {200, 180}, {200, 200}, {100, 200}}));
        const Polylines lines {axis(corner, scale_(20), scale_(0.5))};
        REQUIRE(lines.size() == 1);
        const double length {unscale(lines[0].length()) + 20};  // the ends are 20 mm short
        REQUIRE(length > 160);
        REQUIRE(length < 200);
    }
    {
        const ExPolygon triangle(scaled({{50, 100}, {1000, 102}, {50, 104}}));
        const Polylines lines {axis(triangle, scale_(4), scale_(0.5))};
        REQUIRE(lines.size() == 1);
        REQUIRE(unscale(lines[0].length()) >= 80 - 1e-4);
    }
    {  // upstream issue 2474
        const ExPolygon sliver(raw({{91294454, 31032190}, {11294481, 31032190}, {11294481, 29967810}, {44969182, 29967810}, {89909960, 29967808}, {91294454, 29967808}}));
        Polylines lines {axis(sliver, 1871238, 500000)};
        REQUIRE(lines.size() == 1);
        Polyline &line {lines[0]};
        double y {0};
        for (const auto &p : line.points) y += p.y;
        REQUIRE(std::abs(y / line.points.size() - sliver.contour.bounding_box().center().y) < SCALED_EPSILON);
        if (line.first_point().x > line.last_point().x) line.reverse();
        for (size_t i = 1; i < line.points.size(); ++i) REQUIRE(line.points[i - 1].x <= line.points[i].x);
    }
}

TEST_CASE("Cooling slows short layers and starts the fan") {
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
    REQUIRE(filtered(slowdown + 1, "G1 F3000;_EXTRUDE_SET_SPEED\nG1 X100 E1").find("F3000") != std::string::npos);
    const std::string slowed {filtered(slowdown - 1, "G1 X50 F2500\nG1 F3000;_EXTRUDE_SET_SPEED\nG1 X100 E1\nG1 E4 F400")};
    REQUIRE(slowed.find("F3000") == std::string::npos);
    REQUIRE(slowed.find("F2500") != std::string::npos);  // travel moves keep their speed
    REQUIRE(slowed.find("F400") != std::string::npos);   // so do moves of the extruder alone
    REQUIRE(filtered(fan + 1, "G1 X100 E1 F3000").find("M106") == std::string::npos);
}

TEST_CASE("Cooling: the fan runs at bridge speed only for bridges") {
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
    REQUIRE(wrong_speed == 0);
    REQUIRE(fan_elsewhere == 0);
    REQUIRE(bridge_without == 0);
}

TEST_CASE("Retraction and lift through a print") {
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
        REQUIRE(check(copies) == "");
        config->set("retract_restart_extra", "1");
        REQUIRE(check(copies) == "");
        config->set("retract_restart_extra", "-1");
        REQUIRE(check(copies) == "");
        config->set("retract_lift", "1,2");
        REQUIRE(check(copies) == "");
    };
    variants(1);
    variants(2);
    config->set("infill_extruder", "2");
    config->set("skirts", "4");
    config->set("skirt_height", "3");
    variants(1);
}

TEST_CASE("No retraction or lift when the length is zero") {
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
    REQUIRE(retractions == 0);
    REQUIRE(drops == 0);
}

TEST_CASE("Firmware retraction alternates, also with a length of zero") {
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
        REQUIRE(count > 0);
        REQUIRE(doubled == 0);
    }
}

TEST_CASE("Custom G-code and its placeholders") {
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
        REQUIRE(misplaced == 0);
    }
    {
        auto config {Slic3r::Config::new_from_defaults()};
        PlaceholderParser parser;
        parser.apply_config(config->config());
        parser.set("foo", "0");
        const std::string first {config->config().serialize("temperature")};
        REQUIRE(parser.process("[temperature_[foo]]") == first.substr(0, first.find(',')));
    }
    {
        auto config {Slic3r::Config::new_from_defaults()};
        config->set("output_filename_format", "ts_[travel_speed]_lh_[layer_height].gcode");
        config->set("start_gcode", "TRAVEL:[travel_speed] HEIGHT:[layer_height]\n");
        const std::string travel {config->config().serialize("travel_speed")}, height {config->config().serialize("layer_height")};
        Slic3r::Model model;
        auto print {init_print({TestMesh::cube_20x20x20}, model, config)};
        const std::string name {print->output_filepath("")};
        REQUIRE(name.find("ts_" + travel + "_") != std::string::npos);
        REQUIRE(name.find("lh_" + height + ".") != std::string::npos);
        std::stringstream out;
        Slic3r::Test::gcode(out, print);
        REQUIRE(out.str().find("TRAVEL:" + travel) != std::string::npos);
        REQUIRE(out.str().find("HEIGHT:" + height) != std::string::npos);
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
        REQUIRE(single.find("M104 S205 T1") != std::string::npos);
        REQUIRE_FALSE(std::regex_search(single, std::regex("M104 S\\d+ T0")));
        config->set("infill_extruder", "1");
        config->set("start_gcode", "\n;__temp0:[first_layer_temperature_0]__\n;__temp1:[first_layer_temperature_1]__\n;__temp2:[first_layer_temperature_2]__\n");
        const std::string both {sliced({TestMesh::cube_20x20x20}, config)};
        REQUIRE(both.find("M104 S200 T0") != std::string::npos);
        REQUIRE(both.find("M104 S205 T1") != std::string::npos);
        REQUIRE(both.find("temp0:200") != std::string::npos);
        REQUIRE(both.find("temp1:205") != std::string::npos);
        REQUIRE(both.find("temp2:200") != std::string::npos);  // unused extruder: the first value
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
        REQUIRE_FALSE(change.empty());
        REQUIRE(before == change);
        for (size_t i = 1; i < change.size(); ++i) REQUIRE(change[i] == change[i - 1] + 1);
    }
    {
        auto config {Slic3r::Config::new_from_defaults()};
        config->set("complete_objects", "1");
        config->set("between_objects_gcode", "_MY_CUSTOM_GCODE_");
        const std::string gcode {sliced({TestMesh::cube_20x20x20, TestMesh::cube_20x20x20, TestMesh::cube_20x20x20}, config)};
        const std::regex marker("(^|\n)_MY_CUSTOM_GCODE_");
        REQUIRE(std::distance(std::sregex_iterator(gcode.begin(), gcode.end(), marker), std::sregex_iterator()) == 2);
    }
}
