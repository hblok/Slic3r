// Conditional G-code and firmware retraction: ported from the Perl binding tests
// (xs/t/21_gcode.t, xs/t/24_gcodemath.t).
#include <catch.hpp>

#include "ConditionalGCode.hpp"
#include "GCodeWriter.hpp"
#include "PlaceholderParser.hpp"
#include "PrintConfig.hpp"

using namespace Slic3r;

TEST_CASE("Conditional G-code") {
    REQUIRE(apply_math("{if{3 == 4}} string") == "");
    REQUIRE(apply_math("{if{3 == 4}} string\notherstring") == "otherstring");
    REQUIRE(apply_math("{if{3 == 3}} string") == " string");
    REQUIRE(apply_math("{if 3 > 2} string") == " string");
    REQUIRE(apply_math("{if{3 == 3}}string") == "string");
    REQUIRE(apply_math("M104 S{4*5}; Sets temp to {4*5}") == "M104 S20; Sets temp to 20");
    REQUIRE(apply_math("M104 S\\{a\\}; Sets temp to {4*5}") == "M104 S{a}; Sets temp to 20");
    REQUIRE(apply_math("M104 S{a}; Sets temp to {4*5}") == "M104 S{a}; Sets temp to 20");

    DynamicPrintConfig config;
    config.set_deserialize("infill_extruder", "2");
    PlaceholderParser parser;
    parser.apply_config(config);
    const std::string filled {parser.process("{if [infill_extruder] == 2}M104 S210")};
    REQUIRE(filled == "{if 2 == 2}M104 S210");
    REQUIRE(apply_math(filled) == "M104 S210");
}

TEST_CASE("Retraction by the firmware") {
    const std::pair<const char*, const char*> flavors[] {
        {"reprap", "G10 S1 ; retract for toolchange extruder 0"},
        {"repetier", "G10 S1 ; retract for toolchange extruder 0"},
        {"smoothie", "G10 ; retract for toolchange extruder 0"}};
    for (const auto &flavor : flavors) {
        PrintConfig config;
        config.use_firmware_retraction.value = true;
        config.gcode_flavor.deserialize(flavor.first);
        config.gcode_comments.value = true;
        GCodeWriter writer;
        writer.apply_print_config(config);
        writer.set_extruders(std::vector<unsigned int>{0});
        writer.set_extruder(0);
        const std::string gcode {writer.retract_for_toolchange()};
        REQUIRE(gcode.substr(0, gcode.find('\n')) == flavor.second);
    }
}
