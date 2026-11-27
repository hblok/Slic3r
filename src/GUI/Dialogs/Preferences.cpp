// File > Preferences.
#include "Preferences.hpp"

#include <wx/spinctrl.h>

namespace Slic3r { namespace GUI {

bool show_preferences(wxWindow* parent, Settings& settings) {
    wxDialog dialog(parent, wxID_ANY, _("Preferences"));
    auto* grid {new wxFlexGridSizer(2, 8, 10)};
    auto row = [&dialog, grid](const wxString& label, wxWindow* field, const wxString& help) {
        auto* text {new wxStaticText(&dialog, wxID_ANY, label)};
        text->SetToolTip(help);
        field->SetToolTip(help);
        grid->Add(text, 0, wxALIGN_CENTER_VERTICAL);
        grid->Add(field, 0, wxALIGN_CENTER_VERTICAL);
    };
    auto check = [&dialog, &row](const wxString& label, bool value, const wxString& help) {
        auto* box {new wxCheckBox(&dialog, wxID_ANY, "")};
        box->SetValue(value);
        row(label, box, help);
        return box;
    };
    auto* remember {check(_("Remember output directory"), settings.remember_output_path,
        _("Offer the directory of the last G-code export instead of the input file's."))};
    auto* autocenter {check(_("Auto-center parts (x,y)"), settings.autocenter,
        _("Center the objects around the print bed center."))};
    auto* autoalignz {check(_("Auto-align parts (z=0)"), settings.autoalignz,
        _("Put loaded objects on the bed."))};
    auto* invert_zoom {check(_("Invert zoom in previews"), settings.invert_zoom,
        _("Invert the direction of mouse-wheel zoom."))};
    auto* background {check(_("Background processing"), settings.background_processing,
        _("Slice as soon as the plate or the settings change, to save time at export."))};
    auto* threads {new wxSpinCtrl(&dialog, wxID_ANY)};
    threads->SetRange(0, 256);
    threads->SetValue(settings.threads);
    row(_("Threads (0: as the print settings)"), threads, _("Number of threads used for slicing."));
    auto* nudge {new wxSpinCtrlDouble(&dialog, wxID_ANY)};
    nudge->SetRange(0.1, 100);
    nudge->SetIncrement(0.1);
    nudge->SetDigits(1);
    nudge->SetValue(settings.nudge);
    row(_("2D plater nudge (mm)"), nudge, _("How far the arrow keys move an object in the 2D plater."));

    auto* sizer {new wxBoxSizer(wxVERTICAL)};
    sizer->Add(grid, 0, wxALL, 15);
    sizer->Add(dialog.CreateStdDialogButtonSizer(wxOK | wxCANCEL), 0, wxEXPAND | wxLEFT | wxRIGHT | wxBOTTOM, 10);
    dialog.SetSizerAndFit(sizer);
    if (dialog.ShowModal() != wxID_OK) return false;

    settings.remember_output_path = remember->GetValue();
    settings.autocenter = autocenter->GetValue();
    settings.autoalignz = autoalignz->GetValue();
    settings.invert_zoom = invert_zoom->GetValue();
    settings.background_processing = background->GetValue();
    settings.threads = threads->GetValue();
    settings.nudge = nudge->GetValue();
    settings.save_settings();
    return true;
}

}} // namespace Slic3r::GUI
