#include "Dialogs/PresetEditor.hpp"
#include "misc_ui.hpp"
#include "OptionsGroup/OptionControl.hpp"
#include "GUI.hpp"
#include <wx/bookctrl.h>
#include <wx/textdlg.h>
#include <wx/msgdlg.h>
#include <wx/dir.h>
#include <wx/choicdlg.h>
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

        // the tooltips use title(), a virtual: set in load_presets(), not here in the base
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

    this->_sizer->Add(left_sizer, 0, wxEXPAND | wxALL, 5);
    
    this->_treectrl->Bind(wxEVT_TREE_SEL_CHANGED, [this](wxTreeEvent& e) {
        if (this->_updating_tree) return;
        for (size_t i = 0; i < this->_page_items.size(); ++i)
            if (this->_page_items[i] == e.GetItem()) this->_show_page(this->_pages[i]);
    });
    this->_presets_choice->Bind(wxEVT_CHOICE, [this](wxCommandEvent&) {
        const auto& presets {SLIC3RAPP->presets.at(this->typeId())};
        const int id {this->_presets_choice->GetSelection()};
        if (id < 0 || size_t(id) >= presets.size()) return;
        const wxString chosen {presets[id].name}, leaving {this->_preset_name};
        if (chosen != leaving && this->confirm_leave != nullptr) {
            // the question may read the lists again: names, not positions
            if (!this->confirm_leave(leaving)) {
                this->select_preset_by_name(leaving, true);
                return;
            }
            this->select_preset_by_name(chosen, true);
            return;
        }
        this->_on_select_preset();
    });
    this->_btn_save_preset->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->save_preset(); });
    this->_btn_delete_preset->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->delete_preset(); });
}

static t_config_option_keys known_keys(const t_config_option_keys& keys) {
    t_config_option_keys out;
    for (const auto& key : keys)
        if (!key.empty() && print_config_def.has(key)) out.push_back(key);
    return out;
}

OptionRows PresetEditor::add_group(PresetPage* page, const wxString& title, int label_width) {
    auto* box {new wxStaticBoxSizer(wxVERTICAL, page, title)};
    auto* grid {new wxFlexGridSizer(label_width > 0 ? 2 : 1, 4, 8)};
    grid->AddGrowableCol(label_width > 0 ? 1 : 0, 1);
    box->Add(grid, 0, wxEXPAND | wxALL, 5);
    page->sizer()->Add(box, 0, wxEXPAND | wxALL, 8);
    return {page, box->GetStaticBox(), box, grid, label_width};
}

static wxString option_tooltip(const std::string& opt_key) {
    const ConfigOptionDef& def {print_config_def.get(opt_key)};
    wxString tip {wxString::FromUTF8(def.tooltip.c_str())};
    if (def.default_value != nullptr && !def.multiline)
        tip << _(" (default: ") << wxString::FromUTF8(def.default_value->serialize().c_str()) << ")";
    if (!def.cli.empty()) tip << "\n(--" << wxString::FromUTF8(def.cli.substr(0, def.cli.find_first_of("|=!")).c_str()) << ")";
    return tip;
}

static wxStaticText* row_label(OptionRows& rows, const wxString& text, const wxString& tooltip = "") {
    if (rows.label_width <= 0) return nullptr;
    auto* label {new wxStaticText(rows.parent, wxID_ANY, text.IsEmpty() ? text : text + ":",
        wxDefaultPosition, wxSize(rows.label_width, -1))};
    label->Wrap(rows.label_width);
    if (!tooltip.IsEmpty()) label->SetToolTip(tooltip);
    rows.grid->Add(label, 0, wxALIGN_CENTER_VERTICAL);
    return label;
}

static wxString control_id(const std::string& opt_key, int index) {
    return index < 0 ? wxString(opt_key) : wxString::Format("%s#%d", opt_key, index);
}

wxWindow* PresetEditor::add_control(OptionRows& rows, const std::string& opt_key, int index, int width, int height) {
    const OptionControl option {make_option_control(rows.parent, opt_key,
        [this]() -> DynamicPrintConfig& { return this->config->config(); },
        [this, opt_key]() { this->_changed(opt_key); }, index, width, height)};
    option.window->SetToolTip(option_tooltip(opt_key));
    this->_controls[control_id(opt_key, index).ToStdString()] = {option, rows.page};
    return option.window;
}

void PresetEditor::add_option(OptionRows& rows, const std::string& opt_key, int index, int width, int height) {
    if (!print_config_def.has(opt_key)) return;
    const ConfigOptionDef& def {print_config_def.get(opt_key)};
    row_label(rows, wxString::FromUTF8(def.label.c_str()), option_tooltip(opt_key));
    wxWindow* control {this->add_control(rows, opt_key, index, width, height)};
    const bool wide {rows.label_width <= 0 || def.full_width || def.multiline};
    if (def.sidetext.empty()) {
        rows.grid->Add(control, 0, (wide ? wxEXPAND : 0) | wxALIGN_CENTER_VERTICAL);
        return;
    }
    auto* line {new wxBoxSizer(wxHORIZONTAL)};
    line->Add(control, wide ? 1 : 0, wxALIGN_CENTER_VERTICAL);
    line->Add(new wxStaticText(rows.parent, wxID_ANY, wxString::FromUTF8(def.sidetext.c_str())), 0,
        wxALIGN_CENTER_VERTICAL | wxLEFT, 4);
    rows.grid->Add(line, 0, wide ? wxEXPAND : 0);
}

void PresetEditor::add_line(OptionRows& rows, const wxString& label, std::initializer_list<const char*> opt_keys, int index) {
    row_label(rows, label);
    auto* line {new wxBoxSizer(wxHORIZONTAL)};
    for (const char* key : opt_keys) {
        const ConfigOptionDef& def {print_config_def.get(key)};
        if (!def.label.empty())
            line->Add(new wxStaticText(rows.parent, wxID_ANY, wxString::FromUTF8(def.label.c_str()) + ":"), 0,
                wxALIGN_CENTER_VERTICAL | wxRIGHT, 3);
        line->Add(this->add_control(rows, key, index, 80), 0, wxALIGN_CENTER_VERTICAL);
        if (!def.sidetext.empty())
            line->Add(new wxStaticText(rows.parent, wxID_ANY, wxString::FromUTF8(def.sidetext.c_str())), 0,
                wxALIGN_CENTER_VERTICAL | wxLEFT, 3);
        line->AddSpacer(12);
    }
    rows.grid->Add(line, 0, 0);
}

void PresetEditor::add_widget(OptionRows& rows, const wxString& label, wxSizer* widget) {
    row_label(rows, label);
    rows.grid->Add(widget, 0, wxEXPAND);
}

wxButton* PresetEditor::make_button(wxWindow* parent, const wxString& label, const wxString& icon, std::function<void()> action) {
    auto* button {new wxButton(parent, wxID_ANY, label, wxDefaultPosition, wxDefaultSize, wxBU_EXACTFIT)};
    button->SetFont(ui_settings->small_font());
    button->SetBitmap(wxBitmap(var(icon), wxBITMAP_TYPE_PNG));
    button->Bind(wxEVT_BUTTON, [action](wxCommandEvent&) { action(); });
    return button;
}

void PresetEditor::add_compatible_printers(OptionRows& rows) {
    this->_compatible_all = new wxCheckBox(rows.parent, wxID_ANY, _("All"));
    this->_compatible_set = this->make_button(rows.parent, _(L"Set…"), "printer_empty.png", [this]() {
        wxArrayString names;
        for (const auto& preset : SLIC3RAPP->presets.at(get_preset(preset_t::Printer)))
            if (!preset.default_preset && !preset.external) names.Add(preset.name);
        wxArrayInt selected;
        for (const auto& name : this->config->config().opt<ConfigOptionStrings>("compatible_printers", true)->values) {
            const int at {names.Index(wxString::FromUTF8(name.c_str()))};
            if (at != wxNOT_FOUND) selected.Add(at);
        }
        if (wxGetSelectedChoices(selected, _("Select the printers this profile is compatible with."),
                _("Compatible printers"), names, this) < 0) return;
        auto& values {this->config->config().opt<ConfigOptionStrings>("compatible_printers", true)->values};
        values.clear();
        for (const int at : selected) values.push_back(names[at].ToUTF8().data());
        this->_compatible_choosing = false;
        this->_changed("compatible_printers");
    });
    this->_compatible_all->Bind(wxEVT_CHECKBOX, [this](wxCommandEvent&) {
        this->_compatible_choosing = !this->_compatible_all->GetValue();
        this->_compatible_set->Enable(this->_compatible_choosing);
        if (this->_compatible_choosing) return;  // nothing changes until some are chosen
        this->config->config().opt<ConfigOptionStrings>("compatible_printers", true)->values.clear();
        this->_changed("compatible_printers");
    });
    auto* line {new wxBoxSizer(wxHORIZONTAL)};
    line->Add(this->_compatible_all, 0, wxALIGN_CENTER_VERTICAL | wxRIGHT, 8);
    line->Add(this->_compatible_set, 0, wxALIGN_CENTER_VERTICAL);
    this->add_widget(rows, _("Compatible printers"), line);
}

void PresetEditor::reload_compatible_printers() {
    if (this->_compatible_all == nullptr) return;
    const bool all {this->config->config().opt<ConfigOptionStrings>("compatible_printers", true)->values.empty()};
    // "All" unticked with nothing chosen yet stays unticked
    const bool ticked {all && !this->_compatible_choosing};
    this->_compatible_all->SetValue(ticked);
    this->_compatible_set->Enable(!ticked);
}

void PresetEditor::update_tree() {
    this->_updating_tree = true;
    const wxTreeItemId selected {this->_treectrl->GetSelection()};
    const wxString title {selected.IsOk() ? this->_treectrl->GetItemText(selected) : wxString()};
    this->_treectrl->DeleteChildren(this->_treectrl->GetRootItem());
    this->_page_items.clear();
    size_t show {0};
    for (size_t i = 0; i < this->_pages.size(); ++i) {
        this->_page_items.push_back(this->_treectrl->AppendItem(this->_treectrl->GetRootItem(),
            this->_pages[i]->get_title(), this->_pages[i]->icon()));
        if (this->_pages[i]->get_title() == title) show = i;
    }
    if (!this->_pages.empty()) {
        this->_treectrl->SelectItem(this->_page_items[show]);
        this->_show_page(this->_pages[show]);
    }
    this->_updating_tree = false;
}

void PresetEditor::_show_page(const PresetPage* page) {
    for (auto* other : this->_pages) other->Show(other == page);
    this->Layout();
    for (auto* other : this->_pages)
        if (other == page) other->FitInside();
}

void PresetEditor::remove_page(PresetPage* page) {
    for (auto it = this->_controls.begin(); it != this->_controls.end(); )
        it = it->second.page == page ? this->_controls.erase(it) : std::next(it);
    this->_pages.erase(std::remove(this->_pages.begin(), this->_pages.end(), page), this->_pages.end());
    page->Destroy();
}

void PresetEditor::refresh_all() {
    if (this->config == nullptr) return;
    for (auto& entry : this->_controls) entry.second.control.refresh();
    this->apply_rules();
    this->_update();
}

void PresetEditor::_changed(const std::string& opt_key) {
    if (this->_preset == nullptr) return;
    // a question may take the focus from a text field, whose commit then lands here again
    if (this->_resolving) return;
    this->_resolving = true;
    this->resolve_conflicts(opt_key);
    this->_resolving = false;
    this->refresh_all();
    this->_preset->apply_dirty(this->config);
    // an override that was removed here is removed from the unsaved state too
    for (const auto& key : this->my_overriding_options())
        if (!this->config->config().has(key)) this->_preset->erase_dirty(key);
    // mark the preset as modified in the list (as the Perl GUI)
    const int sel {this->_presets_choice->GetSelection()};
    if (sel >= 0) this->_presets_choice->SetString(sel, this->_preset->dropdown_name());
    if (this->on_value_change != nullptr) this->on_value_change(opt_key);
}

wxString ask_preset_name(wxWindow* parent, const wxString& question, const wxString& suggestion) {
    wxTextEntryDialog dialog(parent, question, _("Save preset"), suggestion);
    if (dialog.ShowModal() != wxID_OK) return "";
    const wxString name {dialog.GetValue().Strip(wxString::both)};
    if (name.IsEmpty() || name.Contains("/") || name.Contains("\\") || name == "- default -") {
        show_error(parent, _("Invalid preset name."));
        return "";
    }
    return name;
}

bool write_preset(wxWindow* parent, preset_t group, DynamicPrintConfig config, const wxString& name) {
    try {
        for (const auto& key : config.keys())
            if (key.size() > 12 && key.compare(key.size() - 12, 12, "_settings_id") == 0)
                config.set_deserialize(key, std::string(name.ToUTF8().data()));
        const wxString dir {SLIC3RAPP->preset_ini.at(get_preset(group))};
        if (!wxDirExists(dir)) wxMkdir(dir);
        config.save((dir + "/" + name + ".ini").ToUTF8().data());
        return true;
    } catch (std::exception& e) {
        show_error(parent, wxString::FromUTF8(e.what()));
        return false;
    }
}

void PresetEditor::save_preset() {
    if (this->_preset == nullptr) return;
    const wxString name {ask_preset_name(this, _("Save ") + this->title() + _(" as:"),
        this->_preset->default_preset ? wxString("") : this->_preset->name)};
    if (name.IsEmpty()) return;
    // the editor's options (all of them, as the Perl GUI), with the preset's id
    if (!write_preset(this, this->type(), this->config->config(), name)) return;
    // the changes are in the file now: neither the preset edited nor the one written
    // over keeps its own
    this->_preset->dismiss_changes();
    for (auto& preset : SLIC3RAPP->presets.at(this->typeId()))
        if (preset.name == name) preset.dismiss_changes();

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

void PresetEditor::_on_select_preset(bool force) {
    auto& presets = SLIC3RAPP->presets.at(this->typeId());
    const int id {this->_presets_choice->GetSelection()};
    if (id < 0 || size_t(id) >= presets.size()) return;
    this->_preset = &presets[id];
    this->_preset_name = this->_preset->name;
    // the editor's options with the preset's values (unsaved changes included)
    this->config = Slic3r::Config::new_from_defaults(known_keys(this->my_options()));
    this->config->apply(this->_preset->dirty_config());
    this->_btn_delete_preset->Enable(!this->_preset->default_preset && !this->_preset->external);
    this->_compatible_choosing = false;
    this->_on_preset_loaded();
    this->refresh_all();
    if (this->on_select_preset != nullptr) this->on_select_preset(this->_preset->name, this->type());
    // a preset can come with combinations that do not work: ask now, as the Perl GUI did
    this->_resolving = true;
    const bool adjusted {this->resolve_conflicts("")};
    this->_resolving = false;
    if (adjusted) this->_changed("");
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
    int icon {-1};
    if (_icon.size() > 0) {
        auto bitmap { wxBitmap(var(_icon), wxBITMAP_TYPE_PNG) };
        this->_icons->Add(bitmap);
        icon = ++this->_iconcount;
    }

    PresetPage* page {new PresetPage(this, _title, icon)};
    page->Hide();
    this->_sizer->Add(page, 1, wxEXPAND | wxLEFT, 5); 
    _pages.push_back(page);
    return page;
}

void PresetEditor::load_presets() {
    this->set_tooltips();
    // the list from the app; keeps the selection by name, else the plater's choice
    wxString current {this->_preset_name};
    if (current.IsEmpty() && !ui_settings->default_presets.at(this->typeId()).empty())
        current = ui_settings->default_presets.at(this->typeId()).front();
    const auto& presets = SLIC3RAPP->presets.at(this->typeId());
    this->_presets_choice->Clear();
    int select {0};
    for (size_t i = 0; i < presets.size(); ++i) {
        this->_presets_choice->Append(presets[i].dropdown_name());
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
