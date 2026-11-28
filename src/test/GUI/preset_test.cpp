// From test_preset.cpp.
#include <gtest/gtest.h>

#include <string>

#include "Config.hpp"
#include "Preset.hpp"

using namespace Slic3r::GUI;
using namespace std::literals::string_literals;

/// the files the tests read (data of the test target)
const std::string testfile_dir {"src/test/inputs/"};

// Preset construction; A preset file with at least one configuration; Preset is constructed.
TEST(Preset, ReadsItsNameAndGroupFromAFile) {
    {  // given: A preset file with at least one configuration
        {  // when: Preset is constructed.
            Preset item {std::string(testfile_dir) + "test_preset", "preset_load_numeric.ini"s, preset_t::Print};
            {  // then: Name is preset_load_numeric
                EXPECT_EQ(item.name, "preset_load_numeric"s);
            }
            {  // then: group is Print
                EXPECT_EQ(item.group, preset_t::Print);
            }
            {  // then: preset default is false.
                EXPECT_EQ(item.default_preset, false);
            }
        }
    }
}

// Preset construction; A default preset construction for Print; Preset is constructed.
TEST(Preset, DefaultPrintPresetHasThePrintOptions) {
    {  // given: A default preset construction for Print
        {  // when: Preset is constructed.
            Preset item {true, "- default -", preset_t::Print};
            {  // then: Name is - default -
                EXPECT_EQ(item.name, "- default -"s);
            }
            {  // then: group is Print
                EXPECT_EQ(item.group, preset_t::Print);
            }
            {  // then: preset default is true.
                EXPECT_EQ(item.default_preset, true);
            }
            {  // then: file_exists() is false
                EXPECT_EQ(item.file_exists(), false);
            }
            {  // then: Does not contain filament_colour (a material option)
                if (auto config = item.config().lock()) {
                    EXPECT_TRUE(!config->has("filament_colour"));
                }
            }
            {  // then: Does not contain gcode_flavor (a printer option)
                if (auto config = item.config().lock()) {
                    EXPECT_TRUE(!config->has("gcode_flavor"));
                }
            }
            {  // then: Does contain layer_height (a print option)
                if (auto config = item.config().lock()) {
                    EXPECT_TRUE(config->has("layer_height"));
                }
            }
        }
    }
}

// Preset construction; A default preset construction for Material; Preset is constructed.
TEST(Preset, DefaultMaterialPresetHasTheMaterialOptions) {
    {  // given: A default preset construction for Material
        {  // when: Preset is constructed.
            Preset item {true, "- default -", preset_t::Material};
            {  // then: Name is - default -
                EXPECT_EQ(item.name, "- default -"s);
            }
            {  // then: group is Material
                EXPECT_EQ(item.group, preset_t::Material);
            }
            {  // then: preset default is true.
                EXPECT_EQ(item.default_preset, true);
            }
            {  // then: file_exists() is false
                EXPECT_EQ(item.file_exists(), false);
            }
            {  // then: Does contain filament_colour (a material option)
                if (auto config = item.config().lock()) {
                    EXPECT_TRUE(config->has("filament_colour"));
                }
            }
            {  // then: Does not contain gcode_flavor (a printer option)
                if (auto config = item.config().lock()) {
                    EXPECT_TRUE(!config->has("gcode_flavor"));
                }
            }
            {  // then: Does not contain layer_height (a print option)
                if (auto config = item.config().lock()) {
                    EXPECT_TRUE(!config->has("layer_height"));
                }
            }
        }
    }
}

// Preset construction; A default preset construction for Printer; Preset is constructed.
TEST(Preset, DefaultPrinterPresetHasThePrinterOptions) {
    {  // given: A default preset construction for Printer
        {  // when: Preset is constructed.
            Preset item {true, "- default -", preset_t::Printer};
            {  // then: Name is - default -
                EXPECT_EQ(item.name, "- default -"s);
            }
            {  // then: group is Printer
                EXPECT_EQ(item.group, preset_t::Printer);
            }
            {  // then: preset default is true.
                EXPECT_EQ(item.default_preset, true);
            }
            {  // then: file_exists() is false
                EXPECT_EQ(item.file_exists(), false);
            }
            {  // then: Does not contain filament_colour (a material option)
                if (auto config = item.config().lock()) {
                    EXPECT_TRUE(!config->has("filament_colour"));
                }
            }
            {  // then: Does contain gcode_flavor (a printer option)
                if (auto config = item.config().lock()) {
                    EXPECT_TRUE(config->has("gcode_flavor"));
                }
            }
            {  // then: Does not contain layer_height (a print option)
                if (auto config = item.config().lock()) {
                    EXPECT_TRUE(!config->has("layer_height"));
                }
            }
        }
    }
}

// Preset loading; A preset file with a config item that has adaptive_slicing = 1; file_exists() returns true
TEST(Preset, FindsItsFile) {
    {  // given: A preset file with a config item that has adaptive_slicing = 1
        Preset item {std::string(testfile_dir) + "test_preset", "preset_load_numeric.ini"s, preset_t::Print};
        {  // then: file_exists() returns true
            EXPECT_EQ(item.file_exists(), true);
        }
        config_ptr ref;
        auto config { Slic3r::Config::new_from_defaults() };
        ref = item.load_config();
    }
}

// Preset loading; A preset file with a config item that has adaptive_slicing = 1; The preset file with one item is loaded
TEST(Preset, LoadsCleanFromItsFile) {
    {  // given: A preset file with a config item that has adaptive_slicing = 1
        Preset item {std::string(testfile_dir) + "test_preset", "preset_load_numeric.ini"s, preset_t::Print};
        config_ptr ref;
        {  // when: The preset file with one item is loaded
            ref = item.load_config();
            {  // then: Config is not dirty.
                EXPECT_EQ(item.dirty(), false);
            }
            {  // then: adaptive_slicing = 1 in the preset config
                EXPECT_EQ(item.dirty_config().get<ConfigOptionBool>("adaptive_slicing").getBool(), true);
            }
        }
        auto config { Slic3r::Config::new_from_defaults() };
        ref = item.load_config();
    }
}

// Preset loading; A preset file with a config item that has adaptive_slicing = 1; Option is changed in the config via loading a config
TEST(Preset, IsDirtyAfterAnotherConfigurationIsApplied) {
    {  // given: A preset file with a config item that has adaptive_slicing = 1
        Preset item {std::string(testfile_dir) + "test_preset", "preset_load_numeric.ini"s, preset_t::Print};
        config_ptr ref;
        auto config { Slic3r::Config::new_from_defaults() };
        ref = item.load_config();
        {  // when: Option is changed in the config via loading a config
            // precondition: adaptive_slicing is still true
            EXPECT_EQ(item.dirty_config().get<ConfigOptionBool>("adaptive_slicing").getBool(), true);
            // precondition: default option for adaptice_slicing is false
            EXPECT_EQ(config->get<ConfigOptionBool>("adaptive_slicing").getBool(), false);
            ref->apply(config);
            {  // then: Config is dirty.
                EXPECT_EQ(item.dirty(), true);
            }
            {  // then: adaptive_slicing = 0 in the preset config
                EXPECT_EQ(item.dirty_config().get<ConfigOptionBool>("adaptive_slicing").getBool(), false);
            }
            {  // then: subsequent calls yield the same reference
                EXPECT_EQ(item.load_config(), ref);
            }
        }
    }
}

// Preset loading; A preset file with a config item that has adaptive_slicing = 1 and default_preset = true; The preset file with one item is loaded
TEST(Preset, AsADefaultPresetLoadsCleanFromItsFile) {
    {  // given: A preset file with a config item that has adaptive_slicing = 1 and default_preset = true
        Preset item {std::string(testfile_dir) + "test_preset", "preset_load_numeric.ini"s, preset_t::Print};
        item.default_preset = true;
        config_ptr ref;
        {  // when: The preset file with one item is loaded
            ref = item.load_config();
            {  // then: Config is not dirty.
                EXPECT_EQ(item.dirty(), false);
            }
            {  // then: adaptive_slicing = 1 in the preset config
                EXPECT_EQ(item.dirty_config().get<ConfigOptionBool>("adaptive_slicing").getBool(), true);
            }
            {  // then: loaded is true
                EXPECT_EQ(item.loaded(), true);
            }
            {  // then: subsequent calls yield the same reference
                EXPECT_EQ(item.load_config(), ref);
            }
        }
    }
}

// Preset loading; A preset file with a config item that has adaptive_slicing = 1 and default_preset = true; Option is changed in the config
TEST(Preset, IsDirtyAfterAnOptionIsChanged) {
    {  // given: A preset file with a config item that has adaptive_slicing = 1 and default_preset = true
        Preset item {std::string(testfile_dir) + "test_preset", "preset_load_numeric.ini"s, preset_t::Print};
        item.default_preset = true;
        config_ptr ref;
        {  // when: Option is changed in the config
            ref = item.load_config();
            ref->set("adaptive_slicing", false);
            {  // then: Config is dirty.
                EXPECT_EQ(item.dirty(), true);
            }
            {  // then: adaptive_slicing = 0 in the preset config
                EXPECT_EQ(item.dirty_config().get<ConfigOptionBool>("adaptive_slicing").getBool(), false);
            }
        }
    }
}

// Preset loading; An invalid preset file
TEST(Preset, KnowsThatItsFileIsMissing) {
    {  // given: An invalid preset file
        Preset item {std::string(testfile_dir) + "test_preset", "___invalid__preset_load_numeric.ini"s, preset_t::Print};
        {  // then: file_exists() returns false
            EXPECT_EQ(item.file_exists(), false);
        }
        {  // then: loaded is false
            EXPECT_EQ(item.loaded(), false);
        }
    }
}

// Compatible printers survive loading and saving a preset
TEST(Preset, KeepsCompatiblePrintersThroughLoadingAndSaving) {
    for (const auto group : {preset_t::Print, preset_t::Material}) {
        Preset item {std::string(testfile_dir) + "test_preset_chooser", "incompat-material-profile.ini"s, group};
        EXPECT_TRUE(item.compatible("printer-profile-2"s));
        EXPECT_FALSE(item.compatible("printer-profile"s));
        item.load_config();
        EXPECT_FALSE(item.dirty());
        EXPECT_EQ(item.config_to_save().config().serialize("compatible_printers"), "printer-profile-2;nothing");
    }
}
