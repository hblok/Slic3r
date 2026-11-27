#ifndef OPTIONCONTROL_HPP
#define OPTIONCONTROL_HPP

#include <functional>

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif

#include "PrintConfig.hpp"

namespace Slic3r { namespace GUI {

/// A control for one print option, chosen by the option's definition: checkbox, choice or
/// text. Used by the preset editors and the object settings.
struct OptionControl {
    wxWindow* window;
    std::function<void()> refresh;  ///< show the config's value again
};

/// `config` is asked for each time (it may be replaced); `changed` runs after the user
/// has put a new value into it. Invalid text is refused.
OptionControl make_option_control(wxWindow* parent, const std::string& opt_key,
    std::function<DynamicPrintConfig&()> config, std::function<void()> changed);

/// The option's stand-alone name ("Top solid layers" rather than "Top").
wxString option_name(const std::string& opt_key);

}} // namespace Slic3r::GUI
#endif
