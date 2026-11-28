#include <gtest/gtest.h>

#include <fstream>
#include <iterator>
#include <string>

#include "Model.hpp"
#include "SLAPrint.hpp"
#include "TriangleMesh.hpp"

using namespace Slic3r;

namespace {

/// A 10 mm cube on the bed.
Model cube() {
    Model model;
    TriangleMesh mesh {TriangleMesh::make_cube(10, 10, 10)};
    mesh.repair();
    model.add_object()->add_volume(mesh);
    model.add_default_instances();
    return model;
}

} // namespace

TEST(SLAPrint, SlicesAnObjectIntoLayersAndWritesThemAsSvg) {
    const Model model {cube()};
    SLAPrint print(&model);
    print.config.layer_height.value = 0.5;
    print.config.first_layer_height.value = 0.5;
    print.slice();
    ASSERT_EQ(print.layers.size(), 20u);
    EXPECT_FALSE(print.layers.front().slices.expolygons.empty());
    EXPECT_FLOAT_EQ(print.layers.back().print_z, 10);

    const std::string file {testing::TempDir() + "cube.svg"};
    print.write_svg(file);
    std::ifstream in(file);
    const std::string svg {std::istreambuf_iterator<char>(in), std::istreambuf_iterator<char>()};
    EXPECT_NE(svg.find("<svg"), std::string::npos);
    EXPECT_NE(svg.find("<path d="), std::string::npos) << svg.substr(0, 300);
}
