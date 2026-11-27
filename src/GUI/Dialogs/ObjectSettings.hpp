#ifndef OBJECTSETTINGS_HPP
#define OBJECTSETTINGS_HPP

#include <functional>

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif
#include <wx/scrolwin.h>

#include "Model.hpp"
#include "PrintConfig.hpp"

namespace Slic3r { namespace GUI {

/// An object's parts and modifiers, and the print settings that apply to the object or
/// one of its volumes only. Edits the object directly (undo takes it back).
class ObjectSettingsDialog : public wxDialog {
public:
    /// `defaults`: the selected presets, where a new setting starts. `changed` runs after
    /// every edit.
    ObjectSettingsDialog(wxWindow* parent, ModelObject* object, const DynamicPrintConfig& defaults,
        std::function<void()> changed);
private:
    ModelObject* object;
    const DynamicPrintConfig defaults;
    std::function<void()> changed;
    wxListBox* parts;
    wxButton* delete_button;
    wxChoice* add_choice;
    wxScrolledWindow* settings;
    std::vector<std::string> addable;   ///< the keys in add_choice
    /// The selected entry's own settings: the object's or a volume's.
    DynamicPrintConfig& selected_config();
    void list_parts(int select);
    void show_settings();
    void load_volumes(bool modifier);
    void delete_volume();
};

}} // namespace Slic3r::GUI
#endif
