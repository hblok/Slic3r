#include "Dialogs/PresetEditor.hpp"
#include "OptionsGroup/OverridePanel.hpp"

namespace Slic3r { namespace GUI {

MaterialEditor::MaterialEditor(wxWindow* parent, t_config_option_keys options) : 
    PresetEditor(parent, options) {
    
    this->config = Slic3r::Config::new_from_defaults(this->my_options());
    this->_build();
    this->update_tree();
    this->load_presets();
}

// The Perl GUI's pages (PresetEditor::Filament::build). A material preset holds the
// values of one extruder: element 0 of the lists.
void MaterialEditor::_build() {
    {
        auto* page {this->add_options_page(_("Filament"), "spool.png")};
        auto filament {this->add_group(page, _("Filament"))};
        for (const char* key : {"filament_colour", "filament_diameter", "extrusion_multiplier"})
            this->add_option(filament, key, 0);
        auto temperature {this->add_group(page, _(L"Temperature (°C)"))};
        this->add_line(temperature, _("Extruder"), {"first_layer_temperature", "temperature"}, 0);
        this->add_line(temperature, _("Bed"), {"first_layer_bed_temperature", "bed_temperature"});
        auto information {this->add_group(page, _("Optional information"))};
        for (const char* key : {"filament_density", "filament_cost"}) this->add_option(information, key, 0);
    }
    {
        auto* page {this->add_options_page(_("Cooling"), "hourglass.png")};
        auto enable {this->add_group(page, _("Enable"))};
        this->add_option(enable, "fan_always_on");
        this->add_option(enable, "cooling");
        this->_cooling_description = new wxStaticText(enable.parent, wxID_ANY, "");
        enable.box->Add(this->_cooling_description, 0, wxEXPAND | wxALL, 5);
        auto fan {this->add_group(page, _("Fan settings"))};
        this->add_line(fan, _("Fan speed"), {"min_fan_speed", "max_fan_speed"});
        this->add_option(fan, "bridge_fan_speed");
        this->add_option(fan, "disable_fan_first_layers");
        auto thresholds {this->add_group(page, _("Cooling thresholds"), 250)};
        for (const char* key : {"fan_below_layer_time", "slowdown_below_layer_time", "min_print_speed"})
            this->add_option(thresholds, key);
    }
    {
        auto* page {this->add_options_page(_("Custom G-code"), "script.png")};
        auto start {this->add_group(page, _("Start G-code"), 0)};
        this->add_option(start, "start_filament_gcode", 0, 400, 150);
        auto end {this->add_group(page, _("End G-code"), 0)};
        this->add_option(end, "end_filament_gcode", 0, 400, 150);
    }
    {
        auto* page {this->add_options_page(_("Notes"), "note.png")};
        auto notes {this->add_group(page, _("Notes"), 0)};
        this->add_option(notes, "filament_notes", 0, 400, 250);
    }
    {
        auto* page {this->add_options_page(_("Overrides"), "wrench.png")};
        auto preferences {this->add_group(page, _("Profile preferences"))};
        this->add_compatible_printers(preferences);
        auto overrides {this->add_group(page, _("Overrides"))};
        this->add_option(overrides, "filament_max_volumetric_speed", 0);
        this->_overrides = new OverridePanel(overrides.parent, MaterialEditor::overriding_options(),
            [this]() -> DynamicPrintConfig& { return this->config->config(); },
            [this](const std::string& key) { this->_changed(key); }, 0);
        this->_overrides->default_config = [this]() {
            return this->plater_config != nullptr ? this->plater_config() : DynamicPrintConfig();
        };
        overrides.box->Add(this->_overrides, 1, wxEXPAND | wxALL, 5);
    }
}

void MaterialEditor::_update() {
    this->reload_compatible_printers();
    this->_overrides->update();

    // what the cooling settings mean, in words
    DynamicPrintConfig& config {this->config->config()};
    auto number = [&config](const char* key) { return config.has(key) ? std::atoi(config.serialize(key).c_str()) : 0; };
    const int first {number("disable_fan_first_layers")};
    const wxString other_layers {number("fan_always_on")
        ? wxString::Format(_("will always run at %d%%%s."), number("min_fan_speed"),
            first > 1 ? wxString::Format(_(" except for the first %d layers"), first)
            : first == 1 ? wxString(_(" except for the first layer")) : wxString())
        : wxString(_("will be turned off."))};
    wxString message;
    if (number("cooling")) {
        const int below {number("slowdown_below_layer_time")};
        message = wxString::Format(_("If estimated layer time is below ~%ds, fan will run at %d%% and print speed will be reduced so that no less than %ds are spent on that layer (however, speed will never be reduced below %dmm/s)."),
            below, number("max_fan_speed"), below, number("min_print_speed"));
        if (number("fan_below_layer_time") > below)
            message << wxString::Format(_("\nIf estimated layer time is greater, but still below ~%ds, fan will run at a proportionally decreasing speed between %d%% and %d%%."),
                number("fan_below_layer_time"), number("max_fan_speed"), number("min_fan_speed"));
        message << _("\nDuring the other layers, fan ") << other_layers;
    } else {
        message = _("Fan ") + other_layers;
    }
    this->_cooling_description->SetLabel(message);
    this->_cooling_description->Wrap(400);
    this->_cooling_description->GetParent()->GetParent()->Layout();
}
}} // namespace Slic3r::GUI
