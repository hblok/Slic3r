#include <gtest/gtest.h>

#include <vector>

#include "Dialogs/BedShapeDialog.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

TEST(BedShapeDialog, KeepsTheShapeItWasGiven) {
    const std::vector<Pointf> shape {Pointf(0, 0), Pointf(220, 0), Pointf(220, 200), Pointf(0, 200)};
    BedShapeDialog dialog(wxTheApp->GetTopWindow(), shape);
    ASSERT_EQ(dialog.shape().size(), 4u);
    for (size_t i = 0; i < 4; ++i) {
        EXPECT_NEAR(dialog.shape()[i].x, shape[i].x, 1e-6) << i;
        EXPECT_NEAR(dialog.shape()[i].y, shape[i].y, 1e-6) << i;
    }
}

TEST(BedShapeDialog, DrawsABedWithAPosition) {
    auto* frame {new wxFrame(nullptr, wxID_ANY, "bed", wxDefaultPosition, wxSize(300, 300))};
    auto* bed {new Bed2D(frame)};
    bed->set_shape({Pointf(0, 0), Pointf(100, 0), Pointf(100, 100), Pointf(0, 100)});
    bed->set_position(Pointf(10, 10));
    frame->Show();
    wxYield();
    EXPECT_EQ(bed->shape().size(), 4u);
    bed->clear_position();
    frame->Destroy();
}
