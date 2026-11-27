#include "OptionsGroup/OverridePanel.hpp"

#include <algorithm>
#include <map>

#include "misc_ui.hpp"

namespace Slic3r { namespace GUI {

OverridePanel::OverridePanel(wxWindow* parent, const std::vector<std::string>& keys,
        std::function<DynamicPrintConfig&()> config, std::function<void(const std::string&)> changed, int index) :
    wxPanel(parent, wxID_ANY), _config(config), _changed(changed), _index(index)
{
    for (const auto& key : keys)
        if (!key.empty() && print_config_def.has(key)) this->_keys.push_back(key);
    std::sort(this->_keys.begin(), this->_keys.end(), [](const std::string& a, const std::string& b) {
        return option_name(a).CmpNoCase(option_name(b)) < 0;
    });
    this->_rows = new wxBoxSizer(wxVERTICAL);
    this->SetSizer(this->_rows);
}

/// The element of a list option that a row edits; -1 for an option with one value.
int OverridePanel::_index_of(const std::string& opt_key) const {
    const ConfigOptionType type {print_config_def.get(opt_key).type};
    const bool list {type == coFloats || type == coInts || type == coBools || type == coPoints || type == coStrings};
    return list ? this->_index : -1;
}

void OverridePanel::update() {
    DynamicPrintConfig& config {this->_config()};
    std::vector<std::string> present;
    for (const auto& key : this->_keys)
        if (config.has(key)) present.push_back(key);
    if (!this->_built || present != this->_shown || this->fixed != this->_shown_fixed) {
        // not from within the event of a control that the rebuild destroys
        this->_shown = present;
        this->_shown_fixed = this->fixed;
        if (!this->_built) this->_build(present);
        else this->CallAfter([this]() { this->_build(this->_shown); });
        this->_built = true;
        return;
    }
    for (auto& control : this->_controls) control.refresh();
}

void OverridePanel::_build(const std::vector<std::string>& present) {
    this->_controls.clear();
    this->_rows->Clear(true);
    std::map<std::string, std::vector<std::string>> categories;
    for (const auto& key : present) categories[print_config_def.get(key).category].push_back(key);
    for (const auto& category : categories) {
        auto* box {new wxStaticBoxSizer(wxVERTICAL, this, wxString::FromUTF8(category.first.c_str()))};
        auto* parent {box->GetStaticBox()};
        auto* grid {new wxFlexGridSizer(3, 3, 5)};
        grid->AddGrowableCol(1, 1);
        for (const auto& key : category.second) {
            if (this->can_delete && this->fixed.count(key) == 0) {
                auto* remove {new wxBitmapButton(parent, wxID_ANY, wxBitmap(var("delete.png"), wxBITMAP_TYPE_PNG),
                    wxDefaultPosition, wxDefaultSize, wxBORDER_NONE)};
                remove->SetToolTip(_("Remove this setting"));
                remove->Bind(wxEVT_BUTTON, [this, key](wxCommandEvent&) {
                    this->_config().erase(key);
                    // not from the button's own event
                    this->CallAfter([this, key]() { this->_changed(key); this->update(); });
                });
                grid->Add(remove, 0, wxALIGN_CENTER_VERTICAL);
            } else {
                grid->AddSpacer(1);
            }
            auto* label {new wxStaticText(parent, wxID_ANY, option_name(key) + ":", wxDefaultPosition, wxSize(130, -1))};
            label->SetFont(ui_settings->small_font());
            label->Wrap(130);
            const OptionControl control {make_option_control(parent, key, this->_config,
                [this, key]() { this->_changed(key); }, this->_index_of(key), 90)};
            control.window->SetToolTip(wxString::FromUTF8(print_config_def.get(key).tooltip.c_str()));
            control.refresh();
            this->_controls.push_back(control);
            grid->Add(label, 0, wxALIGN_CENTER_VERTICAL);
            grid->Add(control.window, 0, wxALIGN_CENTER_VERTICAL);
        }
        box->Add(grid, 0, wxEXPAND | wxALL, 3);
        this->_rows->Add(box, 0, wxEXPAND);
    }
    if (this->can_add) {
        auto* add {new wxBitmapButton(this, wxID_ANY, wxBitmap(var("add.png"), wxBITMAP_TYPE_PNG),
            wxDefaultPosition, wxDefaultSize, wxBORDER_NONE)};
        add->SetToolTip(_("Override one more option"));
        add->Bind(wxEVT_BUTTON, [this, add](wxCommandEvent&) { this->_add_menu(add); });
        this->_rows->Add(add, 0, wxTOP, 3);
    }
    // the surrounding windows make room (and scroll)
    for (wxWindow* window = this; window != nullptr && !window->IsTopLevel(); window = window->GetParent()) {
        window->InvalidateBestSize();
        window->Layout();
        if (auto* scrolled = dynamic_cast<wxScrolledWindow*>(window)) scrolled->FitInside();
    }
}

void OverridePanel::_add_menu(wxWindow* at) {
    wxMenu menu;
    std::map<std::string, wxMenu*> submenus;
    std::vector<std::string> offered;
    for (const auto& key : this->_keys) {
        const std::string& category {print_config_def.get(key).category};
        if (category.empty() || this->_config().has(key)) continue;
        if (submenus.count(category) == 0) submenus[category] = new wxMenu();
        offered.push_back(key);
        submenus[category]->Append(wxID_HIGHEST + static_cast<int>(offered.size()), option_name(key),
            wxString::FromUTF8(print_config_def.get(key).tooltip.c_str()));
    }
    for (const auto& submenu : submenus) menu.AppendSubMenu(submenu.second, wxString::FromUTF8(submenu.first.c_str()));
    if (offered.empty()) return;
    const int chosen {at->GetPopupMenuSelectionFromUser(menu)};
    if (chosen <= wxID_HIGHEST || chosen > wxID_HIGHEST + static_cast<int>(offered.size())) return;
    const std::string key {offered[chosen - wxID_HIGHEST - 1]};
    // starting at the value it has now
    DynamicPrintConfig defaults;
    if (this->default_config != nullptr) defaults = this->default_config();
    if (!defaults.has(key))
        defaults.set_deserialize(key, print_config_def.get(key).default_value->serialize());
    const int index {this->_index_of(key)};
    if (index < 0) {
        this->_config().set_deserialize(key, defaults.serialize(key));
    } else {
        // one element: the list belongs to one extruder
        this->_config().set_deserialize(key, defaults.serialize(key));
        set_option_text(this->_config(), key, option_text(defaults, key, 0), 0);
        resize_option(this->_config(), key, 1);
    }
    this->CallAfter([this, key]() { this->_changed(key); this->update(); });
}

}} // namespace Slic3r::GUI
