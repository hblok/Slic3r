#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
    #include <wx/display.h>
    #include <wx/filefn.h> 
    #include <wx/dir.h>
    #include <wx/filename.h>
#endif
#include <algorithm>
#include <iostream>
#include <string>

#include "MainFrame.hpp"
#include "GUI.hpp"
#include "misc_ui.hpp"
#include "Settings.hpp"
#include "Preset.hpp"

// Logging mechanism
#include "Log.hpp"

namespace Slic3r { namespace GUI {

/// Primary initialization and point of entry into the GUI application.
/// Calls MainFrame and handles preset loading, etc.
bool App::OnInit()
{
    // wx assertions go to stderr instead of a dialog that stops the program
    wxSetAssertHandler([](const wxString& file, int line, const wxString& func,
                          const wxString& cond, const wxString& msg) {
        std::cerr << "wx assertion " << file << ":" << line << " " << func << ": "
                  << cond << " " << msg << std::endl;
    });
    this->SetAppName("Slic3r");
    
    if (datadir.empty())
        datadir = decode_path(wxStandardPaths::Get().GetUserDataDir());
    wxString enc_datadir = encode_path(datadir);
    
    const wxString& slic3r_ini  {datadir + "/slic3r.ini"};
    this->preset_ini[static_cast<int>(preset_t::Print)] = {datadir + "/print"};
    this->preset_ini[static_cast<int>(preset_t::Printer)] = {datadir + "/printer"};
    this->preset_ini[static_cast<int>(preset_t::Material)] = {datadir + "/filament"};
    const wxString& print_ini = this->preset_ini[static_cast<int>(preset_t::Print)];
    const wxString& printer_ini = this->preset_ini[static_cast<int>(preset_t::Printer)];
    const wxString& material_ini = this->preset_ini[static_cast<int>(preset_t::Material)];

    // the first start: no data directory or no slic3r.ini yet
    const bool first_start {!wxDirExists(datadir) || !wxFileExists(slic3r_ini)};
    
    /* Check to make sure if datadir exists */
    for (auto& dir : std::vector<wxString> { enc_datadir, print_ini, printer_ini, material_ini }) {
        if (wxDirExists(dir)) continue;
        if (!wxMkdir(dir)) {
            Slic3r::Log::fatal_error(LogChannel, (_("Slic3r was unable to create its data directory at ")+ dir).ToStdWstring());
        }
    }

    Slic3r::Log::info(LogChannel, (_("Data dir: ") + datadir).ToStdWstring());

    ui_settings = Settings::init_settings();

    // Load gui settings from slic3r.ini (the Perl GUI's file and format)
    ui_settings->ini_file = slic3r_ini;
    ui_settings->load_settings();
    if (this->threads > 0) ui_settings->threads = this->threads;

    ui_settings->save_settings();

    // Load presets
    this->load_presets();

    wxImage::AddHandler(new wxPNGHandler());
    MainFrame *frame = new MainFrame( "Slic3r", wxDefaultPosition, wxDefaultSize);
    this->SetTopWindow(frame);

    // a bundle of presets shipped beside the program, else the wizard on the first start;
    // then the files from the command line go to the plater (all as the Perl GUI did)
    const wxString init_bundle {wxFileName(wxStandardPaths::Get().GetExecutablePath()).GetPath() + "/.init_bundle.ini"};
    this->CallAfter([frame, this, first_start, init_bundle]() {
        if (wxFileExists(init_bundle)) frame->get_plater()->load_config_bundle(init_bundle, true);
        else if (first_start) frame->get_plater()->config_wizard();
        for (const auto& file : this->config_files) frame->get_plater()->load_config_file(wxString::FromUTF8(file.c_str()));
        if (!this->overrides.empty()) frame->get_plater()->set_overrides(this->overrides);
        if (!this->input_files.empty()) frame->get_plater()->load_files(this->input_files);
    });
    
    // run callback functions during idle on the main frame
    this->Bind(wxEVT_IDLE, 
        [this](wxIdleEvent& e) { 
            std::function<void()> func {nullptr}; // 
            // try to get the mutex. If we can't, just skip this idle event and get the next one.
            if (!this->callback_register.try_lock()) return;
            // pop callback
            if (cb.size() >= 1) { 
                func = cb.top();
                cb.pop();
            }
            // unlock mutex
            this->callback_register.unlock();
            try { // call the function if it's not nullptr;
                if (func != nullptr) func();
            } catch (std::exception& e) { Slic3r::Log::error(LogChannel, LOG_WSTRING("Exception thrown: " <<  e.what())); }
        });

    return true;
}

void App::load_presets() {
    // Rebuilt from the data directory on every call (also after a save or delete): the
    // default preset first, then the files sorted by name. It used to drop dirty presets
    // (the comment said "keep"), compare full paths with names, and prepend another
    // default preset on every call.
    for (size_t group = 0; group < preset_types; ++group) {
        Presets& preset_list = this->presets.at(group);
        const Presets before {std::move(preset_list)};
        preset_list.clear();
        preset_list.push_back(Preset(true, "- default -"s, static_cast<preset_t>(group)));
        const wxString& ini = this->preset_ini.at(group);
        if (wxDirExists(ini)) {
            wxArrayString files;
            wxDir::GetAllFiles(ini, &files, "*.ini", wxDIR_FILES);
            files.Sort();
            for (const auto& file : files) {
                wxString path, name, ext;
                wxFileName::SplitPath(file, &path, &name, &ext);
                preset_list.push_back(Preset(path.ToStdString(), (name + "." + ext).ToStdString(), static_cast<preset_t>(group)));
            }
        }
        // saving or deleting one preset must not drop the unsaved changes of the others
        for (auto& preset : preset_list)
            for (const auto& old : before)
                if (old.name == preset.name) preset.keep_changes(old);
        // loaded configuration files stay while the file is there
        for (const auto& old : before)
            if (old.external && old.file_exists()
                    && std::none_of(preset_list.begin(), preset_list.end(), [&old](const Preset& p) { return p.name == old.name; }))
                preset_list.push_back(old);
    }
}

void App::CallAfter(std::function<void()> cb_function) {
    // set mutex
    this->callback_register.lock();
    // push function onto stack
    this->cb.emplace(cb_function);
    // unset mutex
    this->callback_register.unlock();
}

void App::OnUnhandledException() {
    try { throw; } 
    catch (std::exception &e) {
        Slic3r::Log::fatal_error(LogChannel, LOG_WSTRING("Exception Caught: " << e.what()));
    }
}

}} // namespace Slic3r::GUI
