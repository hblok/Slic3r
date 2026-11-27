#ifndef PROJECTOR_HPP
#define PROJECTOR_HPP

#include <functional>
#include <memory>

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif
#include <wx/slider.h>
#include <wx/spinctrl.h>
#include <wx/timer.h>

#include "GCodeSender.hpp"
#include "Model.hpp"
#include "PrintConfig.hpp"
#include "SLAPrint.hpp"
#include "Controller/ManualControlDialog.hpp"
#include "Projector/ProjectorScreen.hpp"

namespace Slic3r { namespace GUI {

/// The SLA/DLP settings of a print, asked before the projector opens (SLAPrintOptions.pm).
/// `config`: the selected presets. False when cancelled; else `sla` holds the choices.
bool ask_sla_options(wxWindow* parent, const DynamicPrintConfig& config, DynamicPrintConfig& sla);

/// A projector screen left black stays open until this (the program quits).
void close_projector_screen();

/// Slices the plate for a DLP printer and shows its layers on a projector screen, moving
/// the printer's Z axis over a serial port (Projector.pm). The main window is hidden
/// meanwhile.
class ProjectorDialog : public wxDialog {
public:
    /// `config`: the presets with the SLA choices on top; `datadir` for DLP.ini.
    ProjectorDialog(const Slic3r::Model& model, const DynamicPrintConfig& config, const wxString& datadir);
    ~ProjectorDialog();
private:
    DynamicPrintConfig _config;
    ProjectorSettings _settings;
    const wxString _ini;
    SLAPrint _print;
    ManualSettings _manual {};
    std::unique_ptr<GCodeSender> _sender;
    wxTimer _timer;
    std::function<void()> _next {nullptr};  ///< what the timer does
    bool _printing {false};
    int _layer {-1};

    wxButton* _manual_control {nullptr};
    wxButton* _print_button {nullptr};
    wxButton* _stop {nullptr};
    wxSpinCtrl* _layer_spin {nullptr};
    wxSlider* _layer_slider {nullptr};
    wxStaticText* _status {nullptr};
    std::vector<wxWindow*> _groups {};

    int layer_count() const { return static_cast<int>(this->_print.layers.size()); }
    void _settings_changed();
    void _delay(double seconds, std::function<void()> then);
    bool _connect();
    void _start();
    void _stop_print();
    void _finish();
    void _next_layer();
    void _project(int layer);
    void _update_buttons();
    void _set_status(const wxString& text);
    void _show_print_time();
    double _remaining_time() const;
    void _export_svg();
    void _close();
};

}} // namespace Slic3r::GUI
#endif
