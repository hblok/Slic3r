#include <gtest/gtest.h>

#include <wx/wx.h>

#include "ProgressStatusBar.hpp"

using namespace Slic3r::GUI;

namespace {
struct Bar {
    wxFrame* frame {new wxFrame(nullptr, wxID_ANY, "status")};
    ProgressStatusBar* bar {new ProgressStatusBar(frame, wxID_ANY)};
    ~Bar() { frame->Destroy(); }
};
} // namespace

TEST(ProgressStatusBar, ShowsProgressUntilItIsComplete) {
    Bar status;
    EXPECT_FALSE(status.bar->prog->IsShown());
    status.bar->SetProgress(40);
    EXPECT_TRUE(status.bar->prog->IsShown());
    EXPECT_EQ(status.bar->GetProgress(), 40u);
    status.bar->SetProgress(100);
    EXPECT_FALSE(status.bar->prog->IsShown());
}

TEST(ProgressStatusBar, OffersCancelOnlyWithSomethingToCancel) {
    Bar status;
    EXPECT_FALSE(status.bar->cancelbutton->IsShown());
    int cancelled {0};
    status.bar->SetCancelCallback([&cancelled]() { ++cancelled; });
    EXPECT_TRUE(status.bar->cancelbutton->IsShown());
    wxCommandEvent click(wxEVT_BUTTON, status.bar->cancelbutton->GetId());
    status.bar->cancelbutton->ProcessWindowEvent(click);
    EXPECT_EQ(cancelled, 1);
    EXPECT_FALSE(status.bar->cancelbutton->IsShown());
}

TEST(ProgressStatusBar, IsBusyBetweenStartAndStop) {
    Bar status;
    status.bar->StartBusy();
    EXPECT_TRUE(status.bar->IsBusy());
    status.bar->StopBusy();
    EXPECT_FALSE(status.bar->IsBusy());
    EXPECT_FALSE(status.bar->prog->IsShown());
}
