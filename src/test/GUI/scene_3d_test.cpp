#include <gtest/gtest.h>

#include "Scene3D.hpp"
#include "misc_ui.hpp"

using namespace Slic3r::GUI;

TEST(Scene3D, DrawsAndTakesAViewWithoutComplaint) {
    ui_settings = Settings::init_settings();
    auto* frame {new wxFrame(nullptr, wxID_ANY, "scene", wxDefaultPosition, wxSize(300, 300))};
    auto* scene {new Scene3D(frame, wxSize(300, 300))};
    auto* other {new Scene3D(frame, wxSize(300, 300))};
    frame->Show();
    for (int i = 0; i < 5; ++i) wxYield();
    // wx assertions would fail the test
    scene->select_view(45, 45);
    scene->zoom_by(1.25);
    other->copy_view(*scene);
    scene->Refresh();
    scene->Update();
    wxYield();
    frame->Destroy();
}
