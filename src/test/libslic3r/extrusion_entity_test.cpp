// From test_extrusion_entity.cpp and test_primitives.cpp.
#include <gtest/gtest.h>

#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <vector>

#include "ExtrusionEntity.hpp"
#include "ExtrusionEntityCollection.hpp"
#include "Polygon.hpp"

using namespace Slic3r;

/// equal within the tolerance Catch's Approx used
#define EXPECT_APPROX(value, expected) EXPECT_NEAR(value, expected, 1.2e-5 * std::abs(expected))

namespace {

const Points square {Point(100, 100), Point(200, 100), Point(200, 200), Point(100, 200)};  // ccw

ExtrusionPath path_of(const Points &points, ExtrusionRole role = erExternalPerimeter) {
    ExtrusionPath path(role, 1, 1, 1);
    path.polyline.points = points;
    return path;
}

std::vector<coord_t> ys(const Polylines &polylines) {
    std::vector<coord_t> out;
    for (const auto &p : polylines) for (const auto &point : p.points) out.push_back(point.y);
    return out;
}

Polylines polylines_of(const ExtrusionEntityCollection &collection) {
    Polylines out;
    for (const auto *entity : collection.entities) out.push_back(entity->as_polyline());
    return out;
}

Point random_point(float LO=-50, float HI=50) {
    float x = LO + static_cast <float> (rand()) /( static_cast <float> (RAND_MAX/(HI-LO)));
    float y = LO + static_cast <float> (rand()) /( static_cast <float> (RAND_MAX/(HI-LO)));
    return Point(x, y);
}

// build a sample extrusion entity collection with random start and end points.
ExtrusionPath random_path(size_t length = 20, float LO=-50, float HI=50) {
    ExtrusionPath t {erPerimeter, 1.0, 1.0, 1.0};
    for (size_t j = 0; j < length; j++) {
        t.polyline.append(random_point(LO, HI));
    }
    return t;
}

ExtrusionPaths random_paths(size_t count=10, size_t length=20, float LO=-50, float HI=50) {
    ExtrusionPaths p;
    for (size_t i = 0; i < count; i++)
        p.push_back(random_path(length, LO, HI));
    return p;
}

/// A sorted collection, an unsorted one and a sorted one, in a collection.
struct Nested {
    ExtrusionPaths unsorted_paths;
    ExtrusionEntityCollection sample;
    Nested() {
        srand(0xDEADBEEF);  // the same paths every time
        unsorted_paths = random_paths();
        ExtrusionEntityCollection unsorted, sorted;
        unsorted.append(unsorted_paths);
        unsorted.no_sort = true;
        sorted.no_sort = false;
        sorted.append(random_paths());
        sample.append(sorted);
        sample.append(unsorted);
        sample.append(sorted);
    }
};

size_t collections_in(const ExtrusionEntityCollection& collection) {
    return std::count_if(collection.entities.cbegin(), collection.entities.cend(),
        [](const ExtrusionEntity* e) { return e->is_collection(); });
}

} // namespace

TEST(ExtrusionEntityCollection, FlattensAllCollections) {
    const Nested nested;
    ExtrusionEntityCollection output;
    nested.sample.flatten(&output);
    EXPECT_EQ(collections_in(output), 0u);
}

TEST(ExtrusionEntityCollection, KeepsAnUnsortedCollectionWhenAsked) {
    const Nested nested;
    ExtrusionEntityCollection output;
    nested.sample.flatten(&output, true);
    ASSERT_EQ(collections_in(output), 1u);
    for (const auto* entity : output.entities) {
        if (!entity->is_collection()) continue;
        const auto* kept = dynamic_cast<const ExtrusionEntityCollection*>(entity);
        ASSERT_EQ(kept->size(), nested.unsorted_paths.size());
        for (size_t i = 0; i < nested.unsorted_paths.size(); ++i) {  // in the original order
            EXPECT_EQ(kept->entities[i]->first_point(), nested.unsorted_paths[i].first_point());
            EXPECT_EQ(kept->entities[i]->last_point(), nested.unsorted_paths[i].last_point());
        }
    }
}

TEST(ExtrusionEntityCollection, ChainsPaths) {
    auto polyline = [](const Points &points) { Polyline p; p.points = points; return p; };
    const Polylines vertical {polyline({Point(0, 15), Point(0, 18), Point(0, 20)}), polyline({Point(0, 10), Point(0, 8), Point(0, 5)})};
    ExtrusionEntityCollection collection;
    for (const auto &p : vertical) collection.append(path_of(p.points));
    ExtrusionEntityCollection chained;
    collection.chained_path_from(Point(0, 30), &chained);
    EXPECT_EQ(ys(polylines_of(chained)), std::vector<coord_t>({20, 18, 15, 10, 8, 5}));
    EXPECT_EQ(ys(polylines_of(collection.chained_path())), std::vector<coord_t>({15, 18, 20, 10, 8, 5}));
    EXPECT_FALSE(collection.no_sort);
    collection.no_sort = true;
    EXPECT_TRUE(ExtrusionEntityCollection(collection).no_sort);
}

TEST(ExtrusionLoop, SplitsAndKeepsItsLength) {
    ExtrusionLoop single;
    single.append(path_of(Polygon(square).split_at_first_point().points));
    EXPECT_EQ(single.polygon().area(), Polygon(square).area());
    EXPECT_EQ(single.length(), 400);
    single.split_at_vertex(square[2]);
    ASSERT_EQ(single.paths.size(), 1u);
    EXPECT_EQ(single.paths[0].polyline.points, Points({square[2], square[3], square[0], square[1], square[2]}));

    const Points lower {Point(100, 100), Point(200, 100), Point(200, 200)};
    const Points upper {Point(200, 200), Point(100, 200), Point(100, 100)};
    ExtrusionLoop two;
    two.append(path_of(lower, erExternalPerimeter));
    two.append(path_of(upper, erOverhangPerimeter));
    const double total {two.length()};
    {
        ExtrusionLoop loop(two);
        loop.split_at_vertex(lower[1]);
        EXPECT_EQ(loop.length(), total);
        ASSERT_EQ(loop.paths.size(), 3u);
        EXPECT_EQ(loop.paths.front().first_point(), lower[1]);
        EXPECT_EQ(loop.paths.back().last_point(), lower[1]);
        EXPECT_EQ(loop.paths[0].last_point(), loop.paths[1].first_point());
        EXPECT_EQ(loop.paths[1].last_point(), loop.paths[2].first_point());
        EXPECT_EQ(loop.paths[0].role, erExternalPerimeter);
        EXPECT_EQ(loop.paths[1].role, erOverhangPerimeter);
        EXPECT_EQ(loop.paths[2].role, erExternalPerimeter);
        ASSERT_EQ(loop.paths[0].polyline.points.size(), 2u);
        ASSERT_EQ(loop.paths[1].polyline.points.size(), 3u);
        ASSERT_EQ(loop.paths[2].polyline.points.size(), 2u);
        ExtrusionPaths clipped;
        loop.clip_end(3, &clipped);
        double length {0};
        for (const auto &path : clipped) length += path.length();
        EXPECT_APPROX(length, total - 3);
    }
    {
        ExtrusionLoop loop(two);
        loop.split_at_vertex(upper[0]);  // at the end of a path
        EXPECT_EQ(loop.length(), total);
        ASSERT_EQ(loop.paths.size(), 2u);
        EXPECT_EQ(loop.paths.front().first_point(), upper[0]);
        EXPECT_EQ(loop.paths.back().last_point(), upper[0]);
        EXPECT_EQ(loop.paths[0].role, erOverhangPerimeter);
        EXPECT_EQ(loop.paths[1].role, erExternalPerimeter);
    }
    {
        ExtrusionLoop loop(two);
        loop.split_at(Point(250, 150));
        EXPECT_EQ(loop.length(), total);
        ASSERT_EQ(loop.paths.size(), 3u);
        EXPECT_EQ(loop.paths.front().first_point(), Point(200, 150));
        EXPECT_EQ(loop.paths.back().last_point(), Point(200, 150));
    }

    ExtrusionLoop four;
    four.append(path_of({Point(59312736, 4821067), Point(64321068, 4821067), Point(64321068, 4821067), Point(64321068, 9321068), Point(59312736, 9321068)}, erExternalPerimeter));
    four.append(path_of({Point(59312736, 9321068), Point(9829401, 9321068)}, erOverhangPerimeter));
    four.append(path_of({Point(9829401, 9321068), Point(4821067, 9321068), Point(4821067, 4821067), Point(9829401, 4821067)}, erExternalPerimeter));
    four.append(path_of({Point(9829401, 4821067), Point(59312736, 4821067)}, erOverhangPerimeter));
    const double length {four.length()};
    const Point at(4821067, 9321068);
    if (!four.split_at_vertex(at)) four.split_at(at);
    EXPECT_EQ(four.length(), length);
    std::vector<ExtrusionRole> roles;
    for (const auto &path : four.paths) roles.push_back(path.role);
    EXPECT_EQ(roles, std::vector<ExtrusionRole>({erExternalPerimeter, erOverhangPerimeter, erExternalPerimeter,
        erOverhangPerimeter, erExternalPerimeter}));

    ExtrusionLoop round;
    round.append(path_of({Point(15896783, 15868739), Point(24842049, 12117558), Point(33853238, 15801279), Point(37591780, 24780128),
        Point(37591780, 24844970), Point(33853231, 33825297), Point(24842049, 37509013), Point(15896798, 33757841),
        Point(12211841, 24812544), Point(15896783, 15868739)}));
    const double around {round.length()};
    round.split_at(Point(15896783, 15868739));
    EXPECT_EQ(round.length(), around);
}
