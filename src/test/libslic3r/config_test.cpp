// The Config class, from test_config.cpp; the cases about the print options themselves are
// in print_config_test.cpp.
#include <gtest/gtest.h>

#include <stdexcept>
#include <string>
#include <vector>

#include "Config.hpp"

using namespace Slic3r;

namespace {

/// A configuration of the default options with one of them set.
template <class T> config_ptr with(const std::string& key, T value) {
    config_ptr config {Config::new_from_defaults()};
    config->set(key, value);
    return config;
}

template <class T> T option(const config_ptr& config, const std::string& key) {
    return config->get<T>(key);
}

const std::string inputs {"src/test/inputs/test_config/"};

} // namespace

TEST(Config, AcceptsAPercentageAsAWidth) {
    EXPECT_NO_THROW(with("perimeter_extrusion_width", "250%")->validate());
}

TEST(Config, RefusesNegativeValues) {
    EXPECT_THROW(with("perimeter_extrusion_width", -10)->validate(), InvalidOptionException);
    EXPECT_THROW(with("perimeters", -10)->validate(), InvalidOptionException);
}

TEST(Config, SetsBooleans) {
    config_ptr config;
    ASSERT_NO_THROW(config = with("gcode_comments", true));
    EXPECT_TRUE(option<ConfigOptionBool>(config, "gcode_comments").getBool());
    ASSERT_NO_THROW(config = with("gcode_comments", "1"));
    EXPECT_TRUE(option<ConfigOptionBool>(config, "gcode_comments").getBool());
}

TEST(Config, RefusesAValueOfTheWrongType) {
    const config_ptr config {Config::new_from_defaults()};
    EXPECT_THROW(config->set("gcode_comments", "Z"), BadOptionTypeException);
    EXPECT_FALSE(option<ConfigOptionBool>(config, "gcode_comments").getBool());
    EXPECT_THROW(config->set("gcode_comments", 1), BadOptionTypeException);
    EXPECT_THROW(config->set("bed_temperature", 5.5), BadOptionTypeException);
    // A number does not keep its value: the refused text leaves 0 behind (plan/TODO.md).
    // The Catch case of that name looks at a configuration nothing was set on.
    EXPECT_THROW(config->set("perimeter_speed", "zzzz"), BadOptionTypeException);
    EXPECT_EQ(Config::new_from_defaults()->getFloat("perimeter_speed"), 60.0);
}

TEST(Config, SetsNumbers) {
    EXPECT_EQ(option<ConfigOptionInt>(with("bed_temperature", "100"), "bed_temperature").getInt(), 100);
    EXPECT_EQ(option<ConfigOptionInt>(with("bed_temperature", 100), "bed_temperature").getInt(), 100);
    EXPECT_EQ(option<ConfigOptionFloat>(with("perimeter_speed", 10), "perimeter_speed").getFloat(), 10.0);
    EXPECT_EQ(option<ConfigOptionFloat>(with("perimeter_speed", 5.5), "perimeter_speed").getFloat(), 5.5);
}

TEST(Config, SetsStrings) {
    EXPECT_EQ(option<ConfigOptionString>(with("octoprint_apikey", "100"), "octoprint_apikey").getString(), "100");
    EXPECT_EQ(option<ConfigOptionString>(with("octoprint_apikey", 100), "octoprint_apikey").getString(), "100");
    EXPECT_EQ(option<ConfigOptionString>(with("octoprint_apikey", 100.5), "octoprint_apikey").getString(),
        std::to_string(100.5));
}

TEST(Config, SetsAValueOrAPercentage) {
    const std::string key {"first_layer_extrusion_width"};
    auto read = [&key](const config_ptr& config) { return option<ConfigOptionFloatOrPercent>(config, key); };
    EXPECT_TRUE(read(with(key, "100%")).percent);
    EXPECT_EQ(read(with(key, "100%")).value, 100);
    EXPECT_FALSE(read(with(key, "100")).percent);
    EXPECT_EQ(read(with(key, "100")).value, 100);
    EXPECT_FALSE(read(with(key, 100)).percent);
    EXPECT_EQ(read(with(key, 100)).value, 100);
    EXPECT_FALSE(read(with(key, 100.5)).percent);
    EXPECT_EQ(read(with(key, 100.5)).value, 100.5);
}

TEST(Config, RefusesUnknownOptions) {
    const config_ptr config {Config::new_from_defaults()};
    EXPECT_THROW(config->set("deadbeef_invalid_option", 1), UnknownOptionException);
    EXPECT_THROW(config->set("deadbeef_invalid_option", 1.0), UnknownOptionException);
    EXPECT_THROW(config->set("deadbeef_invalid_option", "1"), UnknownOptionException);
    EXPECT_THROW(config->set("deadbeef_invalid_option", true), UnknownOptionException);
    EXPECT_THROW(config->get<ConfigOptionString>("deadbeef_invalid_option", false), UnknownOptionException);
    EXPECT_THROW(config->get<ConfigOptionFloat>("deadbeef_invalid_option", false), UnknownOptionException);
    EXPECT_THROW(config->get<ConfigOptionInt>("deadbeef_invalid_option", false), UnknownOptionException);
    EXPECT_THROW(config->get<ConfigOptionBool>("deadbeef_invalid_option", false), UnknownOptionException);
    EXPECT_THROW(config->get_ptr<ConfigOptionString>("deadbeef_invalid_option", false), UnknownOptionException);
    EXPECT_THROW(config->get_ptr<ConfigOptionFloat>("deadbeef_invalid_option", false), UnknownOptionException);
    EXPECT_THROW(config->get_ptr<ConfigOptionInt>("deadbeef_invalid_option", false), UnknownOptionException);
    EXPECT_THROW(config->get_ptr<ConfigOptionBool>("deadbeef_invalid_option", false), UnknownOptionException);
}

TEST(Config, GivesTheDefaultUntilAValueIsSet) {
    const config_ptr config {Config::new_from_defaults()};
    EXPECT_EQ(config->getFloat("layer_height"), 0.3);
    EXPECT_EQ(config->getInt("raft_layers"), 0);
    EXPECT_FALSE(config->getBool("support_material"));
    config->set("layer_height", 0.5);
    EXPECT_EQ(config->getFloat("layer_height"), 0.5);
}

TEST(Config, LoadsSavesAndReloadsAnIniFile) {
    const config_ptr config {Config::new_from_ini(inputs + "new_from_ini_values.ini")};
    EXPECT_NEAR(config->getFloat("layer_height"), 0.15, 1e-6);
    EXPECT_EQ(config->getInt("perimeters"), 5);
    EXPECT_EQ(config->get<ConfigOptionEnum<InfillPattern>>("fill_pattern").value, ipGyroid);
    EXPECT_NEAR(config->get<ConfigOptionPercent>("fill_density").value, 35, 1e-4);
    EXPECT_EQ(config->get<ConfigOptionFloats>("nozzle_diameter").values, (std::vector<double>{0.4, 0.6}));
    EXPECT_EQ(config->getString("end_gcode"), "M104 S0\nM84\n");
    EXPECT_TRUE(config->getBool("spiral_vase"));

    const std::string file {testing::TempDir() + "saved.ini"};
    config->config().save(file);
    const config_ptr reloaded {Config::new_from_ini(file)};
    for (const char* key : {"layer_height", "perimeters", "fill_pattern", "fill_density", "nozzle_diameter",
            "end_gcode", "spiral_vase"})
        EXPECT_EQ(reloaded->config().serialize(key), config->config().serialize(key)) << key;
}

TEST(Config, ReportsAFailedSave) {
    // instead of losing the settings quietly
    EXPECT_THROW(Config::new_from_defaults()->config().save("no-such-directory/config.ini"), std::runtime_error);
}
