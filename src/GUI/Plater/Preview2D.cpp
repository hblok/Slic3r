#include "Preview2D.hpp"

#include <cmath>

#include <wx/dcbuffer.h>
#include <wx/graphics.h>

#include "Layer.hpp"
#include "misc_ui.hpp"

namespace Slic3r { namespace GUI {

Preview2D::Preview2D(wxWindow* parent) : PreviewPanel(parent), canvas(new wxPanel(this, wxID_ANY)) {
    canvas->SetBackgroundStyle(wxBG_STYLE_PAINT);
    canvas->Bind(wxEVT_PAINT, [this](wxPaintEvent&) { this->paint(); });
    canvas->Bind(wxEVT_SIZE, [this](wxSizeEvent& e) { canvas->Refresh(); e.Skip(); });
    canvas->Bind(wxEVT_LEFT_DOWN, [this](wxMouseEvent& e) { drag_from = e.GetPosition(); e.Skip(); });
    canvas->Bind(wxEVT_MOTION, [this](wxMouseEvent& e) {
        if (!e.Dragging()) return;
        const wxPoint move {e.GetPosition() - drag_from};
        pan.m_x += move.x;
        pan.m_y += move.y;
        drag_from = e.GetPosition();
        canvas->Refresh();
    });
    canvas->Bind(wxEVT_LEFT_DCLICK, [this](wxMouseEvent&) { zoom = 1; pan = {0, 0}; canvas->Refresh(); });
    canvas->Bind(wxEVT_MOUSEWHEEL, [this](wxMouseEvent& e) {
        const double factor {std::pow(1.25, static_cast<double>(e.GetWheelRotation()) / e.GetWheelDelta())};
        const wxSize size {canvas->GetClientSize()};
        // the point under the mouse stays where it is
        const double x {e.GetX() - size.x / 2.}, y {e.GetY() - size.y / 2.};
        pan.m_x = x - (x - pan.m_x) * factor;
        pan.m_y = y - (y - pan.m_y) * factor;
        zoom *= factor;
        canvas->Refresh();
    });
    this->attach(canvas);
}

void Preview2D::show_level(size_t new_level) {
    level = new_level;
    canvas->Refresh();
}

void Preview2D::paint() {
    wxAutoBufferedPaintDC dc(canvas);
    dc.SetBackground(wxBrush(ui_settings->color->BACKGROUND255()));
    dc.Clear();
    if (print == nullptr || level >= level_count()) return;

    const BoundingBox bb {print->total_bounding_box()};
    const wxSize size {canvas->GetClientSize()};
    if (bb.size().x <= 0 || bb.size().y <= 0) return;
    const double scale {zoom * 0.95 * std::min(double(size.x) / bb.size().x, double(size.y) / bb.size().y)};
    const Point center {bb.center()};
    auto at = [&](const Point& p, const Point& shift) {
        return wxPoint2DDouble(size.x / 2. + pan.m_x + (p.x + shift.x - center.x) * scale,
                               size.y / 2. + pan.m_y - (p.y + shift.y - center.y) * scale);
    };

    std::unique_ptr<wxGraphicsContext> gc(wxGraphicsContext::Create(dc));
    auto add_line = [&](wxGraphicsPath& out, const Points& points, const Point& shift) {
        if (points.empty()) return;
        out.MoveToPoint(at(points.front(), shift));
        for (const auto& point : points) out.AddLineToPoint(at(point, shift));
    };

    // the slices, shaded, with their holes left open
    gc->SetBrush(wxBrush(ui_settings->color->TOOL_SHADE()));
    gc->SetPen(wxPen(ui_settings->color->TOOL_COLOR(), 1));
    for (const auto& entry : layers_at(level)) {
        for (const auto& shift : entry.first->_shifted_copies) {
            for (const auto& slice : entry.second->slices.expolygons) {
                wxGraphicsPath path {gc->CreatePath()};
                add_line(path, slice.contour.points, shift);
                path.CloseSubpath();
                for (const auto& hole : slice.holes) {
                    add_line(path, hole.points, shift);
                    path.CloseSubpath();
                }
                gc->DrawPath(path, wxODDEVEN_RULE);
            }
        }
    }

    // one graphics path per colour: stroking thousands of segments one by one is slow
    const wxColour colours[] {ui_settings->color->TOOL_STEPPERIM(), ui_settings->color->TOOL_INFILL(),
        ui_settings->color->TOOL_SUPPORT(), ui_settings->color->TOOL_DARK()};
    std::vector<wxGraphicsPath> strokes;
    for (size_t i = 0; i < 4; ++i) strokes.push_back(gc->CreatePath());
    // ponytail: only this level's paths; Perl also greys thicker layers that overlap it
    this->visit_level(level, [&](PreviewRole role, const std::vector<const ExtrusionPath*>& paths, bool, const Point& shift) {
        for (const auto* path : paths)
            add_line(strokes[static_cast<size_t>(role)], path->polyline.points, shift);
    });
    for (size_t i = 0; i < 4; ++i) {
        gc->SetPen(wxPen(colours[i], 1));
        gc->StrokePath(strokes[i]);
    }
}

} } // Namespace Slic3r::GUI
