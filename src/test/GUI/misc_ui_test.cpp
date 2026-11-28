// From test_misc_ui.cpp, and the menu helpers.
#include <gtest/gtest.h>

#include <string>

#include "misc_ui.hpp"

using namespace Slic3r::GUI;

TEST(MiscUi, TrimsZeroesAndLeavesANumberThatParses) {
    EXPECT_EQ(trim_zeroes(std::string("0.0")), "0.0");
    EXPECT_EQ(trim_zeroes(std::string("0.")), "0.0");
    EXPECT_EQ(trim_zeroes(std::string("19.200000000")), "19.2");
}

TEST(MiscUi, KeepsThePrecisionWhenTrimming) {
    for (const std::string number : {"19.200000002", "19.2000000020", "19.20000000200"})
        EXPECT_EQ(trim_zeroes(number), "19.200000002") << number;
}

TEST(MiscUi, AppendsAMenuEntryThatDoesSomething) {
    wxMenu menu;
    int chosen {0};
    wxMenuItem* item {append_menu_item(&menu, "Do it", "Does it", [&chosen](wxCommandEvent&) { ++chosen; })};
    ASSERT_EQ(menu.GetMenuItemCount(), 1u);
    EXPECT_EQ(item->GetItemLabelText(), "Do it");
    wxCommandEvent event(wxEVT_MENU, item->GetId());
    menu.ProcessEvent(event);
    EXPECT_EQ(chosen, 1);
}
