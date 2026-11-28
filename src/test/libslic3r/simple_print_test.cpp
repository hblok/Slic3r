#include <gtest/gtest.h>

#include <fstream>
#include <iterator>
#include <string>

#include "Model.hpp"
#include "SimplePrint.hpp"
#include "TriangleMesh.hpp"

using namespace Slic3r;

TEST(SimplePrint, ExportsTheGcodeOfAModel) {
    Model model;
    TriangleMesh mesh {TriangleMesh::make_cube(10, 10, 5)};
    mesh.repair();
    model.add_object()->add_volume(mesh);

    SimplePrint print;
    print.set_model(model);
    const std::string file {testing::TempDir() + "cube.gcode"};
    print.export_gcode(file);
    std::ifstream in(file);
    const std::string gcode {std::istreambuf_iterator<char>(in), std::istreambuf_iterator<char>()};
    EXPECT_NE(gcode.find("G1 "), std::string::npos);
    EXPECT_GT(print.total_used_filament(), 0);
}
