#include <catch.hpp>

#include "Config.hpp"
#include <boost/filesystem.hpp>
#include <boost/nowide/cstdio.hpp>
#include <test_options.hpp>

#include <string>

using namespace Slic3r;
using namespace std::literals::string_literals;

SCENARIO("Generic config validation performs as expected.") {
    GIVEN("A config generated from default options") {
        auto config {Slic3r::Config::new_from_defaults()};
        WHEN( "perimeter_extrusion_width is set to 250%, a valid value") {
            config->set("perimeter_extrusion_width", "250%");
            THEN( "The config is read as valid.") {
                REQUIRE_NOTHROW(config->validate());
            }
        }
        WHEN( "perimeter_extrusion_width is set to -10, an invalid value") {
            config->set("perimeter_extrusion_width", -10);
            THEN( "An InvalidOptionException exception is thrown.") {
                auto except_thrown {false};
                try {
                    config->validate();
                } catch (const InvalidOptionException& e) {
                    except_thrown = true;
                }
                REQUIRE(except_thrown == true);
            }
        }

        WHEN( "perimeters is set to -10, an invalid value") {
            config->set("perimeters", -10);
            THEN( "An InvalidOptionException exception is thrown.") {
                auto except_thrown {false};
                try {
                    config->validate();
                } catch (const InvalidOptionException& e) {
                    except_thrown = true;
                }
                REQUIRE(except_thrown == true);
            }
        }
    }
}

SCENARIO("Config accessor functions perform as expected.") {
    GIVEN("A config generated from default options") {
        auto config {Slic3r::Config::new_from_defaults()};
        WHEN("A boolean option is set to a boolean value") {
            REQUIRE_NOTHROW(config->set("gcode_comments", true));
            THEN("The underlying value is set correctly.") {
                REQUIRE(config->get<ConfigOptionBool>("gcode_comments").getBool() == true);
            }
        }
        WHEN("A boolean option is set to a string value representing a 0 or 1") {
            CHECK_NOTHROW(config->set("gcode_comments", "1"));
            THEN("The underlying value is set correctly.") {
                REQUIRE(config->get<ConfigOptionBool>("gcode_comments").getBool() == true);
            }
        }
        WHEN("A boolean option is set to a string value representing something other than 0 or 1") {
            THEN("A BadOptionTypeException exception is thrown.") {
                REQUIRE_THROWS_AS(config->set("gcode_comments", "Z"), BadOptionTypeException);
            }
            AND_THEN("Value is unchanged.") {
                REQUIRE(config->get<ConfigOptionBool>("gcode_comments").getBool() == false);
            }
        }
        WHEN("A string option is set to an int value") {
            THEN("A BadOptionTypeException exception is thrown.") {
                REQUIRE_THROWS_AS(config->set("gcode_comments", 1), BadOptionTypeException);
            }
        }
        WHEN("A numeric option is set from serialized string") {
            config->set("bed_temperature", "100");
            THEN("The underlying value is set correctly.") {
                REQUIRE(config->get<ConfigOptionInt>("bed_temperature").getInt() == 100);
            }
        }

        WHEN("An integer-based option is set through the integer interface") {
            config->set("bed_temperature", 100);
            THEN("The underlying value is set correctly.") {
                REQUIRE(config->get<ConfigOptionInt>("bed_temperature").getInt() == 100);
            }
        }
        WHEN("An floating-point option is set through the integer interface") {
            config->set("perimeter_speed", 10);
            THEN("The underlying value is set correctly.") {
                REQUIRE(config->get<ConfigOptionFloat>("perimeter_speed").getFloat() == 10.0);
            }
        }
        WHEN("A floating-point option is set through the double interface") {
            config->set("perimeter_speed", 5.5);
            THEN("The underlying value is set correctly.") {
                REQUIRE(config->get<ConfigOptionFloat>("perimeter_speed").getFloat() == 5.5);
            }
        }
        WHEN("An integer-based option is set through the double interface") {
            THEN("A BadOptionTypeException exception is thrown.") {
                REQUIRE_THROWS_AS(config->set("bed_temperature", 5.5), BadOptionTypeException);
            }
        }
        WHEN("A numeric option is set to a non-numeric value.") {
            THEN("A BadOptionTypeException exception is thrown.") {
                REQUIRE_THROWS_AS(config->set("perimeter_speed", "zzzz"), BadOptionTypeException);
            }
            THEN("The value does not change.") {
                REQUIRE(config->get<ConfigOptionFloat>("perimeter_speed").getFloat() == 60.0);
            }
        }
        WHEN("A string option is set through the string interface") {
            config->set("octoprint_apikey", "100");
            THEN("The underlying value is set correctly.") {
                REQUIRE(config->get<ConfigOptionString>("octoprint_apikey").getString() == "100");
            }
        }
        WHEN("A string option is set through the integer interface") {
            config->set("octoprint_apikey", 100);
            THEN("The underlying value is set correctly.") {
                REQUIRE(config->get<ConfigOptionString>("octoprint_apikey").getString() == "100");
            }
        }
        WHEN("A string option is set through the double interface") {
            config->set("octoprint_apikey", 100.5);
            THEN("The underlying value is set correctly.") {
                REQUIRE(config->get<ConfigOptionString>("octoprint_apikey").getString() == std::to_string(100.5));
            }
        }
        WHEN("A float or percent is set as a percent through the string interface.") {
            config->set("first_layer_extrusion_width", "100%");
            THEN("Value and percent flag are 100/true") {
                auto tmp {config->get<ConfigOptionFloatOrPercent>("first_layer_extrusion_width")};
                REQUIRE(tmp.percent == true);
                REQUIRE(tmp.value == 100);
            }
        }
        WHEN("A float or percent is set as a float through the string interface.") {
            config->set("first_layer_extrusion_width", "100");
            THEN("Value and percent flag are 100/false") {
                auto tmp {config->get<ConfigOptionFloatOrPercent>("first_layer_extrusion_width")};
                REQUIRE(tmp.percent == false);
                REQUIRE(tmp.value == 100);
            }
        }
        WHEN("A float or percent is set as a float through the int interface.") {
            config->set("first_layer_extrusion_width", 100);
            THEN("Value and percent flag are 100/false") {
                auto tmp {config->get<ConfigOptionFloatOrPercent>("first_layer_extrusion_width")};
                REQUIRE(tmp.percent == false);
                REQUIRE(tmp.value == 100);
            }
        }
        WHEN("A float or percent is set as a float through the double interface.") {
            config->set("first_layer_extrusion_width", 100.5);
            THEN("Value and percent flag are 100.5/false") {
                auto tmp {config->get<ConfigOptionFloatOrPercent>("first_layer_extrusion_width")};
                REQUIRE(tmp.percent == false);
                REQUIRE(tmp.value == 100.5);
            }
        }
        WHEN("An invalid option is requested during set.") {
            THEN("A BadOptionTypeException exception is thrown.") {
                REQUIRE_THROWS_AS(config->set("deadbeef_invalid_option", 1), UnknownOptionException);
                REQUIRE_THROWS_AS(config->set("deadbeef_invalid_option", 1.0), UnknownOptionException);
                REQUIRE_THROWS_AS(config->set("deadbeef_invalid_option", "1"), UnknownOptionException);
                REQUIRE_THROWS_AS(config->set("deadbeef_invalid_option", true), UnknownOptionException);
            }
        }

        WHEN("An invalid option is requested during get.") {
            THEN("A UnknownOptionException exception is thrown.") {
                REQUIRE_THROWS_AS(config->get<ConfigOptionString>("deadbeef_invalid_option", false), UnknownOptionException);
                REQUIRE_THROWS_AS(config->get<ConfigOptionFloat>("deadbeef_invalid_option", false), UnknownOptionException);
                REQUIRE_THROWS_AS(config->get<ConfigOptionInt>("deadbeef_invalid_option", false), UnknownOptionException);
                REQUIRE_THROWS_AS(config->get<ConfigOptionBool>("deadbeef_invalid_option", false), UnknownOptionException);
            }
        }
        WHEN("An invalid option is requested during get_ptr.") {
            THEN("A UnknownOptionException exception is thrown.") {
                REQUIRE_THROWS_AS(config->get_ptr<ConfigOptionString>("deadbeef_invalid_option", false), UnknownOptionException);
                REQUIRE_THROWS_AS(config->get_ptr<ConfigOptionFloat>("deadbeef_invalid_option", false), UnknownOptionException);
                REQUIRE_THROWS_AS(config->get_ptr<ConfigOptionInt>("deadbeef_invalid_option", false), UnknownOptionException);
                REQUIRE_THROWS_AS(config->get_ptr<ConfigOptionBool>("deadbeef_invalid_option", false), UnknownOptionException);
            }
        }

        WHEN("getX called on an unset option.") {
            THEN("The default is returned.") {
                REQUIRE(config->getFloat("layer_height") == 0.3);
                REQUIRE(config->getInt("raft_layers") == 0);
                REQUIRE(config->getBool("support_material") == false);
            }
        }

        WHEN("getFloat called on an option that has been set.") {
            config->set("layer_height", 0.5);
            THEN("The set value is returned.") {
                REQUIRE(config->getFloat("layer_height") == 0.5);
            }
        }
    }
}

SCENARIO("Config ini load/save interface") {
    WHEN("new_from_ini is called") {
        auto config {Slic3r::Config::new_from_ini(std::string(testfile_dir) + "test_config/new_from_ini_values.ini"s) };
        THEN("Config object contains ini file options.") {
            REQUIRE(config->getFloat("layer_height") == Approx(0.15));
            REQUIRE(config->getInt("perimeters") == 5);
            REQUIRE(config->get<ConfigOptionEnum<InfillPattern>>("fill_pattern").value == ipGyroid);
            REQUIRE(config->get<ConfigOptionPercent>("fill_density").value == Approx(35));
            REQUIRE(config->get<ConfigOptionFloats>("nozzle_diameter").values == std::vector<double>({0.4, 0.6}));
            REQUIRE(config->getString("end_gcode") == "M104 S0\nM84\n"s);
            REQUIRE(config->getBool("spiral_vase"));
        }
        AND_WHEN("it is saved and loaded again") {
            const std::string file {(boost::filesystem::temp_directory_path()
                / boost::filesystem::unique_path("slic3r-test-%%%%%%.ini")).string()};
            config->config().save(file);
            auto reloaded {Slic3r::Config::new_from_ini(file)};
            boost::nowide::remove(file.c_str());
            THEN("the options are the same") {
                for (const auto &key : {"layer_height", "perimeters", "fill_pattern", "fill_density",
                        "nozzle_diameter", "end_gcode", "spiral_vase"})
                    REQUIRE(reloaded->config().serialize(key) == config->config().serialize(key));
            }
        }
    }
}

SCENARIO("FullPrintConfig validation has the checks of the Perl version") {
    GIVEN("A default full print config") {
        FullPrintConfig config;
        THEN("it is valid") {
            REQUIRE_NOTHROW(config.validate());
        }
        WHEN("fill density is 100% with the default (stars) pattern") {
            config.fill_density.value = 100;
            THEN("it is refused") {
                REQUIRE_THROWS_WITH(config.validate(), "The selected fill pattern is not supposed to work at 100% density");
            }
        }
        WHEN("fill density is 100% with the rectilinear pattern") {
            config.fill_density.value = 100;
            config.fill_pattern.value = ipRectilinear;
            THEN("it is valid") {
                REQUIRE_NOTHROW(config.validate());
            }
        }
        WHEN("firmware retraction is used with Mach3") {
            config.use_firmware_retraction.value = true;
            config.gcode_flavor.value = gcfMach3;
            THEN("it is refused") {
                REQUIRE_THROWS_AS(config.validate(), std::invalid_argument);
            }
        }
    }
}

SCENARIO("Saving a config reports a failed write.") {
    GIVEN("A config and a directory that does not exist") {
        auto config {Slic3r::Config::new_from_defaults()};
        THEN("save() throws instead of losing the settings quietly") {
            REQUIRE_THROWS_AS(config->config().save("no-such-directory/config.ini"), std::runtime_error);
        }
    }
}

// ported from the Perl binding tests (xs/t/15_config.t)
TEST_CASE("Config values serialize as in the ini files") {
    DynamicPrintConfig config;
    auto round_trip = [&config](const std::string &key, const std::string &text) {
        config.set_deserialize(key, text);
        return config.serialize(key);
    };
    REQUIRE(round_trip("layer_height", "0.3") == "0.3");
    REQUIRE(round_trip("perimeters", "2") == "2");
    REQUIRE(round_trip("extrusion_axis", "A") == "A");
    REQUIRE(round_trip("notes", "bar\\nbaz") == "bar\\nbaz");
    REQUIRE(config.opt<ConfigOptionString>("notes")->value == "bar\nbaz");
    REQUIRE(round_trip("first_layer_height", "50%") == "50%");
    config.set_deserialize("layer_height", "0.3");
    REQUIRE(config.get_abs_value("first_layer_height") == Approx(0.15));
    REQUIRE(round_trip("use_relative_e_distances", "1") == "1");
    for (const char* flavor : {"teacup", "mach3", "machinekit"}) REQUIRE(round_trip("gcode_flavor", flavor) == flavor);
    REQUIRE(round_trip("fill_pattern", "stars") == "stars");
    REQUIRE(round_trip("support_material_pattern", "pillars") == "pillars");
    REQUIRE(round_trip("extruder_offset", "10x20,30x45") == "10x20,30x45");
    REQUIRE(round_trip("extruder_offset", "0x0") == "0x0");
    REQUIRE(config.opt<ConfigOptionPoints>("extruder_offset")->values.size() == 1);
    REQUIRE(round_trip("nozzle_diameter", "0.1,0.4") == "0.1,0.4");
    REQUIRE(round_trip("temperature", "195,220") == "195,220");
    REQUIRE(round_trip("wipe", "0,1,1") == "0,1,1");
    REQUIRE(config.opt<ConfigOptionBools>("wipe")->get_at(9) == false);  // beyond the end: the first
    config.set_deserialize("wipe", "");
    REQUIRE(config.opt<ConfigOptionBools>("wipe")->values.empty());
    REQUIRE(round_trip("post_process", "bar;baz") == "bar;baz");

    // lists of strings, quoted where needed
    const std::vector<std::pair<std::vector<std::string>, std::string>> lists {
        {{}, ""}, {{""}, "\"\""}, {{"RGB"}, "RGB"},
        {{"ABC", "DEF", "09182745@!#$*(&"}, "ABC;DEF;09182745@!#$*(&"},
        {{"ABC", "DEF", "", "09182745@!#$*(&", ""}, "ABC;DEF;;09182745@!#$*(&;"},
        {{"some \"quoted\" notes", "yet\n some notes", "whatever \n notes", ""},
            "\"some \\\"quoted\\\" notes\";\"yet\\n some notes\";\"whatever \\n notes\";"}};
    for (const auto &list : lists) {
        config.set_deserialize("filament_notes", "");
        REQUIRE(config.opt<ConfigOptionStrings>("filament_notes")->values.empty());
        auto* notes {config.opt<ConfigOptionStrings>("filament_notes")};
        notes->values = list.first;
        REQUIRE(config.serialize("filament_notes") == list.second);
        config.set_deserialize("filament_notes", list.second);
        REQUIRE(config.opt<ConfigOptionStrings>("filament_notes")->values == list.first);
    }
}

TEST_CASE("Config normalization fills in extruders") {
    {
        DynamicPrintConfig config;
        config.set_deserialize("extruder", "2");
        config.set_deserialize("perimeter_extruder", "3");
        config.normalize();
        REQUIRE_FALSE(config.has("extruder"));
        REQUIRE(config.serialize("infill_extruder") == "2");
        REQUIRE(config.serialize("perimeter_extruder") == "3");
    }
    {
        DynamicPrintConfig config;
        config.set_deserialize("infill_extruder", "2");
        config.normalize();
        REQUIRE(config.serialize("solid_infill_extruder") == "2");
    }
    {
        DynamicPrintConfig config;
        config.set_deserialize("spiral_vase", "1");
        config.set_deserialize("retract_layer_change", "1,0");
        config.normalize();
        REQUIRE(config.serialize("retract_layer_change") == "0,0");
    }
    DynamicPrintConfig bad;
    REQUIRE_NOTHROW(bad.load(std::string(testfile_dir) + "test_config/bad_config_options.ini"));
}

TEST_CASE("Config from command line arguments") {
    auto parse = [](std::vector<std::string> tokens) {
        std::unique_ptr<DynamicPrintConfig> config {new DynamicPrintConfig()};
        t_config_option_keys files;
        config->read_cli(tokens, &files);
        return config;
    };
    auto config = parse({"--extra-perimeters", "--perimeters", "1", "--layer-height", "0.45", "--fill-density", "70%",
        "--detect-bridging-perimeters", "--notes=foobar"});
    REQUIRE(config->serialize("extra_perimeters") == "1");
    REQUIRE(config->serialize("perimeters") == "1");
    REQUIRE(config->serialize("layer_height") == "0.45");
    REQUIRE(config->serialize("fill_density") == "70%");
    REQUIRE(config->serialize("overhangs") == "1");  // an alternative name
    REQUIRE(config->serialize("notes") == "foobar");
    REQUIRE(parse({"--extra-perimeters", "--no-extra-perimeters"})->serialize("extra_perimeters") == "0");
    REQUIRE(parse({"--wipe", "--no-wipe", "--wipe"})->serialize("wipe") == "1,0,1");
    REQUIRE(parse({"--post-process", "foo", "--post-process", "bar"})->serialize("post_process") == "foo;bar");
    REQUIRE(parse({"--retract-speed", "0.4", "--retract-speed", "0.5"})->serialize("retract_speed") == "0.4,0.5");
    REQUIRE(parse({"--extruder-offset", "0,0", "--extruder-offset", "10x5"})->serialize("extruder_offset") == "0x0,10x5");
}
