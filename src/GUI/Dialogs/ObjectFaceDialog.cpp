// Rotate an object so that a chosen face becomes parallel to a plane.
#include "ObjectFaceDialog.hpp"

namespace Slic3r { namespace GUI {

ObjectFaceCanvas::ObjectFaceCanvas(wxWindow* parent, const ModelObject& object) :
    ObjectCanvas(parent, object), mesh(object.raw_mesh())
{}

void ObjectFaceCanvas::mouse_up(wxMouseEvent& e) {
    if (!dragging && e.LeftUp()) {
        Linef3 ray {this->ray_at(e.GetPosition())};
        ray.a.translate(-shift.x, -shift.y, -shift.z);
        ray.b.translate(-shift.x, -shift.y, -shift.z);
        facet = mesh.first_facet_hit(ray);
        if (on_select) on_select();
    }
    Scene3D::mouse_up(e);
}

void ObjectFaceCanvas::after_render() {
    if (facet < 0) return;
    glDisable(GL_LIGHTING);
    glEnable(GL_POLYGON_OFFSET_FILL);
    glPolygonOffset(-1, -1);  // on top of the face itself
    glColor3ub(255, 128, 0);
    // the whole flat face: every triangle in the plane of the one clicked
    const Vectorf3 n {mesh.facet_normal(facet)};
    const stl_vertex& on {mesh.stl.facet_start[facet].vertex[0]};
    glBegin(GL_TRIANGLES);
    for (int i = 0; i < mesh.stl.stats.number_of_facets; ++i) {
        const Vectorf3 other {mesh.facet_normal(i)};
        const stl_vertex& p {mesh.stl.facet_start[i].vertex[0]};
        if (n.x*other.x + n.y*other.y + n.z*other.z < 0.9999
            || std::abs(n.x*(p.x - on.x) + n.y*(p.y - on.y) + n.z*(p.z - on.z)) > 0.001) continue;
        for (const auto& v : mesh.stl.facet_start[i].vertex)
            glVertex3d(v.x + shift.x, v.y + shift.y, v.z + shift.z);
    }
    glEnd();
    glDisable(GL_POLYGON_OFFSET_FILL);
    glEnable(GL_LIGHTING);
}

ObjectFaceDialog::ObjectFaceDialog(wxWindow* parent, const ModelObject& object) :
    wxDialog(parent, wxID_ANY, _("Rotate Face to Plane"), wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER)
{
    canvas = new ObjectFaceCanvas(this, object);
    auto* left {new wxBoxSizer(wxVERTICAL)};
    left->Add(new wxStaticText(this, wxID_ANY, _("Click a face of the object.")), 0, wxALL, 10);
    const wxString planes[] {"XY", "XZ", "YZ"};
    plane = new wxChoice(this, wxID_ANY, wxDefaultPosition, wxDefaultSize, 3, planes);
    plane->SetSelection(0);
    auto* row {new wxBoxSizer(wxHORIZONTAL)};
    row->Add(new wxStaticText(this, wxID_ANY, _("Plane")), 0, wxALIGN_CENTER_VERTICAL | wxRIGHT, 5);
    row->Add(plane, 1);
    left->Add(row, 0, wxLEFT | wxRIGHT | wxEXPAND, 10);
    left->AddStretchSpacer(1);
    auto* buttons {new wxBoxSizer(wxHORIZONTAL)};
    auto* rotate {new wxButton(this, wxID_OK, _("Rotate to plane"))};
    rotate->SetDefault();
    rotate->Disable();
    buttons->Add(new wxButton(this, wxID_CANCEL, _("Cancel")), 0, wxRIGHT, 5);
    buttons->Add(rotate, 0);
    left->Add(buttons, 0, wxALL | wxALIGN_RIGHT, 10);
    auto* sizer {new wxBoxSizer(wxHORIZONTAL)};
    sizer->Add(left, 0, wxEXPAND);
    sizer->Add(canvas, 1, wxEXPAND);
    this->SetSizerAndFit(sizer);
    canvas->on_select = [this, rotate]() { rotate->Enable(canvas->selected()); };
}

Vectorf3 ObjectFaceDialog::target() const {
    const int chosen {plane->GetSelection()};  // XY, XZ, YZ
    return Vectorf3(chosen == 2 ? -1 : 0, chosen == 1 ? -1 : 0, chosen == 0 ? -1 : 0);
}

}} // namespace Slic3r::GUI
