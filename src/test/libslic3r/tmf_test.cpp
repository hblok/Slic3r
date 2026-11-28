// From test_3mf.cpp.
#include <gtest/gtest.h>

#include <algorithm>
#include <cmath>
#include <sstream>
#include <string>
#include <vector>

#include "Model.hpp"
#include "TMF.hpp"
#include "IO.hpp"
#include "boost/filesystem.hpp"
#include "boost/nowide/cstdio.hpp"
#include "miniz/miniz.h"

using namespace Slic3r;

/// the files the tests read (data of the test target)
const std::string testfile_dir {"src/test/inputs/"};
std::string testfile(const std::string& name) { return testfile_dir + name; }

// ported from the Perl binding tests (xs/t/23_3mf.t)


namespace {
/// A file inside a zip archive, without line ends.
std::string zipped(const std::string &archive, const char* name) {
    mz_zip_archive zip;
    mz_zip_zero_struct(&zip);
    EXPECT_TRUE(mz_zip_reader_init_file(&zip, archive.c_str(), 0));
    size_t size {0};
    char* data {static_cast<char*>(mz_zip_reader_extract_file_to_heap(&zip, name, &size, 0))};
    mz_zip_reader_end(&zip);
    EXPECT_NE(data, nullptr);
    std::string text(data, size);
    mz_free(data);
    text.erase(std::remove_if(text.begin(), text.end(), [](char c) { return c == '\n' || c == '\r'; }), text.end());
    return text;
}

std::string temporary(const char* pattern) {
    return (boost::filesystem::temp_directory_path() / boost::filesystem::unique_path(pattern)).string();
}
}

// Reading 3mf file; umlauts in the path of the file; 3mf model is read
TEST(Tmf, 3mfModelIsRead) {
    {  // given: umlauts in the path of the file
        auto model {new Slic3r::Model()};
        {  // when: 3mf model is read
            auto ret = Slic3r::IO::TMF::read(testfile("test_3mf/Geräte/box.3mf"),model);
            {  // then: read should not return 0
                EXPECT_EQ(ret, 1);
            }
        }
    }
}

// 3MF: metadata, volumes and the instance's transformation are read
TEST(Tmf, 3MFMetadataVolumesAndTheInstanceSTransformationAreRead) {
    Slic3r::Model model;
    EXPECT_TRUE(Slic3r::IO::TMF::read(testfile("test_3mf/gimblekeychain.3mf"), &model));
    ASSERT_EQ(model.metadata.size(), 8u);
    ASSERT_EQ(model.objects.size(), 1u);
    const ModelObject &object {*model.objects.front()};
    ASSERT_EQ(object.instances.size(), 1u);
    EXPECT_EQ(object.part_number, -1);
    ASSERT_EQ(object.volumes.size(), 3u);
    EXPECT_EQ(object.facets_count(), 19884);
    const ModelInstance &instance {*object.instances.front()};
    EXPECT_NEAR(instance.offset.x, -76.4989, 1e-4);
    EXPECT_NEAR(instance.offset.y, -142.501, 1e-4);
    EXPECT_NEAR(instance.scaling_factor, 25.4, 1e-4);
    EXPECT_NEAR(instance.rotation, 0, 1e-4);
}

// 3MF: writing and reading again
TEST(Tmf, 3MFWritingAndReadingAgain) {
    const std::string out {temporary("slic3r-test-%%%%%%.3mf")};
    for (const char* input : {"test_3mf/box.3mf", "test_3mf/chess.3mf", "test_3mf/gimblekeychain.3mf"}) {
        Slic3r::Model model, again;
        EXPECT_TRUE(Slic3r::IO::TMF::read(testfile(input), &model));
        EXPECT_TRUE(Slic3r::IO::TMF::write(model, out));
        EXPECT_TRUE(Slic3r::IO::TMF::read(out, &again));
        ASSERT_EQ(again.metadata.size(), model.metadata.size());
        ASSERT_EQ(again.objects.size(), model.objects.size());
    }
    Slic3r::Model stl;
    EXPECT_TRUE(Slic3r::IO::STL::read(testfile("../golden/table.stl"), &stl));
    EXPECT_TRUE(stl.metadata.empty());
    EXPECT_TRUE(stl.objects.front()->instances.empty());
    EXPECT_EQ(stl.objects.front()->part_number, -1);
    EXPECT_TRUE(stl.materials.empty());
    EXPECT_TRUE(Slic3r::IO::TMF::write(stl, out));
    boost::nowide::remove(out.c_str());
}

// 3MF: the written archive
TEST(Tmf, 3MFTheWrittenArchive) {
    const std::string out {temporary("slic3r-test-%%%%%%.3mf")};
    Slic3r::Model model;
    EXPECT_TRUE(Slic3r::IO::AMF::read(testfile("test_amf/FaceColors.amf.xml"), &model));
    EXPECT_TRUE(Slic3r::IO::TMF::write(model, out));
    const std::string xml {zipped(out, "3D/3dmodel.model")};
    EXPECT_NE(xml.find("<model unit=\"millimeter\" xml:lang=\"en-US\""), std::string::npos);
    EXPECT_NE(xml.find("<vertex x=\"-1\" y=\"-0.999998\" z=\"0.999998\"/>"), std::string::npos);
    EXPECT_NE(xml.find("<triangle v1=\"4\" v2=\"3\" v3=\"5\"/>"), std::string::npos);
    EXPECT_NE(xml.find("<slic3r:volume ts=\"0\" te=\"11\" modifier=\"0\" >"), std::string::npos);
    EXPECT_NE(zipped(out, "[Content_Types].xml").find("ContentType=\"application/vnd.ms-package.3dmanufacturing-3dmodel+xml\""), std::string::npos);
    EXPECT_NE(zipped(out, "_rels/.rels").find("Target=\"/3D/3dmodel.model\""), std::string::npos);
    boost::nowide::remove(out.c_str());
}
