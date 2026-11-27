#ifndef GUI_HPP
#define GUI_HPP
#include <wx/toplevel.h>
#include "MainFrame.hpp"
#include "Notifier.hpp"
#include <string>
#include <vector>
#include <array>
#include <stack>
#include <mutex>


#include "Preset.hpp"

namespace Slic3r { namespace GUI {


class App: public wxApp
{
public:
    /// If set to a file path, Slic3r will automatically export to it the active configuration whenever an option is changed or a preset or selected.
    wxString autosave {""};
    
    /// The directory where presets and config are stored. If empty, Slic3r will default to the location provided by wxWidgets.
    wxString datadir {""};
    
    /// Model files from the command line, loaded into the plater at start
    std::vector<std::string> input_files {};
    /// --output from the command line: the G-code export writes there without asking
    std::string output_file {""};
    /// --load from the command line: configuration files to load and select
    std::vector<std::string> config_files {};
    /// print options from the command line, on top of the selected presets
    DynamicPrintConfig overrides {};
    /// --threads from the command line (0: not given)
    unsigned int threads {0};
    
    virtual bool OnInit() override;
    App() : wxApp() {}

    /// Function to add callback functions to the idle loop stack.
    void CallAfter(std::function<void()> cb_function); 


    void OnUnhandledException() override;

    preset_store presets { Presets() };
    std::array<wxString, preset_types> preset_ini { };
    Settings* settings() { return ui_settings.get(); }

    /// (Re)read the presets from the data directory.
    void load_presets();

private:
    std::unique_ptr<Notifier> notifier {nullptr};

    const std::string LogChannel {"APP"}; //< Which log these messages should go to.

    /// Lock to guard the callback stack
    std::mutex callback_register;
    
    /// callbacks registered to run during idle event.
    std::stack<std::function<void()> > cb {};
};


/// Quick reference to this app with its cast applied.
#define SLIC3RAPP (dynamic_cast<App*>(wxTheApp))


}} // namespace Slic3r::GUI
#endif // GUI_HPP
