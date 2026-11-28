// From test_transformationmatrix.cpp.
#include <gtest/gtest.h>

#include <cmath>
#include <vector>

#include "libslic3r.h"
#include "TransformationMatrix.hpp"

using namespace Slic3r;

namespace {

constexpr auto THRESHOLD_EQUALITY = 1.0e-3;

double degtorad(double value) { return PI / 180.0 * value; }

bool check_elements(const TransformationMatrix& matrix, 
    double m00, double m01, double m02, double m03,
    double m10, double m11, double m12, double m13,
    double m20, double m21, double m22, double m23)
{
    bool equal = true;
    equal &= std::abs(matrix.m00 - m00) < THRESHOLD_EQUALITY;
    equal &= std::abs(matrix.m01 - m01) < THRESHOLD_EQUALITY;
    equal &= std::abs(matrix.m02 - m02) < THRESHOLD_EQUALITY;
    equal &= std::abs(matrix.m03 - m03) < THRESHOLD_EQUALITY;
    equal &= std::abs(matrix.m10 - m10) < THRESHOLD_EQUALITY;
    equal &= std::abs(matrix.m11 - m11) < THRESHOLD_EQUALITY;
    equal &= std::abs(matrix.m12 - m12) < THRESHOLD_EQUALITY;
    equal &= std::abs(matrix.m13 - m13) < THRESHOLD_EQUALITY;
    equal &= std::abs(matrix.m20 - m20) < THRESHOLD_EQUALITY;
    equal &= std::abs(matrix.m21 - m21) < THRESHOLD_EQUALITY;
    equal &= std::abs(matrix.m22 - m22) < THRESHOLD_EQUALITY;
    equal &= std::abs(matrix.m23 - m23) < THRESHOLD_EQUALITY;
    return equal;
}

bool check_point(const Pointf3& point, coordf_t x, coordf_t y, coordf_t z)
{
    bool equal = true;
    equal &= std::abs(point.x - x) < THRESHOLD_EQUALITY;
    equal &= std::abs(point.y - y) < THRESHOLD_EQUALITY;
    equal &= std::abs(point.z - z) < THRESHOLD_EQUALITY;
    return equal;
}
} // namespace

TEST(TransformationMatrix, StartsAsTheIdentity) {
    const TransformationMatrix identity;
    EXPECT_TRUE(check_elements(identity,
        1.0, 0.0, 0.0, 0.0,
        0.0, 1.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0));
}

TEST(TransformationMatrix, CopiesAndCompares) {
    const TransformationMatrix original;
    TransformationMatrix copy {original};
    EXPECT_TRUE(check_elements(copy,
        1.0, 0.0, 0.0, 0.0,
        0.0, 1.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0));
    EXPECT_TRUE(original == copy);
    EXPECT_FALSE(original != copy);
    copy.m00 = 2.0;
    EXPECT_TRUE(original != copy);
}

TEST(TransformationMatrix, IsSetByElements) {
    auto trafo_set = TransformationMatrix(1,2,3,4,5,6,7,8,9,10,11,12);
    EXPECT_TRUE(check_elements(trafo_set,
        1,2,3,4,
        5,6,7,8,
        9,10,11,12));
}

TEST(TransformationMatrix, IsSetByAVector) {
    std::vector<double> elements;
    elements.reserve(12);
    elements.push_back(1);
    elements.push_back(2);
    elements.push_back(3);
    elements.push_back(4);
    elements.push_back(5);
    elements.push_back(6);
    elements.push_back(7);
    elements.push_back(8);
    elements.push_back(9);
    elements.push_back(10);
    elements.push_back(11);
    elements.push_back(12);
    auto trafo_vec = TransformationMatrix(elements);
    EXPECT_TRUE(check_elements(trafo_vec,
        1,2,3,4,
        5,6,7,8,
        9,10,11,12));
}

TEST(TransformationMatrix, Multiplies) {
    auto mat1 = TransformationMatrix(1,2,3,4,5,6,7,8,9,10,11,12);
    auto mat2 = TransformationMatrix(1,4,7,10,2,5,8,11,3,6,9,12);

    auto mat3 = TransformationMatrix::multiply(mat1, mat2);
    EXPECT_TRUE(check_elements(mat3,14,32,50,72,38,92,146,208,62,152,242,344));
    mat3 = TransformationMatrix::multiply(mat2, mat1);
    EXPECT_TRUE(check_elements(mat3,84,96,108,130,99,114,129,155,114,132,150,180));

    EXPECT_TRUE(check_elements(mat1.multiplyRight(mat2),14,32,50,72,38,92,146,208,62,152,242,344));
    EXPECT_TRUE(check_elements(mat2.multiplyLeft(mat1),14,32,50,72,38,92,146,208,62,152,242,344));
}

TEST(TransformationMatrix, HasADeterminantAndAnInverse) {
    auto mat = TransformationMatrix(
        0.9004,-0.2369,-0.4847,12.9383,
        -0.9311,0.531,-0.5026,7.7931,
        -0.1225,0.5904,0.2576,-7.316);

    EXPECT_TRUE(std::abs(mat.determinante() - 0.5539) < THRESHOLD_EQUALITY);

    EXPECT_TRUE(check_elements(mat.inverse(),
        0.78273016,-0.40649736,0.67967289,-1.98683622,
        0.54421957,0.31157368,1.63191055,2.46965668,
        -0.87508846,-0.90741083,0.46498424,21.79552507));
}

TEST(TransformationMatrix, TransformsPoints) {
    const Pointf3 vec1(1, 2, 3);
    auto mat = TransformationMatrix(1,2,3,4,5,6,7,8,9,10,11,12);
    EXPECT_TRUE(check_point(mat.transform(vec1),18,46,74));  // default arg should be like a point
    EXPECT_TRUE(check_point(mat.transform(vec1,1),18,46,74));
    EXPECT_TRUE(check_point(mat.transform(vec1,0),14,38,62));
}

TEST(TransformationMatrix, Scales) {
    const Pointf3 vec1(1, 2, 3);
    {
        auto mat = TransformationMatrix::mat_scale(3);
        EXPECT_TRUE(check_point(mat.transform(vec1),3,6,9));
    }
    {
        auto mat = TransformationMatrix::mat_scale(2,3,4);
        EXPECT_TRUE(check_point(mat.transform(vec1),2,6,12));
    }
}

TEST(TransformationMatrix, MirrorsAlongAnAxis) {
    const Pointf3 vec1(1, 2, 3);
    auto mat = TransformationMatrix::mat_mirror(Axis::X);
    EXPECT_TRUE(check_point(mat.transform(vec1),-1,2,3));
    mat = TransformationMatrix::mat_mirror(Axis::Y);
    EXPECT_TRUE(check_point(mat.transform(vec1),1,-2,3));
    mat = TransformationMatrix::mat_mirror(Axis::Z);
    EXPECT_TRUE(check_point(mat.transform(vec1),1,2,-3));
}

TEST(TransformationMatrix, MirrorsAlongAnyVector) {
    const Pointf3 vec1(1, 2, 3);
    const Pointf3 vec2(-4, 3, -2);
    auto mat = TransformationMatrix::mat_mirror(vec2);
    EXPECT_TRUE(check_point(mat.transform(vec1),-0.1034,2.8276,2.4483));
    EXPECT_TRUE(std::abs(mat.determinante() + 1.0) < THRESHOLD_EQUALITY);
}

TEST(TransformationMatrix, Translates) {
    const Pointf3 vec1(1, 2, 3);
    const Pointf3 vec2(-4, 3, -2);
    {
        auto mat = TransformationMatrix::mat_translation(4,2,5);
        EXPECT_TRUE(check_point(mat.transform(vec1),5,4,8));
    }
    {
        auto mat = TransformationMatrix::mat_translation(vec2);
        EXPECT_TRUE(check_point(mat.transform(vec1),-3,5,1));
    }
}

TEST(TransformationMatrix, RotatesAroundAnAxis) {
    const Pointf3 vec1(1, 2, 3);
    auto mat = TransformationMatrix::mat_rotation(degtorad(90), Axis::X);
    EXPECT_TRUE(check_point(mat.transform(vec1),1,-3,2));
    mat = TransformationMatrix::mat_rotation(degtorad(90), Axis::Y);
    EXPECT_TRUE(check_point(mat.transform(vec1),3,2,-1));
    mat = TransformationMatrix::mat_rotation(degtorad(90), Axis::Z);
    EXPECT_TRUE(check_point(mat.transform(vec1),-2,1,3));
}

TEST(TransformationMatrix, RotatesAroundAnyVector) {
    const Pointf3 vec1(1, 2, 3);
    const Pointf3 vec2(-4, 3, -2);
    auto mat = TransformationMatrix::mat_rotation(degtorad(80), vec2);
    EXPECT_TRUE(check_point(mat.transform(vec1),3.0069,1.8341,-1.2627));
    EXPECT_TRUE(std::abs(mat.determinante() - 1.0) < THRESHOLD_EQUALITY);
}

TEST(TransformationMatrix, RotatesByAQuaternion) {
    const Pointf3 vec1(1, 2, 3);
    auto mat = TransformationMatrix::mat_rotation(-0.4775,0.3581,-0.2387,0.7660);
    EXPECT_TRUE(check_point(mat.transform(vec1),3.0069,1.8341,-1.2627));
    EXPECT_TRUE(std::abs(mat.determinante() - 1.0) < THRESHOLD_EQUALITY);
}

TEST(TransformationMatrix, RotatesOneVectorOntoAnother) {
    const Pointf3 vec1(1, 2, 3);
    const Pointf3 vec2(-4, 3, -2);
    auto mat = TransformationMatrix::mat_rotation(vec1,vec2);
    EXPECT_TRUE(check_point(mat.transform(vec1),-2.7792,2.0844,-1.3896));
    EXPECT_TRUE(std::abs(mat.determinante() - 1.0) < THRESHOLD_EQUALITY);
    mat = TransformationMatrix::mat_rotation(vec1,vec1.negative());
    EXPECT_TRUE(check_point(mat.transform(vec1),-1,-2,-3)); // colinear, opposite direction
    mat = TransformationMatrix::mat_rotation(vec1,vec1);
    EXPECT_TRUE(check_elements(mat,
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0, 0.0)); // colinear, same direction
}
