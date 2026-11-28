#include <gtest/gtest.h>

#include <vector>

#include "3DScene.hpp"
#include "TriangleMesh.hpp"

using namespace Slic3r;

TEST(VolumeScene, MakesThreeCornersAndNormalsForEachFace) {
    TriangleMesh cube {TriangleMesh::make_cube(10, 10, 10)};
    cube.repair();
    GLVertexArray vertices;
    vertices.load_mesh(cube);
    EXPECT_EQ(vertices.verts.size(), 12u * 3 * 3);
    EXPECT_EQ(vertices.norms.size(), vertices.verts.size());
}

TEST(VolumeScene, MakesASolidOfAnExtrusion) {
    const Lines lines {Line(Point::new_scale(0, 0), Point::new_scale(10, 0))};
    GLVertexArray quads, triangles;
    _3DScene::_extrusionentity_to_verts_do(lines, {scale_(0.5)}, {0.2}, false, 0.2, Point(0, 0), &quads, &triangles);
    ASSERT_FALSE(quads.verts.empty());
    EXPECT_EQ(quads.norms.size(), quads.verts.size());
    for (size_t i = 2; i < quads.verts.size(); i += 3) {  // between the layer's bottom and top
        EXPECT_GE(quads.verts[i], -1e-5);
        EXPECT_LE(quads.verts[i], 0.2 + 1e-5);
    }
}
