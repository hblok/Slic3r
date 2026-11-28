// From test_support_material.cpp.
#include <gtest/gtest.h>

#include <cmath>
#include <sstream>
#include <string>
#include <vector>

#include "IO.hpp"
#include "GCodeReader.hpp"
#include "libslic3r.h"
#include "TriangleMesh.hpp"
#include "Model.hpp"
#include "SupportMaterial.hpp"
#include "test_data.hpp"

using namespace std;
using namespace Slic3r;

void test_1_checks(Print &print, bool &a, bool &b, bool &c, bool &d);

// Testing 0.1: supports material member functions.


// Test 1.


// Test 8.


// Test 6.


void test_1_checks(Print &print, bool &a, bool &b, bool &c, bool &d)
{
    vector<coordf_t> contact_z = {1.9};
    vector<coordf_t> top_z = {1.1};

    SupportMaterial *support = print.objects.front()->_support_material();

    vector<coordf_t>
        support_z = support->support_layers_z(contact_z, top_z, print.default_object_config.layer_height);

    a = (support_z[0] == print.default_object_config.first_layer_height.value);

    b = true;
    for (size_t i = 1; i < support_z.size(); ++i)
        if (support_z[i] - support_z[i - 1] <= 0) b = false;


    c = true;
    for (size_t i = 1; i < support_z.size(); ++i)
        if (support_z[i] - support_z[i - 1] > print.config.nozzle_diameter.get_at(0) + EPSILON)
            c = false;

    coordf_t expected_top_spacing = support
        ->contact_distance(print.default_object_config.layer_height,
                           print.config.nozzle_diameter.get_at(0));

    bool wrong_top_spacing = 0;
    for (coordf_t top_z_el : top_z) {
        // find layer index of this top surface.
        size_t layer_id = -1;
        for (size_t i = 0; i < support_z.size(); i++) {
            if (abs(support_z[i] - top_z_el) < EPSILON) {
                layer_id = i;
                i = static_cast<int>(support_z.size());
            }
        }

        // check that first support layer above this top surface (or the next one) is spaced with nozzle diameter
        if (abs(support_z[layer_id + 1] - support_z[layer_id] - expected_top_spacing) > EPSILON
            && abs(support_z[layer_id + 2] - support_z[layer_id] - expected_top_spacing) > EPSILON) {
            wrong_top_spacing = 1;
        }
    }
    d = !wrong_top_spacing;
}

// TODO

// SupportMaterial: a raft of 3 layers gives 3 support layers
TEST(SupportMaterial, ARaftOf3LayersGives3SupportLayers) {
    // Create a mesh & modelObject.
    TriangleMesh mesh = TriangleMesh::make_cube(20, 20, 20);

    // Create modelObject.
    Model model = Model();
    ModelObject *object = model.add_object();
    object->add_volume(mesh);
    model.add_default_instances();

    // Align to origin.
    model.align_instances_to_origin();

    // Create Print.
    Print print = Print();
    vector<coordf_t> contact_z = {1.9};
    vector<coordf_t> top_z = {1.1};
    print.default_object_config.support_material = 1;
    print.default_object_config.set_deserialize("raft_layers", "3");
    print.add_model_object(model.objects[0]);
    print.objects.front()->_slice();


    SupportMaterial *support = print.objects.front()->_support_material();

    support->generate(print.objects.front());
    EXPECT_EQ(print.objects.front()->support_layer_count(), 3);
}

// SupportMaterial: support_layers_z and contact_distance; A print object having one modelObject; First layer height = 0.4
TEST(SupportMaterial, FirstLayerHeight04) {
    {  // given: A print object having one modelObject
        // Create a mesh & modelObject.
        TriangleMesh mesh = TriangleMesh::make_cube(20, 20, 20);

        // Create modelObject.
        Model model = Model();
        ModelObject *object = model.add_object();
        object->add_volume(mesh);
        model.add_default_instances();

        // Align to origin.
        model.align_instances_to_origin();
        // Create Print.
        Print print = Print();
        print.default_object_config.set_deserialize("support_material", "1");
        {  // when: First layer height = 0.4
            print.default_object_config.set_deserialize("layer_height", "0.2");
            print.default_object_config.set_deserialize("first_layer_height", "0.4");

            print.add_model_object(model.objects[0]);
            print.objects.front()->_slice();
            bool a, b, c, d;

            test_1_checks(print, a, b, c, d);
            {  // then: First layer height is honored
                EXPECT_EQ(a, true);
            }
            {  // then: No null or negative support layers
                EXPECT_EQ(b, true);
            }
            {  // then: No layers thicker than nozzle diameter
                EXPECT_EQ(c, true);
            }
            {  // then: Layers above top surfaces are spaced correctly
                EXPECT_EQ(d, true);
            }
        }
    }
}

// SupportMaterial: support_layers_z and contact_distance; A print object having one modelObject; Layer height = 0.2 and, first layer height = 0.3
TEST(SupportMaterial, LayerHeight02AndFirstLayerHeight03) {
    {  // given: A print object having one modelObject
        // Create a mesh & modelObject.
        TriangleMesh mesh = TriangleMesh::make_cube(20, 20, 20);

        // Create modelObject.
        Model model = Model();
        ModelObject *object = model.add_object();
        object->add_volume(mesh);
        model.add_default_instances();

        // Align to origin.
        model.align_instances_to_origin();
        // Create Print.
        Print print = Print();
        print.default_object_config.set_deserialize("support_material", "1");
        {  // when: Layer height = 0.2 and, first layer height = 0.3
            print.default_object_config.set_deserialize("layer_height", "0.2");
            print.default_object_config.set_deserialize("first_layer_height", "0.3");
            print.add_model_object(model.objects[0]);
            print.objects.front()->_slice();
            bool a, b, c, d;

            test_1_checks(print, a, b, c, d);
            {  // then: First layer height is honored
                EXPECT_EQ(a, true);
            }
            {  // then: No null or negative support layers
                EXPECT_EQ(b, true);
            }
            {  // then: No layers thicker than nozzle diameter
                EXPECT_EQ(c, true);
            }
            {  // then: Layers above top surfaces are spaced correctly
                EXPECT_EQ(d, true);
            }
        }
    }
}

// SupportMaterial: support_layers_z and contact_distance; A print object having one modelObject; Layer height = nozzle_diameter[0]
TEST(SupportMaterial, LayerHeightNozzleDiameter0) {
    {  // given: A print object having one modelObject
        // Create a mesh & modelObject.
        TriangleMesh mesh = TriangleMesh::make_cube(20, 20, 20);

        // Create modelObject.
        Model model = Model();
        ModelObject *object = model.add_object();
        object->add_volume(mesh);
        model.add_default_instances();

        // Align to origin.
        model.align_instances_to_origin();
        // Create Print.
        Print print = Print();
        print.default_object_config.set_deserialize("support_material", "1");
        {  // when: Layer height = nozzle_diameter[0]
            // as t/support.t (this was a copy of the 0.2 / 0.3 case)
            print.default_object_config.layer_height = print.config.nozzle_diameter.values.front();
            print.default_object_config.set_deserialize("first_layer_height", "0.4");
            print.add_model_object(model.objects[0]);
            print.objects.front()->_slice();
            bool a, b, c, d;

            test_1_checks(print, a, b, c, d);
            {  // then: First layer height is honored
                EXPECT_EQ(a, true);
            }
            {  // then: No null or negative support layers
                EXPECT_EQ(b, true);
            }
            {  // then: No layers thicker than nozzle diameter
                EXPECT_EQ(c, true);
            }
            {  // then: Layers above top surfaces are spaced correctly
                EXPECT_EQ(d, true);
            }
        }
    }
}

// SupportMaterial: forced support is generated
TEST(SupportMaterial, ForcedSupportIsGenerated) {
    // Create a mesh & modelObject.
    TriangleMesh mesh = TriangleMesh::make_cube(20, 20, 20);

    Model model = Model();
    ModelObject *object = model.add_object();
    object->add_volume(mesh);
    model.add_default_instances();
    model.align_instances_to_origin();

    Print print = Print();

    vector<coordf_t> contact_z = {1.9};
    vector<coordf_t> top_z = {1.1};
    print.default_object_config.support_material_enforce_layers = 100;
    print.default_object_config.support_material = 0;
    print.default_object_config.layer_height = 0.2;
    print.default_object_config.set_deserialize("first_layer_height", "0.3");

    print.add_model_object(model.objects[0]);
    print.objects.front()->_slice();

    SupportMaterial *support = print.objects.front()->_support_material();
    auto support_z = support->support_layers_z(contact_z, top_z, print.default_object_config.layer_height);

    bool check = true;
    for (size_t i = 1; i < support_z.size(); i++) {
        if (support_z[i] - support_z[i - 1] <= 0)
            check = false;
    }

    EXPECT_EQ(check, true);
}

namespace {

/// equal within the tolerance Catch's Approx used
bool approximately(double a, double b) { return std::abs(a - b) <= 1.2e-5 * std::abs(b); }

/// A print of the overhang model with support and no top layers (their internal bridges
/// would count too): whether anything is extruded at bridge speed.
bool has_bridge_speed(int raft_layers, double contact_distance) {
    auto config {Slic3r::Config::new_from_defaults()};
    config->set("brim_width", 0);
    config->set("skirts", 0);
    config->set("support_material", true);
    config->set("top_solid_layers", 0);
    config->set("bridge_speed", 99);
    config->set("cooling", false);
    config->set("first_layer_speed", "100%");
    config->set("raft_layers", raft_layers);
    config->set("support_material_contact_distance", contact_distance);
    Slic3r::Model model;
    auto print {Slic3r::Test::init_print({Slic3r::Test::TestMesh::overhang}, model, config)};
    auto gcode {std::stringstream("")};
    Slic3r::Test::gcode(gcode, print);
    bool found = false;
    const double bridge_F {config->getFloat("bridge_speed") * 60};
    GCodeReader().parse_stream(gcode, [&found, bridge_F](GCodeReader&, const GCodeReader::GCodeLine& line) {
        if (line.extruding() && approximately(line.new_F(), bridge_F)) found = true;
    });
    return found;
}

} // namespace

TEST(SupportMaterial, BridgesOverSupportOnlyAtAContactDistance) {
    for (const int raft_layers : {0, 5}) {
        EXPECT_TRUE(has_bridge_speed(raft_layers, 0.2)) << raft_layers << " raft layers";
        EXPECT_FALSE(has_bridge_speed(raft_layers, 0)) << raft_layers << " raft layers";
    }
}

namespace {

/// The table model sliced with support in this style.
struct Supported {
    Slic3r::config_ptr config {Slic3r::Config::new_from_defaults()};
    Slic3r::Model model;
    shared_Print print;
    explicit Supported(const std::string &style, int raft_layers = 0) {
        config->set("support_material", true);
        config->set("support_material_style", style);
        config->set("raft_layers", raft_layers);
        print = Slic3r::Test::init_print({Slic3r::Test::TestMesh::overhang}, model, config);
        print->objects.front()->generate_support_material();
    }
    const PrintObject &object() const { return *print->objects.front(); }
};

double total_length(const ExtrusionEntityCollection &entities) {
    double sum {0};
    for (const ExtrusionEntity *entity : entities.flatten().entities) sum += entity->length();
    return sum * SCALING_FACTOR;
}

Polylines paths(const ExtrusionEntityCollection &entities) {
    Polylines lines;
    for (const ExtrusionEntity *entity : entities.flatten().entities) lines.push_back(entity->as_polyline());
    return lines;
}

double length_mm(const Polylines &lines) {
    double sum {0};
    for (const Polyline &line : lines) sum += line.length();
    return sum * SCALING_FACTOR;
}

} // namespace

TEST(SupportMaterial, TreeBranchesStandOnWhatIsBelowThem) {
    const Supported tree("tree");
    const auto &layers {tree.object().support_layers};
    ASSERT_GT(layers.size(), 5u);
    double all {0}, hanging {0};
    for (size_t i = 1; i < layers.size(); ++i) {
        // the support below, and the model where a branch comes down on it
        Polygons below {to_polygons(layers[i - 1]->support_islands.expolygons)};
        for (const Layer *layer : tree.object().layers)
            if (layer->print_z <= layers[i - 1]->print_z + EPSILON
                    && layer->print_z > layers[i - 1]->print_z - 1)
                append_to(below, Polygons(layer->slices));
        const Polylines base {paths(layers[i]->support_fills)};
        all += length_mm(base);
        hanging += length_mm(diff_pl(base, offset(below, scale_(1.0))));
    }
    EXPECT_GT(all, 100);
    EXPECT_LT(hanging, all / 100);
}

TEST(SupportMaterial, TreeBranchesStayOutOfTheModel) {
    const Supported tree("tree");
    for (const SupportLayer *support : tree.object().support_layers)
        for (const Layer *layer : tree.object().layers) {
            if (std::abs(layer->print_z - support->print_z) > EPSILON) continue;
            EXPECT_LT(length_mm(intersection_pl(paths(support->support_fills), Polygons(layer->slices))), 0.01)
                << "at " << support->print_z;
        }
}

TEST(SupportMaterial, TreeHasTheSameLayersAsNormalSupportAndItsInterface) {
    const Supported normal("normal"), tree("tree");
    ASSERT_EQ(tree.object().support_layers.size(), normal.object().support_layers.size());
    double base {0};
    for (const SupportLayer *layer : tree.object().support_layers) base += total_length(layer->support_fills);
    EXPECT_GT(base, 0);
    EXPECT_FALSE(tree.object().support_layers.back()->support_interface_fills.entities.empty());
}

TEST(SupportMaterial, TreeKeepsTheRaftSolid) {
    const Supported normal("normal", 3), tree("tree", 3);
    for (size_t i = 0; i < 3; ++i) {
        const SupportLayer *a {normal.object().support_layers.at(i)}, *b {tree.object().support_layers.at(i)};
        const double solid {total_length(a->support_fills) + total_length(a->support_interface_fills)};
        const double of_tree {total_length(b->support_fills) + total_length(b->support_interface_fills)};
        // at least as much as the raft under the model itself needs
        EXPECT_GT(of_tree, solid / 3) << "raft layer " << i;
    }
}
