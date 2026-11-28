// The File menu: configuration files and bundles, slicing a file without putting it on
// the plate, repairing an STL.
#include <algorithm>
#include <fstream>
#include <map>

#include <wx/filedlg.h>
#include <wx/filename.h>
#include <wx/msgdlg.h>
#include <wx/textfile.h>

#include "Plater.hpp"
#include "ProgressStatusBar.hpp"
#include "MainFrame.hpp"
#include "GUI.hpp"
#include "Dialogs/ConfigWizard.hpp"
#include "OptionsGroup/OptionControl.hpp"
#include "IO.hpp"
#include "BoundingBox.hpp"

namespace Slic3r { namespace GUI {

namespace {

const char* const GROUP_SECTIONS[] {"print", "filament", "printer"};

/// A file to read; empty when cancelled.
wxString ask_open(wxWindow* parent, const wxString& question, const std::string& wildcard, const wxString& directory = "") {
    wxFileDialog dialog(parent, question, directory.IsEmpty() ? ui_settings->skein_directory : directory, "", wildcard,
        wxFD_OPEN | wxFD_FILE_MUST_EXIST);
    return dialog.ShowModal() == wxID_OK ? dialog.GetPath() : wxString();
}

/// Remember where configuration files are.
void used_config_file(const wxString& file) {
    ui_settings->config_directory = wxFileName(file).GetPath();
    ui_settings->save_settings();
}

wxString ask_save(wxWindow* parent, const wxString& question, const wxFileName& suggestion, const std::string& wildcard) {
    wxFileDialog dialog(parent, question, suggestion.GetPath(), suggestion.GetFullName(), wildcard,
        wxFD_SAVE | wxFD_OVERWRITE_PROMPT);
    return dialog.ShowModal() == wxID_OK ? dialog.GetPath() : wxString();
}

} // namespace

void Plater::select_external_config(const wxString& file) {
    const wxFileName path(file);
    // named after the file, ".ini" kept, as in the Perl GUI; stays in the lists as long as
    // the program runs and the file exists
    const wxString name {path.GetFullName()};
    for (size_t group = 0; group < preset_types; ++group) {
        Presets& presets {SLIC3RAPP->presets.at(group)};
        Preset external(path.GetPath().ToStdString(), name.ToStdString(), static_cast<preset_t>(group));
        external.external = true;
        external.name = name;
        presets.erase(std::remove_if(presets.begin(), presets.end(),
            [&external](const Preset& p) { return p.name == external.name; }), presets.end());
        presets.push_back(external);
    }
    // the editors' lists first: selecting in the plater selects in them too
    for (auto& editor : GetFrame()->preset_editor_tabs) editor.second->reload_list();
    this->_presets->load();
    for (const auto group : {preset_t::Printer, preset_t::Material, preset_t::Print})
        this->_presets->select_preset_by_name(name, group, 0);
    this->refresh_config();
    this->invalidate_slices();
    this->update_shortcuts();
}

void Plater::config_wizard() {
    DynamicPrintConfig print, printer, material;
    const Slic3r::Config current {this->full_config()};
    if (!show_config_wizard(this, current.config(), print, printer, material)) return;
    const wxString name {"My Settings"};
    const std::pair<preset_t, const DynamicPrintConfig*> files[] {
        {preset_t::Print, &print}, {preset_t::Printer, &printer}, {preset_t::Material, &material}};
    auto path = [&name](preset_t group) {
        return wxFileName(SLIC3RAPP->preset_ini.at(get_preset(group)), name + ".ini").GetFullPath();
    };
    if (std::any_of(std::begin(files), std::end(files), [&path](const auto& file) { return wxFileExists(path(file.first)); })
            && wxMessageBox(wxString::Format(_("Replace the presets \"%s\"?"), name), _("Configuration Wizard"),
                wxYES_NO | wxICON_QUESTION, this) != wxYES) return;
    try {
        for (const auto& file : files) file.second->save(path(file.first).ToUTF8().data());
    } catch (std::exception& e) {
        show_error(this, wxString::FromUTF8(e.what()));
        return;
    }
    SLIC3RAPP->load_presets();
    for (auto& editor : GetFrame()->preset_editor_tabs) editor.second->reload_list();
    this->_presets->load();
    for (const auto& file : files) this->_presets->select_preset_by_name(name, file.first, 0);
    ui_settings->save_settings();  // also when the list had selected them by itself
    this->refresh_config();
    this->invalidate_slices();
    this->update_shortcuts();
}

bool Plater::ask_to_save(Preset& preset) {
    const wxString kinds[] {_("Print"), _("Material"), _("Printer")};  // preset_t order
    const size_t group {get_preset(preset.group)};
    wxString options;
    for (const auto& key : preset.dirty_options()) options << "\n- " << option_name(key);
    wxMessageDialog dialog(this, wxString::Format(
            _("%s preset \"%s\" has unsaved changes:\n%s\n\nDo you want to save them?"),
            kinds[group], preset.name, options),
        _("Unsaved Changes"), wxYES_NO | wxCANCEL | wxICON_QUESTION);
    dialog.SetYesNoCancelLabels(_("Save"), _("Discard"), _("Cancel"));
    const int answer {dialog.ShowModal()};
    if (answer == wxID_CANCEL) return false;
    if (answer == wxID_YES) {
        // the default preset and loaded config files are saved under a new name
        const bool rename {preset.default_preset || preset.external};
        const wxString name {!rename ? preset.name : ask_preset_name(this,
            wxString::Format(_("Save %s settings as:"), kinds[group]),
            preset.default_preset ? wxString() : preset.name)};
        if (name.IsEmpty() || !write_preset(this, preset.group, preset.config_to_save().config(), name)) return false;
        // selected: the new preset is the selected one from now on
        auto& selected {ui_settings->default_presets.at(group)};
        if (rename)
            for (auto& entry : selected)
                if (entry == preset.name) {
                    entry = name;
                    ui_settings->save_settings();
                }
    }
    preset.dismiss_changes();
    return true;
}

void Plater::reload_presets() {
    SLIC3RAPP->load_presets();
    this->_presets->load();
    for (auto& editor : GetFrame()->preset_editor_tabs) editor.second->reload_list();
    this->refresh_config();
    this->invalidate_slices();
    this->update_shortcuts();
}

bool Plater::confirm_leave(preset_t group, const wxString& name) {
    commit_pending_edit();
    for (auto& preset : SLIC3RAPP->presets.at(get_preset(group))) {
        if (preset.name != name) continue;
        if (!preset.dirty()) return true;
        if (!this->ask_to_save(preset)) return false;
        this->reload_presets();
        return true;
    }
    return true;
}

bool Plater::prompt_unsaved_changes() {
    commit_pending_edit();
    bool changed {false};
    for (size_t group = 0; group < preset_types; ++group) {
        for (auto& preset : SLIC3RAPP->presets.at(group)) {
            if (!preset.dirty()) continue;
            if (!this->ask_to_save(preset)) {
                if (changed) this->reload_presets();  // staying open: show what was done
                return false;
            }
            changed = true;
        }
    }
    return true;
}

void Plater::load_config_file(const wxString& given) {
    wxString file {given};
    if (file.IsEmpty()) {
        file = ask_open(this, _("Select configuration to load:"), FILE_WILDCARDS.at("ini"), ui_settings->config_directory);
    } else {
        wxFileName path(file);
        path.MakeAbsolute();
        file = path.GetFullPath();
    }
    if (file.IsEmpty()) return;
    used_config_file(file);
    try {
        this->select_external_config(file);
        GetFrame()->statusbar->SetStatusText(_("Loaded ") + file);
    } catch (std::exception& e) {
        show_error(this, wxString::FromUTF8(e.what()));
    }
}

void Plater::export_config() {
    const Slic3r::Config config {this->full_config()};
    const wxString directory {ui_settings->config_directory.IsEmpty() ? ui_settings->skein_directory : ui_settings->config_directory};
    const wxString file {ask_save(this, _("Save configuration as:"),
        wxFileName(directory, "config.ini"), FILE_WILDCARDS.at("ini"))};
    if (file.IsEmpty()) return;
    used_config_file(file);
    try {
        DynamicPrintConfig out;
        out.apply(config.config());
        out.validate();
        out.save(file.ToUTF8().data());
        GetFrame()->statusbar->SetStatusText(_("Configuration saved to ") + file);
    } catch (std::exception& e) {
        show_error(this, wxString::FromUTF8(e.what()));
    }
}

void Plater::import_config_from_gcode() {
    const wxString file {ask_open(this, _("Select G-code file to load config from:"), FILE_WILDCARDS.at("gcode"), ui_settings->config_directory)};
    if (file.IsEmpty()) return;
    used_config_file(file);
    std::ifstream in(file.ToUTF8().data());
    std::string line;
    if (!std::getline(in, line) || line.find("generated by Slic3r") == std::string::npos) {
        show_error(this, _("This file was not sliced by Slic3r."));
        return;
    }
    // the settings are the block of "; key = value" comments at the end
    std::vector<std::string> comments;
    while (std::getline(in, line)) {
        if (line.compare(0, 2, "; ") == 0) comments.push_back(line.substr(2));
        else if (!line.empty()) comments.clear();
    }
    DynamicPrintConfig config;
    for (const auto& comment : comments) {
        const size_t eq {comment.find(" = ")};
        if (eq == std::string::npos) continue;
        const std::string key {comment.substr(0, eq)};
        if (print_config_def.options.count(key) == 0) continue;  // the other comments
        config.set_deserialize(key, comment.substr(eq + 3));
    }
    if (config.keys().empty()) {
        show_error(this, _("No settings found at the end of this file."));
        return;
    }
    wxFileName ini(file);
    ini.SetExt("ini");
    if (ini.FileExists() && wxMessageBox(wxString::Format(_("Replace %s?"), ini.GetFullPath()), _("Import Config"),
            wxYES_NO | wxICON_QUESTION, this) != wxYES) return;
    try {
        config.save(ini.GetFullPath().ToUTF8().data());
        this->select_external_config(ini.GetFullPath());
        GetFrame()->statusbar->SetStatusText(_("Configuration imported to ") + ini.GetFullPath());
    } catch (std::exception& e) {
        show_error(this, wxString::FromUTF8(e.what()));
    }
}

void Plater::export_config_bundle() {
    const wxString directory {ui_settings->config_directory.IsEmpty() ? ui_settings->skein_directory : ui_settings->config_directory};
    const wxString file {ask_save(this, _("Save presets bundle as:"),
        wxFileName(directory, "Slic3r_config_bundle.ini"), FILE_WILDCARDS.at("ini"))};
    if (file.IsEmpty()) return;
    used_config_file(file);
    // the Perl GUI's bundle: [settings], the selected [presets], one [group:name] section
    // per preset file
    std::ofstream out(file.ToUTF8().data());
    out << "# generated by Slic3r " << SLIC3R_VERSION << "\n";
    out << "\n[settings]\nautocenter = " << (ui_settings->autocenter ? 1 : 0) << "\n\n[presets]\n";
    for (size_t group = 0; group < preset_types; ++group) {
        const auto& names {ui_settings->default_presets.at(group)};
        for (size_t i = 0; i < names.size(); ++i)
            out << GROUP_SECTIONS[group] << (i > 0 ? "_" + std::to_string(i) : std::string())
                << " = " << names[i].ToUTF8().data() << "\n";
    }
    for (size_t group = 0; group < preset_types; ++group) {
        wxArrayString files;
        const wxString& directory {SLIC3RAPP->preset_ini.at(group)};
        if (wxDirExists(directory)) wxDir::GetAllFiles(directory, &files, "*.ini", wxDIR_FILES);
        files.Sort();
        for (const auto& path : files) {
            out << "\n[" << GROUP_SECTIONS[group] << ":" << wxFileName(path).GetName().ToUTF8().data() << "]\n";
            std::ifstream in(path.ToUTF8().data());
            for (std::string line; std::getline(in, line); )
                if (!line.empty() && line[0] != '#' && line[0] != ';' && line[0] != '[') out << line << "\n";
        }
    }
    out.close();
    if (!out) show_error(this, _("Writing the bundle failed."));
    else GetFrame()->statusbar->SetStatusText(_("Presets bundle saved to ") + file);
}

void Plater::load_config_bundle(const wxString& path, bool only_with_id) {
    wxString file {path};
    if (file.IsEmpty()) {
        file = ask_open(this, _("Select configuration bundle to load:"), FILE_WILDCARDS.at("ini"), ui_settings->config_directory);
        if (file.IsEmpty()) return;
        used_config_file(file);
    }
    std::ifstream in(file.ToUTF8().data());
    std::map<std::pair<size_t, std::string>, std::string> sections;
    std::map<std::string, std::string> settings, selected;
    std::string* section {nullptr};
    std::map<std::string, std::string>* values {nullptr};
    for (std::string line; std::getline(in, line); ) {
        if (!line.empty() && line.back() == '\r') line.pop_back();
        if (!line.empty() && line.front() == '[') {
            section = nullptr;
            values = line == "[settings]" ? &settings : line == "[presets]" ? &selected : nullptr;
            for (size_t group = 0; group < preset_types; ++group) {
                const std::string start {std::string("[") + GROUP_SECTIONS[group] + ":"};
                if (line.compare(0, start.size(), start) != 0 || line.back() != ']') continue;
                const std::string name {line.substr(start.size(), line.size() - start.size() - 1)};
                // the name becomes a file name: nothing that leaves the preset folder
                if (name.empty() || name.find_first_of("/\\") != std::string::npos || name[0] == '.') continue;
                section = &sections[{group, name}];
            }
        } else if (section != nullptr && !line.empty()) {
            *section += line + "\n";
        } else if (values != nullptr) {
            const size_t eq {line.find(" = ")};
            if (eq != std::string::npos) (*values)[line.substr(0, eq)] = line.substr(eq + 3);
        }
    }
    // the ids of the presets there are, so that none is imported twice
    auto id_of = [](const std::string& text, size_t group) {
        const std::string key {std::string(GROUP_SECTIONS[group]) + "_settings_id = "};
        const size_t at {text.find(key)};
        if (at == std::string::npos) return std::string();
        return text.substr(at + key.size(), text.find('\n', at) - at - key.size());
    };
    int imported {0}, skipped {0};
    auto write = [&imported](const wxFileName& target, const std::string& text) {
        std::ofstream out(target.GetFullPath().ToUTF8().data());
        out << text;
        if (out) ++imported;
    };
    // presets the user already has under that name
    std::vector<std::pair<wxFileName, std::string>> clashes;
    wxString clash_names;
    for (const auto& entry : sections) {
        const size_t group {entry.first.first};
        const std::string id {id_of(entry.second, group)};
        if (only_with_id && id.empty()) continue;
        bool known {false};
        for (auto& preset : SLIC3RAPP->presets.at(group)) {
            Slic3r::Config config {preset.dirty_config()};
            const std::string key {std::string(GROUP_SECTIONS[group]) + "_settings_id"};
            if (!id.empty() && config.has(key) && config.config().serialize(key) == id) known = true;
        }
        const wxFileName target(SLIC3RAPP->preset_ini.at(group), wxString::FromUTF8(entry.first.second.c_str()) + ".ini");
        if (known) { ++skipped; continue; }
        if (target.FileExists()) {
            clashes.emplace_back(target, entry.second);
            clash_names << "\n" << GROUP_SECTIONS[group] << ": " << target.GetName();
            continue;
        }
        write(target, entry.second);
    }
    // never over a preset of the user's without asking (and not at all at the first start)
    const bool overwrite {!clashes.empty() && path.IsEmpty() && wxMessageBox(
        _("The bundle has presets with the names of some of yours:") + "\n" + clash_names + "\n\n" + _("Overwrite yours?"),
        _("Existing presets"), wxYES_NO | wxNO_DEFAULT | wxICON_QUESTION, this) == wxYES};
    for (const auto& clash : clashes) {
        if (overwrite) write(clash.first, clash.second);
        else ++skipped;
    }
    if (settings.count("autocenter") > 0) ui_settings->autocenter = settings["autocenter"] == "1";
    for (size_t group = 0; group < preset_types; ++group) {
        const std::string key {GROUP_SECTIONS[group]};
        if (selected.count(key) == 0) continue;
        auto& names {ui_settings->default_presets.at(group)};
        names = {wxString::FromUTF8(selected[key].c_str())};
        for (size_t i = 1; selected.count(key + "_" + std::to_string(i)) > 0; ++i)
            names.push_back(wxString::FromUTF8(selected[key + "_" + std::to_string(i)].c_str()));
    }
    ui_settings->save_settings();
    this->reload_presets();
    if (imported > 0 || path.IsEmpty())
        show_info(this, wxString::Format(_("%d presets imported, %d skipped because they exist."), imported, skipped),
            _("Config Bundle"));
}

void Plater::quick_slice(bool save_as, bool again, bool svg) {
    if (this->running != nullptr) {
        GetFrame()->statusbar->SetStatusText(_("Slicing is already running."));
        return;
    }
    wxString input {this->quick_slice_input};
    if (!again) {
        input = ask_open(this, _("Choose a file to slice (STL/OBJ/AMF/3MF):"), MODEL_WILDCARD);
        if (input.IsEmpty()) return;
    } else if (input.IsEmpty() || !wxFileExists(input)) {
        show_error(this, input.IsEmpty() ? wxString(_("No previously sliced file."))
            : wxString::Format(_("Previously sliced file (%s) not found."), input));
        return;
    }
    std::shared_ptr<SliceJob> job;
    try {
        Slic3r::Model loaded {Slic3r::Model::read_from_file(input.ToUTF8().data())};
        for (auto* object : loaded.objects) {
            object->input_file = input.ToUTF8().data();
            object->align_to_ground();
        }
        this->refresh_config();
        const BoundingBoxf bed {this->config->get<ConfigOptionPoints>("bed_shape").values};
        if (loaded.add_default_instances())
            loaded.arrange_objects(this->config->config().min_object_distance(), &bed);
        loaded.center_instances_around_point(this->bed_centerf());
        job = this->make_job(loaded);
    } catch (std::exception& e) {
        show_error(this, wxString::FromUTF8(e.what()));
        return;
    }
    job->for_plate = false;
    wxString output {again ? this->quick_slice_output : wxString()};
    const wxString extension {svg ? "svg" : "gcode"};
    if (output.IsEmpty() || wxFileName(output).GetExt() != extension) {
        wxFileName suggestion(wxString::FromUTF8(job->print.output_filepath("").c_str()));
        suggestion.SetExt(extension);
        output = suggestion.GetFullPath();
        if (save_as) {
            output = ask_save(this, wxString::Format(_("Save %s file as:"), svg ? "SVG" : "G-code"), suggestion,
                FILE_WILDCARDS.at(svg ? "svg" : "gcode"));
            if (output.IsEmpty()) return;
        }
    }
    if (!svg) {
        this->quick_slice_input = input;
        this->quick_slice_output = save_as ? output : wxString();
        this->update_enabled();
    }
    job->output_file = output.ToUTF8().data();
    job->svg = svg;
    this->run_job(job);
}

void Plater::repair_stl() {
    const wxString input {ask_open(this, _("Select the STL file to repair:"), FILE_WILDCARDS.at("stl"))};
    if (input.IsEmpty()) return;
    wxFileName suggestion(input);
    suggestion.SetName(suggestion.GetName() + "_fixed");
    suggestion.SetExt("obj");
    const wxString output {ask_save(this, _("Save OBJ file (less prone to coordinate errors than STL) as:"),
        suggestion, FILE_WILDCARDS.at("obj"))};
    if (output.IsEmpty()) return;
    try {
        TriangleMesh mesh;
        if (!IO::STL::read(input.ToUTF8().data(), &mesh)) throw std::runtime_error("The file couldn't be read.");
        mesh.repair();
        if (!IO::OBJ::write(mesh, output.ToUTF8().data())) throw std::runtime_error("The file couldn't be written.");
        show_info(this, _("Your file was repaired."), _("Repair"));
    } catch (std::exception& e) {
        show_error(this, wxString::FromUTF8(e.what()));
    }
}

} } // Namespace Slic3r::GUI
