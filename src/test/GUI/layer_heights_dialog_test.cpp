#include <gtest/gtest.h>

#include <memory>

#include "Config.hpp"
#include "Dialogs/LayerHeightsDialog.hpp"
#include "Settings.hpp"
#include "misc_ui.hpp"
#include "object_fixture.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

TEST(LayerHeightsDialog, LeavesTheObjectAloneWhenNothingIsDrawn) {
    ui_settings = Settings::init_settings();
    BoxObject box;
    LayerHeightsDialog dialog(wxTheApp->GetTopWindow(), *box.object, Config::new_from_defaults()->config());
    dialog.apply(*box.object);
    EXPECT_TRUE(box.object->layer_height_ranges.empty());
    EXPECT_FALSE(box.object->layer_height_spline.layersUpdated());
    EXPECT_FALSE(box.object->config.has("adaptive_slicing_quality"));
}
