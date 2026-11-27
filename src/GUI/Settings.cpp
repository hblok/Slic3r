#include "Settings.hpp"
#include "misc_ui.hpp"
#include <cctype>
#include <cstdlib>
#include <fstream>
#include <wx/filefn.h>
#include <wx/display.h>
#include <wx/toplevel.h>
#include <cstdio>

namespace Slic3r { namespace GUI {

std::unique_ptr<Settings> ui_settings {nullptr}; 

Settings::Settings() {
    // Initialize fonts
    this->_small_font = wxSystemSettings::GetFont(wxSYS_DEFAULT_GUI_FONT);
    if (the_os == OS::Mac) _small_font.SetPointSize(11);
    this->_small_bold_font = wxSystemSettings::GetFont(wxSYS_DEFAULT_GUI_FONT);
    if (the_os == OS::Mac) _small_bold_font.SetPointSize(11);
    this->_small_bold_font.MakeBold();
    this->_medium_font = wxSystemSettings::GetFont(wxSYS_DEFAULT_GUI_FONT);
    this->_medium_font.SetPointSize(12);

    this->_scroll_step = wxSystemSettings::GetFont(wxSYS_DEFAULT_GUI_FONT).GetPointSize();
}
static const char* preset_section_key(size_t group) {
    // the Perl GUI's names
    static const char* names[] = {"print", "filament", "printer"};
    return names[group];
}

void Settings::load_settings() {
    if (this->ini_file.empty() || !wxFileExists(this->ini_file)) return;
    std::ifstream in(this->ini_file.ToStdString());
    std::string line, category {"_"};
    while (std::getline(in, line)) {
        if (!line.empty() && line.back() == '\r') line.pop_back();
        if (line.empty() || line[0] == '#' || isspace((unsigned char)line[0])) continue;
        if (line.front() == '[' && line.back() == ']') {
            category = line.substr(1, line.size() - 2);
            continue;
        }
        const size_t eq = line.find('=');
        if (eq == std::string::npos) continue;
        std::string key = line.substr(0, eq), value = line.substr(eq + 1);
        while (!key.empty() && key.back() == ' ') key.pop_back();
        while (!value.empty() && value.front() == ' ') value.erase(0, 1);
        this->_ini[category][key] = value;
    }
    auto& general = this->_ini["_"];
    auto flag = [&general](const char* key, bool& field) {
        if (general.count(key)) field = general[key] == "1";
    };
    flag("autocenter", this->autocenter);
    flag("autoalignz", this->autoalignz);
    flag("invert_zoom", this->invert_zoom);
    flag("background_processing", this->background_processing);
    flag("remember_output_path", this->remember_output_path);
    if (general.count("last_output_path")) this->last_output_path = wxString::FromUTF8(general["last_output_path"]);
    // a hand-edited value that is no number leaves the default
    if (general.count("threads")) this->threads = std::strtoul(general["threads"].c_str(), nullptr, 10);
    if (general.count("nudge_val") && std::atof(general["nudge_val"].c_str()) > 0) this->nudge = std::atof(general["nudge_val"].c_str());
    flag("show_host", this->show_host);
    flag("tabbed_preset_editors", this->preset_editor_tabs);
    flag("reload_hide_dialog", this->hide_reload_dialog);
    flag("reload_preserve_trafo", this->reload_preserve_trafo);
    if (general.count("reload_behavior")) {
        const int behavior {std::atoi(general["reload_behavior"].c_str())};
        if (behavior >= 0 && behavior <= 2) this->reload = static_cast<ReloadBehavior>(behavior);
    }
    if (general.count("rotation_controls")) this->rotation_controls = general["rotation_controls"];
    if (general.count("colorscheme")) this->colorscheme = general["colorscheme"];
    if (this->colorscheme == "getSolarized") this->color.reset(new Slic3r::GUI::Solarized);
    if (general.count("color_toolpaths_by"))
        this->color_toolpaths_by = general["color_toolpaths_by"] == "extruder" ? PathColor::extruder : PathColor::role;
    // as the Perl GUI: [recent]; earlier versions of this one wrote [_]
    if (general.count("skein_directory")) this->skein_directory = wxString::FromUTF8(general["skein_directory"]);
    general.erase("skein_directory");
    auto& recent = this->_ini["recent"];
    if (recent.count("skein_directory")) this->skein_directory = wxString::FromUTF8(recent["skein_directory"]);
    if (recent.count("config_directory")) this->config_directory = wxString::FromUTF8(recent["config_directory"]);
    this->octoprint_overwrite = this->_ini["octoprint"]["overwrite"] == "1";
    this->octoprint_start = this->_ini["octoprint"]["start"] == "1";
    
    auto& presets = this->_ini["presets"];
    for (size_t group = 0; group < preset_types; ++group) {
        auto& names = this->default_presets[group];
        names.clear();
        const std::string key = preset_section_key(group);
        if (presets.count(key)) names.push_back(wxString::FromUTF8(presets[key]));
        for (size_t i = 1; presets.count(key + "_" + std::to_string(i)); ++i)
            names.push_back(wxString::FromUTF8(presets[key + "_" + std::to_string(i)]));
    }
}

void Settings::save_settings() {
    if (this->ini_file.empty()) return;
    auto& general = this->_ini["_"];
    general["autocenter"] = this->autocenter ? "1" : "0";
    general["autoalignz"] = this->autoalignz ? "1" : "0";
    general["invert_zoom"] = this->invert_zoom ? "1" : "0";
    general["background_processing"] = this->background_processing ? "1" : "0";
    general["remember_output_path"] = this->remember_output_path ? "1" : "0";
    general["last_output_path"] = this->last_output_path.ToUTF8().data();
    if (this->threads > 0) general["threads"] = std::to_string(this->threads);
    else general.erase("threads");
    general["nudge_val"] = wxString::Format("%g", this->nudge).ToStdString();
    general["show_host"] = this->show_host ? "1" : "0";
    general["tabbed_preset_editors"] = this->preset_editor_tabs ? "1" : "0";
    general["reload_hide_dialog"] = this->hide_reload_dialog ? "1" : "0";
    general["reload_preserve_trafo"] = this->reload_preserve_trafo ? "1" : "0";
    general["reload_behavior"] = std::to_string(static_cast<int>(this->reload));
    general["rotation_controls"] = this->rotation_controls;
    general["colorscheme"] = this->colorscheme;
    general["color_toolpaths_by"] = this->color_toolpaths_by == PathColor::extruder ? "extruder" : "role";
    general["version"] = SLIC3R_VERSION;
    auto& recent = this->_ini["recent"];
    recent["skein_directory"] = this->skein_directory.ToUTF8().data();
    recent["config_directory"] = this->config_directory.ToUTF8().data();
    this->_ini["octoprint"]["overwrite"] = this->octoprint_overwrite ? "1" : "0";
    this->_ini["octoprint"]["start"] = this->octoprint_start ? "1" : "0";
    
    auto& presets = this->_ini["presets"];
    for (size_t group = 0; group < preset_types; ++group) {
        const std::string key = preset_section_key(group);
        for (auto it = presets.begin(); it != presets.end(); )  // drop the old extra extruders
            it = (it->first.rfind(key + "_", 0) == 0) ? presets.erase(it) : std::next(it);
        const auto& names = this->default_presets[group];
        if (names.empty()) { presets.erase(key); continue; }
        presets[key] = names[0].ToUTF8().data();
        for (size_t i = 1; i < names.size(); ++i)
            presets[key + "_" + std::to_string(i)] = names[i].ToUTF8().data();
    }
    
    // as Perl's write_ini: a comment line, then "_" first and the other categories sorted
    std::ofstream out(this->ini_file.ToStdString());
    out << "# generated by Slic3r " << SLIC3R_VERSION << "\n";
    for (const auto& kv : this->_ini["_"]) out << kv.first << " = " << kv.second << "\n";
    for (const auto& category : this->_ini) {
        if (category.first == "_" || category.second.empty()) continue;
        out << "\n[" << category.first << "]\n";
        for (const auto& kv : category.second) out << kv.first << " = " << kv.second << "\n";
    }
}

void Settings::save_window_pos(wxTopLevelWindow* window, const wxString& name) {
    auto& general = this->_ini["_"];
    const std::string key {name.ToStdString()};
    const wxPoint position {window->GetScreenPosition()};
    const wxSize size {window->GetSize()};
    general[key + "_pos"] = std::to_string(position.x) + "," + std::to_string(position.y);
    general[key + "_size"] = std::to_string(size.x) + "," + std::to_string(size.y);
    general[key + "_maximized"] = window->IsMaximized() ? "1" : "0";
    this->save_settings();
}

void Settings::restore_window_pos(wxTopLevelWindow* window, const wxString& name) {
    auto& general = this->_ini["_"];
    const std::string key {name.ToStdString()};
    auto pair = [&general](const std::string& entry, int& a, int& b) {
        return general.count(entry) > 0 && std::sscanf(general[entry].c_str(), "%d,%d", &a, &b) == 2;
    };
    int width, height, x, y;
    if (!pair(key + "_pos", x, y) || !pair(key + "_size", width, height)) return;
    window->SetSize(wxSize(width, height));
    // only a position that leaves most of the window on the screen
    const wxRect screen {wxDisplay().GetClientArea()};
    if (x + width / 2 < screen.GetRight() && y + height / 2 < screen.GetBottom()) window->Move(x, y);
    if (general[key + "_maximized"] == "1") window->Maximize();
}
}} // namespace Slic3r::GUI
