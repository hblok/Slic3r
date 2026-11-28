// From test_model.cpp.
#include <gtest/gtest.h>

#include <cmath>
#include <sstream>
#include <string>
#include <vector>

#include "Model.hpp"
#include "test_data.hpp"

using namespace Slic3r::Test;

// Model construction; A Slic3r Model; Model object is added
TEST(Model, ModelObjectIsAdded) {
    {  // given: A Slic3r Model
        auto model {Slic3r::Model()};
        auto sample_mesh {Slic3r::TriangleMesh::make_cube(20,20,20)};
        sample_mesh.repair();

        auto config {Slic3r::Config::new_from_defaults()};
        std::shared_ptr<Slic3r::Print> print = std::make_shared<Slic3r::Print>();
        print->apply_config(config);
        {  // when: Model object is added
            ModelObject* mo {model.add_object()};
            {  // then: Model object list == 1
                ASSERT_EQ(model.objects.size(), 1u);
            }
            mo->add_volume(sample_mesh);
            {  // then: Model volume list == 1
                ASSERT_EQ(mo->volumes.size(), 1u);
            }
            {  // then: Model volume modifier is false
                EXPECT_EQ(mo->volumes.front()->modifier, false);
            }
            {  // then: Mesh is equivalent to input mesh.
                EXPECT_EQ(sample_mesh.vertices(), mo->volumes.front()->mesh.vertices());
            }
            ModelInstance* inst {mo->add_instance()};
            inst->rotation = 0;
            inst->scaling_factor = 1.0;
            model.arrange_objects(print->config.min_object_distance());
            model.center_instances_around_point(Slic3r::Pointf(100,100));
            print->auto_assign_extruders(mo);
            print->add_model_object(mo);
            {  // then: Print works?
                print->process();
                auto gcode {std::stringstream("")};
                print->export_gcode(gcode, true);
                EXPECT_GT(gcode.str().size(), 0u);
            }
        }
    }
}

// Model::split; A model with one object made of two separate cubes; it is split
TEST(Model, ItIsSplit) {
    {  // given: A model with one object made of two separate cubes
        TriangleMesh mesh = TriangleMesh::make_cube(10, 10, 10);
        TriangleMesh other = TriangleMesh::make_cube(10, 10, 10);
        other.translate(20, 0, 0);
        mesh.merge(other);
        mesh.repair();  // split() needs it; loading a file does it
        Model model;
        model.add_object()->add_volume(mesh);
        {  // when: it is split
            model.split();  // crashed: it copied parts from freed memory
            {  // then: there are two objects of one cube each
                ASSERT_EQ(model.objects.size(), 2u);
                for (const ModelObject* o : model.objects) {
                    ASSERT_EQ(o->volumes.size(), 1u);
                    EXPECT_EQ(o->volumes.front()->mesh.facets_count(), 12);
                }
            }
        }
    }
}
