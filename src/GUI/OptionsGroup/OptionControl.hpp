#ifndef OPTIONCONTROL_HPP
#define OPTIONCONTROL_HPP

#include <functional>
#include <string>

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif

#include "PrintConfig.hpp"

namespace Slic3r { namespace GUI {

/// A control for one print option, chosen by the option's definition: checkbox, choice,
/// editable list, spin field, slider, colour, point or text. Used by the preset editors,
/// the override lists and the object settings.
struct OptionControl {
    wxWindow* window;
    std::function<void()> refresh;  ///< show the config's value again
};

/// `config` is asked for each time (it may be replaced); `changed` runs after the user
/// has put a new value into it. Invalid text is refused. `index` picks one element of an
/// option with a value per extruder; -1: the whole option. `width` and `height` override
/// the definition's.
OptionControl make_option_control(wxWindow* parent, const std::string& opt_key,
    std::function<DynamicPrintConfig&()> config, std::function<void()> changed,
    int index = -1, int width = -1, int height = -1);

/// The option (or element `index` of it) as it is typed: strings unescaped, the lines of
/// a list of strings one below the other.
std::string option_text(DynamicPrintConfig& config, const std::string& opt_key, int index = -1);
/// The other way; false (and nothing changed) when the text is not understood.
bool set_option_text(DynamicPrintConfig& config, const std::string& opt_key, const std::string& text, int index = -1);

/// Give a list option `count` elements: new ones as the last.
void resize_option(DynamicPrintConfig& config, const std::string& opt_key, size_t count);

/// The option's stand-alone name ("Top solid layers" rather than "Top").
wxString option_name(const std::string& opt_key);

/// A value typed into a text field is stored when the field loses the focus: do that now
/// for the focused field (before slicing, saving or quitting from a menu).
void commit_pending_edit();

}} // namespace Slic3r::GUI
#endif
