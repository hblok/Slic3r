#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
    #include <wx/display.h>
    #include <wx/filefn.h> 
    #include <wx/dir.h>
    #include <wx/filename.h>
#endif
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
    this->notifier = std::unique_ptr<Notifier>();
    
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


    // if we don't have a datadir or a slic3r.ini, prompt for wizard.
    bool run_wizard = (wxDirExists(datadir) && wxFileExists(slic3r_ini));
    
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

    ui_settings->save_settings();

    // Load presets
    this->load_presets();


    wxImage::AddHandler(new wxPNGHandler());
    MainFrame *frame = new MainFrame( "Slic3r", wxDefaultPosition, wxDefaultSize);
    this->SetTopWindow(frame);

    // Load init bundle
    //

    // files from the command line go to the plater (as the Perl GUI did)
    if (!this->input_files.empty())
        this->CallAfter([frame, this]() { frame->get_plater()->load_files(this->input_files); });
    
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
    /*
    EVT_IDLE($frame, sub {
        while (my $cb = shift @cb) {
            $cb->();
        }
    });
    */


    return true;
}

void App::save_window_pos(const wxTopLevelWindow* window, const wxString& name ) {
    ui_settings->window_pos[name] = 
        std::make_tuple<wxPoint, wxSize, bool>(
            window->GetScreenPosition(),
            window->GetSize(),
            window->IsMaximized());

    ui_settings->save_settings();
}

void App::restore_window_pos(wxTopLevelWindow* window, const wxString& name ) {
    try {
        auto tmp = ui_settings->window_pos[name];
        const auto& size = std::get<1>(tmp);
        const auto& pos = std::get<0>(tmp);
        window->SetSize(size);

        auto display = wxDisplay().GetClientArea();
        if (((pos.x + size.x / 2) < display.GetRight()) && (pos.y + size.y/2 < display.GetBottom()))
            window->Move(pos);

        window->Maximize(std::get<2>(tmp));
    }
    catch (std::out_of_range& e) {
        // config was empty
    }
}

void App::load_presets() {
    // Rebuilt from the data directory on every call (also after a save or delete): the
    // default preset first, then the files sorted by name. It used to drop dirty presets
    // (the comment said "keep"), compare full paths with names, and prepend another
    // default preset on every call.
    for (size_t group = 0; group < preset_types; ++group) {
        Presets& preset_list = this->presets.at(group);
        preset_list.clear();
        preset_list.push_back(Preset(true, "- default -"s, static_cast<preset_t>(group)));
        const wxString& ini = this->preset_ini.at(group);
        if (!wxDirExists(ini)) continue;
        wxArrayString files;
        wxDir::GetAllFiles(ini, &files, "*.ini", wxDIR_FILES);
        files.Sort();
        for (const auto& file : files) {
            wxString path, name, ext;
            wxFileName::SplitPath(file, &path, &name, &ext);
            preset_list.push_back(Preset(path.ToStdString(), (name + "." + ext).ToStdString(), static_cast<preset_t>(group)));
        }
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
