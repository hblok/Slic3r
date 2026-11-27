#ifndef PREFERENCES_HPP
#define PREFERENCES_HPP

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif

#include "Settings.hpp"

namespace Slic3r { namespace GUI {

/// Edits the settings and saves them to slic3r.ini on OK. Returns true then.
bool show_preferences(wxWindow* parent, Settings& settings);

}} // namespace Slic3r::GUI
#endif
