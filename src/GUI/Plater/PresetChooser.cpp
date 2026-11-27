#include "PresetChooser.hpp"
#include "Dialogs/PresetEditor.hpp"
#include "misc_ui.hpp"
#include "OptionsGroup/OptionControl.hpp"

namespace Slic3r { namespace GUI {

PresetChooser::PresetChooser(wxWindow* parent, std::weak_ptr<Print> print) : PresetChooser(parent, print, SLIC3RAPP->settings(), SLIC3RAPP->presets) {}

PresetChooser::PresetChooser(wxWindow* parent, std::weak_ptr<Print> print, Settings* external_settings, preset_store& external_presets) :
    wxPanel(parent, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL, ""),
    _local_sizer(new wxFlexGridSizer(3,1,2)), _parent(parent), _settings(external_settings), _print(print), _presets(external_presets)
{
    _local_sizer->AddGrowableCol(1, 1);
    _local_sizer->SetFlexibleDirection(wxHORIZONTAL);
    this->SetSizer(_local_sizer);

    this->_add_row(preset_t::Print, 0, _("Print settings:"));
    this->_add_row(preset_t::Material, 1, _("Material:"));
    this->_add_row(preset_t::Printer, 2, _("Printer:"));
}

wxBitmapComboBox* PresetChooser::_add_row(preset_t group, size_t at_row, const wxString& label) {
    auto* text {new wxStaticText(this, wxID_ANY, label, wxDefaultPosition, wxDefaultSize, wxALIGN_RIGHT)};
    text->SetFont(_settings->small_font());

    auto* choice {new wxBitmapComboBox(this, wxID_ANY, "", wxDefaultPosition, wxDefaultSize, 0, nullptr, wxCB_READONLY)};
    const size_t index {this->preset_choosers[get_preset(group)].size()};
    this->preset_choosers[get_preset(group)].push_back(choice);

    // Settings button
    auto* settings_btn {new wxBitmapButton(this, wxID_ANY, wxBitmap(var("cog.png"), wxBITMAP_TYPE_PNG), wxDefaultPosition, wxDefaultSize, wxBORDER_NONE)};

    const size_t at {at_row * 3};
    this->_local_sizer->Insert(at, text, 0, wxALIGN_RIGHT | wxALIGN_CENTER_VERTICAL | wxRIGHT, 4);
    this->_local_sizer->Insert(at + 1, choice, 1, wxEXPAND | wxBOTTOM, 0);
    this->_local_sizer->Insert(at + 2, settings_btn, 0, wxALIGN_CENTER_VERTICAL | wxEXPAND | wxLEFT, 3);
    settings_btn->Bind(wxEVT_BUTTON, [this, group, index](wxCommandEvent&) {
        if (this->on_settings != nullptr) this->on_settings(group, index);
    });

    // On a combobox event, puts a call to _on_change_combobox() on the evt_idle stack.
    choice->Bind(wxEVT_COMBOBOX,
        [this, group, choice](wxCommandEvent&) {
            wxTheApp->CallAfter([this, group, choice]() { this->_on_change_combobox(group, choice); });
        });
    return choice;
}

void PresetChooser::set_extruder_count(size_t count) {
    auto& choosers {this->preset_choosers[get_preset(preset_t::Material)]};
    count = std::max<size_t>(count, 1);
    if (count == choosers.size()) return;
    while (choosers.size() < count) this->_add_row(preset_t::Material, 1 + choosers.size(), "");
    while (choosers.size() > count) {
        const size_t at {choosers.size() * 3};  // the row after the print settings' one
        for (int i = 0; i < 3; ++i) {
            wxWindow* window {this->_local_sizer->GetItem(at)->GetWindow()};
            this->_local_sizer->Detach(at);
            window->Destroy();
        }
        choosers.pop_back();
    }
    this->InvalidateBestSize();
    if (this->GetParent() != nullptr) this->GetParent()->Layout();
}

wxString PresetChooser::selected(preset_t group, size_t index) const {
    const auto& choosers {this->preset_choosers[get_preset(group)]};
    if (index >= choosers.size() || choosers[index]->GetSelection() == wxNOT_FOUND) return "";
    return choosers[index]->GetString(choosers[index]->GetSelection());
}

void PresetChooser::load(std::array<Presets, preset_types> presets) {

    wxString selected_printer_name {""};
    for (const auto& group : { preset_t::Printer, preset_t::Material, preset_t::Print }) {
        auto current_list = presets.at(get_preset(group));
        // Filter out profiles not compatible with this printer
        if (group != preset_t::Printer) {
            current_list = grep(presets.at(get_preset(group)), [selected_printer_name] (const Preset& x) -> bool { return x.compatible(selected_printer_name); });
        }

        // show default names if no other presets visible.
        if (current_list.size() > 1) {
            current_list = grep(current_list, [] (const Preset& x) -> bool { return !x.default_preset; });
        }

        // Read the current defaults from the settings file
        const std::vector<wxString> settings_defaults {_settings->default_presets.at(get_preset(group))};

        size_t i {0};
        std::vector<std::string> preset_names {};
        __chooser_names[get_preset(group)].clear();
        // populate the chooser
        for (auto* chooser : this->preset_choosers[get_preset(group)]) {
            chooser->Clear();
            assert(chooser->GetCount() == 0);
            for (auto preset : current_list) {
                wxBitmap bitmap;
                switch (group) {
                    case preset_t::Print:
                        bitmap = wxBitmap(var("cog.png"), wxBITMAP_TYPE_PNG);
                        break;
                    case preset_t::Material: {
                        // a square of the filament's colour, else a spool
                        Preset copy {preset};
                        const Slic3r::Config config {copy.dirty_config()};
                        wxColour colour;
                        if (!preset.default_preset && config.has("filament_colour")
                                && colour.Set(wxString::FromUTF8(config.config().serialize("filament_colour").c_str()))) {
                            wxImage image(16, 16);
                            image.SetRGB(wxRect(0, 0, 16, 16), colour.Red(), colour.Green(), colour.Blue());
                            bitmap = wxBitmap(image);
                        } else {
                            bitmap = wxBitmap(var("spool.png"), wxBITMAP_TYPE_PNG);
                        }
                        break;
                    }
                    case preset_t::Printer: 
                        bitmap = wxBitmap(var("printer_empty.png"), wxBITMAP_TYPE_PNG);
                        break;
                    default: break;
                }
                chooser->Append(preset.name, bitmap);
                __chooser_names[get_preset(group)].push_back(preset.name);
            }
            assert(chooser->GetCount() == current_list.size());

            // Apply default options from settings
            bool updated_from_settings = false;
            if (settings_defaults.size() > i) { // only apply if there is a value from Settings
                updated_from_settings = this->select_preset_by_name(settings_defaults.at(i), chooser);
            }

            if (!updated_from_settings) // default
                chooser->SetSelection(0);

            wxString selected_preset { chooser->GetString(chooser->GetSelection()) };
            if (group == preset_t::Printer) {
                selected_printer_name = selected_preset;
            }

            ++i;
        }
        this->_update_preset_settings(group);
        if (group == preset_t::Printer) {
            // a material chooser for each of the printer's nozzles
            size_t extruders {1};
            for (auto& preset : presets.at(get_preset(group)))
                if (preset.name == selected_printer_name) {
                    Slic3r::Config config {preset.dirty_config()};
                    if (config.has("nozzle_diameter"))
                        extruders = config.get<ConfigOptionFloats>("nozzle_diameter").values.size();
                }
            this->set_extruder_count(extruders);
        }
    }
}

bool PresetChooser::select_preset_by_name(wxString name, preset_t group, size_t index = 0) {
    auto& ps_list = this->preset_choosers.at(get_preset(group));
    bool updated = false;
    if (ps_list.size() > index) {
        // only a change of selection counts: "found" alone made the editors and the
        // plater select each other until the stack ran out
        const int before {ps_list.at(index)->GetSelection()};
        updated = select_preset_by_name(name, ps_list.at(index))
            && ps_list.at(index)->GetSelection() != before;
    }
    if (updated)
        this->_on_select_preset(group, index);
    return updated;
}

bool PresetChooser::select_preset_by_name(wxString name, wxBitmapComboBox* chooser) {
    auto index { chooser->FindString(name) };
    if (index != wxNOT_FOUND) {
        chooser->SetSelection(index);
        return true;
    }
    return false;
}

void PresetChooser::_update_preset_settings(preset_t preset) {
    auto& settings_presets {_settings->default_presets.at(get_preset(preset))};
    auto selected {this->_get_selected_presets(preset)};
    // names for extruders the printer does not have now are kept for when it does again
    for (size_t i = selected.size(); i < settings_presets.size(); ++i) selected.push_back(settings_presets[i]);
    settings_presets = selected;

}

void PresetChooser::_on_select_preset(preset_t preset, size_t index) {
    // update settings store
    this->_update_preset_settings(preset);
    // save settings
    _settings->save_settings();
    if (preset == preset_t::Printer) {
        this->load(); // reload print/filament settings to honor compatible printers
    }
    if (this->on_preset_selected != nullptr)
        this->on_preset_selected(preset, this->selected(preset, index), index);
}

std::vector<wxString> PresetChooser::_get_selected_presets(preset_t group) const {
        const auto& choosers { this->preset_choosers[get_preset(group)] };
        std::vector<wxString> selected;
        selected.reserve(choosers.size());

        for (auto* chooser :  choosers) {
            selected.push_back(chooser->GetString(chooser->GetSelection()));
        }
        return selected;
}

Slic3r::Config PresetChooser::full_config() {
    // a value being typed in an editor counts
    commit_pending_edit();
    auto config {Slic3r::Config::new_from_defaults()};
    auto preset_config = [this](preset_t group, size_t index, DynamicPrintConfig& out) {
        const wxString name {this->selected(group, index)};
        for (auto& preset : this->_presets[get_preset(group)])
            if (preset.name == name) {
                out.apply(preset.dirty_config().config());
                return true;
            }
        return false;
    };
    DynamicPrintConfig printer, material, print;
    preset_config(preset_t::Printer, 0, printer);
    const t_config_option_keys overrides {MaterialEditor::overriding_options()};
    auto overrides_printer = [&overrides](const std::string& key) {
        return std::find(overrides.begin(), overrides.end(), key) != overrides.end();
    };
    const size_t extruders {this->preset_choosers[get_preset(preset_t::Material)].size()};
    for (size_t i = 0; i < extruders; ++i) {
        DynamicPrintConfig other;
        if (!preset_config(preset_t::Material, i, other)) continue;
        for (const auto& key : other.keys()) {
            if (overrides_printer(key)) {
                // this extruder's value of a printer setting
                if (printer.has(key)) set_option_text(printer, key, option_text(other, key, 0), static_cast<int>(i));
                continue;
            }
            if (i == 0) {
                material.apply_only(other, {key}, false, false);
            } else if (key != "compatible_printers" && material.has(key)
                    && dynamic_cast<ConfigOptionVectorBase*>(material.option(key)) != nullptr) {
                // element i of every list the first material has
                set_option_text(material, key, option_text(other, key, 0), static_cast<int>(i));
            }
        }
    }
    preset_config(preset_t::Print, 0, print);
    config->config().apply(printer);
    config->config().apply(material);
    config->config().apply(print);
    return *config;
}

wxString PresetChooser::_get_selected_preset(preset_t group, size_t index) const {
    return this->selected(group, index);
}
void PresetChooser::_on_change_combobox(preset_t preset, wxBitmapComboBox* choice) {
    const auto& choosers {this->preset_choosers[get_preset(preset)]};
    const auto found {std::find(choosers.begin(), choosers.end(), choice)};
    if (found == choosers.end()) return;
    const size_t index {static_cast<size_t>(found - choosers.begin())};
    const wxString chosen {this->selected(preset, index)};
    // the name chosen before: what the settings still hold
    const auto& before {this->_settings->default_presets.at(get_preset(preset))};
    if (index < before.size() && before[index] != chosen && this->confirm_leave != nullptr) {
        const wxString leaving {before[index]};
        if (!this->confirm_leave(preset, leaving)) {
            this->select_preset_by_name(leaving, choosers[index]);
            return;
        }
        this->select_preset_by_name(chosen, this->preset_choosers[get_preset(preset)][index]);
    }
    wxTheApp->CallAfter([this, preset, index]()
    {
        this->_on_select_preset(preset, index);
        // reload presets; removes the modified mark
        this->load();
    });
}


}} // Slic3r::GUI
