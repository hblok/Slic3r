#include <gtest/gtest.h>

#include "Dialogs/ObjectSettings.hpp"
#include "Settings.hpp"
#include "misc_ui.hpp"
#include "object_fixture.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

TEST(ObjectSettings, ShowsAnObjectWithoutChangingIt) {
    ui_settings = Settings::init_settings();
    ui_settings->ini_file = testing::TempDir() + "slic3r.ini";
    BoxObject box;
    int changes {0};
    {
        ObjectSettingsDialog dialog(wxTheApp->GetTopWindow(), box.object, DynamicPrintConfig(),
            [&changes]() { ++changes; });
        wxYield();
    }
    EXPECT_EQ(changes, 0);
    EXPECT_EQ(box.object->volumes.size(), 1u);
}
