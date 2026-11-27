#ifndef CONTROLLER_UI_HPP
#define CONTROLLER_UI_HPP

#include <map>
#include <string>
#include <vector>

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif
#include <wx/scrolwin.h>
#include <wx/bmpbuttn.h>

#include "PrintConfig.hpp"

namespace Slic3r { namespace GUI {

class PrinterPanel;

/// The "Controller" tab: control of printers over a serial port, one panel each (the
/// Perl GUI's Controller.pm).
class Controller : public wxScrolledWindow {
public:
    Controller(wxWindow* parent, const wxString& title);

    /// The tab is shown: a panel for each printer that is worth one.
    void activate();
    /// The panel of a printer preset with a serial port (made when there is none).
    PrinterPanel* add_printer(const wxString& preset_name);
    /// Whether some printer is printing (closing the program asks then).
    bool printing() const;
    void disconnect_all();
private:
    wxBoxSizer* _sizer {nullptr};
    wxStaticText* _no_printers {nullptr};
    wxBitmapButton* _add {nullptr};
    std::vector<PrinterPanel*> _panels {};
    /// The printer presets that have a serial port, with their settings.
    std::map<wxString, DynamicPrintConfig> _printers() const;
    void _add_menu();
};

}} // Namespace Slic3r::GUI

#endif // CONTROLLER_UI_HPP
