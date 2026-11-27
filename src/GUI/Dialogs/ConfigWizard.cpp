// Help > Configuration Wizard, also on the first start: the few settings a new printer
// needs (the Perl GUI's ConfigWizard.pm).
#include "Dialogs/ConfigWizard.hpp"

#include <vector>

#include <wx/wizard.h>

#include "Dialogs/BedShapeDialog.hpp"
#include "OptionsGroup/OptionControl.hpp"

namespace Slic3r { namespace GUI {

namespace {

constexpr int TEXT_WIDTH {430};

/// A page: title, the list of pages with this one marked, and the contents.
struct Page {
    wxWizardPageSimple* page;
    wxBoxSizer* contents;
    wxBoxSizer* index;

    Page(wxWizard* wizard, const wxString& title) :
        page(new wxWizardPageSimple(wizard)), contents(new wxBoxSizer(wxVERTICAL)), index(new wxBoxSizer(wxVERTICAL))
    {
        auto* heading {new wxStaticText(page, wxID_ANY, title)};
        wxFont font {heading->GetFont()};
        font.MakeBold();
        font.SetPointSize(14);
        heading->SetFont(font);
        auto* columns {new wxBoxSizer(wxHORIZONTAL)};
        columns->Add(index, 0, wxRIGHT, 20);
        columns->Add(contents, 1, wxEXPAND);
        auto* sizer {new wxBoxSizer(wxVERTICAL)};
        sizer->Add(heading, 0, wxBOTTOM, 10);
        sizer->Add(columns, 1, wxEXPAND);
        page->SetSizer(sizer);
    }
    void text(const wxString& paragraph) {
        auto* label {new wxStaticText(page, wxID_ANY, paragraph)};
        label->Wrap(TEXT_WIDTH);
        label->SetMinSize(wxSize(TEXT_WIDTH, -1));
        contents->Add(label, 0, wxTOP | wxBOTTOM, 6);
    }
    void option(DynamicPrintConfig& config, const std::string& key, int index_of = -1) {
        const OptionControl control {make_option_control(page, key,
            [&config]() -> DynamicPrintConfig& { return config; }, []() {}, index_of)};
        control.refresh();
        auto* row {new wxBoxSizer(wxHORIZONTAL)};
        row->Add(new wxStaticText(page, wxID_ANY, option_name(key) + ":"), 0, wxALIGN_CENTER_VERTICAL | wxRIGHT, 8);
        row->Add(control.window, 0, wxALIGN_CENTER_VERTICAL);
        row->Add(new wxStaticText(page, wxID_ANY, wxString::FromUTF8(print_config_def.get(key).sidetext.c_str())),
            0, wxALIGN_CENTER_VERTICAL | wxLEFT, 4);
        contents->Add(row, 0, wxTOP | wxBOTTOM, 10);
    }
};

} // namespace

bool show_config_wizard(wxWindow* parent, const DynamicPrintConfig& current,
    DynamicPrintConfig& print, DynamicPrintConfig& printer, DynamicPrintConfig& material)
{
    // what is asked, starting at the selected presets' values
    DynamicPrintConfig chosen;
    for (const char* key : {"gcode_flavor", "bed_shape", "nozzle_diameter", "filament_diameter", "temperature", "bed_temperature"}) {
        if (current.has(key)) chosen.set_deserialize(key, current.serialize(key));
        else chosen.set_deserialize(key, print_config_def.get(key).default_value->serialize());
    }
    for (const char* key : {"nozzle_diameter", "filament_diameter", "temperature"}) resize_option(chosen, key, 1);

    wxWizard wizard(parent, wxID_ANY, _("Configuration Assistant"));
    const wxString titles[] {_("Welcome"), _("Firmware Type"), _("Bed Size"), _("Nozzle Diameter"),
        _("Filament Diameter"), _("Extrusion Temperature"), _("Bed Temperature"), _("Finish")};
    std::vector<Page> pages;
    pages.emplace_back(&wizard, _("Welcome to the Slic3r Configuration Assistant"));
    pages.back().text(_("Hello, welcome to Slic3r! This assistant helps you with the initial configuration; just a few settings and you will be ready to print."));
    pages.back().text(_("To import an existing configuration instead, cancel this assistant and use the Load Config menu item found in the File menu."));
    pages.back().text(_("To continue, click Next."));
    pages.emplace_back(&wizard, titles[1]);
    pages.back().text(_("Choose the type of firmware used by your printer, then click Next."));
    pages.back().option(chosen, "gcode_flavor");
    pages.emplace_back(&wizard, titles[2]);
    pages.back().text(_("Set the shape of your printer's bed, then click Next."));
    auto* bed {new BedShapePanel(pages.back().page, chosen.opt<ConfigOptionPoints>("bed_shape")->values)};
    pages.back().contents->Add(bed);
    pages.emplace_back(&wizard, titles[3]);
    pages.back().text(_("Enter the diameter of your printer's hot end nozzle, then click Next."));
    pages.back().option(chosen, "nozzle_diameter", 0);
    pages.emplace_back(&wizard, titles[4]);
    pages.back().text(_("Enter the diameter of your filament, then click Next."));
    pages.back().text(_("Good precision is required, so use a caliper and do multiple measurements along the filament, then compute the average."));
    pages.back().option(chosen, "filament_diameter", 0);
    pages.emplace_back(&wizard, titles[5]);
    pages.back().text(_("Enter the temperature needed for extruding your filament, then click Next."));
    pages.back().text(_(L"A rule of thumb is 160 to 230 °C for PLA, and 215 to 250 °C for ABS."));
    pages.back().option(chosen, "temperature", 0);
    pages.emplace_back(&wizard, titles[6]);
    pages.back().text(_("Enter the bed temperature needed for getting your filament to stick to your heated bed, then click Next."));
    pages.back().text(_(L"A rule of thumb is 60 °C for PLA and 110 °C for ABS. Leave zero if you have no heated bed."));
    pages.back().option(chosen, "bed_temperature");
    pages.emplace_back(&wizard, _("Congratulations!"));
    pages.back().text(_("You have successfully completed the Slic3r Configuration Assistant. Slic3r is now configured for your printer and filament."));
    pages.back().text(_("To close this assistant and apply the newly created configuration, click Finish."));

    for (size_t i = 0; i < pages.size(); ++i) {
        for (size_t t = 0; t < pages.size(); ++t) {
            auto* entry {new wxStaticText(pages[i].page, wxID_ANY, (t == i ? wxString::FromUTF8("\xe2\x96\xb6 ") : wxString("    ")) + titles[t])};
            if (t > i) entry->SetForegroundColour(wxColour(128, 128, 128));
            pages[i].index->Add(entry, 0, wxBOTTOM, 4);
        }
        if (i > 0) wxWizardPageSimple::Chain(pages[i - 1].page, pages[i].page);
    }
    for (auto& page : pages) wizard.GetPageAreaSizer()->Add(page.page);

    if (!wizard.RunWizard(pages.front().page)) return false;
    commit_pending_edit();
    chosen.opt<ConfigOptionPoints>("bed_shape", true)->values = bed->shape();

    auto set = [](DynamicPrintConfig& config, const char* key, const std::string& value) {
        config.set_deserialize(key, value);
    };
    auto decimal = [](double value) { return std::string(wxString::FromCDouble(value).ToUTF8().data()); };
    const double nozzle {chosen.opt<ConfigOptionFloats>("nozzle_diameter")->values.front()};
    // the layers from the nozzle, as the Perl wizard
    set(print, "first_layer_height", decimal(nozzle));
    set(print, "layer_height", decimal(std::max(nozzle - 0.1, 0.05)));
    for (const char* key : {"gcode_flavor", "bed_shape", "nozzle_diameter"}) set(printer, key, chosen.serialize(key));
    const int temperature {std::atoi(chosen.serialize("temperature").c_str())};
    const int bed_temperature {std::atoi(chosen.serialize("bed_temperature").c_str())};
    set(printer, "has_heatbed", bed_temperature > 0 ? "1" : "0");
    set(material, "filament_diameter", chosen.serialize("filament_diameter"));
    set(material, "temperature", std::to_string(temperature));
    set(material, "first_layer_temperature", std::to_string(temperature + 5));
    set(material, "bed_temperature", std::to_string(bed_temperature));
    set(material, "first_layer_bed_temperature", std::to_string(bed_temperature > 0 ? bed_temperature + 5 : 0));
    return true;
}

}} // namespace Slic3r::GUI
