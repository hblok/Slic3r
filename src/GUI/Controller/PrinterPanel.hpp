#ifndef PRINTERPANEL_HPP
#define PRINTERPANEL_HPP

#include <ctime>
#include <map>
#include <memory>
#include <string>
#include <vector>

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif
#include <wx/combobox.h>
#include <wx/gauge.h>
#include <wx/scrolwin.h>
#include <wx/timer.h>

#include "GCodeSender.hpp"
#include "PrintConfig.hpp"
#include "Controller/ManualControlDialog.hpp"

namespace Slic3r { namespace GUI {

/// A G-code file waiting to be printed, or printed.
struct PrintJob {
    std::string gcode_file;
    std::map<std::string, float> filament;  ///< mm used, by material preset
    std::time_t queued {std::time(nullptr)};
    double duration {0};                    ///< estimated, seconds
    bool printing {false}, paused {false}, printed {false};
};

/// One printer: its connection, temperatures, print queue and log (PrinterPanel.pm).
class PrinterPanel : public wxPanel {
public:
    PrinterPanel(wxWindow* parent, const wxString& printer_name, const DynamicPrintConfig& config);
    ~PrinterPanel();

    const wxString& printer_name() const { return this->_name; }
    void set_config(const DynamicPrintConfig& config) { this->_config = config; }
    bool is_connected() const { return this->_sender != nullptr && this->_sender->is_connected(); }
    bool has_jobs() const { return !this->_jobs.empty(); }
    bool printing() const { return this->_printing != nullptr; }
    void connect();
    void disconnect();
    /// Add a G-code file to the queue.
    void load_print_job(const std::string& gcode_file, const std::map<std::string, float>& filament);
    void append_to_log(const wxString& text);
private:
    const wxString _name;
    DynamicPrintConfig _config;
    std::unique_ptr<GCodeSender> _sender;
    std::vector<std::shared_ptr<PrintJob>> _jobs;
    std::shared_ptr<PrintJob> _printing;
    ManualSettings _manual {};

    wxComboBox* _port {nullptr};
    wxComboBox* _speed {nullptr};
    wxBitmapButton* _rescan {nullptr};
    wxButton* _connect {nullptr};
    wxButton* _disconnect {nullptr};
    wxButton* _manual_control {nullptr};
    wxGauge* _gauge {nullptr};
    wxStaticText* _status {nullptr};
    wxPanel* _temperatures {nullptr};
    wxStaticText* _temperature {nullptr};
    wxStaticText* _bed_temperature {nullptr};
    wxScrolledWindow* _jobs_panel {nullptr};
    wxTextCtrl* _log {nullptr};
    wxTimer _status_timer;
    wxTimer _temperature_timer;
    bool _blink {false};

    void _update_connection_controls();
    void _set_status(const wxString& status);
    void _scan_ports();
    void _poll();
    /// Show the queue again (not from within one of its buttons' events).
    void _reload_jobs();
    wxWindow* _job_panel(const std::shared_ptr<PrintJob>& job);
    void _print(const std::shared_ptr<PrintJob>& job);
    void _print_completed();
};

}} // namespace Slic3r::GUI
#endif
