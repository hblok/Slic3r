// Cut an object across an axis and keep the upper part, the lower part or both.
#include "ObjectCutDialog.hpp"

#include "misc_ui.hpp"
#include "ExPolygon.hpp"
#include "TriangleMesh.hpp"

namespace Slic3r { namespace GUI {

ObjectCanvas::ObjectCanvas(wxWindow* parent, const ModelObject& object) :
    Scene3D(parent, wxSize(420, 420)), bb(object.instance_bounding_box(0))
{
    // the object around the origin of an empty bed, as large as the object needs
    const Pointf3 center {bb.center()};
    shift = Pointf3(-center.x, -center.y, -bb.min.z);
    bb.translate(shift.x, shift.y, shift.z);
    this->show_objects({&object});
    const coord_t half {scale_(std::max(bb.size().x, bb.size().y))};
    set_bed_shape({Point(-half, -half), Point(half, -half), Point(half, half), Point(-half, half)});
}

void ObjectCanvas::show_objects(const std::vector<const ModelObject*>& objects) {
    volumes.clear();
    for (const auto* object : objects)
        for (const auto* volume : object->volumes) {
            GLVertexArray vertices;
            vertices.load_mesh(volume->mesh);
            volumes.push_back(Volume {ui_settings->color->COLOR_PARTS(), shift, vertices, volume->mesh.bounding_box()});
        }
    Refresh();
}

void ObjectCutCanvas::set_plane(Axis new_axis, double new_height) {
    axis = new_axis;
    height = new_height;
    Refresh();
}

void ObjectCutCanvas::after_render() {
    // a see-through quad, a little larger than the object
    const double margin {5};
    const double lo[] {bb.min.x - margin, bb.min.y - margin, bb.min.z - margin};
    const double hi[] {bb.max.x + margin, bb.max.y + margin, bb.max.z + margin};
    const double min[] {bb.min.x, bb.min.y, bb.min.z};
    const int u {axis == X ? 1 : 0}, v {axis == Z ? 1 : 2};
    double corner[3];
    corner[axis] = min[axis] + height;
    glDisable(GL_LIGHTING);
    glDisable(GL_CULL_FACE);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    const wxColour colour {ui_settings->color->COLOR_CUTPLANE()};
    glColor4ub(colour.Red(), colour.Green(), colour.Blue(), 128);
    glBegin(GL_QUADS);
    for (const auto& edge : {std::make_pair(false, false), std::make_pair(true, false), std::make_pair(true, true), std::make_pair(false, true)}) {
        corner[u] = edge.first ? hi[u] : lo[u];
        corner[v] = edge.second ? hi[v] : lo[v];
        glVertex3d(corner[0], corner[1], corner[2]);
    }
    glEnd();
    glDisable(GL_BLEND);
    glDisable(GL_DEPTH_TEST);
    glLineWidth(2);
    glColor3ub(0, 0, 0);
    glBegin(GL_LINES);
    for (const auto& point : section) glVertex3d(point.x + shift.x, point.y + shift.y, point.z + shift.z);
    glEnd();
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glEnable(GL_LIGHTING);
}

namespace {

/// The outline of a mesh in the plane across `A` at `at`.
template <Axis A>
void section_of(TriangleMesh mesh, double at, std::vector<Pointf3>& out) {
    ExPolygons slices;
    TriangleMeshSlicer<A>(&mesh).slice(static_cast<float>(at), &slices);
    for (const auto& slice : slices)
        for (const auto& line : slice.lines())
            for (const Point& p : {line.a, line.b}) {
                const double u {unscale(p.x)}, v {unscale(p.y)};
                // the slicer's two coordinates are (y, z), (z, x) or (x, y)
                out.push_back(A == X ? Pointf3(at, u, v) : A == Y ? Pointf3(v, at, u) : Pointf3(u, v, at));
            }
}

} // namespace

ObjectCutDialog::ObjectCutDialog(wxWindow* parent, ModelObject* object) :
    wxDialog(parent, wxID_ANY, _("Cut"), wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER),
    object(object), size(object->instance_bounding_box(0).size())
{
    canvas = new ObjectCutCanvas(this, *object);
    auto* grid {new wxFlexGridSizer(2, 5, 5)};
    auto add = [this, grid](const wxString& label, wxWindow* field) {
        grid->Add(new wxStaticText(this, wxID_ANY, label), 0, wxALIGN_CENTER_VERTICAL);
        grid->Add(field, 0, wxEXPAND);
    };
    const wxString axes[] {"X", "Y", "Z"};
    axis = new wxChoice(this, wxID_ANY, wxDefaultPosition, wxDefaultSize, 3, axes);
    axis->SetSelection(Z);
    height = new wxSpinCtrlDouble(this, wxID_ANY);
    height->SetDigits(2);
    height->SetIncrement(0.5);
    keep_upper = new wxCheckBox(this, wxID_ANY, _("Upper part"));
    keep_lower = new wxCheckBox(this, wxID_ANY, _("Lower part"));
    rotate_lower = new wxCheckBox(this, wxID_ANY, _("Rotate lower part upwards"));
    keep_upper->SetValue(true);
    keep_lower->SetValue(true);
    add(_("Axis"), axis);
    add(_("Height"), height);
    add(_("Keep"), keep_upper);
    add("", keep_lower);
    add("", rotate_lower);
    preview = new wxCheckBox(this, wxID_ANY, _("Show preview"));
    preview->SetToolTip(_("With one part kept, show that part as it will be cut."));
    preview->SetValue(true);
    add("", preview);
    auto tile = [this](wxSpinCtrlDouble*& field) {
        field = new wxSpinCtrlDouble(this, wxID_ANY);
        field->SetRange(1, 10000);
        field->SetValue(100);
        return field;
    };
    add(_("Tile width X"), tile(grid_x));
    add(_("Tile width Y"), tile(grid_y));
    auto* cut_grid {new wxButton(this, wxID_ANY, _("Cut by grid"))};
    add("", cut_grid);

    auto* left {new wxBoxSizer(wxVERTICAL)};
    left->Add(grid, 0, wxALL, 10);
    left->AddStretchSpacer(1);
    auto* buttons {new wxBoxSizer(wxHORIZONTAL)};
    auto* cut {new wxButton(this, wxID_OK, _("Perform cut"))};
    cut->SetDefault();
    buttons->Add(new wxButton(this, wxID_CANCEL, _("Cancel")), 0, wxRIGHT, 5);
    buttons->Add(cut, 0);
    left->Add(buttons, 0, wxALL | wxALIGN_RIGHT, 10);
    auto* sizer {new wxBoxSizer(wxHORIZONTAL)};
    sizer->Add(left, 0, wxEXPAND);
    sizer->Add(canvas, 1, wxEXPAND);
    this->SetSizerAndFit(sizer);

    axis->Bind(wxEVT_CHOICE, [this](wxCommandEvent&) {
        const double lengths[] {size.x, size.y, size.z};
        height->SetRange(0, lengths[axis->GetSelection()]);
        height->SetValue(lengths[axis->GetSelection()] / 2);
        this->update();
    });
    height->Bind(wxEVT_SPINCTRLDOUBLE, [this](wxSpinDoubleEvent&) { this->update(); });
    height->Bind(wxEVT_TEXT, [this](wxCommandEvent& e) { this->update(); e.Skip(); });
    keep_upper->Bind(wxEVT_CHECKBOX, [this](wxCommandEvent&) { this->update(); });
    keep_lower->Bind(wxEVT_CHECKBOX, [this](wxCommandEvent&) { this->update(); });
    preview->Bind(wxEVT_CHECKBOX, [this](wxCommandEvent&) { this->update(); });
    cut_grid->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { by_grid = true; this->EndModal(wxID_OK); });
    height->SetRange(0, size.z);
    height->SetValue(size.z / 2);
    this->update();
}

void ObjectCutDialog::update() {
    canvas->set_plane(static_cast<Axis>(axis->GetSelection()), height->GetValue());
    {
        const CutOptions cut {this->options()};
        const double at {cut.at(object->instance_bounding_box(0))};
        std::vector<Pointf3> lines;
        for (const auto* volume : object->volumes) {
            if (volume->modifier) continue;
            if (cut.axis == X) section_of<X>(volume->mesh, at, lines);
            else if (cut.axis == Y) section_of<Y>(volume->mesh, at, lines);
            else section_of<Z>(volume->mesh, at, lines);
        }
        canvas->set_section(lines);
    }
    rotate_lower->Enable(axis->GetSelection() == Z && keep_lower->GetValue());
    if (auto* cut {this->FindWindow(wxID_OK)}) cut->Enable(keep_upper->GetValue() || keep_lower->GetValue());
    // live preview: only when one of the two parts is to survive
    const bool one {keep_upper->GetValue() != keep_lower->GetValue()};
    preview->Enable(one);
    if (one && preview->GetValue()) {
        Slic3r::Model halves;
        object->cut(this->options().axis, this->options().at(object->instance_bounding_box(0)), &halves);
        canvas->show_objects({halves.objects.at(keep_upper->GetValue() ? 0 : 1)});
    } else {
        canvas->show_objects({object});
    }
}

CutOptions ObjectCutDialog::options() const {
    CutOptions o;
    o.axis = static_cast<Axis>(axis->GetSelection());
    o.height = height->GetValue();
    o.keep_upper = keep_upper->GetValue();
    o.keep_lower = keep_lower->GetValue();
    o.rotate_lower = rotate_lower->IsEnabled() && rotate_lower->GetValue();
    if (by_grid) o.grid = Pointf(grid_x->GetValue(), grid_y->GetValue());
    return o;
}

}} // namespace Slic3r::GUI
