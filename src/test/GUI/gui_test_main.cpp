// main() of the GUI tests: Google Test inside a wxWidgets application that has no main
// loop of its own. A test makes its windows under wxTheApp's top window.
#include <gtest/gtest.h>

#include <wx/wx.h>

#include <iostream>

int main(int argc, char** argv) {
    testing::InitGoogleTest(&argc, argv);
    wxApp::SetInstance(new wxApp);
    if (!wxEntryStart(argc, argv)) {
        std::cerr << "wxWidgets did not start (is there a display?)" << std::endl;
        return 1;
    }
    // wx assertions fail the test they happen in, instead of opening a dialog
    wxSetAssertHandler([](const wxString& file, int line, const wxString& func, const wxString& cond,
            const wxString& msg) {
        ADD_FAILURE() << "wx assertion " << file << ":" << line << " " << func << ": " << cond << " " << msg;
    });
    wxImage::AddHandler(new wxPNGHandler);
    wxFrame* top {new wxFrame(nullptr, wxID_ANY, "test")};
    wxTheApp->SetTopWindow(top);
    top->Show();
    const int result {RUN_ALL_TESTS()};
    top->Destroy();
    wxTheApp->ProcessPendingEvents();
    wxEntryCleanup();
    return result;
}
