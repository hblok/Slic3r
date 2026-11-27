#ifndef OBJECTSETTINGS_HPP
#define OBJECTSETTINGS_HPP

#include <functional>

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif
#include <wx/scrolwin.h>
#include <wx/spinctrl.h>

#include "Model.hpp"
#include "PrintConfig.hpp"
#include "ObjectCutDialog.hpp"

namespace Slic3r { namespace GUI {

/// The object's parts and modifiers in 3D (modifiers see-through, the selected one
/// highlighted); a click selects one.
class PartsCanvas : public ObjectCanvas {
public:
    PartsCanvas(wxWindow* parent, const ModelObject& object);
    void show_parts(int selected);
    /// A volume was clicked (its index), or the background (-1).
    std::function<void(int)> on_select {nullptr};
protected:
    void mouse_up(wxMouseEvent& e) override;
private:
    const ModelObject& object;
};

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
    wxSpinCtrlDouble* position[3];      ///< the selected volume's lowest corner
    std::vector<std::string> addable;   ///< the keys in add_choice
    /// The selected entry's own settings: the object's or a volume's.
    DynamicPrintConfig& selected_config();
    PartsCanvas* view;
    /// Scale or rotate the selected volume (the list's context menu).
    void volume_menu();
    void transform_volume(int axis, bool to_size, bool rotate);
    void list_parts(int select);
    void show_settings();
    void load_volumes(bool modifier);
    void delete_volume();
    void create_modifier();
    /// Move the selected volume so that its lowest corner is where the fields say.
    void move_volume();
};

}} // namespace Slic3r::GUI
#endif
