#include <gtest/gtest.h>

#include <stdexcept>
#include <type_traits>

#include "Exception.hpp"

using namespace Slic3r;

// callers rely on which failures count as critical
static_assert(std::is_base_of<CriticalException, FileIOError>::value, "I/O errors are critical");
static_assert(!std::is_base_of<CriticalException, SlicingError>::value, "slicing errors are not");

TEST(Exception, CarriesItsMessage) {
    EXPECT_STREQ(FileIOError("disk full").what(), "disk full");
}

TEST(Exception, IsCaughtAsAnyOfItsBases) {
    EXPECT_THROW(throw FileIOError("x"), IOError);
    EXPECT_THROW(throw OutOfRange("x"), LogicError);
    EXPECT_THROW(throw PlaceholderParserError("x"), RuntimeError);
    EXPECT_THROW(throw SlicingError("x"), Exception);
    EXPECT_THROW(throw HostNetworkError("x"), std::runtime_error);
}
