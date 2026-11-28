#include <gtest/gtest.h>

#include <memory>
#include <vector>

#include "Config.hpp"
#include "Plater/Plate3D.hpp"
#include "Settings.hpp"
#include "misc_ui.hpp"
#include "object_fixture.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

TEST(Plate3D, DrawsAnObjectOnTheBed) {
    ui_settings = Settings::init_settings();
    BoxObject box;
    std::vector<PlaterObject> objects(1);
    auto model {std::make_shared<Model>(box.model)};
    std::shared_ptr<Config> config {Config::new_from_defaults()};
    auto* frame {new wxFrame(nullptr, wxID_ANY, "plate", wxDefaultPosition, wxSize(400, 400))};
    auto* plate {new Plate3D(frame, wxSize(400, 400), objects, model, config)};
    frame->Show();
    plate->update();
    for (int i = 0; i < 5; ++i) wxYield();
    // wx assertions would fail the test
    frame->Destroy();
}
