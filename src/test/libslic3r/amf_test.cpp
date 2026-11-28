// From test_amf.cpp.
#include <gtest/gtest.h>

#include <cmath>
#include <sstream>
#include <string>
#include <vector>

#include "Model.hpp"
#include "IO.hpp"

using namespace Slic3r;
using namespace std::literals::string_literals;

/// the files the tests read (data of the test target)
const std::string testfile_dir {"src/test/inputs/"};
std::string testfile(const std::string& name) { return testfile_dir + name; }

// Reading deflated AMF files; Compressed AMF file of a 20mm cube; file is read
TEST(Amf, CompressedAMFFileOfA20mmCubeFileIsRead) {
    {  // given: Compressed AMF file of a 20mm cube
        auto model {new Slic3r::Model()};
        {  // when: file is read
            bool result_code = Slic3r::IO::AMF::read(testfile("test_amf/20mmbox_deflated.amf"), model);;
            {  // then: Does not return false.
                EXPECT_EQ(result_code, true);
            }
            {  // then: Model object contains a single ModelObject.
                ASSERT_EQ(model->objects.size(), 1u);
            }
        }
        delete model;
    }
}

// Reading deflated AMF files; Compressed AMF file of a 20mm cube; single file is read with some subdirectories
TEST(Amf, SingleFileIsReadWithSomeSubdirectories) {
    {  // given: Compressed AMF file of a 20mm cube
        auto model {new Slic3r::Model()};
        {  // when: single file is read with some subdirectories
            bool result_code = Slic3r::IO::AMF::read(testfile("test_amf/20mmbox_deflated-in_directories.amf"), model);;
            {  // then: Read returns false.
                EXPECT_EQ(result_code, true);
            }
            {  // then: Model object contains no ModelObjects.
                ASSERT_EQ(model->objects.size(), 1u);
            }
        }
        delete model;
    }
}

// Reading deflated AMF files; Compressed AMF file of a 20mm cube; file is read with multiple files in the archive
TEST(Amf, FileIsReadWithMultipleFilesInTheArchive) {
    {  // given: Compressed AMF file of a 20mm cube
        auto model {new Slic3r::Model()};
        {  // when: file is read with multiple files in the archive
            bool result_code = Slic3r::IO::AMF::read(testfile("test_amf/20mmbox_deflated-mult_files.amf"), model);;
            {  // then: Read returns true.
                EXPECT_EQ(result_code, true);
            }
            {  // then: Model object contains one ModelObject.
                ASSERT_EQ(model->objects.size(), 1u);
            }
        }
        delete model;
    }
}

// Reading deflated AMF files; Uncompressed AMF file of a 20mm cube; file is read
TEST(Amf, UncompressedAMFFileOfA20mmCubeFileIsRead) {
    {  // given: Uncompressed AMF file of a 20mm cube
        auto model {new Slic3r::Model()};
        {  // when: file is read
            bool result_code = Slic3r::IO::AMF::read(testfile("test_amf/20mmbox.amf"), model);;
            {  // then: Does not return false.
                EXPECT_EQ(result_code, true);
            }
            {  // then: Model object contains a single ModelObject.
                ASSERT_EQ(model->objects.size(), 1u);
            }
        }
        delete model;
    }
}

// Reading deflated AMF files; Uncompressed AMF file of a 20mm cube; nonexistant file is read
TEST(Amf, NonexistantFileIsRead) {
    {  // given: Uncompressed AMF file of a 20mm cube
        auto model {new Slic3r::Model()};
        {  // when: nonexistant file is read
            bool result_code = Slic3r::IO::AMF::read(testfile("test_amf/20mmbox-doesnotexist.amf"), model);;
            {  // then: Read returns false.
                EXPECT_EQ(result_code, false);
            }
            {  // then: Model object contains no ModelObject.
                ASSERT_EQ(model->objects.size(), 0u);
            }
        }
        delete model;
    }
}

// Reading AMF file; badly formed AMF file (missing vertices); AMF model is read
TEST(Amf, BadlyFormedAMFFileMissingAMFModelIsRead) {
    {  // given: badly formed AMF file (missing vertices)
        auto model {new Slic3r::Model()};
        {  // when: AMF model is read
            auto ret = Slic3r::IO::AMF::read(testfile("test_amf/5061-malicious.amf"),model);
            {  // then: read should return True
                EXPECT_TRUE(ret);
            }
        }
    }
}

// Reading AMF file; Ok formed AMF file; AMF model is read
TEST(Amf, OkFormedAMFFileAMFModelIsRead) {
    {  // given: Ok formed AMF file
        auto model {new Slic3r::Model()};
        {  // when: AMF model is read
            auto ret = Slic3r::IO::AMF::read(testfile("test_amf/read-amf.amf"),model);
            {  // then: read should return True
                EXPECT_TRUE(ret);
            }
        }
    }
}
