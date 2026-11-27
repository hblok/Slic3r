#ifndef OBJECTFACEDIALOG_HPP
#define OBJECTFACEDIALOG_HPP

#include "ObjectCutDialog.hpp"

namespace Slic3r { namespace GUI {

/// The object; a click selects one of its faces (a drag still turns the view).
class ObjectFaceCanvas : public ObjectCanvas {
public:
    ObjectFaceCanvas(wxWindow* parent, const ModelObject& object);
    std::function<void()> on_select;
    bool selected() const { return facet >= 0; }
    /// Outward normal of the selected face.
    Vectorf3 normal() const { return mesh.facet_normal(facet); }
protected:
    void mouse_up(wxMouseEvent& e) override;
    void after_render() override;
private:
    TriangleMesh mesh;  ///< the printed volumes, in the object's coordinates
    int facet {-1};
};

/// Choose a face of the object and the plane it shall be parallel to.
class ObjectFaceDialog : public wxDialog {
public:
    /// The object must have its instance rotation and scale applied to the mesh.
    ObjectFaceDialog(wxWindow* parent, const ModelObject& object);
    Vectorf3 normal() const { return canvas->normal(); }
    /// Where the normal shall point to: down onto the chosen plane.
    Vectorf3 target() const;
private:
    ObjectFaceCanvas* canvas;
    wxChoice* plane;
};

}} // namespace Slic3r::GUI
#endif // OBJECTFACEDIALOG_HPP
