#include <gtest/gtest.h>

#include <wx/wx.h>

#include <string>

#include "OptionsGroup/OptionControl.hpp"

using namespace Slic3r;
using namespace Slic3r::GUI;

namespace {
DynamicPrintConfig with(const std::string& key, const std::string& value) {
    DynamicPrintConfig config;
    config.set_deserialize(key, value);
    return config;
}
} // namespace

TEST(OptionControl, ShowsABooleanAsACheckBox) {
    DynamicPrintConfig config {with("spiral_vase", "1")};
    const OptionControl control {make_option_control(wxTheApp->GetTopWindow(), "spiral_vase",
        [&config]() -> DynamicPrintConfig& { return config; }, []() {})};
    control.refresh();
    auto* box {dynamic_cast<wxCheckBox*>(control.window)};
    ASSERT_NE(box, nullptr);
    EXPECT_TRUE(box->GetValue());
    control.window->Destroy();
}

TEST(OptionControl, PutsAChangeIntoTheConfiguration) {
    DynamicPrintConfig config {with("spiral_vase", "0")};
    int changes {0};
    const OptionControl control {make_option_control(wxTheApp->GetTopWindow(), "spiral_vase",
        [&config]() -> DynamicPrintConfig& { return config; }, [&changes]() { ++changes; })};
    control.refresh();
    auto* box {dynamic_cast<wxCheckBox*>(control.window)};
    ASSERT_NE(box, nullptr);
    box->SetValue(true);
    wxCommandEvent click(wxEVT_CHECKBOX, box->GetId());
    box->ProcessWindowEvent(click);
    EXPECT_EQ(config.serialize("spiral_vase"), "1");
    EXPECT_EQ(changes, 1);
    control.window->Destroy();
}

TEST(OptionControl, ReadsAndWritesOneExtrudersValue) {
    DynamicPrintConfig config {with("nozzle_diameter", "0.4,0.6")};
    EXPECT_EQ(option_text(config, "nozzle_diameter", 1), "0.6");
    EXPECT_TRUE(set_option_text(config, "nozzle_diameter", "0.8", 0));
    EXPECT_EQ(config.serialize("nozzle_diameter"), "0.8,0.6");
    EXPECT_FALSE(set_option_text(config, "nozzle_diameter", "wide", 0));
    EXPECT_EQ(config.serialize("nozzle_diameter"), "0.8,0.6");
}

TEST(OptionControl, GrowsAListWithItsLastValue) {
    DynamicPrintConfig config {with("nozzle_diameter", "0.4")};
    resize_option(config, "nozzle_diameter", 3);
    EXPECT_EQ(config.serialize("nozzle_diameter"), "0.4,0.4,0.4");
}

TEST(OptionControl, NamesAnOption) {
    EXPECT_FALSE(option_name("layer_height").IsEmpty());
}
