#ifndef CONFIGWIZARD_HPP
#define CONFIGWIZARD_HPP

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif

#include "PrintConfig.hpp"

namespace Slic3r { namespace GUI {

/// Asks for the printer and the material. On OK fills the two configurations with the
/// settings to save as presets, starting from `current`, and returns true.
bool show_config_wizard(wxWindow* parent, const DynamicPrintConfig& current,
    DynamicPrintConfig& printer, DynamicPrintConfig& material);

}} // namespace Slic3r::GUI
#endif
