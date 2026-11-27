#ifndef CONFIGWIZARD_HPP
#define CONFIGWIZARD_HPP

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif

#include "PrintConfig.hpp"

namespace Slic3r { namespace GUI {

/// Asks, a page at a time, for the printer and the material (the Perl GUI's wizard).
/// When finished fills the three configurations with the settings to save as presets,
/// starting from `current`, and returns true.
bool show_config_wizard(wxWindow* parent, const DynamicPrintConfig& current,
    DynamicPrintConfig& print, DynamicPrintConfig& printer, DynamicPrintConfig& material);

}} // namespace Slic3r::GUI
#endif
