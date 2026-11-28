// From test_fill.cpp; its cases about whole prints follow with the slicing core.
#include <gtest/gtest.h>

#include <algorithm>
#include <array>
#include <cmath>
#include <iterator>
#include <memory>
#include <set>
#include <vector>

#include "ClipperUtils.hpp"
#include "Fill/Fill.hpp"
#include "Flow.hpp"
#include "Surface.hpp"

using namespace Slic3r;
using namespace Slic3r::Geometry;

/// equal within the tolerance Catch's Approx used
#define EXPECT_APPROX(value, expected) EXPECT_NEAR(value, expected, 1.2e-5 * std::abs(expected))

namespace {

/// A rectilinear filler with lines every 50 units, left as they fall.
std::unique_ptr<Slic3r::Fill> rectilinear() {
    std::unique_ptr<Slic3r::Fill> filler {Slic3r::Fill::new_from_type("rectilinear")};
    filler->angle = -(PI) / 2.0;
    filler->min_spacing = 5;
    filler->dont_adjust = true;
    filler->endpoints_overlap = false;
    filler->density = filler->min_spacing / 50.0;
    return filler;
}

bool test_if_solid_surface_filled(const ExPolygon& expolygon, double flow_spacing, double angle = 0, double density = 1.0) {
    auto* filler {Slic3r::Fill::new_from_type("rectilinear")};
    filler->bounding_box = expolygon.bounding_box();
    filler->angle = angle;
    filler->dont_adjust = false;

    Surface surface(stBottom, expolygon);
    Flow flow(flow_spacing, 0.4, flow_spacing);

    filler->min_spacing = flow.spacing();

    Polylines paths {filler->fill_surface(surface)};

    // check whether any part was left uncovered
    Polygons grown_paths;
    grown_paths.reserve(paths.size());

// figure out what is actually going on here re: data types
    std::for_each(paths.begin(), paths.end(), [filler, &grown_paths] (const Polyline& p) { 
        polygons_append(grown_paths, p.grow(scale_(filler->spacing() / 2.0)));
    });
    
    ExPolygons uncovered = diff_ex(expolygon, grown_paths, true);

    // ignore very small dots
    const auto scaled_flow_spacing { std::pow(scale_(flow_spacing), 2) };
    auto iter {std::remove_if(uncovered.begin(), uncovered.end(), [scaled_flow_spacing] (const ExPolygon& poly) {
        return poly.area() > scaled_flow_spacing;
    }) };
    uncovered.erase(iter, uncovered.end());

    return uncovered.size() == 0; // solid surface is fully filled

}

} // namespace

TEST(FillRectilinear, FillsASquareInOnePath) {
    const std::unique_ptr<Slic3r::Fill> filler {rectilinear()};
    auto test = [&filler](const ExPolygon& poly) {
        return filler->fill_surface(Slic3r::Surface(stTop, poly));
    };
    (void)test;
    Points test_set;
    test_set.reserve(4);
    Pointfs points {Pointf(0,0), Pointf(100,0), Pointf(100,100), Pointf(0,100)};
    for (size_t i = 0; i < 4; ++i) {
        std::transform(points.cbegin()+i, points.cend(),   std::back_inserter(test_set), [] (const Pointf& a) -> Point { return Point::new_scale(a); } ); 
        std::transform(points.cbegin(), points.cbegin()+i, std::back_inserter(test_set), [] (const Pointf& a) -> Point { return Point::new_scale(a); } ); 
        Polylines paths {test(Slic3r::ExPolygon(test_set))};
        ASSERT_EQ(paths.size(), 1u); // one continuous path

        // TODO: determine what the "Expected length" should be for rectilinear fill of a 100x100 polygon. 
        // This check only checks that it's above scale(3*100 + 2*50) + scaled_epsilon.
        // ok abs($paths->[0]->length - scale(3*100 + 2*50)) - scaled_epsilon, 'path has expected length';
        EXPECT_GT(std::abs(paths[0].length() - static_cast<double>(scale_(3*100 + 2*50))) - SCALED_EPSILON, 0); // path has expected length

        test_set.clear();
    }
}

TEST(FillRectilinear, FillsADiamondInOnePath) {
    const std::unique_ptr<Slic3r::Fill> filler {rectilinear()};
    auto test = [&filler](const ExPolygon& poly) {
        return filler->fill_surface(Slic3r::Surface(stTop, poly));
    };
    (void)test;
    Pointfs points {Pointf(0,0), Pointf(100,0), Pointf(150,50), Pointf(100,100), Pointf(0,100), Pointf(-50,50)};
    Points test_set;
    test_set.reserve(6);
    std::transform(points.cbegin(), points.cend(),   std::back_inserter(test_set), [] (const Pointf& a) -> Point { return Point::new_scale(a); } ); 
    Polylines paths {test(Slic3r::ExPolygon(test_set))};
    ASSERT_EQ(paths.size(), 1u); // one continuous path
}

TEST(FillRectilinear, GoesAroundAHole) {
    const std::unique_ptr<Slic3r::Fill> filler {rectilinear()};
    auto test = [&filler](const ExPolygon& poly) {
        return filler->fill_surface(Slic3r::Surface(stTop, poly));
    };
    (void)test;
    Pointfs square { Pointf(0,0), Pointf(100,0), Pointf(100,100), Pointf(0,100)};
    Pointfs hole {Pointf(25,25), Pointf(75,25), Pointf(75,75), Pointf(25,75) };
    std::reverse(hole.begin(), hole.end());

    Points test_hole;
    Points test_square;

    std::transform(square.cbegin(), square.cend(), std::back_inserter(test_square), [] (const Pointf& a) -> Point { return Point::new_scale(a); } ); 
    std::transform(hole.cbegin(), hole.cend(), std::back_inserter(test_hole), [] (const Pointf& a) -> Point { return Point::new_scale(a); } ); 

    for (double angle : {-(PI/2.0), -(PI/4.0), -(PI), PI/2.0, PI}) {
        for (double spacing : {25.0, 5.0, 7.5, 8.5}) {
            filler->density = filler->min_spacing / spacing;
            filler->angle = angle;
            ExPolygon e(test_square, test_hole);
            Polylines paths {test(e)};
            EXPECT_TRUE((paths.size() >= 2 && paths.size() <= 3));
            // paths don't cross hole
            ASSERT_EQ(diff_pl(paths, offset(e, +SCALED_EPSILON*10)).size(), 0u);
        }
    }
}

TEST(FillRectilinear, LeavesNoSegmentOut) {
    const std::unique_ptr<Slic3r::Fill> filler {rectilinear()};
    auto test = [&filler](const ExPolygon& poly) {
        return filler->fill_surface(Slic3r::Surface(stTop, poly));
    };
    (void)test;
    filler->angle = (PI/4.0);
    filler->dont_adjust = false;
    filler->min_spacing = 0.654498;
    filler->endpoints_overlap = unscale(359974);
    filler->density = 1;
    filler->layer_id = 66;
    filler->z = 20.15;

    Points points {Point(25771516,14142125),Point(14142138,25771515),Point(2512749,14142131),Point(14142125,2512749)};
    Polylines paths {test(Slic3r::ExPolygon(points))};
    ASSERT_EQ(paths.size(), 1u); // one continuous path

    // TODO: determine what the "Expected length" should be for rectilinear fill of a 100x100 polygon. 
    // This check only checks that it's above scale(3*100 + 2*50) + scaled_epsilon.
    // ok abs($paths->[0]->length - scale(3*100 + 2*50)) - scaled_epsilon, 'path has expected length';
    EXPECT_GT(std::abs(paths[0].length() - static_cast<double>(scale_(3*100 + 2*50))) - SCALED_EPSILON, 0); // path has expected length
}

TEST(FillRectilinear, FillsARotatedSquare) {
    // a filler of its own, as it comes
    const std::unique_ptr<Slic3r::Fill> filler {Slic3r::Fill::new_from_type("rectilinear")};
    Points square { Point::new_scale(0,0), Point::new_scale(50,0), Point::new_scale(50,50), Point::new_scale(0,50)};
    ExPolygon expolygon(square);
    filler->bounding_box = expolygon.bounding_box();
    filler->angle = 0;
    
    auto surface {Surface(stTop, expolygon)};
    auto flow {Slic3r::Flow(0.69, 0.4, 0.50)};

    filler->min_spacing = flow.spacing();
    filler->density = 1.0;

    for (auto angle : { 0.0, 45.0}) {
        surface.expolygon.rotate(angle, Point(0,0));
        auto paths {filler->fill_surface(surface)};
        ASSERT_EQ(paths.size(), 1u);
    }
}

TEST(FillRectilinear, SolidlyFillsARectangle) {
    const std::unique_ptr<Slic3r::Fill> filler {rectilinear()};
    auto test = [&filler](const ExPolygon& poly) {
        return filler->fill_surface(Slic3r::Surface(stTop, poly));
    };
    (void)test;
    Points points {
        Point::new_scale(6883102, 9598327.01296997),
        Point::new_scale(6883102, 20327272.01297),
        Point::new_scale(3116896, 20327272.01297),
        Point::new_scale(3116896, 9598327.01296997) 
    };
    ExPolygon expolygon(points);
     
    EXPECT_EQ(test_if_solid_surface_filled(expolygon, 0.55), true);
    for (size_t i = 0; i <= 20; ++i)
    {
        expolygon.scale(1.05);
        EXPECT_EQ(test_if_solid_surface_filled(expolygon, 0.55), true);
    }
}

TEST(FillRectilinear, SolidlyFillsAnAwkwardShape) {
    const std::unique_ptr<Slic3r::Fill> filler {rectilinear()};
    auto test = [&filler](const ExPolygon& poly) {
        return filler->fill_surface(Slic3r::Surface(stTop, poly));
    };
    (void)test;
    Points points {
            Point(59515297,5422499),Point(59531249,5578697),Point(59695801,6123186),
            Point(59965713,6630228),Point(60328214,7070685),Point(60773285,7434379),
            Point(61274561,7702115),Point(61819378,7866770),Point(62390306,7924789),
            Point(62958700,7866744),Point(63503012,7702244),Point(64007365,7434357),
            Point(64449960,7070398),Point(64809327,6634999),Point(65082143,6123325),
            Point(65245005,5584454),Point(65266967,5422499),Point(66267307,5422499),
            Point(66269190,8310081),Point(66275379,17810072),Point(66277259,20697500),
            Point(65267237,20697500),Point(65245004,20533538),Point(65082082,19994444),
            Point(64811462,19488579),Point(64450624,19048208),Point(64012101,18686514),
            Point(63503122,18415781),Point(62959151,18251378),Point(62453416,18198442),
            Point(62390147,18197355),Point(62200087,18200576),Point(61813519,18252990),
            Point(61274433,18415918),Point(60768598,18686517),Point(60327567,19047892),
            Point(59963609,19493297),Point(59695865,19994587),Point(59531222,20539379),
            Point(59515153,20697500),Point(58502480,20697500),Point(58502480,5422499)
    };
    ExPolygon expolygon(points);
     
    EXPECT_EQ(test_if_solid_surface_filled(expolygon, 0.55), true);
    EXPECT_EQ(test_if_solid_surface_filled(expolygon, 0.55, PI/2.0), true);
}

TEST(FillRectilinear, SolidlyFillsAFlatStrip) {
    const std::unique_ptr<Slic3r::Fill> filler {rectilinear()};
    auto test = [&filler](const ExPolygon& poly) {
        return filler->fill_surface(Slic3r::Surface(stTop, poly));
    };
    (void)test;
    Points points {
        Point::new_scale(0,0),Point::new_scale(98,0),Point::new_scale(98,10), Point::new_scale(0,10)
    };
    ExPolygon expolygon(points);
     
    EXPECT_EQ(test_if_solid_surface_filled(expolygon, 0.5, 45.0, 0.99), true);
}

TEST(Fill, Monotonic) {
    // 20 mm square with an 8 mm hole in the middle, solid fill with vertical lines
    ExPolygon square;
    square.contour = Polygon::new_scale({Pointf(0,0), Pointf(20,0), Pointf(20,20), Pointf(0,20)});
    Polygon hole = Polygon::new_scale({Pointf(6,6), Pointf(6,14), Pointf(14,14), Pointf(14,6)});  // clockwise
    square.holes.push_back(hole);
    auto lines_of = [&square] (const char* pattern) {
        std::unique_ptr<Slic3r::Fill> filler {Slic3r::Fill::new_from_type(pattern)};
        filler->angle = PI / 2.0;  // vertical lines in the rotated frame: x is the column
        filler->min_spacing = 0.5;
        filler->density = 1;
        const Polylines polylines = filler->fill_surface(Slic3r::Surface(stTop, square));
        // the straight lines in printing order: (column x, y from, y to)
        std::vector<std::array<coord_t,3>> lines;
        for (const Polyline &p : polylines)
            for (size_t i = 1; i < p.points.size(); ++i)
                if (std::abs(p.points[i].x - p.points[i-1].x) < 10 && std::abs(p.points[i].y - p.points[i-1].y) > scale_(1))
                    lines.push_back({p.points[i].x, std::min(p.points[i].y, p.points[i-1].y), std::max(p.points[i].y, p.points[i-1].y)});
        return lines;
    };
    // lines of the column just before a line, overlapping it, printed after it
    // columns: x rounded to 0.01 mm (rotating back leaves a unit or two of noise)
    auto column = [] (coord_t x) { return coord_t(std::lround(x / double(scale_(0.01)))); };
    // lines of the column just before a line, overlapping it, printed after it
    auto violations = [&column] (const std::vector<std::array<coord_t,3>> &lines, int sign) {
        std::set<coord_t> xs;
        for (const auto &l : lines) xs.insert(column(l[0]));
        std::vector<coord_t> col(xs.begin(), xs.end());
        auto index = [&] (coord_t x) { return std::lower_bound(col.begin(), col.end(), column(x)) - col.begin(); };
        size_t v = 0;
        for (size_t k = 0; k < lines.size(); ++k)
            for (size_t j = k + 1; j < lines.size(); ++j)
                if (index(lines[j][0]) == index(lines[k][0]) - sign && lines[j][1] < lines[k][2] && lines[k][1] < lines[j][2]) ++v;
        return v;
    };
    const auto mono = lines_of("monotonic");
    const auto rect = lines_of("rectilinear");
    {  // the columns are evenly spaced from edge to edge
        std::set<coord_t> xs;
        for (const auto &l : mono) xs.insert(column(l[0]));
        std::vector<coord_t> col(xs.begin(), xs.end());
        EXPECT_GT(col.size(), 30u);
        for (size_t i = 2; i < col.size(); ++i)
            EXPECT_LE(std::abs((col[i] - col[i-1]) - (col[1] - col[0])), 1);
        EXPECT_LT(col.front() * scale_(0.01), scale_(0.5));
        EXPECT_GT(col.back() * scale_(0.01), scale_(19.5));
    }
    {  // every line follows its neighbours in the previous column
        EXPECT_EQ(std::min(violations(mono, 1), violations(mono, -1)), 0);
    }
    {  // rectilinear is not monotonic here (it goes around the hole)
        EXPECT_GT(std::min(violations(rect, 1), violations(rect, -1)), 0);
    }
}
