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

/// One object, alone around the origin of an empty bed. The object must have its
/// instance rotation and scale applied to the mesh.
class ObjectCanvas : public Scene3D {
public:
    ObjectCanvas(wxWindow* parent, const ModelObject& object);
    /// Show these objects (parts of the first one) instead, where they are.
    void show_objects(const std::vector<const ModelObject*>& objects);
protected:
    BoundingBoxf3 bb;   ///< of the object given to the constructor, in the scene
    Pointf3 shift;      ///< from the object's coordinates to the scene's
};

/// The object with the cutting plane through it.
class ObjectCutCanvas : public ObjectCanvas {
public:
    using ObjectCanvas::ObjectCanvas;
    /// A cut across `axis`, `height` mm above the object's lowest point on that axis.
    void set_plane(Axis axis, double height);
    /// The outline of the object where the plane goes through it: pairs of points, in
    /// the object's coordinates.
    void set_section(const std::vector<Pointf3>& lines) { this->section = lines; this->Refresh(); }
protected:
    void after_render() override;
private:
    Axis axis {Z};
    double height {0};
    std::vector<Pointf3> section {};
};

struct CutOptions {
    Axis axis {Z};
    double height {0};          ///< from the object's lowest point on that axis, mm
    bool keep_upper {true}, keep_lower {true}, rotate_lower {false};
    Pointf grid {0, 0};         ///< tile widths when cutting by grid, else 0
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
    wxCheckBox* preview;
    wxSpinCtrlDouble* grid_x;
    wxSpinCtrlDouble* grid_y;
    bool by_grid {false};
    const ModelObject* object;
    Sizef3 size;
    /// Fits the height's range to the axis and enables what makes sense.
    void update();
};

}} // namespace Slic3r::GUI
#endif // OBJECTCUTDIALOG_HPP
