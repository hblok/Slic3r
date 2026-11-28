#include <gtest/gtest.h>

#include "Config.hpp"
#include "Projector/Projector.hpp"
#include "Settings.hpp"
#include "gui_test_support.hpp"
#include "misc_ui.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

TEST(Projector, AsksForTheOptionsStartingFromThePresets) {
    ui_settings = Settings::init_settings();
    DynamicPrintConfig config {Config::new_from_defaults()->config()}, sla;
    config.set_deserialize("layer_height", "0.1");
    const auto ok {answer_next_dialog(wxID_OK)};
    ASSERT_TRUE(ask_sla_options(wxTheApp->GetTopWindow(), config, sla));
    EXPECT_EQ(sla.serialize("layer_height"), "0.1");
    EXPECT_NE(sla.serialize("perimeter_extrusion_width"), "0");  // "automatic" gets a width
}

TEST(Projector, CanBeCancelled) {
    ui_settings = Settings::init_settings();
    DynamicPrintConfig sla;
    const auto cancel {answer_next_dialog(wxID_CANCEL)};
    EXPECT_FALSE(ask_sla_options(wxTheApp->GetTopWindow(), Config::new_from_defaults()->config(), sla));
}
