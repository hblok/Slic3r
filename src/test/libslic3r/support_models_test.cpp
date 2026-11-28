#include <gtest/gtest.h>

#include "Support/Models.hpp"

using namespace Slic3r;

TEST(SupportModels, TheNormalStyleHasNoModelOfItsOwn) {
    PrintObjectConfig config;
    EXPECT_EQ(config.support_material_style.value, smsNormal);
    EXPECT_EQ(Support::make_model(config, 0.45), nullptr);
}

TEST(SupportModels, TreeStyleMakesAModel) {
    PrintObjectConfig config;
    config.set_deserialize("support_material_style", "tree");
    EXPECT_NE(Support::make_model(config, 0.45), nullptr);
}

TEST(SupportModels, SettingsOutOfRangeStillGiveAModel) {
    PrintObjectConfig config;
    config.set_deserialize("support_material_style", "tree");
    config.set_deserialize("support_material_tree_angle", "89");
    config.set_deserialize("support_material_tree_branch_diameter", "0");
    config.set_deserialize("support_material_tree_tip_spacing", "0");
    const auto model {Support::make_model(config, 0.45)};
    ASSERT_NE(model, nullptr);
    std::vector<Support::Slab> slabs(5);
    for (auto &slab : slabs) slab.height = 0.3;
    slabs.back().roof = {Polygon({Point::new_scale(0, 0), Point::new_scale(5, 0), Point::new_scale(5, 5)})};
    EXPECT_FALSE(model->base(slabs).front().empty());
}
