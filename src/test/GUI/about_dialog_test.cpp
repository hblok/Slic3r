#include <gtest/gtest.h>

#include "Dialogs/AboutDialog.hpp"
#include "gui_test_support.hpp"

using namespace Slic3r::GUI;

TEST(AboutDialog, ShowsTheLogoAndCloses) {
    // a missing logo would raise a wx assertion or an error dialog
    AboutDialog dialog(wxTheApp->GetTopWindow());
    const auto answer {answer_next_dialog(wxID_OK)};
    EXPECT_EQ(dialog.ShowModal(), wxID_OK);
}
