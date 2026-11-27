// File > Preferences.
#include "Preferences.hpp"

#include <algorithm>
#include <vector>

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

    auto choice = [&dialog, &row](const wxString& label, const std::vector<wxString>& labels, int selected,
            const wxString& help) {
        auto* box {new wxChoice(&dialog, wxID_ANY)};
        for (const auto& text : labels) box->Append(text);
        box->SetSelection(selected);
        row(label, box, help);
        return box;
    };
    auto* hide_reload {check(_("Hide dialog on reload"), settings.hide_reload_dialog,
        _("Do not ask when reloading a file with added parts and modifiers: do what is chosen below."))};
    auto* preserve {check(_("Keep transformations on reload"), settings.reload_preserve_trafo,
        _("\"Reload from disk\" applies the object's transformations to the reloaded one."))};
    auto* behavior {choice(_("Default reload behavior"),
        {_("Reload all"), _("Reload main, copy added"), _("Reload main, discard added")},
        static_cast<int>(settings.reload),
        _("What \"Reload from disk\" does with additional parts and modifiers."))};
    auto* tabbed {check(_("Display profile editors as tabs"), settings.preset_editor_tabs,
        _("Open a settings editor as a tab, else in a window. (Restart required.)"))};
    auto* host {check(_("Show Controller tab"), settings.show_host,
        _("The tab that controls a printer over a serial port. (Restart required.)"))};
    const std::vector<std::string> rotations {"z", "xyz", "xyz-big"};
    auto* rotation {choice(_("Rotation controls in toolbar"), {_("Z only"), _("X,Y,Z"), _("X,Y,Z (big buttons)")},
        std::max<int>(0, std::find(rotations.begin(), rotations.end(), settings.rotation_controls) - rotations.begin()) % 3,
        _("Which rotation buttons the toolbar has. (Restart required.)"))};
    auto* scheme {choice(_("Color scheme"), {_("Default"), _("Solarized")},
        settings.colorscheme == "getSolarized" ? 1 : 0, _("Colors of the plater. (Restart required.)"))};

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
    settings.hide_reload_dialog = hide_reload->GetValue();
    settings.reload_preserve_trafo = preserve->GetValue();
    settings.reload = static_cast<ReloadBehavior>(behavior->GetSelection());
    const std::string chosen_rotation {rotations.at(rotation->GetSelection())};
    const std::string chosen_scheme {scheme->GetSelection() == 1 ? "getSolarized" : "getDefault"};
    const bool restart {tabbed->GetValue() != settings.preset_editor_tabs || host->GetValue() != settings.show_host
        || chosen_rotation != settings.rotation_controls || chosen_scheme != settings.colorscheme};
    settings.preset_editor_tabs = tabbed->GetValue();
    settings.show_host = host->GetValue();
    settings.rotation_controls = chosen_rotation;
    settings.colorscheme = chosen_scheme;
    settings.save_settings();
    if (restart)
        wxMessageBox(_("You need to restart Slic3r to make the changes effective."), _("Preferences"),
            wxOK | wxICON_INFORMATION, parent);
    return true;
}

}} // namespace Slic3r::GUI
