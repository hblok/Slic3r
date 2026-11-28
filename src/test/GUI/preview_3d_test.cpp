#include <gtest/gtest.h>

#include "Plater/Preview3D.hpp"
#include "Settings.hpp"
#include "misc_ui.hpp"
#include "test_data.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

TEST(Preview3D, DrawsASlicedPrint) {
    ui_settings = Settings::init_settings();
    Model model;
    auto print {Slic3r::Test::init_print({Slic3r::Test::TestMesh::cube_20x20x20}, model)};
    print->process();
    auto* frame {new wxFrame(nullptr, wxID_ANY, "preview", wxDefaultPosition, wxSize(400, 300))};
    auto* preview {new Preview3D(frame)};
    frame->Show();
    preview->set_print(print);
    for (int i = 0; i < 5; ++i) wxYield();
    // wx assertions would fail the test
    preview->reload();
    wxYield();
    preview->set_print(nullptr);
    wxYield();
    frame->Destroy();
}
