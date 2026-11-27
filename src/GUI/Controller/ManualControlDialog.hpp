#ifndef MANUALCONTROLDIALOG_HPP
#define MANUALCONTROLDIALOG_HPP

#include <functional>

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif

#include "GCodeSender.hpp"
#include "PrintConfig.hpp"

namespace Slic3r { namespace GUI {

class Bed2D;

/// What the manual control remembers between its openings.
struct ManualSettings {
    double xy_speed {130};  ///< mm/s
    double z_speed {10};
    wxString temperature {}, bed_temperature {};
};

/// Move the head, home, set temperatures and send commands (ManualControlDialog.pm).
class ManualControlDialog : public wxDialog {
public:
    /// `log` gets the commands sent (may be null).
    ManualControlDialog(wxWindow* parent, const DynamicPrintConfig& config, GCodeSender& sender, ManualSettings& settings,
        std::function<void(const wxString&)> log);
private:
    std::function<void(const wxString&)> _log;
    const DynamicPrintConfig _config;
    GCodeSender& _sender;
    ManualSettings& _settings;
    Bed2D* _bed {nullptr};
    bool _x_homed {false}, _y_homed {false}, _have_position {false};
    double _x {0}, _y {0};
    void _command(const std::string& line);
    void _move_to(double x, double y);
    void _move_by(char axis, double distance);
    /// '\0': all axes
    void _home(char axis);
    void _set_temperature(const wxString& text, bool bed);
};

}} // namespace Slic3r::GUI
#endif
