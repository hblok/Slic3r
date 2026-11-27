// The Perl GUI's BedShapeDialog.pm and 2DBed.pm.
#include "Dialogs/BedShapeDialog.hpp"

#include <algorithm>
#include <cmath>

#include <wx/dcbuffer.h>

#include "BoundingBox.hpp"
#include "ClipperUtils.hpp"
#include "Model.hpp"
#include "Polygon.hpp"
#include "Polyline.hpp"
#include "misc_ui.hpp"

namespace Slic3r { namespace GUI {

Bed2D::Bed2D(wxWindow* parent) : wxPanel(parent, wxID_ANY, wxDefaultPosition, wxSize(280, 280)) {
    this->SetBackgroundStyle(wxBG_STYLE_PAINT);
    this->Bind(wxEVT_PAINT, [this](wxPaintEvent&) { this->_repaint(); });
    this->Bind(wxEVT_SIZE, [this](wxSizeEvent& e) { this->Refresh(); e.Skip(); });
    auto mouse = [this](wxMouseEvent& e) {
        if (this->on_move != nullptr && (e.LeftDown() || e.Dragging()) && this->_scale > 0) {
            const int height {this->GetClientSize().y};
            const Pointf at((e.GetX() - this->_shift.x) / this->_scale, (height - e.GetY() - this->_shift.y) / this->_scale);
            this->set_position(at);
            this->on_move(at);
        }
        e.Skip();
    };
    this->Bind(wxEVT_LEFT_DOWN, mouse);
    this->Bind(wxEVT_MOTION, mouse);
}

wxPoint Bed2D::_to_pixels(const Pointf& point) const {
    return wxPoint(static_cast<int>(point.x * this->_scale + this->_shift.x),
        static_cast<int>(this->GetClientSize().y - (point.y * this->_scale + this->_shift.y)));
}

void Bed2D::_repaint() {
    wxAutoBufferedPaintDC dc(this);
    dc.SetBackground(wxBrush(this->GetParent()->GetBackgroundColour()));
    dc.Clear();
    const wxSize size {this->GetClientSize()};
    if (this->_shape.size() < 3 || size.x <= 20 || size.y <= 30) return;

    // the bed and the origin fit in the panel, with room for the origin's label
    double x0 {0}, x1 {0}, y0 {0}, y1 {0};
    for (const auto& p : this->_shape) {
        x0 = std::min(x0, p.x); x1 = std::max(x1, p.x);
        y0 = std::min(y0, p.y); y1 = std::max(y1, p.y);
    }
    if (x1 - x0 <= 0 || y1 - y0 <= 0) return;
    const double width {size.x - 9.0}, height {size.y - 22.0};
    this->_scale = std::min(width / (x1 - x0), height / (y1 - y0));
    this->_shift = Pointf(4 + width / 2 - (x0 + x1) / 2 * this->_scale,
        18 + height / 2 - (y0 + y1) / 2 * this->_scale);

    std::vector<wxPoint> outline;
    for (const auto& p : this->_shape) outline.push_back(this->_to_pixels(p));
    dc.SetPen(*wxBLACK_PEN);
    dc.SetBrush(wxBrush(wxColour(255, 238, 222)));
    dc.DrawPolygon(outline.size(), outline.data());

    // 1 cm grid, clipped to the bed
    Polygon bed;
    for (const auto& p : this->_shape) bed.points.push_back(Point::new_scale(p.x, p.y));
    Polylines grid;
    auto line = [&grid](double ax, double ay, double bx, double by) {
        Polyline l;
        l.points = {Point::new_scale(ax, ay), Point::new_scale(bx, by)};
        grid.push_back(l);
    };
    for (double x = std::floor(x0 / 10) * 10 + 10; x < x1; x += 10) line(x, y0, x, y1);
    for (double y = std::floor(y0 / 10) * 10 + 10; y < y1; y += 10) line(x0, y, x1, y);
    dc.SetPen(wxPen(wxColour(211, 211, 211)));
    for (const auto& l : intersection_pl(grid, Polygons{bed})) {
        if (l.points.size() < 2) continue;
        dc.DrawLine(this->_to_pixels(Pointf::new_unscale(l.points.front())),
            this->_to_pixels(Pointf::new_unscale(l.points.back())));
    }
    dc.SetPen(*wxBLACK_PEN);
    dc.SetBrush(*wxTRANSPARENT_BRUSH);
    dc.DrawPolygon(outline.size(), outline.data());

    // axes from the origin, with arrow heads
    const wxPoint origin {this->_to_pixels(Pointf(0, 0))};
    dc.SetPen(wxPen(*wxRED, 2));
    dc.DrawLine(origin, origin + wxPoint(50, 0));
    dc.DrawLine(origin + wxPoint(50, 0), origin + wxPoint(46, -4));
    dc.DrawLine(origin + wxPoint(50, 0), origin + wxPoint(46, 4));
    dc.SetPen(wxPen(*wxGREEN, 2));
    dc.DrawLine(origin, origin + wxPoint(0, -50));
    dc.DrawLine(origin + wxPoint(0, -50), origin + wxPoint(-4, -46));
    dc.DrawLine(origin + wxPoint(0, -50), origin + wxPoint(4, -46));
    dc.SetPen(*wxBLACK_PEN);
    dc.SetBrush(*wxBLACK_BRUSH);
    dc.DrawCircle(origin, 3);
    dc.SetTextForeground(*wxBLACK);
    dc.DrawText("(0,0)", origin + wxPoint(1, 2));

    if (this->_has_position) {
        const wxPoint at {this->_to_pixels(this->_position)};
        dc.SetPen(wxPen(wxColour(200, 0, 0), 2));
        dc.SetBrush(*wxTRANSPARENT_BRUSH);
        dc.DrawCircle(at, 5);
        dc.DrawLine(at - wxPoint(15, 0), at + wxPoint(15, 0));
        dc.DrawLine(at - wxPoint(0, 15), at + wxPoint(0, 15));
    }
}

BedShapeDialog::BedShapeDialog(wxWindow* parent, const std::vector<Pointf>& shape) :
    wxDialog(parent, wxID_ANY, _("Bed Shape"), wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER),
    _panel(new BedShapePanel(this, shape))
{
    auto* sizer {new wxBoxSizer(wxVERTICAL)};
    sizer->Add(this->_panel, 1, wxEXPAND);
    sizer->Add(this->CreateButtonSizer(wxOK | wxCANCEL), 0, wxALIGN_RIGHT | wxALL, 10);
    this->SetSizerAndFit(sizer);
}

BedShapePanel::BedShapePanel(wxWindow* parent, const std::vector<Pointf>& shape) : wxPanel(parent, wxID_ANY)
{
    auto* box {new wxStaticBoxSizer(wxVERTICAL, this, _("Shape"))};
    this->_book = new wxChoicebook(box->GetStaticBox(), wxID_ANY, wxDefaultPosition, wxSize(300, -1));
    auto page = [this]() {
        auto* panel {new wxPanel(this->_book)};
        auto* grid {new wxFlexGridSizer(3, 5, 8)};
        auto* outer {new wxBoxSizer(wxVERTICAL)};
        outer->Add(grid, 0, wxALL, 8);
        panel->SetSizer(outer);
        return std::make_pair(panel, grid);
    };
    auto field = [this](wxPanel* panel, wxFlexGridSizer* grid, const wxString& label) {
        grid->Add(new wxStaticText(panel, wxID_ANY, label), 0, wxALIGN_CENTER_VERTICAL);
        auto* spin {new wxSpinCtrlDouble(panel, wxID_ANY, "", wxDefaultPosition, wxSize(170, -1),
            wxSP_ARROW_KEYS, -10000, 10000, 0, 1)};
        spin->SetDigits(2);
        spin->Bind(wxEVT_SPINCTRLDOUBLE, [this](wxSpinDoubleEvent&) { this->_update_shape(); });
        spin->Bind(wxEVT_TEXT, [this](wxCommandEvent&) { this->CallAfter([this]() { this->_update_shape(); }); });
        grid->Add(spin);
        grid->Add(new wxStaticText(panel, wxID_ANY, "mm"), 0, wxALIGN_CENTER_VERTICAL);
        return spin;
    };
    {
        auto p {page()};
        this->_size[0] = field(p.first, p.second, _("Size X"));
        this->_size[1] = field(p.first, p.second, _("Size Y"));
        this->_origin[0] = field(p.first, p.second, _("Origin X"));
        this->_origin[1] = field(p.first, p.second, _("Origin Y"));
        for (auto* origin : this->_origin)
            origin->SetToolTip(_("Distance of the 0,0 G-code coordinate from the front left corner of the rectangle."));
        this->_book->AddPage(p.first, _("Rectangular"));
    }
    {
        auto p {page()};
        this->_diameter = field(p.first, p.second, _("Diameter"));
        this->_diameter->SetToolTip(_("Diameter of the print bed. It is assumed that origin (0,0) is located in the center."));
        this->_book->AddPage(p.first, _("Circular"));
    }
    {
        auto p {page()};
        auto* load {new wxButton(p.first, wxID_ANY, _(L"Load shape from STL…"))};
        load->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->_load_model(); });
        p.second->Add(load);
        this->_book->AddPage(p.first, _("Custom"));
    }
    box->Add(this->_book, 0, wxEXPAND);

    this->_bed = new Bed2D(this);
    auto* top {new wxBoxSizer(wxHORIZONTAL)};
    top->Add(box, 0, wxEXPAND | wxALL, 10);
    top->Add(this->_bed, 1, wxEXPAND | wxTOP | wxBOTTOM | wxRIGHT, 10);
    this->_set_shape(shape);
    this->SetSizerAndFit(top);
    this->_book->Bind(wxEVT_CHOICEBOOK_PAGE_CHANGED, [this](wxBookCtrlEvent& e) { this->_update_shape(); e.Skip(); });
}

/// Which of the three kinds the points are, and show them as that.
void BedShapePanel::_set_shape(const std::vector<Pointf>& points) {
    double x0 {1e9}, x1 {-1e9}, y0 {1e9}, y1 {-1e9};
    for (const auto& p : points) {
        x0 = std::min(x0, p.x); x1 = std::max(x1, p.x);
        y0 = std::min(y0, p.y); y1 = std::max(y1, p.y);
    }
    auto rectangle = [this](double w, double h, double dx, double dy) {
        this->_size[0]->SetValue(w);
        this->_size[1]->SetValue(h);
        this->_origin[0]->SetValue(dx);
        this->_origin[1]->SetValue(dy);
        this->_diameter->SetValue(200);
        this->_book->ChangeSelection(0);
        this->_update_shape();
    };
    if (points.size() < 3) {
        rectangle(200, 200, 0, 0);  // no shape at all
        return;
    }
    // four corners, each on two sides of the bounding box
    if (points.size() == 4 && std::all_of(points.begin(), points.end(), [&](const Pointf& p) {
            return (std::abs(p.x - x0) < 1e-4 || std::abs(p.x - x1) < 1e-4)
                && (std::abs(p.y - y0) < 1e-4 || std::abs(p.y - y1) < 1e-4); })) {
        rectangle(x1 - x0, y1 - y0, x0 == 0 ? 0 : -x0, y0 == 0 ? 0 : -y0);
        return;
    }
    // all points equally far from the middle
    const Pointf centre((x0 + x1) / 2, (y0 + y1) / 2);
    double sum {0};
    std::vector<double> distances;
    for (const auto& p : points) {
        distances.push_back(std::hypot(p.x - centre.x, p.y - centre.y));
        sum += distances.back();
    }
    const double radius {sum / distances.size()};
    this->_size[0]->SetValue(x1 - x0);
    this->_size[1]->SetValue(y1 - y0);
    if (points.size() > 8 && std::all_of(distances.begin(), distances.end(),
            [radius](double d) { return std::abs(d - radius) < 1e-2; })) {
        this->_diameter->SetValue(std::round(radius * 2));
        this->_book->ChangeSelection(1);
    } else {
        this->_diameter->SetValue(200);
        this->_book->ChangeSelection(2);
    }
    this->_bed->set_shape(points);  // as it is, until a value is changed
}

void BedShapePanel::_update_shape() {
    if (this->_bed == nullptr || this->_diameter == nullptr) return;
    if (this->_book->GetSelection() == 0) {
        const double w {this->_size[0]->GetValue()}, h {this->_size[1]->GetValue()};
        if (w <= 0 || h <= 0) return;
        const double x {-this->_origin[0]->GetValue()}, y {-this->_origin[1]->GetValue()};
        this->_bed->set_shape({Pointf(x + 0, y + 0), Pointf(x + w, y + 0), Pointf(x + w, y + h), Pointf(x + 0, y + h)});
    } else if (this->_book->GetSelection() == 1) {
        const double radius {this->_diameter->GetValue() / 2};
        if (radius <= 0) return;
        std::vector<Pointf> circle;
        for (int i = 1; i <= 60; ++i) {
            const double angle {2 * PI / 60 * i};
            // rounded as scaled coordinates would be
            circle.push_back(Pointf(std::round(radius * std::cos(angle) * 1e6) / 1e6,
                std::round(radius * std::sin(angle) * 1e6) / 1e6));
        }
        this->_bed->set_shape(circle);
    }
}

void BedShapePanel::_load_model() {
    wxFileDialog dialog(this, _("Choose a file to import bed shape from (STL/OBJ/AMF/3MF):"), "", "",
        wxString(MODEL_WILDCARD), wxFD_OPEN | wxFD_FILE_MUST_EXIST);
    if (dialog.ShowModal() != wxID_OK) return;
    try {
        const Slic3r::Model model {Slic3r::Model::read_from_file(dialog.GetPath().ToUTF8().data())};
        const ExPolygons projection {model.raw_mesh().horizontal_projection()};
        if (projection.empty()) {
            show_error(this, _("The selected file contains no geometry."));
            return;
        }
        if (projection.size() > 1) {
            show_error(this, _("The selected file contains several disjoint areas. This is not supported."));
            return;
        }
        std::vector<Pointf> shape;
        for (const auto& p : projection.front().contour.points) shape.push_back(Pointf::new_unscale(p));
        this->_bed->set_shape(shape);
    } catch (std::exception& e) {
        show_error(this, wxString::FromUTF8(e.what()));
    }
}

}} // namespace Slic3r::GUI
