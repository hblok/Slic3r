#include <catch.hpp>
#include <test_options.hpp>
#include "Model.hpp"
#include "TMF.hpp"
#include "IO.hpp"
#include <algorithm>
#include <boost/filesystem.hpp>
#include <boost/nowide/cstdio.hpp>
#include <miniz/miniz.h>


using namespace Slic3r;

SCENARIO("Reading 3mf file") {
    GIVEN("umlauts in the path of the file") {
        auto model {new Slic3r::Model()};
        WHEN("3mf model is read") {
            auto ret = Slic3r::IO::TMF::read(testfile("test_3mf/Geräte/box.3mf"),model);
            THEN("read should not return 0") {
                REQUIRE(ret == 1);
            }
        }
    }
}

// ported from the Perl binding tests (xs/t/23_3mf.t)
TEST_CASE("3MF: metadata, volumes and the instance's transformation are read") {
    Slic3r::Model model;
    REQUIRE(Slic3r::IO::TMF::read(testfile("test_3mf/gimblekeychain.3mf"), &model));
    REQUIRE(model.metadata.size() == 8);
    REQUIRE(model.objects.size() == 1);
    const ModelObject &object {*model.objects.front()};
    REQUIRE(object.instances.size() == 1);
    REQUIRE(object.part_number == -1);
    REQUIRE(object.volumes.size() == 3);
    REQUIRE(object.facets_count() == 19884);
    const ModelInstance &instance {*object.instances.front()};
    REQUIRE(instance.offset.x == Approx(-76.4989).margin(1e-4));
    REQUIRE(instance.offset.y == Approx(-142.501).margin(1e-4));
    REQUIRE(instance.scaling_factor == Approx(25.4).margin(1e-4));
    REQUIRE(instance.rotation == Approx(0).margin(1e-4));
}

namespace {
/// A file inside a zip archive, without line ends.
std::string zipped(const std::string &archive, const char* name) {
    mz_zip_archive zip;
    mz_zip_zero_struct(&zip);
    REQUIRE(mz_zip_reader_init_file(&zip, archive.c_str(), 0));
    size_t size {0};
    char* data {static_cast<char*>(mz_zip_reader_extract_file_to_heap(&zip, name, &size, 0))};
    mz_zip_reader_end(&zip);
    REQUIRE(data != nullptr);
    std::string text(data, size);
    mz_free(data);
    text.erase(std::remove_if(text.begin(), text.end(), [](char c) { return c == '\n' || c == '\r'; }), text.end());
    return text;
}

std::string temporary(const char* pattern) {
    return (boost::filesystem::temp_directory_path() / boost::filesystem::unique_path(pattern)).string();
}
}

TEST_CASE("3MF: writing and reading again") {
    const std::string out {temporary("slic3r-test-%%%%%%.3mf")};
    for (const char* input : {"test_3mf/box.3mf", "test_3mf/chess.3mf", "test_3mf/gimblekeychain.3mf"}) {
        Slic3r::Model model, again;
        REQUIRE(Slic3r::IO::TMF::read(testfile(input), &model));
        REQUIRE(Slic3r::IO::TMF::write(model, out));
        REQUIRE(Slic3r::IO::TMF::read(out, &again));
        REQUIRE(again.metadata.size() == model.metadata.size());
        REQUIRE(again.objects.size() == model.objects.size());
    }
    Slic3r::Model stl;
    REQUIRE(Slic3r::IO::STL::read(testfile("../golden/table.stl"), &stl));
    REQUIRE(stl.metadata.empty());
    REQUIRE(stl.objects.front()->instances.empty());
    REQUIRE(stl.objects.front()->part_number == -1);
    REQUIRE(stl.materials.empty());
    REQUIRE(Slic3r::IO::TMF::write(stl, out));
    boost::nowide::remove(out.c_str());
}

TEST_CASE("3MF: the written archive") {
    const std::string out {temporary("slic3r-test-%%%%%%.3mf")};
    Slic3r::Model model;
    REQUIRE(Slic3r::IO::AMF::read(testfile("test_amf/FaceColors.amf.xml"), &model));
    REQUIRE(Slic3r::IO::TMF::write(model, out));
    const std::string xml {zipped(out, "3D/3dmodel.model")};
    REQUIRE(xml.find("<model unit=\"millimeter\" xml:lang=\"en-US\"") != std::string::npos);
    REQUIRE(xml.find("<vertex x=\"-1\" y=\"-0.999998\" z=\"0.999998\"/>") != std::string::npos);
    REQUIRE(xml.find("<triangle v1=\"4\" v2=\"3\" v3=\"5\"/>") != std::string::npos);
    REQUIRE(xml.find("<slic3r:volume ts=\"0\" te=\"11\" modifier=\"0\" >") != std::string::npos);
    REQUIRE(zipped(out, "[Content_Types].xml").find("ContentType=\"application/vnd.ms-package.3dmanufacturing-3dmodel+xml\"") != std::string::npos);
    REQUIRE(zipped(out, "_rels/.rels").find("Target=\"/3D/3dmodel.model\"") != std::string::npos);
    boost::nowide::remove(out.c_str());
}
