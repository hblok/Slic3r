#include <gtest/gtest.h>

#include "Dialogs/ObjectFaceDialog.hpp"
#include "Settings.hpp"
#include "misc_ui.hpp"
#include "object_fixture.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

TEST(ObjectFaceDialog, TurnsAFaceDownByDefault) {
    ui_settings = Settings::init_settings();
    BoxObject box;
    ObjectFaceDialog dialog(wxTheApp->GetTopWindow(), *box.object);
    const Vectorf3 down {dialog.target()};
    EXPECT_EQ(down.x, 0);
    EXPECT_EQ(down.y, 0);
    EXPECT_EQ(down.z, -1);
}
