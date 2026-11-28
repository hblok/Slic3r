// From GUI/test_cli.cpp, working on a copy of the model in a directory of its own.
#include <gtest/gtest.h>

#include <sys/stat.h>

#include <algorithm>
#include <cmath>
#include <fstream>
#include <iterator>
#include <string>
#include <vector>

#include "GCodeReader.hpp"
#include "slic3r.hpp"

using namespace Slic3r;

/// equal within the tolerance Catch's Approx used
#define EXPECT_APPROX(value, expected) EXPECT_NEAR(value, expected, 1.2e-5 * std::abs(expected))

namespace {

const std::string inputs {"src/test/inputs/test_cli/"};

std::string content(const std::string& path) {
    std::ifstream in(path, std::ios::binary);
    return std::string(std::istreambuf_iterator<char>(in), std::istreambuf_iterator<char>());
}

/// A new directory with a copy of the 20 x 20 x 10 mm box: the program writes beside its input.
struct Box {
    std::string dir, stl;
    Box() {
        static int count {0};
        dir = testing::TempDir() + "command_line_" + std::to_string(++count) + "/";
        mkdir(dir.c_str(), 0700);
        stl = dir + "20mmbox.stl";
        std::ofstream(stl, std::ios::binary) << content(inputs + "20mmbox.stl");
    }
    bool has(const std::string& name) const { return std::ifstream(dir + name).good(); }
};

/// Run the command line on these arguments.
void run(CLI& cli, std::vector<std::string> arguments) {
    arguments.insert(arguments.begin(), "slic3r");
    std::vector<char*> argv;
    for (auto& argument : arguments) argv.push_back(&argument[0]);
    argv.push_back(nullptr);
    cli.run(static_cast<int>(arguments.size()), argv.data());
}
void run(const std::vector<std::string>& arguments) {
    CLI cli;
    run(cli, arguments);
}

/// The size of the STL written for the box with these options.
Sizef3 exported_size(std::vector<std::string> options) {
    const Box box;
    const std::string out {box.dir + "transformed.stl"};
    options.insert(options.end(), {"--export-stl", "--output", out, box.stl});
    run(options);
    return Model::read_from_file(out).mesh().bounding_box().size();
}

/// The extent in X and Y of the lines `counts` lets through, in the G-code of the box
/// sliced with the test configuration and `options`.
BoundingBoxf extent(const std::vector<std::string>& options, bool (*counts)(const GCodeReader&)) {
    const Box box;
    CLI cli;
    std::vector<std::string> arguments {"-g", "--load", inputs + "20mmbox_config.ini"};
    arguments.insert(arguments.end(), options.begin(), options.end());
    arguments.push_back(box.stl);
    run(cli, arguments);
    const std::string gcode {content(box.dir + "20mmbox.gcode")};
    EXPECT_FALSE(gcode.empty());
    BoundingBoxf extent;
    extent.min = Pointf(50, 50);
    extent.max = Pointf(-50, -50);
    GCodeReader reader;
    reader.apply_config(cli.full_print_config_ref());
    reader.parse(gcode, [&extent, counts](GCodeReader& self, const GCodeReader::GCodeLine&) {
        if (!counts(self)) return;
        extent.min.x = std::min(extent.min.x, self.X);
        extent.min.y = std::min(extent.min.y, self.Y);
        extent.max.x = std::max(extent.max.x, self.X);
        extent.max.y = std::max(extent.max.y, self.Y);
    });
    return extent;
}

} // namespace

TEST(CommandLine, ExportsGcode) {
    for (const char* option : {"--export-gcode", "-g"}) {
        const Box box;
        run({option, box.stl});
        EXPECT_TRUE(box.has("20mmbox.gcode")) << option;
    }
}

TEST(CommandLine, ExportsModels) {
    for (const std::string format : {"obj", "pov", "amf", "3mf"}) {
        const Box box;
        run({"--export-" + format, box.stl});
        EXPECT_TRUE(box.has("20mmbox." + format)) << format;
    }
}

TEST(CommandLine, ExportsOneSvgFileWithAllLayers) {
    const Box box;
    run({"--export-svg", box.stl});
    ASSERT_TRUE(box.has("20mmbox.svg"));
    const std::string svg {content(box.dir + "20mmbox.svg")};
    EXPECT_NE(svg.find("<g id=\"layer0\" slic3r:z=\"0.175\">"), std::string::npos);  // mm, not unscaled twice
    EXPECT_NE(svg.find("<g id=\"layer32\""), std::string::npos);
    EXPECT_EQ(svg.find("<g id=\"layer33\""), std::string::npos);
}

TEST(CommandLine, ExportsSlaSvg) {
    for (const char* option : {"--export-sla-svg", "--sla"}) {
        const Box box;
        run({option, box.stl});
        EXPECT_TRUE(box.has("20mmbox.svg")) << option;
    }
}

TEST(CommandLine, WritesWhereToldTo) {
    const Box box;
    run({"--sla", "--output", box.dir + "output.svg", box.stl});
    EXPECT_TRUE(box.has("output.svg"));
    run({"--export-stl", "--output", box.dir + "output.stl", box.stl});
    EXPECT_TRUE(box.has("output.stl"));
    run({"--save", box.dir + "cfg.ini", box.stl});
    EXPECT_TRUE(box.has("cfg.ini"));
}

// the transforms run before the objects have instances; they crashed until 2026-11-27
TEST(CommandLine, Scales) {
    const Sizef3 size {exported_size({"--scale", "2"})};
    EXPECT_APPROX(size.x, 40);
    EXPECT_APPROX(size.y, 40);
    EXPECT_APPROX(size.z, 20);
}

TEST(CommandLine, RotatesAroundZ) {
    const Sizef3 size {exported_size({"--rotate", "45"})};
    EXPECT_APPROX(size.x, 20 * std::sqrt(2));
    EXPECT_APPROX(size.z, 10);
}

TEST(CommandLine, RotatesAroundX) {
    const Sizef3 size {exported_size({"--rotate-x", "90"})};
    EXPECT_APPROX(size.x, 20);
    EXPECT_APPROX(size.y, 10);
    EXPECT_APPROX(size.z, 20);
}

TEST(CommandLine, ScalesToFit) {
    const Sizef3 size {exported_size({"--scale-to-fit", "10,10,10"})};
    EXPECT_APPROX(size.x, 10);
    EXPECT_APPROX(size.z, 5);
}

TEST(CommandLine, DuplicatesInAGrid) {
    const Sizef3 size {exported_size({"--duplicate-grid", "2,2"})};  // 6 mm apart
    EXPECT_APPROX(size.x, 46);
    EXPECT_APPROX(size.y, 46);
    EXPECT_APPROX(size.z, 10);
}

TEST(CommandLine, CentresOnAPoint) {
    // the second layer, without the first move from the origin
    const BoundingBoxf first_layer {extent({"--center", "40,40"}, [](const GCodeReader& at) {
        return at.X != 0.0 && at.Y != 0.0 && at.Z <= 0.6 && at.Z > 0.3;
    })};
    EXPECT_APPROX(first_layer.min.x, 30.1);
    EXPECT_APPROX(first_layer.min.y, 30.1);
    EXPECT_APPROX(first_layer.max.x, 49.9);
    EXPECT_APPROX(first_layer.max.y, 49.9);
}

TEST(CommandLine, LeavesTheObjectWhereItIsWithDontArrange) {
    // the box is centred on the origin
    const BoundingBoxf first_layer {extent({"--dont-arrange"}, [](const GCodeReader& at) { return at.Z < 0.6; })};
    EXPECT_APPROX(first_layer.min.x, -9.9);
    EXPECT_APPROX(first_layer.min.y, -9.9);
    EXPECT_APPROX(first_layer.max.x, 9.9);
    EXPECT_APPROX(first_layer.max.y, 9.9);
}
