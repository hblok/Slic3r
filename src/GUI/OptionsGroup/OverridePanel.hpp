#ifndef OVERRIDEPANEL_HPP
#define OVERRIDEPANEL_HPP

#include <functional>
#include <set>
#include <string>
#include <vector>

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif

#include "OptionsGroup/OptionControl.hpp"

namespace Slic3r { namespace GUI {

/// A list of options that a configuration may hold of its own: one row for each option it
/// has, grouped by category, with a button to take it out and one to add another (the
/// Perl GUI's OverrideSettingsPanel). Used for a material's overrides of the printer and
/// for the plater's shortcuts.
class OverridePanel : public wxPanel {
public:
    /// `keys`: the options that may be listed. `changed` runs after a value was changed,
    /// added or removed. `index`: the element edited of a list option; -1: all of it.
    OverridePanel(wxWindow* parent, const std::vector<std::string>& keys,
        std::function<DynamicPrintConfig&()> config, std::function<void(const std::string&)> changed, int index = 0);

    /// Where an added option starts.
    std::function<DynamicPrintConfig()> default_config {nullptr};
    /// Options that can't be taken out.
    std::set<std::string> fixed {};
    bool can_add {true};
    bool can_delete {true};

    /// Show the config's options and values; rebuilds the rows when the options changed.
    void update();
    /// The listed options, in order of the rows.
    const std::vector<std::string>& shown() const { return this->_shown; }
private:
    std::vector<std::string> _keys;
    std::function<DynamicPrintConfig&()> _config;
    std::function<void(const std::string&)> _changed;
    int _index;
    std::vector<std::string> _shown {};
    std::set<std::string> _shown_fixed {};
    std::vector<OptionControl> _controls {};
    bool _built {false};
    wxBoxSizer* _rows {nullptr};
    void _build(const std::vector<std::string>& present);
    void _add_menu(wxWindow* at);
    int _index_of(const std::string& opt_key) const;
};

}} // namespace Slic3r::GUI
#endif
