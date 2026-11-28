#include <gtest/gtest.h>

#include <memory>
#include <vector>

#include "Config.hpp"
#include "Plater/Plate2D.hpp"
#include "Settings.hpp"
#include "misc_ui.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

TEST(Plate2D, DrawsAnEmptyBed) {
    ui_settings = Settings::init_settings();
    std::vector<PlaterObject> objects;
    auto model {std::make_shared<Model>()};
    std::shared_ptr<Config> config {Config::new_from_defaults()};
    auto* frame {new wxFrame(nullptr, wxID_ANY, "plate", wxDefaultPosition, wxSize(400, 400))};
    auto* plate {new Plate2D(frame, wxSize(400, 400), objects, model, config)};
    frame->Show();
    plate->update_bed_size();
    for (int i = 0; i < 5; ++i) wxYield();
    // wx assertions would fail the test
    frame->Destroy();
}
