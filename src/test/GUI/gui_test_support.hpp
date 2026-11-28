/// What several GUI tests need.
#ifndef GUI_TEST_SUPPORT_HPP
#define GUI_TEST_SUPPORT_HPP

#include <wx/wx.h>

#include <memory>

/// Ends the first modal dialog that appears, with `code`, while the returned timer lives.
inline std::unique_ptr<wxTimer> answer_next_dialog(int code) {
    struct Answer : wxTimer {
        int code;
        explicit Answer(int c) : code(c) {}
        void Notify() override {
            for (wxWindow* window : wxTopLevelWindows) {
                auto* dialog = dynamic_cast<wxDialog*>(window);
                if (dialog != nullptr && dialog->IsModal()) {
                    Stop();
                    dialog->EndModal(code);
                    return;
                }
            }
        }
    };
    std::unique_ptr<wxTimer> timer {new Answer(code)};
    timer->Start(50);
    return timer;
}

#endif
