// The surface collection case of test_primitives.cpp.
#include <gtest/gtest.h>

#include <vector>

#include "ExPolygon.hpp"
#include "Surface.hpp"
#include "SurfaceCollection.hpp"

using namespace Slic3r;

namespace {

ExPolygon holed() {
    return ExPolygon(Points{Point(100, 100), Point(200, 100), Point(200, 200), Point(100, 200)},
        Points{Point(140, 140), Point(140, 160), Point(160, 160), Point(160, 140)});
}

} // namespace

TEST(SurfaceCollection, GroupsByType) {
    SurfaceCollection collection;
    collection.surfaces.push_back(Surface(stBottom, holed()));
    collection.surfaces.push_back(Surface(stBottom, holed()));
    collection.surfaces.push_back(Surface(stTop, holed()));
    std::vector<SurfacesPtr> groups;
    collection.group(&groups);
    ASSERT_EQ(groups.size(), 2u);
}
