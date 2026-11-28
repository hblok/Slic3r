#include <gtest/gtest.h>

#include <wx/wx.h>

#include <string>

#include "Config.hpp"
#include "Controller/ManualControlDialog.hpp"
#include "GCodeSender.hpp"
#include "Settings.hpp"
#include "misc_ui.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

TEST(ManualControlDialog, OpensForAPrinterThatIsNotConnected) {
    ui_settings = Settings::init_settings();
    GCodeSender sender;
    ManualSettings manual;
    int commands {0};
    {
        ManualControlDialog dialog(wxTheApp->GetTopWindow(), Config::new_from_defaults()->config(), sender, manual,
            [&commands](const wxString&) { ++commands; });
        wxYield();
    }
    EXPECT_EQ(commands, 0);  // nothing is sent by opening it
}
