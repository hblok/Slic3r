#include <gtest/gtest.h>

#include <fstream>
#include <iterator>
#include <string>

#include "Settings.hpp"

using namespace Slic3r::GUI;

namespace {
std::string content(const std::string& path) {
    std::ifstream in(path);
    return std::string(std::istreambuf_iterator<char>(in), std::istreambuf_iterator<char>());
}
} // namespace

TEST(Settings, ReadsBackWhatItSaved) {
    const std::string file {testing::TempDir() + "slic3r.ini"};
    Settings saved;
    saved.ini_file = file;
    saved.autocenter = false;
    saved.background_processing = true;
    saved.nudge = 2.5;
    saved.threads = 3;
    saved.rotation_controls = "xyz";
    saved.default_presets[get_preset(preset_t::Material)] = {"PLA", "ABS"};
    saved.save_settings();

    Settings loaded;
    loaded.ini_file = file;
    loaded.load_settings();
    EXPECT_FALSE(loaded.autocenter);
    EXPECT_TRUE(loaded.background_processing);
    EXPECT_FLOAT_EQ(loaded.nudge, 2.5);
    EXPECT_EQ(loaded.threads, 3u);
    EXPECT_EQ(loaded.rotation_controls, "xyz");
    EXPECT_EQ(loaded.default_presets[get_preset(preset_t::Material)], (std::vector<wxString>{"PLA", "ABS"}));
}

TEST(Settings, KeepsWhatItDoesNotUse) {
    const std::string file {testing::TempDir() + "perl.ini"};
    std::ofstream(file) << "mode = expert\n\n[recent]\nsomething = else\n";
    Settings settings;
    settings.ini_file = file;
    settings.load_settings();
    settings.save_settings();
    const std::string saved {content(file)};
    EXPECT_NE(saved.find("mode = expert"), std::string::npos) << saved;
    EXPECT_NE(saved.find("something = else"), std::string::npos) << saved;
}

TEST(Settings, RestoresAWindowsSize) {
    Settings settings;
    settings.ini_file = testing::TempDir() + "windows.ini";
    auto* window {new wxFrame(nullptr, wxID_ANY, "sized", wxPoint(10, 20), wxSize(400, 300))};
    settings.save_window_pos(window, "sized");
    window->SetSize(wxSize(200, 100));
    settings.restore_window_pos(window, "sized");
    EXPECT_EQ(window->GetSize(), wxSize(400, 300));
    window->Destroy();
}
