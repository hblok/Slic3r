// From test_printobject.cpp.
#include <gtest/gtest.h>

#include <cmath>
#include <sstream>
#include <string>
#include <vector>

#include "test_data.hpp"
#include "Log.hpp"
#include "libslic3r.h"

using namespace Slic3r::Test;
using namespace std::literals;

/// equal within the tolerance Catch's Approx used
#define EXPECT_APPROX(value, expected) EXPECT_NEAR(value, expected, 1.2e-5 * std::abs(expected))
[[maybe_unused]] bool approximately(double a, double b, double margin = -1) {
    return std::abs(a - b) <= (margin < 0 ? 1.2e-5 * std::abs(b) : margin);
}

// PrintObject: object layer heights; 20mm cube and default initial config, initial layer height of 2mm; generate_object_layers() is called for 2mm layer heights and nozzle diameter of 3mm
TEST(PrintObject, GenerateObjectLayersIsCalledFor2mmLayerHeightsAndNozzleDiameter) {
    {  // given: 20mm cube and default initial config, initial layer height of 2mm
        auto config {Slic3r::Config::new_from_defaults()};
        TestMesh m { TestMesh::cube_20x20x20 };
        Slic3r::Model model;

        config->set("first_layer_height", 2.0);
        {  // when: generate_object_layers() is called for 2mm layer heights and nozzle diameter of 3mm
            config->set("nozzle_diameter", "3");
            config->set("layer_height", 2.0);
            auto print {Slic3r::Test::init_print({m}, model, config)};
            auto result {print->objects[0]->generate_object_layers(2.0)};
            {  // then: The output vector has 10 entries
                ASSERT_EQ(result.size(), 10u);
            }
            {  // and then: Each layer is approximately 2mm above the previous Z
                coordf_t last = 0.0;
                for (size_t i = 0; i < result.size(); i++) {
                    EXPECT_APPROX((result[i] - last), 2.0);
                    last = result[i];
                }
            }
        }
    }
}

// PrintObject: object layer heights; 20mm cube and default initial config, initial layer height of 2mm; generate_object_layers() is called for 10mm layer heights and nozzle diameter of 11mm
TEST(PrintObject, GenerateObjectLayersIsCalledFor10mmLayerHeightsAndNozzleDiameter) {
    {  // given: 20mm cube and default initial config, initial layer height of 2mm
        auto config {Slic3r::Config::new_from_defaults()};
        TestMesh m { TestMesh::cube_20x20x20 };
        Slic3r::Model model;

        config->set("first_layer_height", 2.0);
        {  // when: generate_object_layers() is called for 10mm layer heights and nozzle diameter of 11mm
            config->set("nozzle_diameter", "11");
            config->set("layer_height", 10.0);
            auto print {Slic3r::Test::init_print({m}, model, config)};
            auto result {print->objects[0]->generate_object_layers(2.0)};
            {  // then: The output vector has 2 entries
                ASSERT_EQ(result.size(), 3u);
            }
            {  // and then: Layer 0 is at 2mm
                EXPECT_APPROX(result[0], 2.0);
            }
            {  // and then: Layer 1 is at 12mm
                EXPECT_APPROX(result[1], 12.0);
            }
        }
    }
}

// PrintObject: object layer heights; 20mm cube and default initial config, initial layer height of 2mm; generate_object_layers() is called for 15mm layer heights and nozzle diameter of 16mm
TEST(PrintObject, 20mmCubeAndDefaultInitialConfigGenerateObjectLayersIsCalledFor15mmLayer) {
    {  // given: 20mm cube and default initial config, initial layer height of 2mm
        auto config {Slic3r::Config::new_from_defaults()};
        TestMesh m { TestMesh::cube_20x20x20 };
        Slic3r::Model model;

        config->set("first_layer_height", 2.0);
        {  // when: generate_object_layers() is called for 15mm layer heights and nozzle diameter of 16mm
            config->set("nozzle_diameter", "16");
            config->set("layer_height", 15.0);
            auto print {Slic3r::Test::init_print({m}, model, config)};
            auto result {print->objects[0]->generate_object_layers(2.0)};
            {  // then: The output vector has 2 entries
                ASSERT_EQ(result.size(), 3u);
            }
            {  // and then: Layer 0 is at 2mm
                EXPECT_APPROX(result[0], 2.0);
            }
            {  // and then: Layer 1 is at 17mm
                EXPECT_APPROX(result[1], 17.0);
            }
        }
    }
}

// PrintObject: object layer heights; 20mm cube and default initial config, initial layer height of 2mm; generate_object_layers() is called for 15mm layer heights and nozzle diameter of 5mm
TEST(PrintObject, ObjectLayerHeightsGenerateObjectLayersIsCalledFor15mmLayer) {
    {  // given: 20mm cube and default initial config, initial layer height of 2mm
        auto config {Slic3r::Config::new_from_defaults()};
        TestMesh m { TestMesh::cube_20x20x20 };
        Slic3r::Model model;

        config->set("first_layer_height", 2.0);
        {  // when: generate_object_layers() is called for 15mm layer heights and nozzle diameter of 5mm
            config->set("nozzle_diameter", "5");
            config->set("layer_height", 15.0);
            auto print {Slic3r::Test::init_print({m}, model, config)};
            auto result {print->objects[0]->generate_object_layers(2.0)};
            {  // then: The layer height is limited to 5mm.
                EXPECT_EQ(result.size(), 5u);
                coordf_t last = 2.0;
                for (size_t i = 1; i < result.size(); i++) {
                    EXPECT_APPROX((result[i] - last), 5.0);
                    last = result[i];
                }
            }
        }
    }
}

// PrintObject: minimum horizontal shells; 20mm cube and default initial config, initial layer height of 0.1mm; min shell thickness is 1.0 with layer height of 0.1
TEST(PrintObject, MinShellThicknessIs10WithLayerHeightOf01) {
    {  // given: 20mm cube and default initial config, initial layer height of 0.1mm
        auto config {Slic3r::Config::new_from_defaults()};
        TestMesh m { TestMesh::cube_20x20x20 };
        Slic3r::Model model;

        config->set("nozzle_diameter", "3");
        config->set("bottom_solid_layers", 1);
        config->set("perimeters", 1);
        config->set("first_layer_height", 0.1);
        config->set("layer_height", 0.1);
        config->set("fill_density", "0%");
        config->set("min_top_bottom_shell_thickness", 1.0);
        {  // when: min shell thickness is 1.0 with layer height of 0.1
            config->set("min_top_bottom_shell_thickness", 1.0);
            auto print {Slic3r::Test::init_print({m}, model, config)};
            slic3r_log->set_level(log_t::DEBUG);
            print->objects[0]->prepare_infill();
            for (int i = 0; i < 12; i++)
                print->objects[0]->layers[i]->make_fills();
            {  // then: Layers 0-9 are solid (Z < 1.0) (all fill_surfaces are solid)
                for (int i = 0; i < 10; i++) {
                    EXPECT_LE(print->objects[0]->layers[i]->print_z, (i+1 * 0.1));
                    for (auto* r : print->objects[0]->layers[i]->regions) {
                        for (auto s : r->fill_surfaces) {
                            EXPECT_TRUE(s.is_solid());
                        }
                    }
                }
            }
            {  // and then: Layer 10 (Z > 1.0) is not solid.
                for (auto* r : print->objects[0]->layers[10]->regions) {
                    bool all_solid = true;
                    for (auto s : r->fill_surfaces) {
                        EXPECT_TRUE(!s.is_solid());
                    }
                }
            }
        }
    }
}

// PrintObject: minimum horizontal shells; 20mm cube and default initial config, initial layer height of 0.1mm; min shell thickness is 1.22 with layer height of 0.1
TEST(PrintObject, MinShellThicknessIs122WithLayerHeightOf01) {
    {  // given: 20mm cube and default initial config, initial layer height of 0.1mm
        auto config {Slic3r::Config::new_from_defaults()};
        TestMesh m { TestMesh::cube_20x20x20 };
        Slic3r::Model model;

        config->set("nozzle_diameter", "3");
        config->set("bottom_solid_layers", 1);
        config->set("perimeters", 1);
        config->set("first_layer_height", 0.1);
        config->set("layer_height", 0.1);
        config->set("fill_density", "0%");
        config->set("min_top_bottom_shell_thickness", 1.0);
        {  // when: min shell thickness is 1.22 with layer height of 0.1
            config->set("min_top_bottom_shell_thickness", 1.22);
            config->set("layer_height", 0.1);
            auto print {Slic3r::Test::init_print({m}, model, config)};
            slic3r_log->set_level(log_t::DEBUG);
            print->objects[0]->prepare_infill();
            for (int i = 0; i < 20; i++)
                print->objects[0]->layers[i]->make_fills();
            {  // and then: Layers 0-12 are solid (bottom of layer >= 1.22) (all fill_surfaces are solid)
                for (int i = 0; i < 13; i++) {
                    EXPECT_LE(print->objects[0]->layers[i]->print_z, (i+1 * 0.1));
                    for (auto* r : print->objects[0]->layers[i]->regions) {
                        for (auto s : r->fill_surfaces) {
                            EXPECT_TRUE(s.is_solid());
                        }
                    }
                }
            }
            {  // and then: Layer 13 (Z > 1.0) is not solid.
                for (auto* r : print->objects[0]->layers[13]->regions) {
                    bool all_solid = true;
                    for (auto s : r->fill_surfaces) {
                        EXPECT_TRUE(!s.is_solid());
                    }
                }
            }
        }
    }
}

// PrintObject: minimum horizontal shells; 20mm cube and default initial config, initial layer height of 0.1mm; min shell thickness is 1.22 14 bottom layers
TEST(PrintObject, MinShellThicknessIs12214BottomLayers) {
    {  // given: 20mm cube and default initial config, initial layer height of 0.1mm
        auto config {Slic3r::Config::new_from_defaults()};
        TestMesh m { TestMesh::cube_20x20x20 };
        Slic3r::Model model;

        config->set("nozzle_diameter", "3");
        config->set("bottom_solid_layers", 1);
        config->set("perimeters", 1);
        config->set("first_layer_height", 0.1);
        config->set("layer_height", 0.1);
        config->set("fill_density", "0%");
        config->set("min_top_bottom_shell_thickness", 1.0);
        {  // when: min shell thickness is 1.22 14 bottom layers
            config->set("min_top_bottom_shell_thickness", 1.22);
            config->set("bottom_solid_layers", 14);
            config->set("layer_height", 0.1);
            auto print {Slic3r::Test::init_print({m}, model, config)};
            slic3r_log->set_level(log_t::DEBUG);
            print->objects[0]->prepare_infill();
            for (int i = 0; i < 20; i++)
                print->objects[0]->layers[i]->make_fills();
            {  // and then: Layers 0-13 are solid (bottom of layer >= 1.22) (all fill_surfaces are solid)
                for (int i = 0; i < 14; i++) {
                    EXPECT_LE(print->objects[0]->layers[i]->print_z, (i+1 * 0.1));
                    for (auto* r : print->objects[0]->layers[i]->regions) {
                        for (auto s : r->fill_surfaces) {
                            EXPECT_TRUE(s.is_solid());
                        }
                    }
                }
            }
            {  // and then: Layer 14 is not solid.
                for (auto* r : print->objects[0]->layers[14]->regions) {
                    bool all_solid = true;
                    for (auto s : r->fill_surfaces) {
                        EXPECT_TRUE(!s.is_solid());
                    }
                }
            }
        }
    }
}

// PrintObject: drawn layer heights are used when the object is sliced anew; A 20mm cube with 0.4mm layers; all heights are drawn at 0.2mm
TEST(PrintObject, AllHeightsAreDrawnAt02mm) {
    {  // given: A 20mm cube with 0.4mm layers
        auto config {Slic3r::Config::new_from_defaults()};
        config->set("nozzle_diameter", "0.5");
        config->set("layer_height", 0.4);
        config->set("first_layer_height", 0.4);
        Slic3r::Model model;
        auto print {Slic3r::Test::init_print({TestMesh::cube_20x20x20}, model, config)};
        auto* object {print->objects[0]};
        object->prepare_layer_heights();
        auto spline {object->layer_height_spline};
        const auto positions {spline.getOriginalLayers()};
        const size_t standard {positions.size()};

        // the layers of a new print of the same model
        auto layers = [&config](Slic3r::Model& what) {
            Slic3r::Print again;
            again.apply_config(config->config());
            again.add_model_object(what.objects[0]);
            coordf_t raft {0};
            return again.objects[0]->generate_object_layers(again.objects[0]->first_object_layer_height(&raft)).size();
        };
        {  // when: all heights are drawn at 0.2mm
            EXPECT_TRUE(spline.updateLayerHeights(std::vector<coordf_t>(positions.size(), 0.2)));
            model.objects[0]->layer_height_spline = spline;
            {  // then: there are about twice the layers
                EXPECT_EQ(standard, 50);
                EXPECT_GT(layers(model), 90);
            }
            {  // and then: an object of another height gets the standard layers
                model.objects[0]->scale(Pointf3(1, 1, 2));
                EXPECT_EQ(layers(model), 100);
            }
        }
    }
}
