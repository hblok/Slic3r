#include <gtest/gtest.h>

#include <fstream>

#include "Dialogs/Preferences.hpp"
#include "Settings.hpp"
#include "gui_test_support.hpp"

using namespace Slic3r::GUI;

namespace {
bool exists(const std::string& path) { return std::ifstream(path).good(); }
} // namespace

TEST(Preferences, SavesTheSettingsOnOk) {
    Settings settings;
    settings.ini_file = testing::TempDir() + "ok.ini";
    settings.autocenter = false;
    const auto ok {answer_next_dialog(wxID_OK)};
    EXPECT_TRUE(show_preferences(wxTheApp->GetTopWindow(), settings));
    EXPECT_FALSE(settings.autocenter);  // shown, not changed
    EXPECT_TRUE(exists(testing::TempDir() + "ok.ini"));
}

TEST(Preferences, SavesNothingOnCancel) {
    Settings settings;
    settings.ini_file = testing::TempDir() + "cancel.ini";
    const auto cancel {answer_next_dialog(wxID_CANCEL)};
    EXPECT_FALSE(show_preferences(wxTheApp->GetTopWindow(), settings));
    EXPECT_FALSE(exists(testing::TempDir() + "cancel.ini"));
}
