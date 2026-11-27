// Help > Configuration Wizard: the few settings a new printer needs.
// ponytail: one page; the Perl wizard has a page per question and a drawing of the bed
#include "Dialogs/ConfigWizard.hpp"

#include <algorithm>

#include <wx/spinctrl.h>

#include "OptionsGroup/OptionControl.hpp"
#include "BoundingBox.hpp"

namespace Slic3r { namespace GUI {

bool show_config_wizard(wxWindow* parent, const DynamicPrintConfig& current,
    DynamicPrintConfig& printer, DynamicPrintConfig& material)
{
    wxDialog dialog(parent, wxID_ANY, _("Configuration Wizard"));
    auto* grid {new wxFlexGridSizer(2, 6, 10)};
    auto row = [&dialog, grid](const wxString& label, wxWindow* field) {
        grid->Add(new wxStaticText(&dialog, wxID_ANY, label), 0, wxALIGN_CENTER_VERTICAL);
        grid->Add(field, 0, wxEXPAND);
    };
    auto number = [&dialog, &row](const wxString& label, double value, double low, double high, double step) {
        auto* spin {new wxSpinCtrlDouble(&dialog, wxID_ANY)};
        spin->SetRange(low, high);
        spin->SetIncrement(step);
        spin->SetDigits(step < 1 ? 2 : 0);
        spin->SetValue(value);
        row(label, spin);
        return spin;
    };

    DynamicPrintConfig chosen;
    chosen.apply(current);
    const OptionControl flavor {make_option_control(&dialog, "gcode_flavor",
        [&chosen]() -> DynamicPrintConfig& { return chosen; }, []() {})};
    flavor.refresh();
    row(_("Firmware (G-code flavor)"), flavor.window);

    const BoundingBoxf bed {current.opt<ConfigOptionPoints>("bed_shape")->values};
    auto* width {number(_("Bed width, X (mm)"), bed.size().x, 10, 2000, 1)};
    auto* depth {number(_("Bed depth, Y (mm)"), bed.size().y, 10, 2000, 1)};
    auto first = [&current](const char* key) { return std::atof(current.serialize(key).c_str()); };
    auto* nozzle {number(_("Nozzle diameter (mm)"), first("nozzle_diameter"), 0.05, 5, 0.05)};
    auto* filament {number(_("Filament diameter (mm)"), first("filament_diameter"), 0.5, 5, 0.05)};
    auto* temperature {number(_(L"Extrusion temperature (°C)"), first("temperature"), 0, 500, 5)};
    auto* bed_temperature {number(_(L"Bed temperature (°C, 0: no heated bed)"), first("bed_temperature"), 0, 200, 5)};

    auto* sizer {new wxBoxSizer(wxVERTICAL)};
    sizer->Add(grid, 0, wxALL, 15);
    sizer->Add(dialog.CreateStdDialogButtonSizer(wxOK | wxCANCEL), 0, wxEXPAND | wxLEFT | wxRIGHT | wxBOTTOM, 10);
    dialog.SetSizerAndFit(sizer);
    if (dialog.ShowModal() != wxID_OK) return false;

    auto set = [](DynamicPrintConfig& config, const char* key, const wxString& value) {
        config.set_deserialize(key, value.ToStdString());
    };
    auto decimal = [](double value) { return wxString::FromCDouble(value, 2); };
    set(printer, "gcode_flavor", wxString(chosen.serialize("gcode_flavor")));
    const wxString x {decimal(width->GetValue())}, y {decimal(depth->GetValue())};
    set(printer, "bed_shape", "0x0," + x + "x0," + x + "x" + y + ",0x" + y);
    set(printer, "has_heatbed", bed_temperature->GetValue() > 0 ? "1" : "0");
    set(printer, "nozzle_diameter", decimal(nozzle->GetValue()));
    set(material, "filament_diameter", decimal(filament->GetValue()));
    for (const char* key : {"temperature", "first_layer_temperature"})
        set(material, key, wxString::Format("%.0f", temperature->GetValue()));
    for (const char* key : {"bed_temperature", "first_layer_bed_temperature"})
        set(material, key, wxString::Format("%.0f", bed_temperature->GetValue()));
    return true;
}

}} // namespace Slic3r::GUI
