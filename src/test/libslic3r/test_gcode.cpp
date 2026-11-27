#include <catch.hpp>
#include <regex>
#include "test_data.hpp"
#include "GCodeReader.hpp"
#include "GCodeTimeEstimator.hpp"
#include "PlaceholderParser.hpp"
#include "GCode.hpp"

using namespace Slic3r::Test;
using namespace Slic3r;


#include "GCode/CoolingBuffer.hpp"
#include "GCode.hpp"

SCENARIO("Cooling buffer speed factor rewrite enforces precision") {
    GIVEN("GCode line of set speed") {
        std::string gcode_string = "G1 F1000000.000";
        WHEN("40% speed factor is applied to a speed of 1000000 with 3-digit precision") {
            Slic3r::apply_speed_factor(gcode_string, (1.0f/3.0f), 30.0);
            REQUIRE_THAT(gcode_string, Catch::Equals("G1 F333333.344"));
        }
    }
}

SCENARIO( "Test of COG calculation") {
    GIVEN("A default configuration and a print test object") {
        auto config {Slic3r::Config::new_from_defaults()};
        auto gcode {std::stringstream("")};

        WHEN("the output is executed with no support material") {
            Slic3r::Model model;
            auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
            print->process();
            Slic3r::Test::gcode(gcode, print);
            auto exported {gcode.str()};

            THEN("Some text output is generated.") {
                REQUIRE(exported.size() > 0);
            }

            THEN("COG values are contained in output") {
                REQUIRE(exported.find("; cog_x") != std::string::npos);
                REQUIRE(exported.find("; cog_y") != std::string::npos);
                REQUIRE(exported.find("; cog_z") != std::string::npos);
            }

            THEN("Check if COG values are correct") {

                int cog_x_start = exported.find("; cog_x = ");
                int cog_x_len = exported.substr(cog_x_start).find('\n');
                int cog_y_start = exported.find("; cog_y = ");
                int cog_y_len = exported.substr(cog_y_start).find('\n');
                int cog_z_start = exported.find("; cog_z = ");
                int cog_z_len = exported.substr(cog_z_start).find('\n');

                float val_x, val_y, val_z;
                // crop cog_x text
                val_x = std::stof(exported.substr(cog_x_start + 10, cog_x_len - 10));
                val_y = std::stof(exported.substr(cog_y_start + 10, cog_y_len - 10));
                val_z = std::stof(exported.substr(cog_z_start + 10, cog_z_len - 10));

                REQUIRE(abs(val_x-100.0) <= 0.5);
                REQUIRE(abs(val_y-100.0) <= 0.5);
                REQUIRE(abs(val_z-10.0) <= 0.5);
            }
        }

        gcode.clear();
    }
}

SCENARIO("Print time estimate") {
    using Slic3r::GCodeTimeEstimator;
    THEN("times are written as hours, minutes and seconds") {
        REQUIRE(GCodeTimeEstimator::format_time(59.6) == "1m 0s");
        REQUIRE(GCodeTimeEstimator::format_time(3725) == "1h 2m 5s");
        REQUIRE(GCodeTimeEstimator::format_time(7) == "7s");
    }
    GIVEN("a 100 mm move at 50 mm/s") {
        const std::string gcode = "G1 X100 F3000\n";
        THEN("a lower acceleration gives a longer estimate") {
            GCodeTimeEstimator slow(500), fast(9000);
            slow.parse(gcode);
            fast.parse(gcode);
            REQUIRE(fast.time == Approx(2.0).epsilon(0.05));  // 100 mm / 50 mm/s plus a little
            REQUIRE(slow.time > fast.time);
        }
        THEN("an M204 in the G-code wins") {
            GCodeTimeEstimator e(500), f(9000);
            e.parse("M204 S9000\n" + gcode);
            f.parse(gcode);
            REQUIRE(e.time == Approx(f.time));
        }
    }
}

SCENARIO("Placeholders keep fractional numbers") {
    Slic3r::PlaceholderParser pp;
    pp.set("layer_z", 0.2);
    pp.set("count", 3);
    pp.set("extruder", 1u);
    THEN("doubles are not cut to integers (layer_z was \"0\" for 0.2 mm)") {
        REQUIRE(pp.process("[layer_z] [count] [extruder]") == "0.2 3 1");
    }
    THEN("they print like Perl numbers") {
        pp.set("layer_z", 0.30000000000000004);
        REQUIRE(pp.process("[layer_z]") == "0.3");
    }
}
