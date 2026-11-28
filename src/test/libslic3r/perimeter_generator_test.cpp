#include <gtest/gtest.h>

#include "ExtrusionEntityCollection.hpp"
#include "PerimeterGenerator.hpp"

using namespace Slic3r;

namespace {

/// The perimeters of a 20 mm square slice.
struct Square {
    SurfaceCollection slices, fill_surfaces;
    ExtrusionEntityCollection loops, gap_fill;
    PrintRegionConfig region;
    PrintObjectConfig object;
    PrintConfig print;
    explicit Square(int perimeters) {
        Polygon outline {Polygon::new_scale({Pointf(0, 0), Pointf(20, 0), Pointf(20, 20), Pointf(0, 20)})};
        slices.surfaces.push_back(Surface(stInternal, ExPolygon(outline)));
        region.perimeters.value = perimeters;
        PerimeterGenerator generator(&slices, 0.2, Flow(0.5, 0.2, 0.4), &region, &object, &print,
            &loops, &gap_fill, &fill_surfaces);
        generator.process();
    }
};

} // namespace

TEST(PerimeterGenerator, MakesAsManyLoopsAsAsked) {
    for (const int perimeters : {1, 2, 3}) {
        const Square square(perimeters);
        EXPECT_EQ(square.loops.flatten().entities.size(), static_cast<size_t>(perimeters));
        EXPECT_FALSE(square.fill_surfaces.empty());
    }
}

TEST(PerimeterGenerator, LeavesLessToFillWithMorePerimeters) {
    const Square one(1), three(3);
    EXPECT_LT(three.fill_surfaces.surfaces.at(0).expolygon.area(), one.fill_surfaces.surfaces.at(0).expolygon.area());
}
