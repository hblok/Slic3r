#include <gtest/gtest.h>

#include <cstring>
#include <fstream>
#include <string>

#include "Exception.hpp"
#include "miniz_extension.hpp"

using namespace Slic3r;

namespace {
std::string in_temp(const char* name) { return testing::TempDir() + name; }
} // namespace

TEST(MinizExtension, WritesAZipFileAndReadsItBack) {
    const std::string path {in_temp("round_trip.zip")}, text {"layer by layer"};
    MZ_Archive written;
    ASSERT_TRUE(open_zip_writer(&written.arch, path)) << written.get_errorstr();
    EXPECT_TRUE(written.is_alive());
    ASSERT_TRUE(mz_zip_writer_add_mem(&written.arch, "note.txt", text.data(), text.size(), MZ_DEFAULT_COMPRESSION));
    ASSERT_TRUE(mz_zip_writer_finalize_archive(&written.arch));
    EXPECT_FALSE(written.is_alive());
    ASSERT_TRUE(close_zip_writer(&written.arch));

    MZ_Archive read;
    ASSERT_TRUE(open_zip_reader(&read.arch, path)) << read.get_errorstr();
    std::string back(text.size(), ' ');
    ASSERT_TRUE(mz_zip_reader_extract_file_to_mem(&read.arch, "note.txt", &back[0], back.size(), 0));
    EXPECT_EQ(back, text);
    EXPECT_TRUE(close_zip_reader(&read.arch));
}

TEST(MinizExtension, ReportsAFileThatIsNotThere) {
    MZ_Archive archive;
    EXPECT_FALSE(open_zip_reader(&archive.arch, in_temp("missing.zip")));
    EXPECT_EQ(archive.get_errorstr(), "file open failed!");
}

TEST(MinizExtension, ThrowsOnAFileThatIsNoZip) {
    const std::string path {in_temp("plain.zip")};
    std::ofstream(path) << "just text";
    MZ_Archive archive;
    EXPECT_THROW(open_zip_reader(&archive.arch, path), FileIOError);
}
