// From test_print.cpp.
#include <gtest/gtest.h>

#include <algorithm>
#include <cmath>
#include <map>
#include <sstream>
#include <string>
#include <vector>

#include "test_data.hpp"
#include "libslic3r.h"
#include "Print.hpp"
#include "GCodeReader.hpp"
#include "boost/filesystem.hpp"

using namespace Slic3r::Test;
using namespace std::literals;

void test_is_solid_infill(shared_Print p, size_t obj_id, size_t layer_id ) {
    const PrintObject& obj { *(p->objects.at(obj_id)) };
    const Layer& layer { *(obj.get_layer(layer_id)) };

    // iterate over all of the regions in the layer
    for (const LayerRegion* reg : layer.regions) {
        // for each region, iterate over the fill surfaces
        for (const Surface& s : reg->fill_surfaces) {
            EXPECT_TRUE(s.is_solid());
        }
    }
}

// PrintObject: Perimeter generation; 20mm cube and default config; make_perimeters() is called
TEST(Print, MakePerimetersIsCalled) {
    {  // given: 20mm cube and default config
        auto config {Slic3r::Config::new_from_defaults()};
        TestMesh m { TestMesh::cube_20x20x20 };
        Slic3r::Model model;
        auto event_counter {0U};
        std::string stage;
        int value {0};
        auto callback {[&event_counter, &stage, &value] (int a, const char* b) { stage = std::string(b); event_counter++; value = a; }};
        config->set("fill_density", 0);
        {  // when: make_perimeters() is called
            auto print {Slic3r::Test::init_print({m}, model, config)};
            const auto& object = *(print->objects.at(0));
            print->objects[0]->make_perimeters();
            {  // then: 67 layers exist in the model
                ASSERT_EQ(object.layers.size(), 67u);
            }
            {  // then: Every layer in region 0 has 1 island of perimeters
                for(auto* layer : object.layers) {
                    ASSERT_EQ(layer->regions[0]->perimeters.size(), 1u);
                }
            }
            {  // then: Every layer in region 0 has 3 paths in its perimeters list.
                for(auto* layer : object.layers) {
                    EXPECT_EQ(layer->regions[0]->perimeters.items_count(), 3);
                }
            }
        }
    }
}

// Print: Skirt generation; 20mm cube and default config; Skirts is set to 2 loops
TEST(Print, SkirtsIsSetTo2Loops) {
    {  // given: 20mm cube and default config
        auto config {Slic3r::Config::new_from_defaults()};
        TestMesh m { TestMesh::cube_20x20x20 };
        Slic3r::Model model;
        auto event_counter {0U};
        std::string stage;
        int value {0};
        config->set("skirt_height", 1);
        config->set("skirt_distance", 1);
        {  // when: Skirts is set to 2 loops
            config->set("skirts", 2);
            auto print {Slic3r::Test::init_print({m}, model, config)};
            print->make_skirt();
            {  // then: Skirt Extrusion collection has 2 loops in it
                EXPECT_EQ(print->skirt.items_count(), 2);
                ASSERT_EQ(print->skirt.flatten().entities.size(), 2u);
            }
        }
    }
}

// Print: Changing number of solid surfaces does not cause all surfaces to become internal.; sliced 20mm cube and config with top_solid_surfaces = 2 and bottom_solid_surfaces = 1; Model is re-sliced with top_solid_layers == 3
TEST(Print, ModelIsReSlicedWithTopSolidLayers3) {
    {  // given: sliced 20mm cube and config with top_solid_surfaces = 2 and bottom_solid_surfaces = 1
        auto config {Slic3r::Config::new_from_defaults()};
        TestMesh m { TestMesh::cube_20x20x20 };
        config->set("top_solid_layers", 2);
        config->set("bottom_solid_layers", 1);
        config->set("layer_height", 0.5); // get a known number of layers
        config->set("first_layer_height", 0.5);
        Slic3r::Model model;
        auto event_counter {0U};
        std::string stage;
        auto print {Slic3r::Test::init_print({m}, model, config)};
        print->process();
        // Precondition: Ensure that the model has 2 solid top layers (39, 38)
        // and one solid bottom layer (0).
        test_is_solid_infill(print, 0, 0); // should be solid
        test_is_solid_infill(print, 0, 39); // should be solid
        test_is_solid_infill(print, 0, 38); // should be solid
        {  // when: Model is re-sliced with top_solid_layers == 3
            print->regions[0]->config.top_solid_layers = 3;
            print->objects[0]->invalidate_step(posPrepareInfill);
            print->process();
            {  // then: Print object does not have 0 solid bottom layers.
                test_is_solid_infill(print, 0, 0);
            }
            {  // and then: Print object has 3 top solid layers
                test_is_solid_infill(print, 0, 39);
                test_is_solid_infill(print, 0, 38);
                test_is_solid_infill(print, 0, 37);
            }
        }
    }
}

// Print: Brim generation; 20mm cube and default config, 1mm first layer width; Brim is set to 3mm
TEST(Print, BrimIsSetTo3mm) {
    {  // given: 20mm cube and default config, 1mm first layer width
        auto config {Slic3r::Config::new_from_defaults()};
        TestMesh m { TestMesh::cube_20x20x20 };
        Slic3r::Model model;
        auto event_counter {0U};
        std::string stage;
        int value {0};
        config->set("first_layer_extrusion_width", 1);
        {  // when: Brim is set to 3mm
            config->set("brim_width", 3);
            auto print {Slic3r::Test::init_print({m}, model, config)};
            print->make_brim();
            {  // then: Brim Extrusion collection has 3 loops in it
                EXPECT_EQ(print->brim.items_count(), 3);
            }
        }
    }
}

// Print: Brim generation; 20mm cube and default config, 1mm first layer width; Brim is set to 6mm
TEST(Print, BrimIsSetTo6mm) {
    {  // given: 20mm cube and default config, 1mm first layer width
        auto config {Slic3r::Config::new_from_defaults()};
        TestMesh m { TestMesh::cube_20x20x20 };
        Slic3r::Model model;
        auto event_counter {0U};
        std::string stage;
        int value {0};
        config->set("first_layer_extrusion_width", 1);
        {  // when: Brim is set to 6mm
            config->set("brim_width", 6);
            auto print {Slic3r::Test::init_print({m}, model, config)};
            print->make_brim();
            {  // then: Brim Extrusion collection has 6 loops in it
                EXPECT_EQ(print->brim.items_count(), 6);
            }
        }
    }
}

// Print: Brim generation; 20mm cube and default config, 1mm first layer width; Brim is set to 6mm, extrusion width 0.5mm
TEST(Print, BrimIsSetTo6mmExtrusionWidth05mm) {
    {  // given: 20mm cube and default config, 1mm first layer width
        auto config {Slic3r::Config::new_from_defaults()};
        TestMesh m { TestMesh::cube_20x20x20 };
        Slic3r::Model model;
        auto event_counter {0U};
        std::string stage;
        int value {0};
        config->set("first_layer_extrusion_width", 1);
        {  // when: Brim is set to 6mm, extrusion width 0.5mm
            config->set("brim_width", 6);
            config->set("first_layer_extrusion_width", 0.5);
            auto print {Slic3r::Test::init_print({m}, model, config)};
            print->make_brim();
            {  // then: Brim Extrusion collection has 12 loops in it
                EXPECT_EQ(print->brim.items_count(), 12);
            }
        }
    }
}

// Post-processing scripts (as the Perl escaped_split); script lines
TEST(Print, ScriptLines) {
    using namespace Slic3r;
    {  // given: script lines
        {  // then: they split on whitespace
            EXPECT_EQ(split_post_process_script("/bin/script  --flag x"), std::vector<std::string>({"/bin/script", "--flag", "x"}));
        }
        {  // then: '!' before whitespace keeps it, '!!' is '!'
            EXPECT_EQ(split_post_process_script("/my! dir/script a!!b c!d"), std::vector<std::string>({"/my dir/script", "a!b", "c!d"}));
        }
    }
}

// Post-processing scripts (as the Perl escaped_split); a program that creates the file it gets; it is run as a post-processing script
TEST(Print, ItIsRunAsAPostProcessingScript) {
    using namespace Slic3r;
    {  // given: a program that creates the file it gets
        const std::string file {(boost::filesystem::temp_directory_path()
            / boost::filesystem::unique_path("slic3r-pp-%%%%%%.gcode")).string()};
        {  // when: it is run as a post-processing script
            run_post_process_script("/usr/bin/touch", file);
            {  // then: it got the G-code file as last argument, without a shell
                EXPECT_TRUE(boost::filesystem::exists(file));
                boost::filesystem::remove(file);
            }
        }
    }
}

// Post-processing scripts (as the Perl escaped_split); a program that creates the file it gets; the script is not executable
TEST(Print, TheScriptIsNotExecutable) {
    using namespace Slic3r;
    {  // given: a program that creates the file it gets
        const std::string file {(boost::filesystem::temp_directory_path()
            / boost::filesystem::unique_path("slic3r-pp-%%%%%%.gcode")).string()};
        {  // when: the script is not executable
            {  // then: it is an error
                EXPECT_ANY_THROW(run_post_process_script("/nonexistent/script", file));
            }
        }
    }
}

// Fuzzy skin; a 20 mm cube
TEST(Print, FuzzySkinA20MmCube) {
    // extrusion moves per layer height
    auto moves_by_z = [] (std::shared_ptr<Slic3r::Config> config) {
        Slic3r::Model model;
        auto print {init_print({TestMesh::cube_20x20x20}, model, config)};
        std::stringstream gcode;
        Slic3r::Test::gcode(gcode, print);
        std::map<double, std::vector<std::string>> moves;
        Slic3r::GCodeReader().parse_stream(gcode, [&moves] (Slic3r::GCodeReader& self, const Slic3r::GCodeReader::GCodeLine& line) {
            if (line.extruding() && line.dist_XY() > 0) moves[self.Z].push_back(line.raw);
        });
        return moves;
    };
    {  // given: a 20 mm cube
        auto config {Slic3r::Config::new_from_defaults()};
        const auto plain {moves_by_z(config)};
        config->set("fuzzy_skin", true);
        const auto fuzzy {moves_by_z(config)};
        {  // then: the first layer is unchanged
            EXPECT_EQ(fuzzy.begin()->second, plain.begin()->second);
        }
        {  // then: the outer wall of the other layers has many more points
            const double z = std::next(plain.begin(), 3)->first;
            EXPECT_GT(fuzzy.at(z).size(), plain.at(z).size() + 50);
        }
        {  // then: the output is the same on every run
            EXPECT_EQ(moves_by_z(config), fuzzy);
        }
    }
}

// Ironing; a 20 mm cube
TEST(Print, IroningA20MmCube) {
    // per layer: E per mm of each extrusion move, in printing order
    auto flow_by_z = [] (std::shared_ptr<Slic3r::Config> config) {
        Slic3r::Model model;
        auto print {init_print({TestMesh::cube_20x20x20}, model, config)};
        std::stringstream gcode;
        Slic3r::Test::gcode(gcode, print);
        std::map<double, std::vector<double>> flow;
        Slic3r::GCodeReader().parse_stream(gcode, [&flow] (Slic3r::GCodeReader& self, const Slic3r::GCodeReader::GCodeLine& line) {
            if (line.extruding() && line.dist_XY() > 0) flow[self.Z].push_back(line.dist_E() / line.dist_XY());
        });
        return flow;
    };
    auto max_of = [] (const std::vector<double> &v) { return *std::max_element(v.begin(), v.end()); };
    {  // given: a 20 mm cube
        auto config {Slic3r::Config::new_from_defaults()};
        {  // then: without ironing there are no low-flow moves
            for (const auto &layer : flow_by_z(config))
                for (const double f : layer.second) EXPECT_GT(f, 0.25 * max_of(layer.second));
        }
        config->set("ironing", true);
        const auto flow {flow_by_z(config)};
        {  // then: the top layer ends with a low-flow pass, and only the top layer has one
            const auto &top = flow.rbegin()->second;
            const double full = max_of(top);
            size_t first_low = top.size();
            for (size_t i = 0; i < top.size(); ++i)
                if (top[i] < 0.25 * full) { first_low = i; break; }
            EXPECT_LT(first_low, top.size());
            EXPECT_GT(top.size() - first_low, 50);        // dense lines
            for (size_t i = first_low; i < top.size(); ++i)
                EXPECT_LT(top[i], 0.25 * full);           // nothing printed after it
            for (auto it = flow.begin(); it != std::prev(flow.end()); ++it)
                for (const double f : it->second) EXPECT_GT(f, 0.25 * max_of(it->second));
        }
    }
}
