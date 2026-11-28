// From test_test_data.cpp.
#include <gtest/gtest.h>

#include <cmath>
#include <sstream>
#include <string>
#include <vector>

#include "test_data.hpp"

using namespace Slic3r::Test;

// init_print functionality; A default config; init_print is called with a single mesh.
TEST(PrintTestData, InitPrintIsCalledWithASingleMesh) {
    {  // given: A default config
        config_ptr config {Slic3r::Config::new_from_defaults()};
        std::stringstream gcode;
        {  // when: init_print is called with a single mesh.
            Slic3r::Model model;
            auto print = init_print({TestMesh::cube_20x20x20}, model, config, true);
            gcode.clear();
            {  // then: One mesh/printobject is in the resulting Print object.
                ASSERT_EQ(print->objects.size(), 1u);
            }
            {  // then: print->process() doesn't crash.
                EXPECT_NO_THROW(print->process());
            }
            {  // then: Export gcode functions outputs text.
                print->process();
                print->export_gcode(gcode, true);
                EXPECT_GT(gcode.str().size(), 0u);
            }
        }
    }
}
