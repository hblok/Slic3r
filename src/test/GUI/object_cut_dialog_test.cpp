#include <gtest/gtest.h>

#include "Dialogs/ObjectCutDialog.hpp"
#include "Settings.hpp"
#include "misc_ui.hpp"
#include "object_fixture.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

TEST(ObjectCutDialog, StartsWithAHorizontalCutKeepingBothParts) {
    ui_settings = Settings::init_settings();
    BoxObject box;
    ObjectCutDialog dialog(wxTheApp->GetTopWindow(), box.object);
    const CutOptions options {dialog.options()};
    EXPECT_EQ(options.axis, Z);
    EXPECT_GT(options.height, 0);
    EXPECT_LT(options.height, 10);
    EXPECT_TRUE(options.keep_upper);
    EXPECT_TRUE(options.keep_lower);
    EXPECT_EQ(options.grid.x, 0);
}

TEST(ObjectCutDialog, MeasuresTheHeightFromTheObjectsLowestPoint) {
    CutOptions options;
    options.axis = X;
    options.height = 3;
    BoundingBoxf3 box;
    box.min = Pointf3(-10, -5, 0);
    EXPECT_DOUBLE_EQ(options.at(box), -7);
}
