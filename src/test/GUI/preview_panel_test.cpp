#include <gtest/gtest.h>

#include <vector>

#include "Plater/PreviewPanel.hpp"
#include "test_data.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

namespace {

/// A panel that only remembers what it is asked to show.
class Levels : public PreviewPanel {
public:
    explicit Levels(wxWindow* parent) : PreviewPanel(parent) { attach(new wxPanel(this)); }
    size_t loads {0}, shown {0};
    using PreviewPanel::level_count;
    using PreviewPanel::level_z;
    using PreviewPanel::visit_level;
protected:
    void load() override { ++loads; }
    void show_level(size_t level) override { shown = level; }
};

} // namespace

TEST(PreviewPanel, HasALevelForEachLayerAndStartsAtTheTop) {
    Model model;
    auto print {Slic3r::Test::init_print({Slic3r::Test::TestMesh::cube_20x20x20}, model)};
    print->process();
    auto* panel {new Levels(wxTheApp->GetTopWindow())};
    panel->set_print(print);
    ASSERT_EQ(panel->level_count(), print->objects.at(0)->layers.size());
    EXPECT_EQ(panel->shown, panel->level_count() - 1);
    EXPECT_NEAR(panel->level_z(panel->level_count() - 1), 20, 0.5);
    size_t perimeters {0};
    panel->visit_level(0, [&perimeters](PreviewRole role, const std::vector<const ExtrusionPath*>&, bool, const Point&, int) {
        if (role == PreviewRole::Perimeter) ++perimeters;
    });
    EXPECT_GT(perimeters, 0u);
    panel->set_print(nullptr);
    EXPECT_EQ(panel->level_count(), 0u);
    panel->Destroy();
}
