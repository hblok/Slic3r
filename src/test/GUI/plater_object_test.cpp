#include <gtest/gtest.h>

#include <memory>

#include "Model.hpp"
#include "Plater/PlaterObject.hpp"
#include "TriangleMesh.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

namespace {
/// A 10 mm cube with one instance.
std::shared_ptr<Model> cube() {
    auto model {std::make_shared<Model>()};
    TriangleMesh mesh {TriangleMesh::make_cube(10, 10, 10)};
    mesh.repair();
    model->add_object()->add_volume(mesh);
    model->add_default_instances();
    return model;
}
} // namespace

TEST(PlaterObject, DrawsAnObjectAsItsOutlineFromAbove) {
    PlaterObject object;
    const ExPolygonCollection& thumbnail {object.make_thumbnail(cube(), 0)};
    ASSERT_EQ(thumbnail.expolygons.size(), 1u);
    EXPECT_NEAR(thumbnail.expolygons[0].area() / scale_(1) / scale_(1), 100, 1);  // grown by a hair
}

TEST(PlaterObject, TurnsAndScalesTheOutlineAsTheInstance) {
    const auto model {cube()};
    model->objects[0]->instances[0]->scaling_factor = 2;
    PlaterObject object;
    object.make_thumbnail(model, 0);
    const ExPolygonCollection& transformed {object.transform_thumbnail(model, 0)};
    ASSERT_EQ(transformed.expolygons.size(), 1u);
    EXPECT_NEAR(transformed.expolygons[0].area() / scale_(1) / scale_(1), 400, 4);
}

TEST(PlaterObject, KnowsWhetherAPointIsOnAnInstance) {
    PlaterObject object;
    object.instance_thumbnails = {object.make_thumbnail(cube(), 0)};
    EXPECT_TRUE(object.instance_contains(Point::new_scale(5, 5)));
    EXPECT_FALSE(object.instance_contains(Point::new_scale(15, 5)));
}
