#include <gtest/gtest.h>

#include <string>
#include <vector>

#include "Projector/Projector.hpp"
#include "Projector/ProjectorScreen.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

TEST(ProjectorScreen, KeepsItsSettingsInAFile) {
    const std::string file {testing::TempDir() + "DLP.ini"};
    ProjectorSettings saved;
    saved.show_bed = false;
    saved.zoom = 90;
    saved.bottom_layers = 5;
    saved.offset_x = 1.5;
    saved.offset_y = -2;
    saved.save(file);
    ProjectorSettings loaded;
    loaded.load(file);
    EXPECT_FALSE(loaded.show_bed);
    EXPECT_DOUBLE_EQ(loaded.zoom, 90);
    EXPECT_EQ(loaded.bottom_layers, 5);
    EXPECT_DOUBLE_EQ(loaded.offset_x, 1.5);
    EXPECT_DOUBLE_EQ(loaded.offset_y, -2);
}

TEST(ProjectorScreen, ShowsNoLayerUntilTold) {
    auto* screen {new ProjectorScreen()};
    ProjectorSettings settings;
    const std::vector<Pointf> bed {Pointf(0, 0), Pointf(100, 0), Pointf(100, 60), Pointf(0, 60)};
    screen->set_source(nullptr, bed, &settings);
    screen->Show();
    EXPECT_EQ(screen->layer(), -1);
    screen->project(3);
    wxYield();
    EXPECT_EQ(screen->layer(), 3);
    screen->Destroy();
}
