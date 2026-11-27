#include "Dialogs/PresetEditor.hpp"
#include "misc_ui.hpp"
#include "GUI.hpp"
#include <wx/bookctrl.h>
#include <wx/textdlg.h>
#include <wx/msgdlg.h>
#include <wx/dir.h>
#include <algorithm>
#include <map>


namespace Slic3r { namespace GUI {

PresetEditor::PresetEditor(wxWindow* parent, t_config_option_keys options) : 
    wxPanel(parent, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxBK_LEFT | wxTAB_TRAVERSAL) {

    this->_sizer = new wxBoxSizer(wxHORIZONTAL);
    this->SetSizer(this->_sizer);

    wxSizer* left_sizer { new wxBoxSizer(wxVERTICAL) };

    {
        // choice menu
        this->_presets_choice = new wxChoice(this, wxID_ANY, wxDefaultPosition, wxSize(left_col_width, -1));
        this->_presets_choice->SetFont(ui_settings->small_font());


        // buttons
        this->_btn_save_preset = new wxBitmapButton(this, wxID_ANY, wxBitmap(var("disk.png"), wxBITMAP_TYPE_PNG), wxDefaultPosition, wxDefaultSize, wxBORDER_NONE);
        this->_btn_delete_preset = new wxBitmapButton(this, wxID_ANY, wxBitmap(var("delete.png"), wxBITMAP_TYPE_PNG), wxDefaultPosition, wxDefaultSize, wxBORDER_NONE);

        // the tooltips use title(), a virtual: set in build_pages(), not here in the base
        // constructor ("pure virtual method called")
        this->_btn_delete_preset->Disable();

        wxBoxSizer* hsizer {new wxBoxSizer(wxHORIZONTAL)};
        left_sizer->Add(hsizer, 0, wxEXPAND | wxBOTTOM, 5);
        hsizer->Add(this->_presets_choice, 1, wxRIGHT | wxALIGN_CENTER_VERTICAL, 3);
        hsizer->Add(this->_btn_save_preset, 0, wxALIGN_CENTER_VERTICAL);
        hsizer->Add(this->_btn_delete_preset, 0, wxALIGN_CENTER_VERTICAL);

    }

    // tree
    this->_treectrl = new wxTreeCtrl(this, wxID_ANY, wxDefaultPosition, wxSize(left_col_width, -1), wxTR_NO_BUTTONS | wxTR_HIDE_ROOT | wxTR_SINGLE | wxTR_NO_LINES | wxBORDER_SUNKEN | wxWANTS_CHARS);

    left_sizer->Add(this->_treectrl, 1, wxEXPAND);
    this->_icons = new wxImageList(16, 16, 1);
    this->_treectrl->AssignImageList(this->_icons);
    this->_iconcount = -1;

    this->_treectrl->AddRoot("root");
    this->_treectrl->SetIndent(0);
    this->disable_tree_sel_changed_event = false;

    this->_sizer->Add(left_sizer, 0, wxEXPAND | wxALL, 5);
    
    this->_treectrl->Bind(wxEVT_TREE_SEL_CHANGED, [this](wxTreeEvent& e) {
        for (size_t i = 0; i < this->_page_items.size(); ++i)
            if (this->_page_items[i] == e.GetItem()) this->_show_page(i);
    });
    this->_presets_choice->Bind(wxEVT_CHOICE, [this](wxCommandEvent&) { this->_on_select_preset(); });
    this->_btn_save_preset->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->save_preset(); });
    this->_btn_delete_preset->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->delete_preset(); });
}

static t_config_option_keys known_keys(const t_config_option_keys& keys) {
    t_config_option_keys out;
    for (const auto& key : keys)
        if (!key.empty() && print_config_def.has(key)) out.push_back(key);
    return out;
}

void PresetEditor::build_pages() {
    this->set_tooltips();
    std::vector<std::string> categories;
    std::map<std::string, t_config_option_keys> by_category;
    for (const auto& key : known_keys(this->my_options())) {
        const auto& def = print_config_def.get(key);
        const std::string category = def.category.empty() ? "Other" : def.category;
        if (by_category.count(category) == 0) categories.push_back(category);
        by_category[category].push_back(key);
    }
    const auto root = this->_treectrl->GetRootItem();
    for (const auto& category : categories) {
        PresetPage* page {this->add_options_page(wxString::FromUTF8(category))};
        auto* grid {new wxFlexGridSizer(3, 6, 8)};
        grid->AddGrowableCol(1, 1);
        for (const auto& key : by_category[category]) this->_add_row(page, grid, key);
        page->sizer()->Add(grid, 0, wxEXPAND | wxALL, 10);
        page->FitInside();
        this->_page_items.push_back(this->_treectrl->AppendItem(root, wxString::FromUTF8(category)));
    }
    if (!this->_page_items.empty()) this->_show_page(0);
}

void PresetEditor::_show_page(size_t idx) {
    for (size_t i = 0; i < this->_pages.size(); ++i) this->_pages[i]->Show(i == idx);
    this->Layout();
}

void PresetEditor::_add_row(PresetPage* page, wxFlexGridSizer* grid, const std::string& opt_key) {
    const ConfigOptionDef& def {print_config_def.get(opt_key)};
    const wxString tooltip {wxString::FromUTF8(def.tooltip + (def.cli.empty() ? "" : "\n(--" + def.cli.substr(0, def.cli.find_first_of("|=!")) + ")"))};
    // full_label is the stand-alone name ("Top solid layers" rather than "Top")
    const std::string& name {!def.full_label.empty() ? def.full_label : !def.label.empty() ? def.label : opt_key};
    auto* label {new wxStaticText(page, wxID_ANY, wxString::FromUTF8(name) + ":")};
    label->SetToolTip(tooltip);
    wxWindow* control {nullptr};
    
    if (def.type == coBool) {
        auto* check {new wxCheckBox(page, wxID_ANY, "")};
        check->Bind(wxEVT_CHECKBOX, [this, opt_key, check](wxCommandEvent&) {
            this->config->set(opt_key, check->GetValue());
            this->_changed(opt_key);
        });
        this->_refreshers.push_back([this, opt_key, check]() { check->SetValue(this->config->getBool(opt_key)); });
        control = check;
    } else if (def.type == coEnum) {
        const std::vector<std::string> values {def.enum_values};
        wxArrayString labels;
        for (size_t i = 0; i < values.size(); ++i)
            labels.Add(wxString::FromUTF8(i < def.enum_labels.size() ? def.enum_labels[i] : values[i]));
        auto* choice {new wxChoice(page, wxID_ANY, wxDefaultPosition, wxDefaultSize, labels)};
        choice->Bind(wxEVT_CHOICE, [this, opt_key, choice, values](wxCommandEvent&) {
            const int sel {choice->GetSelection()};
            if (sel < 0) return;
            this->config->set(opt_key, values[sel]);
            this->_changed(opt_key);
        });
        this->_refreshers.push_back([this, opt_key, choice, values]() {
            const auto it = std::find(values.begin(), values.end(), this->config->config().serialize(opt_key));
            choice->SetSelection(it == values.end() ? wxNOT_FOUND : int(it - values.begin()));
        });
        control = choice;
    } else {
        // text: raw for (multi-line) strings and lists of strings, else the option's own
        // text form, which is also parsed back (invalid input is refused)
        const bool multiline {def.multiline};
        auto* text {new wxTextCtrl(page, wxID_ANY, "", wxDefaultPosition,
            wxSize(multiline ? 400 : 150, multiline ? std::max(def.height, 60) : -1),
            multiline ? wxTE_MULTILINE : wxTE_PROCESS_ENTER)};
        auto get = [this, opt_key, type = def.type]() -> wxString {
            if (type == coString)
                return wxString::FromUTF8(this->config->get<ConfigOptionString>(opt_key).value);
            if (type == coStrings) {
                wxString out;
                for (const auto& v : this->config->get<ConfigOptionStrings>(opt_key).values)
                    out << (out.empty() ? "" : "\n") << wxString::FromUTF8(v);
                return out;
            }
            return wxString::FromUTF8(this->config->config().serialize(opt_key));
        };
        auto commit = [this, opt_key, text, get, type = def.type]() {
            const wxString value {text->GetValue()};
            if (value == get()) return;
            try {
                if (type == coString) {
                    this->config->get<ConfigOptionString>(opt_key).value = value.ToUTF8().data();
                } else if (type == coStrings) {
                    auto& values = this->config->get<ConfigOptionStrings>(opt_key).values;
                    values.clear();
                    for (const auto& line : wxSplit(value, '\n', 0))
                        if (!line.IsEmpty()) values.push_back(line.ToUTF8().data());
                } else {
                    this->config->set(opt_key, std::string(value.ToUTF8().data()));
                }
            } catch (std::exception&) {
                wxBell();
                text->ChangeValue(get());  // refused: back to the stored value
                return;
            }
            this->_changed(opt_key);
        };
        text->Bind(wxEVT_KILL_FOCUS, [commit](wxFocusEvent& e) { commit(); e.Skip(); });
        if (!multiline) text->Bind(wxEVT_TEXT_ENTER, [commit](wxCommandEvent&) { commit(); });
        this->_refreshers.push_back([text, get]() { text->ChangeValue(get()); });
        control = text;
    }
    control->SetToolTip(tooltip);
    grid->Add(label, 0, wxALIGN_CENTER_VERTICAL | wxALIGN_RIGHT);
    grid->Add(control, 0, def.multiline ? wxEXPAND : 0);
    grid->Add(new wxStaticText(page, wxID_ANY, wxString::FromUTF8(def.sidetext)), 0, wxALIGN_CENTER_VERTICAL);
}

void PresetEditor::_changed(const std::string& opt_key) {
    if (this->_preset == nullptr) return;
    this->_preset->apply_dirty(this->config);
    // mark the preset as modified in the list (as the Perl GUI)
    const int sel {this->_presets_choice->GetSelection()};
    if (sel >= 0 && !this->_presets_choice->GetString(sel).EndsWith(_(" (modified)")))
        this->_presets_choice->SetString(sel, this->_preset->name + _(" (modified)"));
    if (this->on_value_change != nullptr) this->on_value_change(opt_key);
}

void PresetEditor::save_preset() {
    if (this->_preset == nullptr) return;
    wxTextEntryDialog dialog(this, _("Save ") + this->title() + _(" as:"), _("Save preset"),
        this->_preset->default_preset ? wxString("") : this->_preset->name);
    if (dialog.ShowModal() != wxID_OK) return;
    const wxString name {dialog.GetValue().Strip(wxString::both)};
    if (name.IsEmpty() || name.Contains("/") || name.Contains("\\") || name == "- default -") {
        show_error(this, _("Invalid preset name."));
        return;
    }
    // the editor's options (all of them, as the Perl GUI), with the preset's id
    for (const auto& key : known_keys(this->my_options()))
        if (key.size() > 12 && key.compare(key.size() - 12, 12, "_settings_id") == 0)
            this->config->set(key, std::string(name.ToUTF8().data()));
    const wxString dir {SLIC3RAPP->preset_ini.at(this->typeId())};
    if (!wxDirExists(dir)) wxMkdir(dir);
    this->config->config().save((dir + "/" + name + ".ini").ToStdString());
    
    SLIC3RAPP->load_presets();
    this->_preset = nullptr;
    this->load_presets();
    this->select_preset_by_name(name, true);
    if (this->on_save_preset != nullptr) this->on_save_preset(name, this->type());
}

void PresetEditor::delete_preset() {
    if (this->_preset == nullptr || this->_preset->default_preset) return;
    const wxString name {this->_preset->name};
    if (wxMessageBox(_("Delete the preset ") + name + "?", _("Delete preset"), wxYES_NO | wxICON_QUESTION, this) != wxYES)
        return;
    wxRemoveFile(SLIC3RAPP->preset_ini.at(this->typeId()) + "/" + name + ".ini");
    SLIC3RAPP->load_presets();
    this->_preset = nullptr;
    this->load_presets();
    if (this->on_save_preset != nullptr) this->on_save_preset(this->_preset != nullptr ? this->_preset->name : wxString(), this->type());
}

/// TODO: Can this get deleted before the callback executes?
void PresetEditor::_on_value_change(std::string opt_key) {
    SLIC3RAPP->CallAfter(
    [this, opt_key]() {
        this->current_preset->apply_dirty(this->config);
        if (this->on_value_change != nullptr) this->on_value_change(opt_key);
        this->load_presets();
        this->_update(opt_key);
    } ); 
}

void PresetEditor::_on_select_preset(bool force) {
    auto& presets = SLIC3RAPP->presets.at(this->typeId());
    const int id {this->_presets_choice->GetSelection()};
    if (id < 0 || size_t(id) >= presets.size()) return;
    this->_preset = &presets[id];
    this->_preset_name = this->_preset->name;
    // the editor's options with the preset's values (unsaved changes included)
    this->config = Slic3r::Config::new_from_defaults(known_keys(this->my_options()));
    this->config->apply(this->_preset->dirty_config());
    for (auto& refresh : this->_refreshers) refresh();
    this->_btn_delete_preset->Enable(!this->_preset->default_preset);
    this->_on_preset_loaded();
    if (this->on_select_preset != nullptr) this->on_select_preset(this->_preset->name, this->type());
}
void PresetEditor::select_preset(int id, bool force) {
    this->_presets_choice->SetSelection(id);
    this->_on_select_preset(force);
}

void PresetEditor::select_preset_by_name(const wxString& name, bool force) {
    const auto presets {SLIC3RAPP->presets.at(this->typeId())};
    int id = -1;
    auto result = std::find(presets.cbegin(), presets.cend(), name);
    if (result != presets.cend()) id = std::distance(presets.cbegin(), result);
    if (id == -1) {
        Slic3r::Log::warn(this->LogChannel(), LOG_WSTRING("No preset named" + name)); 
        return;
    }
    this->_presets_choice->SetSelection(id);
    this->_on_select_preset(force);
}

PresetPage* PresetEditor::add_options_page(const wxString& _title, const wxString& _icon) {
    
    if (_icon.size() > 0) {
        auto bitmap { wxBitmap(var(_icon), wxBITMAP_TYPE_PNG) };
        this->_icons->Add(bitmap);
        this->_iconcount += 1;
    }

    PresetPage* page {new PresetPage(this, _title, this->_iconcount)};
    page->Hide();
    this->_sizer->Add(page, 1, wxEXPAND | wxLEFT, 5); 
    _pages.push_back(page);
    return page;
}

// TODO
void PresetEditor::reload_config() {
}

// TODO
void PresetEditor::reload_preset() {
}

// TODO
void PresetEditor::_update_tree() {
}

void PresetEditor::load_presets() {
    // the list from the app; keeps the selection by name, else the plater's choice
    wxString current {this->_preset_name};
    if (current.IsEmpty() && !ui_settings->default_presets.at(this->typeId()).empty())
        current = ui_settings->default_presets.at(this->typeId()).front();
    const auto& presets = SLIC3RAPP->presets.at(this->typeId());
    this->_presets_choice->Clear();
    int select {0};
    for (size_t i = 0; i < presets.size(); ++i) {
        this->_presets_choice->Append(presets[i].name);
        if (presets[i].name == current) select = int(i);
    }
    if (presets.empty()) return;
    this->_presets_choice->SetSelection(select);
    const auto callback = this->on_select_preset;  // loading is not a user's selection
    this->on_select_preset = nullptr;
    this->_on_select_preset(true);
    this->on_select_preset = callback;
}

}} // namespace Slic3r::GUI
