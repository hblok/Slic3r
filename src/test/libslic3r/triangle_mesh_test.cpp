// From test_trianglemesh.cpp. Its two cases for upstream issue 4486 are behind compile
// switches that neither build sets, and are not carried over.
#include <gtest/gtest.h>

#include <algorithm>
#include <cmath>
#include <sstream>
#include <string>
#include <vector>

#include "TriangleMesh.hpp"
#include "libslic3r.h"
#include "Point.hpp"

using namespace Slic3r;
using namespace std;

/// equal within the tolerance Catch's Approx used
#define EXPECT_APPROX(value, expected) EXPECT_NEAR(value, expected, 1.2e-5 * std::abs(expected))
[[maybe_unused]] bool approximately(double a, double b, double margin = -1) {
    return std::abs(a - b) <= (margin < 0 ? 1.2e-5 * std::abs(b) : margin);
}

#ifdef TEST_PERFORMANCE

#endif // TEST_PERFORMANCE

#ifdef BUILD_PROFILE

#endif //BUILD_PROFILE

// TriangleMesh: Basic mesh statistics; A 20mm cube, built from constexpr std::array
TEST(TriangleMesh, A20mmCubeBuiltFromConstexprStdArray) {
    {  // given: A 20mm cube, built from constexpr std::array
        constexpr std::array<Pointf3, 8> vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        constexpr std::array<Point3, 12> facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };
        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // then: Volume is appropriate for 20mm square cube.
            EXPECT_LT(abs(cube.volume() - 20.0*20.0*20.0), 1e-2);
        }
        {  // then: Vertices array matches input.
            for (auto i = 0U; i < cube.vertices().size(); i++) {
                EXPECT_EQ(cube.vertices().at(i), vertices.at(i));
            }
            for (auto i = 0U; i < vertices.size(); i++) {
                EXPECT_EQ(vertices.at(i), cube.vertices().at(i));
            }
        }
        {  // then: Vertex count matches vertex array size.
            EXPECT_EQ(cube.facets_count(), facets.size());
        }
        {  // then: Facet array matches input.
            for (auto i = 0U; i < cube.facets().size(); i++) {
                EXPECT_EQ(cube.facets().at(i), facets.at(i));
            }

            for (auto i = 0U; i < facets.size(); i++) {
                EXPECT_EQ(facets.at(i), cube.facets().at(i));
            }
        }
        {  // then: Facet count matches facet array size.
            EXPECT_EQ(cube.facets_count(), facets.size());
        }
        {  // then: Number of normals is equal to the number of facets.
            ASSERT_EQ(cube.normals().size(), facets.size());
        }
        {  // then: center() returns the center of the object.
            EXPECT_EQ(cube.center(), Pointf3(10.0,10.0,10.0));
        }
        {  // then: Size of cube is (20,20,20)
            ASSERT_EQ(cube.size(), Pointf3(20,20,20));
        }
    }
}

// TriangleMesh: Basic mesh statistics; A 20mm cube with one corner on the origin
TEST(TriangleMesh, A20mmCubeWithOneCornerOnTheOrigin) {
    {  // given: A 20mm cube with one corner on the origin
        const Pointf3s vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        const Point3s facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };

        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // then: Volume is appropriate for 20mm square cube.
            EXPECT_LT(abs(cube.volume() - 20.0*20.0*20.0), 1e-2);
        }
        {  // then: Vertices array matches input.
            for (auto i = 0U; i < cube.vertices().size(); i++) {
                EXPECT_EQ(cube.vertices().at(i), vertices.at(i));
            }
            for (auto i = 0U; i < vertices.size(); i++) {
                EXPECT_EQ(vertices.at(i), cube.vertices().at(i));
            }
        }
        {  // then: Vertex count matches vertex array size.
            EXPECT_EQ(cube.facets_count(), facets.size());
        }
        {  // then: Facet array matches input.
            for (auto i = 0U; i < cube.facets().size(); i++) {
                EXPECT_EQ(cube.facets().at(i), facets.at(i));
            }

            for (auto i = 0U; i < facets.size(); i++) {
                EXPECT_EQ(facets.at(i), cube.facets().at(i));
            }
        }
        {  // then: Facet count matches facet array size.
            EXPECT_EQ(cube.facets_count(), facets.size());
        }
        {  // then: Number of normals is equal to the number of facets.
            ASSERT_EQ(cube.normals().size(), facets.size());
        }
        {  // then: center() returns the center of the object.
            EXPECT_EQ(cube.center(), Pointf3(10.0,10.0,10.0));
        }
        {  // then: Size of cube is (20,20,20)
            ASSERT_EQ(cube.size(), Pointf3(20,20,20));
        }
    }
}

// TriangleMesh: Transformation functions affect mesh as expected.; A 20mm cube with one corner on the origin; The cube is scaled 200\% uniformly
TEST(TriangleMesh, TheCubeIsScaled200Uniformly) {
    {  // given: A 20mm cube with one corner on the origin
        const Pointf3s vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        const std::vector<Point3> facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };
        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // when: The cube is scaled 200\% uniformly
            cube.scale(2.0);
            {  // then: The volume is equivalent to 40x40x40 (all dimensions increased by 200\%
                EXPECT_LT(abs(cube.volume() - 40.0*40.0*40.0), 1e-2);
            }
        }
    }
}

// TriangleMesh: Transformation functions affect mesh as expected.; A 20mm cube with one corner on the origin; The resulting cube is scaled 200\% in the X direction
TEST(TriangleMesh, TheResultingCubeIsScaled200InTheXDirection) {
    {  // given: A 20mm cube with one corner on the origin
        const Pointf3s vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        const std::vector<Point3> facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };
        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // when: The resulting cube is scaled 200\% in the X direction
            cube.scale(Vectorf3(2.0, 1, 1));
            {  // then: The volume is doubled.
                EXPECT_LT(abs(cube.volume() - 2*20.0*20.0*20.0), 1e-2);
            }
            {  // then: The X coordinate size is 200\%.
                EXPECT_EQ(cube.vertices().at(0).x, 40.0);
            }
        }
    }
}

// TriangleMesh: Transformation functions affect mesh as expected.; A 20mm cube with one corner on the origin; The cube is scaled 25\% in the X direction
TEST(TriangleMesh, TheCubeIsScaled25InTheXDirection) {
    {  // given: A 20mm cube with one corner on the origin
        const Pointf3s vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        const std::vector<Point3> facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };
        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // when: The cube is scaled 25\% in the X direction
            cube.scale(Vectorf3(0.25, 1, 1));
            {  // then: The volume is 25\% of the previous volume.
                EXPECT_LT(abs(cube.volume() - 0.25*20.0*20.0*20.0), 1e-2);
            }
            {  // then: The X coordinate size is 25\% from previous.
                EXPECT_EQ(cube.vertices().at(0).x, 5.0);
            }
        }
    }
}

// TriangleMesh: Transformation functions affect mesh as expected.; A 20mm cube with one corner on the origin; The cube is rotated 45 degrees.
TEST(TriangleMesh, TheCubeIsRotated45Degrees) {
    {  // given: A 20mm cube with one corner on the origin
        const Pointf3s vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        const std::vector<Point3> facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };
        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // when: The cube is rotated 45 degrees.
            cube.rotate(45.0, Slic3r::Point(20,20));
            {  // then: The X component of the size is sqrt(2)*20
                EXPECT_LT(abs(cube.size().x - sqrt(2.0)*20), 1e-2);
            }
        }
    }
}

// TriangleMesh: Transformation functions affect mesh as expected.; A 20mm cube with one corner on the origin; The cube is translated (5, 10, 0) units with a Pointf3 
TEST(TriangleMesh, TheCubeIsTranslated5100UnitsWithAPointf3) {
    {  // given: A 20mm cube with one corner on the origin
        const Pointf3s vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        const std::vector<Point3> facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };
        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // when: The cube is translated (5, 10, 0) units with a Pointf3
            cube.translate(Pointf3(5.0, 10.0, 0.0));
            {  // then: The first vertex is located at 25, 30, 0
                EXPECT_EQ(cube.vertices().at(0), Pointf3(25.0, 30.0, 0.0));
            }
        }
    }
}

// TriangleMesh: Transformation functions affect mesh as expected.; A 20mm cube with one corner on the origin; The cube is translated (5, 10, 0) units with 3 doubles
TEST(TriangleMesh, TheCubeIsTranslated5100UnitsWith3Doubles) {
    {  // given: A 20mm cube with one corner on the origin
        const Pointf3s vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        const std::vector<Point3> facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };
        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // when: The cube is translated (5, 10, 0) units with 3 doubles
            cube.translate(5.0, 10.0, 0.0);
            {  // then: The first vertex is located at 25, 30, 0
                EXPECT_EQ(cube.vertices().at(0), Pointf3(25.0, 30.0, 0.0));
            }
        }
    }
}

// TriangleMesh: Transformation functions affect mesh as expected.; A 20mm cube with one corner on the origin; The cube is translated (5, 10, 0) units and then aligned to origin
TEST(TriangleMesh, TheCubeIsTranslated5100UnitsAndThenAlignedToOrigin) {
    {  // given: A 20mm cube with one corner on the origin
        const Pointf3s vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        const std::vector<Point3> facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };
        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // when: The cube is translated (5, 10, 0) units and then aligned to origin
            cube.translate(5.0, 10.0, 0.0);
            cube.align_to_origin();
            {  // then: The third vertex is located at 0,0,0
                EXPECT_EQ(cube.vertices().at(2), Pointf3(0.0, 0.0, 0.0));
            }
        }
    }
}

// TriangleMesh: slice behavior.; A 20mm cube with one corner on the origin; Cube is sliced with z = [0,2,4,8,6,8,10,12,14,16,18,20]
TEST(TriangleMesh, CubeIsSlicedWithZ024868101214161820) {
    {  // given: A 20mm cube with one corner on the origin
        const Pointf3s vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        const std::vector<Point3> facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };
        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // when: Cube is sliced with z = [0,2,4,8,6,8,10,12,14,16,18,20]
            std::vector<double> z { 0,2,4,8,6,8,10,12,14,16,18,20 };
            auto result {cube.slice(z)};
            {  // then: The correct number of polygons are returned per layer.
                for (auto i = 0U; i < z.size(); i++) {
                    ASSERT_EQ(result.at(i).size(), 1u);
                }
            }
            {  // then: The area of the returned polygons is correct.
                for (auto i = 0U; i < z.size(); i++) {
                    EXPECT_EQ(result.at(i).at(0).area(), 20.0*20/(std::pow(SCALING_FACTOR,2)));
                }
            }
        }
    }
}

// TriangleMesh: slice behavior.; A STL with an irregular shape.;  a top tangent plane is sliced
TEST(TriangleMesh, ATopTangentPlaneIsSliced) {
    {  // given: A STL with an irregular shape.
        const Pointf3s vertices {Pointf3(0,0,0),Pointf3(0,0,20),Pointf3(0,5,0),Pointf3(0,5,20),Pointf3(50,0,0),Pointf3(50,0,20),Pointf3(15,5,0),Pointf3(35,5,0),Pointf3(15,20,0),Pointf3(50,5,0),Pointf3(35,20,0),Pointf3(15,5,10),Pointf3(50,5,20),Pointf3(35,5,10),Pointf3(35,20,10),Pointf3(15,20,10)};
        const Point3s facets {Point3(0,1,2),Point3(2,1,3),Point3(1,0,4),Point3(5,1,4),Point3(0,2,4),Point3(4,2,6),Point3(7,6,8),Point3(4,6,7),Point3(9,4,7),Point3(7,8,10),Point3(2,3,6),Point3(11,3,12),Point3(7,12,9),Point3(13,12,7),Point3(6,3,11),Point3(11,12,13),Point3(3,1,5),Point3(12,3,5),Point3(5,4,9),Point3(12,5,9),Point3(13,7,10),Point3(14,13,10),Point3(8,15,10),Point3(10,15,14),Point3(6,11,8),Point3(8,11,15),Point3(15,11,13),Point3(14,15,13)};

        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // when:  a top tangent plane is sliced
            auto slices {cube.slice({5.0, 10.0})};
            {  // then: its area is included
                EXPECT_GT(slices.at(0).at(0).area(), 0);
                EXPECT_GT(slices.at(1).at(0).area(), 0);
            }
        }
    }
}

// TriangleMesh: slice behavior.; A STL with an irregular shape.;  a model that has been transformed is sliced
TEST(TriangleMesh, AModelThatHasBeenTransformedIsSliced) {
    {  // given: A STL with an irregular shape.
        const Pointf3s vertices {Pointf3(0,0,0),Pointf3(0,0,20),Pointf3(0,5,0),Pointf3(0,5,20),Pointf3(50,0,0),Pointf3(50,0,20),Pointf3(15,5,0),Pointf3(35,5,0),Pointf3(15,20,0),Pointf3(50,5,0),Pointf3(35,20,0),Pointf3(15,5,10),Pointf3(50,5,20),Pointf3(35,5,10),Pointf3(35,20,10),Pointf3(15,20,10)};
        const Point3s facets {Point3(0,1,2),Point3(2,1,3),Point3(1,0,4),Point3(5,1,4),Point3(0,2,4),Point3(4,2,6),Point3(7,6,8),Point3(4,6,7),Point3(9,4,7),Point3(7,8,10),Point3(2,3,6),Point3(11,3,12),Point3(7,12,9),Point3(13,12,7),Point3(6,3,11),Point3(11,12,13),Point3(3,1,5),Point3(12,3,5),Point3(5,4,9),Point3(12,5,9),Point3(13,7,10),Point3(14,13,10),Point3(8,15,10),Point3(10,15,14),Point3(6,11,8),Point3(8,11,15),Point3(15,11,13),Point3(14,15,13)};

        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // when:  a model that has been transformed is sliced
            cube.mirror_z();
            auto slices {cube.slice({-5.0, -10.0})};
            {  // then: it is sliced properly (mirrored bottom plane area is included)
                EXPECT_GT(slices.at(0).at(0).area(), 0);
                EXPECT_GT(slices.at(1).at(0).area(), 0);
            }
        }
    }
}

// make_xxx functions produce meshes.; make_cube() function; make_cube() is called with arguments 20,20,20
TEST(TriangleMesh, MakeCubeIsCalledWithArguments202020) {
    {  // given: make_cube() function
        {  // when: make_cube() is called with arguments 20,20,20
            auto cube {TriangleMesh::make_cube(20,20,20)};
            {  // then: The resulting mesh has one and only one vertex at 0,0,0
                auto verts {cube.vertices()};
                EXPECT_EQ(std::count_if(verts.begin(), verts.end(), [](Pointf3& t) { return t.x == 0 && t.y == 0 && t.z == 0; } ), 1);
            }
            {  // then: The mesh volume is 20*20*20
                EXPECT_LT(abs(cube.volume() - 20.0*20.0*20.0), 1e-2);
            }
            {  // then: The resulting mesh is in the repaired state.
                EXPECT_EQ(cube.repaired, true);
            }
            {  // then: There are 12 facets.
                ASSERT_EQ(cube.facets().size(), 12u);
            }
        }
    }
}

// make_xxx functions produce meshes.; make_cylinder() function; make_cylinder() is called with arguments 10,10, PI / 3
TEST(TriangleMesh, MakeCylinderIsCalledWithArguments1010PI3) {
    {  // given: make_cylinder() function
        {  // when: make_cylinder() is called with arguments 10,10, PI / 3
            auto cyl {TriangleMesh::make_cylinder(10, 10, PI / 243.0)};
            double angle = (2*PI / floor(2*PI / (PI / 243.0)));
            {  // then: The resulting mesh has one and only one vertex at 0,0,0
                auto verts {cyl.vertices()};
                EXPECT_EQ(std::count_if(verts.begin(), verts.end(), [](Pointf3& t) { return t.x == 0 && t.y == 0 && t.z == 0; } ), 1);
            }
            {  // then: The resulting mesh has one and only one vertex at 0,0,10
                auto verts {cyl.vertices()};
                EXPECT_EQ(std::count_if(verts.begin(), verts.end(), [](Pointf3& t) { return t.x == 0 && t.y == 0 && t.z == 10; } ), 1);
            }
            {  // then: Resulting mesh has 2 + (2*PI/angle * 2) vertices.
                ASSERT_EQ(cyl.vertices().size(), (2 + ((2*PI/angle)*2)));
            }
            {  // then: Resulting mesh has 2*PI/angle * 4 facets
                ASSERT_EQ(cyl.facets().size(), (2*PI/angle)*4);
            }
            {  // then: The resulting mesh is in the repaired state.
                EXPECT_EQ(cyl.repaired, true);
            }
            {  // then: The mesh volume is approximately 10pi * 10^2
                EXPECT_LT(abs(cyl.volume() - (10.0 * M_PI * std::pow(10,2))), 1);
            }
        }
    }
}

// make_xxx functions produce meshes.; make_sphere() function; make_sphere() is called with arguments 10, PI / 3
TEST(TriangleMesh, MakeSphereIsCalledWithArguments10PI3) {
    {  // given: make_sphere() function
        {  // when: make_sphere() is called with arguments 10, PI / 3
            auto sph {TriangleMesh::make_sphere(10, PI / 243.0)};
            double angle = (2.0*PI / floor(2.0*PI / (PI / 243.0)));
            {  // then: Resulting mesh has one point at 0,0,-10 and one at 0,0,10
                auto verts {sph.vertices()};
                EXPECT_EQ(std::count_if(verts.begin(), verts.end(), [](Pointf3& t) { return t.x == 0 && t.y == 0 && t.z == 10; } ), 1);
                EXPECT_EQ(std::count_if(verts.begin(), verts.end(), [](Pointf3& t) { return t.x == 0 && t.y == 0 && t.z == -10; } ), 1);
            }
            {  // then: The resulting mesh is in the repaired state.
                EXPECT_EQ(sph.repaired, true);
            }
            {  // then: The mesh volume is approximately 4/3 * pi * 10^3
                EXPECT_LT(abs(sph.volume() - (4.0/3.0 * M_PI * std::pow(10,3))), 1); // 1% tolerance?
            }
        }
    }
}

// TriangleMesh: split functionality.; A 20mm cube with one corner on the origin; The mesh is split into its component parts.
TEST(TriangleMesh, TheMeshIsSplitIntoItsComponentParts) {
    {  // given: A 20mm cube with one corner on the origin
        const Pointf3s vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        const Point3s facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };

        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // when: The mesh is split into its component parts.
            auto meshes {cube.split()};
            {  // then:  The bounding box statistics are propagated to the split copies
                ASSERT_EQ(meshes.size(), 1u);
                EXPECT_EQ(meshes.at(0)->bb3(), cube.bb3());
            }
        }
    }
}

// TriangleMesh: split functionality.; Two 20mm cubes, each with one corner on the origin, merged into a single TriangleMesh; The combined mesh is split
TEST(TriangleMesh, TheCombinedMeshIsSplit) {
    {  // given: Two 20mm cubes, each with one corner on the origin, merged into a single TriangleMesh
        const Pointf3s vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        const Point3s facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };

        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        auto cube2 {TriangleMesh(vertices, facets)};
        cube2.repair();

        cube.merge(cube2);
        cube.repair();
        {  // when: The combined mesh is split
            auto meshes {cube.split()};
            {  // then: Two meshes are in the output vector.
                ASSERT_EQ(meshes.size(), 2u);
            }
        }
    }
}

// TriangleMesh: Mesh merge functions; Two 20mm cubes, each with one corner on the origin; The two meshes are merged
TEST(TriangleMesh, TheTwoMeshesAreMerged) {
    {  // given: Two 20mm cubes, each with one corner on the origin
        const Pointf3s vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        const Point3s facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };

        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        auto cube2 {TriangleMesh(vertices, facets)};
        cube2.repair();
        {  // when: The two meshes are merged
            cube.merge(cube2);
            cube.repair();
            {  // then: There are twice as many facets in the merged mesh as the original.
                EXPECT_EQ(cube.stats().number_of_facets, 2 * cube2.stats().number_of_facets);
            }
        }
    }
}

// TriangleMeshSlicer: Cut behavior.; A 20mm cube with one corner on the origin; Object is cut at the bottom
TEST(TriangleMesh, ObjectIsCutAtTheBottom) {
    {  // given: A 20mm cube with one corner on the origin
        const Pointf3s vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        const Point3s facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };

        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // when: Object is cut at the bottom
            TriangleMesh upper {};
            TriangleMesh lower {};
            cube.cut(Z, 0, &upper, &lower);
            {  // then: Upper mesh has all facets except those belonging to the slicing plane.
                EXPECT_EQ(upper.facets_count(), 12);
            }
            {  // then: Lower mesh has no facets.
                EXPECT_EQ(lower.facets_count(), 0);
            }
        }
    }
}

// TriangleMeshSlicer: Cut behavior.; A 20mm cube with one corner on the origin; Object is cut at the center
TEST(TriangleMesh, ObjectIsCutAtTheCenter) {
    {  // given: A 20mm cube with one corner on the origin
        const Pointf3s vertices { Pointf3(20,20,0), Pointf3(20,0,0), Pointf3(0,0,0), Pointf3(0,20,0), Pointf3(20,20,20), Pointf3(0,20,20), Pointf3(0,0,20), Pointf3(20,0,20) };
        const Point3s facets { Point3(0,1,2), Point3(0,2,3), Point3(4,5,6), Point3(4,6,7), Point3(0,4,7), Point3(0,7,1), Point3(1,7,6), Point3(1,6,2), Point3(2,6,5), Point3(2,5,3), Point3(4,0,3), Point3(4,3,5) };

        auto cube {TriangleMesh(vertices, facets)};
        cube.repair();
        {  // when: Object is cut at the center
            TriangleMesh upper {};
            TriangleMesh lower {};
            cube.cut(Z, 10, &upper, &lower);
            {  // then: Upper mesh has 2 external horizontal facets, 3 facets on each side, and 6 facets on the triangulated side (2 + 12 + 6).
                EXPECT_EQ(upper.facets_count(), 2+12+6);
            }
            {  // then: Lower mesh has 2 external horizontal facets, 3 facets on each side, and 6 facets on the triangulated side (2 + 12 + 6).
                EXPECT_EQ(lower.facets_count(), 2+12+6);
            }
        }
    }
}

// TriangleMesh: picking a facet with a line; A 20 mm cube; a line goes down through it
TEST(TriangleMesh, ALineGoesDownThroughIt) {
    {  // given: A 20 mm cube
        auto cube {TriangleMesh::make_cube(20, 20, 20)};
        cube.repair();
        {  // when: a line goes down through it
            const int facet {cube.first_facet_hit(Linef3(Pointf3(5, 6, 100), Pointf3(5, 6, -100)))};
            {  // then: the top is hit first, and its normal points up
                EXPECT_GE(facet, 0);
                EXPECT_APPROX(cube.facet_normal(facet).z, 1);
            }
        }
    }
}

// TriangleMesh: picking a facet with a line; A 20 mm cube; a line comes from the side
TEST(TriangleMesh, ALineComesFromTheSide) {
    {  // given: A 20 mm cube
        auto cube {TriangleMesh::make_cube(20, 20, 20)};
        cube.repair();
        {  // when: a line comes from the side
            const int facet {cube.first_facet_hit(Linef3(Pointf3(-50, 5, 6), Pointf3(50, 5, 6)))};
            {  // then: the near side is hit
                EXPECT_GE(facet, 0);
                EXPECT_APPROX(cube.facet_normal(facet).x, -1);
            }
        }
    }
}

// TriangleMesh: picking a facet with a line; A 20 mm cube; a line misses, or ends before it
TEST(TriangleMesh, ALineMissesOrEndsBeforeIt) {
    {  // given: A 20 mm cube
        auto cube {TriangleMesh::make_cube(20, 20, 20)};
        cube.repair();
        {  // when: a line misses, or ends before it
            {  // then: nothing is hit
                EXPECT_EQ(cube.first_facet_hit(Linef3(Pointf3(30, 6, 100), Pointf3(30, 6, -100))), -1);
                EXPECT_EQ(cube.first_facet_hit(Linef3(Pointf3(5, 6, 100), Pointf3(5, 6, 50))), -1);
            }
        }
    }
}
