// The print options, from test_config.cpp.
#include <gtest/gtest.h>

#include <cmath>
#include <memory>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

#include "PrintConfig.hpp"

using namespace Slic3r;

/// equal within the tolerance Catch's Approx used
#define EXPECT_APPROX(value, expected) EXPECT_NEAR(value, expected, 1.2e-5 * std::abs(expected))

TEST(PrintConfig, DefaultsAreValid) {
    FullPrintConfig config;
    EXPECT_NO_THROW(config.validate());
}

TEST(PrintConfig, RefusesFullDensityWithAPatternThatCannotDoIt) {
    FullPrintConfig config;
    config.fill_density.value = 100;  // with the default (stars) pattern
    try {
        config.validate();
        FAIL() << "accepted";
    } catch (const std::exception& e) {
        EXPECT_STREQ(e.what(), "The selected fill pattern is not supposed to work at 100% density");
    }
    config.fill_pattern.value = ipRectilinear;
    EXPECT_NO_THROW(config.validate());
}

TEST(PrintConfig, RefusesFirmwareRetractionWithMach3) {
    FullPrintConfig config;
    config.use_firmware_retraction.value = true;
    config.gcode_flavor.value = gcfMach3;
    EXPECT_THROW(config.validate(), std::invalid_argument);
}

TEST(PrintConfig, ValuesSerializeAsInTheIniFiles) {
    DynamicPrintConfig config;
    auto round_trip = [&config](const std::string &key, const std::string &text) {
        config.set_deserialize(key, text);
        return config.serialize(key);
    };
    EXPECT_EQ(round_trip("layer_height", "0.3"), "0.3");
    EXPECT_EQ(round_trip("perimeters", "2"), "2");
    EXPECT_EQ(round_trip("extrusion_axis", "A"), "A");
    EXPECT_EQ(round_trip("notes", "bar\\nbaz"), "bar\\nbaz");
    EXPECT_EQ(config.opt<ConfigOptionString>("notes")->value, "bar\nbaz");
    EXPECT_EQ(round_trip("first_layer_height", "50%"), "50%");
    config.set_deserialize("layer_height", "0.3");
    EXPECT_APPROX(config.get_abs_value("first_layer_height"), 0.15);
    EXPECT_EQ(round_trip("use_relative_e_distances", "1"), "1");
    for (const char* flavor : {"teacup", "mach3", "machinekit"}) EXPECT_EQ(round_trip("gcode_flavor", flavor), flavor);
    EXPECT_EQ(round_trip("fill_pattern", "stars"), "stars");
    EXPECT_EQ(round_trip("support_material_pattern", "pillars"), "pillars");
    EXPECT_EQ(round_trip("extruder_offset", "10x20,30x45"), "10x20,30x45");
    EXPECT_EQ(round_trip("extruder_offset", "0x0"), "0x0");
    ASSERT_EQ(config.opt<ConfigOptionPoints>("extruder_offset")->values.size(), 1u);
    EXPECT_EQ(round_trip("nozzle_diameter", "0.1,0.4"), "0.1,0.4");
    EXPECT_EQ(round_trip("temperature", "195,220"), "195,220");
    EXPECT_EQ(round_trip("wipe", "0,1,1"), "0,1,1");
    EXPECT_EQ(config.opt<ConfigOptionBools>("wipe")->get_at(9), false);  // beyond the end: the first
    config.set_deserialize("wipe", "");
    EXPECT_TRUE(config.opt<ConfigOptionBools>("wipe")->values.empty());
    EXPECT_EQ(round_trip("post_process", "bar;baz"), "bar;baz");

    // lists of strings, quoted where needed
    const std::vector<std::pair<std::vector<std::string>, std::string>> lists {
        {{}, ""}, {{""}, "\"\""}, {{"RGB"}, "RGB"},
        {{"ABC", "DEF", "09182745@!#$*(&"}, "ABC;DEF;09182745@!#$*(&"},
        {{"ABC", "DEF", "", "09182745@!#$*(&", ""}, "ABC;DEF;;09182745@!#$*(&;"},
        {{"some \"quoted\" notes", "yet\n some notes", "whatever \n notes", ""},
            "\"some \\\"quoted\\\" notes\";\"yet\\n some notes\";\"whatever \\n notes\";"}};
    for (const auto &list : lists) {
        config.set_deserialize("filament_notes", "");
        EXPECT_TRUE(config.opt<ConfigOptionStrings>("filament_notes")->values.empty());
        auto* notes {config.opt<ConfigOptionStrings>("filament_notes")};
        notes->values = list.first;
        EXPECT_EQ(config.serialize("filament_notes"), list.second);
        config.set_deserialize("filament_notes", list.second);
        EXPECT_EQ(config.opt<ConfigOptionStrings>("filament_notes")->values, list.first);
    }
}

TEST(PrintConfig, NormalizationFillsInExtruders) {
    {
        DynamicPrintConfig config;
        config.set_deserialize("extruder", "2");
        config.set_deserialize("perimeter_extruder", "3");
        config.normalize();
        EXPECT_FALSE(config.has("extruder"));
        EXPECT_EQ(config.serialize("infill_extruder"), "2");
        EXPECT_EQ(config.serialize("perimeter_extruder"), "3");
    }
    {
        DynamicPrintConfig config;
        config.set_deserialize("infill_extruder", "2");
        config.normalize();
        EXPECT_EQ(config.serialize("solid_infill_extruder"), "2");
    }
    {
        DynamicPrintConfig config;
        config.set_deserialize("spiral_vase", "1");
        config.set_deserialize("retract_layer_change", "1,0");
        config.normalize();
        EXPECT_EQ(config.serialize("retract_layer_change"), "0,0");
    }
    DynamicPrintConfig bad;
    EXPECT_NO_THROW(bad.load("src/test/inputs/test_config/bad_config_options.ini"));
}

TEST(PrintConfig, ReadsCommandLineArguments) {
    auto parse = [](std::vector<std::string> tokens) {
        std::unique_ptr<DynamicPrintConfig> config {new DynamicPrintConfig()};
        t_config_option_keys files;
        config->read_cli(tokens, &files);
        return config;
    };
    auto config = parse({"--extra-perimeters", "--perimeters", "1", "--layer-height", "0.45", "--fill-density", "70%",
        "--detect-bridging-perimeters", "--notes=foobar"});
    EXPECT_EQ(config->serialize("extra_perimeters"), "1");
    EXPECT_EQ(config->serialize("perimeters"), "1");
    EXPECT_EQ(config->serialize("layer_height"), "0.45");
    EXPECT_EQ(config->serialize("fill_density"), "70%");
    EXPECT_EQ(config->serialize("overhangs"), "1");  // an alternative name
    EXPECT_EQ(config->serialize("notes"), "foobar");
    EXPECT_EQ(parse({"--extra-perimeters", "--no-extra-perimeters"})->serialize("extra_perimeters"), "0");
    EXPECT_EQ(parse({"--wipe", "--no-wipe", "--wipe"})->serialize("wipe"), "1,0,1");
    EXPECT_EQ(parse({"--post-process", "foo", "--post-process", "bar"})->serialize("post_process"), "foo;bar");
    EXPECT_EQ(parse({"--retract-speed", "0.4", "--retract-speed", "0.5"})->serialize("retract_speed"), "0.4,0.5");
    EXPECT_EQ(parse({"--extruder-offset", "0,0", "--extruder-offset", "10x5"})->serialize("extruder_offset"), "0x0,10x5");
}
