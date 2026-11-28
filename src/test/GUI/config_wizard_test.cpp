#include <gtest/gtest.h>

#include "Dialogs/ConfigWizard.hpp"
#include "gui_test_support.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

TEST(ConfigWizard, FillsThreeConfigurationsWhenFinished) {
    DynamicPrintConfig current, print, printer, material;
    current.set_deserialize("nozzle_diameter", "0.4");
    current.set_deserialize("temperature", "210");
    const auto finish {answer_next_dialog(wxID_OK)};
    ASSERT_TRUE(show_config_wizard(wxTheApp->GetTopWindow(), current, print, printer, material));
    EXPECT_EQ(printer.serialize("nozzle_diameter"), "0.4");
    EXPECT_EQ(print.serialize("first_layer_height"), "0.4");  // from the nozzle
    EXPECT_NEAR(print.opt<ConfigOptionFloat>("layer_height")->value, 0.3, 1e-9);
    EXPECT_EQ(material.serialize("temperature"), "210");
    EXPECT_EQ(material.serialize("first_layer_temperature"), "215");
}

TEST(ConfigWizard, ChangesNothingWhenCancelled) {
    DynamicPrintConfig current, print, printer, material;
    const auto cancel {answer_next_dialog(wxID_CANCEL)};
    EXPECT_FALSE(show_config_wizard(wxTheApp->GetTopWindow(), current, print, printer, material));
    EXPECT_TRUE(print.empty());
    EXPECT_TRUE(material.empty());
}
