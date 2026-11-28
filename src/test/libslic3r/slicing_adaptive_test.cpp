#include <gtest/gtest.h>

#include "SlicingAdaptive.hpp"
#include "TriangleMesh.hpp"

using namespace Slic3r;

namespace {

/// A 20 mm cube: upright walls, a flat top at z = 20.
struct Cube {
    TriangleMesh mesh {TriangleMesh::make_cube(20, 20, 20)};
    SlicingAdaptive slicing;
    Cube() {
        mesh.repair();
        slicing.add_mesh(&mesh);
        slicing.prepare(20);
    }
};

} // namespace

TEST(SlicingAdaptive, UsesThickLayersOnUprightWallsAtLowQuality) {
    EXPECT_FLOAT_EQ(Cube().slicing.next_layer_height(5, 0, 0.1, 0.4), 0.4f);
}

TEST(SlicingAdaptive, UsesThinLayersAtFullQuality) {
    EXPECT_FLOAT_EQ(Cube().slicing.next_layer_height(5, 100, 0.1, 0.4), 0.1f);
}

TEST(SlicingAdaptive, StopsAtAHorizontalFace) {
    Cube cube;
    EXPECT_NEAR(cube.slicing.horizontal_facet_distance(19.9, 0.4), 0.1, 1e-5);
    EXPECT_FLOAT_EQ(cube.slicing.horizontal_facet_distance(10, 0.4), 0.4f);
}
