#include <gtest/gtest.h>

#include <wx/wx.h>

#include <string>
#include <vector>

#include "OptionsGroup/OverridePanel.hpp"
#include "Settings.hpp"
#include "misc_ui.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

TEST(OverridePanel, ListsTheOptionsTheConfigurationHas) {
    ui_settings = Settings::init_settings();
    DynamicPrintConfig config;
    config.set_deserialize("retract_lift", "0.4");
    auto* panel {new OverridePanel(wxTheApp->GetTopWindow(), {"retract_length", "retract_lift"},
        [&config]() -> DynamicPrintConfig& { return config; }, [](const std::string&) {})};
    panel->update();
    EXPECT_EQ(panel->shown(), std::vector<std::string>{"retract_lift"});
    config.set_deserialize("retract_length", "2");
    panel->update();
    wxYield();  // the rows are rebuilt after the event
    EXPECT_EQ(panel->shown().size(), 2u);
    panel->Destroy();
}
