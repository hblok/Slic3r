#ifndef OBJECTCUTDIALOG_HPP
#define OBJECTCUTDIALOG_HPP

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif
#include <wx/spinctrl.h>

#include "Scene3D.hpp"
#include "Model.hpp"

namespace Slic3r { namespace GUI {

/// The object with the cutting plane through it.
class ObjectCutCanvas : public Scene3D {
public:
    ObjectCutCanvas(wxWindow* parent, ModelObject* object);
    /// A cut across `axis`, `height` mm above the object's lowest point on that axis.
    void set_plane(Axis axis, double height);
protected:
    void after_render() override;
private:
    BoundingBoxf3 bb;
    Axis axis {Z};
    double height {0};
};

struct CutOptions {
    Axis axis {Z};
    double height {0};          ///< from the object's lowest point on that axis, mm
    bool keep_upper {true}, keep_lower {true}, rotate_lower {false};
    /// The coordinate ModelObject::cut() wants: the mesh's own, as is
    /// ModelObject::instance_bounding_box() (it leaves out the instance's offset).
    double at(const BoundingBoxf3& instance_bb) const {
        const Pointf3& low {instance_bb.min};
        return (axis == X ? low.x : axis == Y ? low.y : low.z) + height;
    }
};

class ObjectCutDialog : public wxDialog {
public:
    /// The object must have its instance rotation and scale applied to the mesh.
    ObjectCutDialog(wxWindow* parent, ModelObject* object);
    CutOptions options() const;
private:
    ObjectCutCanvas* canvas;
    wxChoice* axis;
    wxSpinCtrlDouble* height;
    wxCheckBox* keep_upper;
    wxCheckBox* keep_lower;
    wxCheckBox* rotate_lower;
    Sizef3 size;
    /// Fits the height's range to the axis and enables what makes sense.
    void update();
};

}} // namespace Slic3r::GUI
#endif // OBJECTCUTDIALOG_HPP
