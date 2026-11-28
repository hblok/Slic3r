// Points, lines, polylines, polygons, clipping, extrusion entities and the motion
// planner: ported from the Perl binding tests (xs/t/).
#include <catch.hpp>

#include <numeric>

#include "BoundingBox.hpp"
#include "ClipperUtils.hpp"
#include "ExPolygon.hpp"
#include "ExPolygonCollection.hpp"
#include "ExtrusionEntity.hpp"
#include "ExtrusionEntityCollection.hpp"
#include "Geometry.hpp"
#include "Line.hpp"
#include "MotionPlanner.hpp"
#include "Point.hpp"
#include "Polygon.hpp"
#include "Polyline.hpp"
#include "PolylineCollection.hpp"
#include "SurfaceCollection.hpp"

using namespace Slic3r;

namespace {

const Points square {Point(100, 100), Point(200, 100), Point(200, 200), Point(100, 200)};  // ccw
const Points hole_in_square {Point(140, 140), Point(140, 160), Point(160, 160), Point(160, 140)};  // cw

ExPolygon holed() { return ExPolygon(square, hole_in_square); }

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

std::vector<coord_t> xs(const Polylines &polylines) {
    std::vector<coord_t> out;
    for (const auto &p : polylines) for (const auto &point : p.points) out.push_back(point.x);
    return out;
}

Polylines polylines_of(const ExtrusionEntityCollection &collection) {
    Polylines out;
    for (const auto *entity : collection.entities) out.push_back(entity->as_polyline());
    return out;
}

} // namespace

TEST_CASE("Point operations") {
    const Point point(10, 15);
    Point other(point);
    other.scale(2);
    REQUIRE(other == Point(20, 30));
    other.translate(10, -15);
    REQUIRE(other == Point(30, 15));
    REQUIRE_FALSE(point.coincides_with(other));

    Point nearest;
    REQUIRE(point.nearest_point({other, Point(100, 200)}, &nearest));
    REQUIRE(nearest == other);

    const Line line(Point(0, 0), Point(100, 0));
    REQUIRE(Point(0, 0).distance_to(line) == 0);
    REQUIRE(Point(100, 0).distance_to(line) == 0);
    REQUIRE(Point(50, 0).distance_to(line) == 0);
    REQUIRE(Point(150, 0).distance_to(line) == 50);
    REQUIRE(Point(0, 50).distance_to(line) == 50);
    REQUIRE(Point(50, 50).distance_to(line) == 50);
    REQUIRE(Point(50, 50).perp_distance_to(line) == 50);
    REQUIRE(Point(150, 50).perp_distance_to(line) == 50);
    REQUIRE(Point(100, 0).distance_to(Line(Point(50, 50), Point(125, -25))) == 0);
    // no overflow with large coordinates
    REQUIRE(Point(1664161, 18335848).perp_distance_to(Line(Point(18335846, 18335845), Point(18335846, 1664160))) == 16671685);
    REQUIRE(Point(76975850, 89989996).ccw(Point(76989990, 109989991), Point(76989987, 89989994)) < 0);

    const Line base(Point(10, 10), Point(20, 10));
    REQUIRE(Point(15, 15).projection_onto(base) == Point(15, 10));
    REQUIRE(Point(0, 15).projection_onto(base) == Point(10, 10));
    REQUIRE(Point(25, 15).projection_onto(base) == Point(20, 10));
    REQUIRE(Point(10, 10).projection_onto(base) == Point(10, 10));
    REQUIRE(Point(12, 10).projection_onto(base) == Point(12, 10));
}

TEST_CASE("Line operations") {
    Line line(Point(100, 100), Point(200, 100));
    line.translate(10, -5);
    REQUIRE(line.a == Point(110, 95));
    REQUIRE(line.b == Point(210, 95));
    line.reverse();
    REQUIRE(line.a == Point(210, 95));
    REQUIRE(Line(Point(0, 0), Point(200, 0)).parallel_to(Line(Point(200, 200), Point(0, 200))));

    for (const double angle : {0.0, PI / 4, PI / 2, PI}) {
        Line turned(Point(0, 0), Point(100, 0));
        turned.rotate(angle, Point(0, 0));
        Line reversed(turned);
        reversed.reverse();
        REQUIRE(turned.parallel_to(turned));
        REQUIRE(turned.parallel_to(reversed));
        REQUIRE(turned.parallel_to(turned.direction()));
        REQUIRE(turned.parallel_to(turned.direction() + PI));
        REQUIRE(turned.parallel_to(turned.direction() - PI));
        for (const double nudge : {1e-4 / 2, -1e-4 / 2}) {
            Line nudged(turned);
            nudged.rotate(nudge, Point(0, 0));
            REQUIRE(turned.parallel_to(nudged));
        }
    }

    Point crossing;
    REQUIRE(Line(Point(100, 0), Point(200, 0)).intersection_infinite(Line(Point(300, 300), Point(300, 100)), &crossing));
    REQUIRE(crossing == Point(300, 0));
}

TEST_CASE("Polyline operations") {
    const Points corner {Point(100, 100), Point(200, 100), Point(200, 200)};
    Polyline polyline;
    polyline.points = corner;
    REQUIRE(polyline.lines().size() == 2);
    REQUIRE(polyline.length() == 200);

    Polyline doubled(polyline);
    doubled.append(polyline);
    REQUIRE(doubled.points.size() == 6);
    const double length {doubled.length()};
    doubled.clip_end(length / 3);
    REQUIRE(std::abs(doubled.length() - (length - length / 3)) < 1);

    Polyline straight;
    straight.points = {Point(0, 0), Point(20, 0), Point(50, 0), Point(80, 0), Point(100, 0)};
    straight.simplify(2);
    REQUIRE(straight.points == Points({Point(0, 0), Point(100, 0)}));
    Polyline zigzag;
    zigzag.points = {Point(0, 0), Point(50, 50), Point(100, 0), Point(125, -25), Point(150, 50)};
    zigzag.simplify(25);
    REQUIRE(zigzag.points == Points({Point(0, 0), Point(50, 50), Point(125, -25), Point(150, 50)}));
    // Douglas-Peucker uses the distance to the segment, not to the line through it
    Polyline back;
    back.points = {Point(0, 0), Point(100, 0), Point(50, 10)};
    back.simplify(25);
    REQUIRE(back.points.size() == 3);

    Polyline extended(polyline);
    extended.extend_end(50);
    REQUIRE(extended.length() == 250);
    extended.extend_start(50);
    REQUIRE(extended.length() == 300);

    Polyline first, second;
    polyline.split_at(Point(150, 100), &first, &second);
    REQUIRE(first.points.size() == 2);
    REQUIRE(second.points.size() == 3);
    REQUIRE(first.last_point() == Point(150, 100));
    REQUIRE(second.first_point() == Point(150, 100));

    Polyline closed;
    closed.points = {corner[0], corner[1], corner[2], corner[0]};
    Polyline head, tail;
    closed.split_at(closed.first_point(), &head, &tail);
    REQUIRE(head.points.size() == 1);
    REQUIRE(tail.points.size() == 4);
}

TEST_CASE("Polygon operations") {
    const Polygon polygon(square);
    Polygon clockwise(polygon);
    clockwise.reverse();
    REQUIRE(polygon.is_valid());
    REQUIRE(polygon.lines().size() == 4);
    REQUIRE(polygon.split_at_first_point().points == Points({square[0], square[1], square[2], square[3], square[0]}));
    const Points from_third {square[2], square[3], square[0], square[1], square[2]};
    REQUIRE(polygon.split_at_index(2).points == from_third);
    REQUIRE(polygon.split_at_vertex(square[2]).points == from_third);
    REQUIRE(polygon.area() == 100 * 100);
    REQUIRE(polygon.is_counter_clockwise());
    REQUIRE_FALSE(clockwise.is_counter_clockwise());
    clockwise.make_counter_clockwise();
    REQUIRE(clockwise.is_counter_clockwise());
    clockwise.make_counter_clockwise();
    REQUIRE(clockwise.is_counter_clockwise());
    REQUIRE(polygon.contains(Point(150, 150)));
    clockwise.reverse();
    REQUIRE(clockwise.contains(Point(150, 150)));
    REQUIRE(polygon.centroid() == Point(150, 150));

    Polygon hexagon;
    hexagon.points.push_back(Point(100, 0));
    for (int i = 1; i <= 5; ++i) {
        Point corner(100, 0);
        corner.rotate(PI / 3 * i, Point(0, 0));
        hexagon.points.push_back(corner);
    }
    Polygons triangles;
    hexagon.triangulate_convex(&triangles);
    REQUIRE(triangles.size() == 4);
    for (const auto &triangle : triangles) REQUIRE(triangle.is_counter_clockwise());

    const Polygon sliver(Points{Point(50000000, 100000000), Point(300000000, 102000000), Point(50000000, 104000000)});
    Point crossing;
    REQUIRE(sliver.intersection(Line(Point(175992032, 102000000), Point(47983964, 102000000)), &crossing));
    REQUIRE(crossing == Point(50000000, 102000000));
}

TEST_CASE("ExPolygon operations") {
    const ExPolygon expolygon {holed()};
    REQUIRE(expolygon.is_valid());
    REQUIRE(expolygon.area() == 100 * 100 - 20 * 20);

    ExPolygon moved {holed()};
    moved.translate(10, -5);
    REQUIRE(moved.contour.points.front() == Point(110, 95));
    REQUIRE(moved.holes.front().points.front() == Point(150, 135));

    ExPolygon turned {holed()};
    turned.rotate(PI / 2, Point(150, 150));
    REQUIRE(turned.contour.points == Points({square[1], square[2], square[3], square[0]}));
    REQUIRE(turned.holes.front().points == Points({hole_in_square[3], hole_in_square[0], hole_in_square[1], hole_in_square[2]}));

    Polygons trapezoids;
    ExPolygon(Polygon(square)).get_trapezoids2(&trapezoids, PI / 2);
    REQUIRE(trapezoids.size() == 1);
    REQUIRE(trapezoids.front().points.size() == 4);

    trapezoids.clear();
    expolygon.get_trapezoids2(&trapezoids, PI / 2);
    REQUIRE(trapezoids.size() == 4);
    double covered {0};
    for (const auto &trapezoid : trapezoids) covered += trapezoid.area();
    REQUIRE(covered == Approx(expolygon.area()));

    trapezoids.clear();
    ExPolygon(Points{Point(0, 100), Point(100, 0), Point(200, 0), Point(300, 100), Point(200, 200), Point(100, 200)})
        .get_trapezoids2(&trapezoids, PI / 2);
    REQUIRE(trapezoids.size() == 3);

    Polygons triangles;
    expolygon.triangulate_pp(&triangles);
    REQUIRE(triangles.size() == 8);
    covered = 0;
    for (const auto &triangle : triangles) covered += triangle.area();
    REQUIRE(covered == Approx(expolygon.area()));
}

TEST_CASE("Clipping and offsetting") {
    const Polygon outer(Points{Point(200, 100), Point(200, 200), Point(100, 200), Point(100, 100)});
    const Polygon hole(Points{Point(160, 140), Point(140, 140), Point(140, 160), Point(160, 160)});
    const ExPolygon expolygon(outer.points, hole.points);
    // grown or shrunk: a square ring, its sides 'by' further out
    auto ring = [](const ExPolygons &result, coord_t by) {
        REQUIRE(result.size() == 1);
        REQUIRE(result[0].holes.size() == 1);
        const BoundingBox contour {result[0].contour.bounding_box()}, inner {result[0].holes[0].bounding_box()};
        REQUIRE(contour.min == Point(100 - by, 100 - by));
        REQUIRE(contour.max == Point(200 + by, 200 + by));
        REQUIRE(inner.min == Point(140 + by, 140 + by));
        REQUIRE(inner.max == Point(160 - by, 160 - by));
    };
    // scale 1: the offsets are in the coordinates' own units
    ring(offset_ex(Polygons{outer, hole}, 5, 1), 5);
    ring(offset2_ex(Polygons{outer, hole}, 5, -2, 1), 3);

    const ExPolygon large(Points{Point(20000000, 20000000), Point(0, 20000000), Point(0, 0), Point(20000000, 0)},
        Points{Point(5000000, 15000000), Point(15000000, 15000000), Point(15000000, 5000000), Point(5000000, 5000000)});
    const ExPolygons reopened {offset2_ex(to_polygons(large), -1, +1, 1)};
    REQUIRE(reopened.at(0).area() == large.area());

    Polygon filled(hole);
    filled.reverse();
    REQUIRE(diff_ex(Polygons{outer}, Polygons{filled}).at(0).area() == expolygon.area());

    Polyline across;
    across.points = {Point(50, 150), Point(300, 150)};
    const Polylines inside {intersection_pl(Polylines{across}, Polygons{outer, hole})};
    REQUIRE(inside.size() == 2);
    for (const auto &line : inside) REQUIRE(line.length() == 40);
    Polylines outside {diff_pl(Polylines{across}, Polygons{outer, hole})};
    REQUIRE(outside.size() == 3);
    std::vector<double> lengths;
    for (const auto &line : outside) lengths.push_back(line.length());
    std::sort(lengths.begin(), lengths.end());
    REQUIRE(lengths == std::vector<double>({20, 50, 100}));

    // old Clipper bugs (upstream issue 2028 and Clipper 96, 122, 126)
    Polyline comb;
    comb.points = {Point(44735000, 31936670), Point(55270000, 31936670), Point(55270000, 25270000), Point(74730000, 25270000),
        Point(74730000, 44730000), Point(68063296, 44730000), Point(68063296, 55270000), Point(74730000, 55270000),
        Point(74730000, 74730000), Point(55270000, 74730000), Point(55270000, 68063296), Point(44730000, 68063296),
        Point(44730000, 74730000), Point(25270000, 74730000), Point(25270000, 55270000), Point(31936670, 55270000),
        Point(31936670, 44730000), Point(25270000, 44730000), Point(25270000, 25270000), Point(44730000, 25270000),
        Point(44730000, 31936670)};
    const Polygon corner_box(Points{Point(75200000, 45200000), Point(54800000, 45200000), Point(54800000, 24800000), Point(75200000, 24800000)});
    REQUIRE(intersection_pl(Polylines{comb}, Polygons{corner_box}).size() == 1);

    Polyline loop;
    loop.points = {Point(1975, 1975), Point(25, 1975), Point(25, 25), Point(1975, 25), Point(1975, 1975)};
    const Polylines clipped {intersection_pl(Polylines{loop}, Polygons{
        Polygon(Points{Point(2025, 2025), Point(-25, 2025), Point(-25, -25), Point(2025, -25)}),
        Polygon(Points{Point(525, 525), Point(525, 1475), Point(1475, 1475), Point(1475, 525)})})};
    REQUIRE(clipped.size() == 1);
    REQUIRE(clipped[0].points.size() == 5);

    Polyline whole;
    whole.points = {Point(200000, 19799999), Point(200000, 200000), Point(24304692, 200000), Point(15102879, 17506106),
        Point(13883200, 19799999), Point(200000, 19799999)};
    const Polylines kept {intersection_pl(Polylines{whole}, Polygons{Polygon(Points{Point(15257205, 18493894),
        Point(14350057, 20200000), Point(-200000, 20200000), Point(-200000, -200000), Point(25196917, -200000)})})};
    REQUIRE(kept.size() == 1);
    REQUIRE(kept[0].length() == Approx(whole.length()));
}

TEST_CASE("Surface collections group by type") {
    SurfaceCollection collection;
    collection.surfaces.push_back(Surface(stBottom, holed()));
    collection.surfaces.push_back(Surface(stBottom, holed()));
    collection.surfaces.push_back(Surface(stTop, holed()));
    std::vector<SurfacesPtr> groups;
    collection.group(&groups);
    REQUIRE(groups.size() == 2);
}

TEST_CASE("Extrusion loops split and keep their length") {
    ExtrusionLoop single;
    single.append(path_of(Polygon(square).split_at_first_point().points));
    REQUIRE(single.polygon().area() == Polygon(square).area());
    REQUIRE(single.length() == 400);
    single.split_at_vertex(square[2]);
    REQUIRE(single.paths.size() == 1);
    REQUIRE(single.paths[0].polyline.points == Points({square[2], square[3], square[0], square[1], square[2]}));

    const Points lower {Point(100, 100), Point(200, 100), Point(200, 200)};
    const Points upper {Point(200, 200), Point(100, 200), Point(100, 100)};
    ExtrusionLoop two;
    two.append(path_of(lower, erExternalPerimeter));
    two.append(path_of(upper, erOverhangPerimeter));
    const double total {two.length()};
    {
        ExtrusionLoop loop(two);
        loop.split_at_vertex(lower[1]);
        REQUIRE(loop.length() == total);
        REQUIRE(loop.paths.size() == 3);
        REQUIRE(loop.paths.front().first_point() == lower[1]);
        REQUIRE(loop.paths.back().last_point() == lower[1]);
        REQUIRE(loop.paths[0].last_point() == loop.paths[1].first_point());
        REQUIRE(loop.paths[1].last_point() == loop.paths[2].first_point());
        REQUIRE(loop.paths[0].role == erExternalPerimeter);
        REQUIRE(loop.paths[1].role == erOverhangPerimeter);
        REQUIRE(loop.paths[2].role == erExternalPerimeter);
        REQUIRE(loop.paths[0].polyline.points.size() == 2);
        REQUIRE(loop.paths[1].polyline.points.size() == 3);
        REQUIRE(loop.paths[2].polyline.points.size() == 2);
        ExtrusionPaths clipped;
        loop.clip_end(3, &clipped);
        double length {0};
        for (const auto &path : clipped) length += path.length();
        REQUIRE(length == Approx(total - 3));
    }
    {
        ExtrusionLoop loop(two);
        loop.split_at_vertex(upper[0]);  // at the end of a path
        REQUIRE(loop.length() == total);
        REQUIRE(loop.paths.size() == 2);
        REQUIRE(loop.paths.front().first_point() == upper[0]);
        REQUIRE(loop.paths.back().last_point() == upper[0]);
        REQUIRE(loop.paths[0].role == erOverhangPerimeter);
        REQUIRE(loop.paths[1].role == erExternalPerimeter);
    }
    {
        ExtrusionLoop loop(two);
        loop.split_at(Point(250, 150));
        REQUIRE(loop.length() == total);
        REQUIRE(loop.paths.size() == 3);
        REQUIRE(loop.paths.front().first_point() == Point(200, 150));
        REQUIRE(loop.paths.back().last_point() == Point(200, 150));
    }

    ExtrusionLoop four;
    four.append(path_of({Point(59312736, 4821067), Point(64321068, 4821067), Point(64321068, 4821067), Point(64321068, 9321068), Point(59312736, 9321068)}, erExternalPerimeter));
    four.append(path_of({Point(59312736, 9321068), Point(9829401, 9321068)}, erOverhangPerimeter));
    four.append(path_of({Point(9829401, 9321068), Point(4821067, 9321068), Point(4821067, 4821067), Point(9829401, 4821067)}, erExternalPerimeter));
    four.append(path_of({Point(9829401, 4821067), Point(59312736, 4821067)}, erOverhangPerimeter));
    const double length {four.length()};
    const Point at(4821067, 9321068);
    if (!four.split_at_vertex(at)) four.split_at(at);
    REQUIRE(four.length() == length);
    std::vector<ExtrusionRole> roles;
    for (const auto &path : four.paths) roles.push_back(path.role);
    REQUIRE(roles == std::vector<ExtrusionRole>({erExternalPerimeter, erOverhangPerimeter, erExternalPerimeter,
        erOverhangPerimeter, erExternalPerimeter}));

    ExtrusionLoop round;
    round.append(path_of({Point(15896783, 15868739), Point(24842049, 12117558), Point(33853238, 15801279), Point(37591780, 24780128),
        Point(37591780, 24844970), Point(33853231, 33825297), Point(24842049, 37509013), Point(15896798, 33757841),
        Point(12211841, 24812544), Point(15896783, 15868739)}));
    const double around {round.length()};
    round.split_at(Point(15896783, 15868739));
    REQUIRE(round.length() == around);
}

TEST_CASE("Chained paths") {
    auto polyline = [](const Points &points) { Polyline p; p.points = points; return p; };
    const Polylines vertical {polyline({Point(0, 15), Point(0, 18), Point(0, 20)}), polyline({Point(0, 10), Point(0, 8), Point(0, 5)})};
    const Polylines horizontal {polyline({Point(15, 0), Point(10, 0), Point(4, 0)}), polyline({Point(10, 5), Point(15, 5), Point(20, 5)})};
    REQUIRE(ys(PolylineCollection::chained_path_from(vertical, Point(0, 30))) == std::vector<coord_t>({20, 18, 15, 10, 8, 5}));
    REQUIRE(ys(PolylineCollection::chained_path(vertical)) == std::vector<coord_t>({15, 18, 20, 10, 8, 5}));
    REQUIRE(xs(PolylineCollection::chained_path_from(horizontal, Point(30, 0))) == std::vector<coord_t>({20, 15, 10, 15, 10, 4}));

    ExtrusionEntityCollection collection;
    for (const auto &p : vertical) collection.append(path_of(p.points));
    ExtrusionEntityCollection chained;
    collection.chained_path_from(Point(0, 30), &chained);
    REQUIRE(ys(polylines_of(chained)) == std::vector<coord_t>({20, 18, 15, 10, 8, 5}));
    REQUIRE(ys(polylines_of(collection.chained_path())) == std::vector<coord_t>({15, 18, 20, 10, 8, 5}));
    REQUIRE_FALSE(collection.no_sort);
    collection.no_sort = true;
    REQUIRE(ExtrusionEntityCollection(collection).no_sort);
}

TEST_CASE("Hull, parallel directions, arranging and bounding boxes") {
    REQUIRE(Geometry::convex_hull(Points{Point(100, 100), Point(100, 200), Point(200, 200), Point(200, 100), Point(150, 150)})
        .points.size() == 4);
    REQUIRE(Geometry::directions_parallel(0, 0, 0));
    REQUIRE(Geometry::directions_parallel(0, PI, 0));
    REQUIRE(Geometry::directions_parallel(0, 0, PI / 180));
    REQUIRE(Geometry::directions_parallel(0, PI, PI / 180));
    REQUIRE_FALSE(Geometry::directions_parallel(PI / 2, PI, 0));
    REQUIRE_FALSE(Geometry::directions_parallel(PI / 2, PI, PI / 180));
    Pointfs positions;
    REQUIRE(Geometry::arrange(4, Pointf(20, 20), 5, nullptr, positions));
    REQUIRE(positions.size() == 4);

    const BoundingBox box(Points{Point(100, 200), Point(500, -600)});
    REQUIRE(box.min == Point(100, -600));
    REQUIRE(box.max == Point(500, 200));
    BoundingBox one;
    one.merge(Point(10, 10));
    REQUIRE(one.min == Point(10, 10));
    REQUIRE(one.max == Point(10, 10));
}

TEST_CASE("Motion planner goes around holes") {
    const double unit {1 / SCALING_FACTOR};
    ExPolygon island {holed()};
    island.contour.scale(unit);
    island.holes[0].scale(unit);
    auto at = [unit](coord_t x, coord_t y) { return Point(static_cast<coord_t>(x * unit), static_cast<coord_t>(y * unit)); };
    {
        MotionPlanner planner(ExPolygons{island});
        const Point from {at(120, 120)}, to {at(180, 180)};
        const Polyline path {planner.shortest_path(from, to)};
        REQUIRE(path.is_valid());
        REQUIRE(path.length() > Line(from, to).length());
        REQUIRE(path.first_point() == from);
        REQUIRE(path.last_point() == to);
        REQUIRE(island.contains(path));
    }
    {
        MotionPlanner planner(ExPolygons{island});
        const Point from {at(80, 100)}, to {at(220, 200)};  // outside the island
        const Polyline path {planner.shortest_path(from, to)};
        REQUIRE(path.is_valid());
        REQUIRE(path.length() > Line(from, to).length());
        REQUIRE(path.first_point() == from);
        REQUIRE(path.last_point() == to);
        REQUIRE(intersection_pl(Polylines{path}, to_polygons(island)).empty());
    }
    {
        ExPolygon second(island);
        second.translate(300 * unit, 0);
        MotionPlanner planner(ExPolygons{island, second});
        const Point from {at(120, 120)}, to {at(420, 120)};
        REQUIRE(island.contains(from));
        REQUIRE(second.contains(to));
        REQUIRE(planner.shortest_path(from, to).is_valid());
    }
    {
        const ExPolygons islands {
            ExPolygon(Points{Point(123800962, 89330311), Point(123959159, 89699438), Point(124000004, 89898430), Point(124000012, 110116427), Point(123946510, 110343065), Point(123767391, 110701303), Point(123284087, 111000001), Point(102585791, 111000009), Point(102000004, 110414223), Point(102000004, 89585787), Point(102585790, 89000000), Point(123300022, 88999993)}),
            ExPolygon(Points{Point(97800954, 89330311), Point(97959151, 89699438), Point(97999996, 89898430), Point(98000004, 110116427), Point(97946502, 110343065), Point(97767383, 110701303), Point(97284079, 111000001), Point(76585783, 111000009), Point(75999996, 110414223), Point(75999996, 89585787), Point(76585782, 89000000), Point(97300014, 88999993)})};
        MotionPlanner planner(islands);
        const Point from(79120520, 107839491), to(104664164, 108335852);
        REQUIRE(islands[1].contains(from));
        REQUIRE(islands[0].contains(to));
        REQUIRE(planner.shortest_path(from, to).is_valid());
    }
}
