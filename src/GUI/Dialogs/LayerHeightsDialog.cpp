// Layer heights of one object: a curve to drag, and a table of height ranges.
#include "LayerHeightsDialog.hpp"

#include <algorithm>
#include <cmath>
#include <set>
#include <sstream>

#include <wx/dcbuffer.h>

#include "Print.hpp"
#include "misc_ui.hpp"

namespace Slic3r { namespace GUI {

namespace {
constexpr int BORDER {10};  // around the plot, pixels
}

SplineCanvas::SplineCanvas(wxWindow* parent, const LayerHeightSpline& spline, double min_height, double max_height,
        double object_height) :
    wxPanel(parent, wxID_ANY, wxDefaultPosition, wxSize(220, 380)),
    spline(spline), before(spline), positions(spline.getOriginalLayers()),
    min_height(min_height), max_height(max_height), object_height(object_height)
{
    for (const auto z : positions) heights.push_back(this->spline.getLayerHeightAt(z));
    this->SetBackgroundStyle(wxBG_STYLE_PAINT);
    this->Bind(wxEVT_PAINT, [this](wxPaintEvent&) { this->paint(); });
    this->Bind(wxEVT_SIZE, [this](wxSizeEvent& e) { this->Refresh(); e.Skip(); });
    for (const auto type : {wxEVT_LEFT_DOWN, wxEVT_RIGHT_DOWN, wxEVT_MOTION, wxEVT_LEFT_UP, wxEVT_RIGHT_UP})
        this->Bind(type, [this](wxMouseEvent& e) { this->drag(e); });
    this->Bind(wxEVT_MOUSE_CAPTURE_LOST, [this](wxMouseCaptureLostEvent&) { dragging = false; });
}

void SplineCanvas::reset() {
    spline.setLayers(positions);  // the heights follow from the positions again
    for (size_t i = 0; i < positions.size(); ++i) heights[i] = positions[i] - (i == 0 ? 0 : positions[i - 1]);
    changed = true;
    this->Refresh();
}

wxPoint SplineCanvas::to_pixel(double thickness, double z) const {
    const wxSize size {this->GetClientSize()};
    const double w = size.x - 2 * BORDER, h = size.y - 2 * BORDER;
    const double x {(thickness - min_height) / std::max(max_height - min_height, 1e-6)};
    const double y {z / object_height};
    return wxPoint(BORDER + std::min(std::max(x, 0.), 1.) * w, BORDER + (1 - std::min(std::max(y, 0.), 1.)) * h);
}

void SplineCanvas::from_pixel(const wxPoint& at, double& thickness, double& z) const {
    const wxSize size {this->GetClientSize()};
    const double x {double(at.x - BORDER) / std::max(size.x - 2 * BORDER, 1)};
    const double y {1 - double(at.y - BORDER) / std::max(size.y - 2 * BORDER, 1)};
    thickness = min_height + std::min(std::max(x, 0.), 1.) * (max_height - min_height);
    z = std::min(std::max(y, 0.), 1.) * object_height;
}

void SplineCanvas::drag(const wxMouseEvent& e) {
    double thickness, z;
    this->from_pixel(e.GetPosition(), thickness, z);
    if (e.LeftDown() || e.RightDown()) {
        dragging = true;
        start_z = z;
        at_start = heights;
        this->CaptureMouse();
    } else if (dragging && (e.Dragging() || e.LeftUp() || e.RightUp())) {
        const bool bend {e.LeftIsDown() || e.LeftUp()};
        heights = at_start;
        for (size_t i = 0; i < positions.size(); ++i) {
            if (bend) {  // towards the pointer's thickness, less further from the start
                const double reach {std::max(std::abs(start_z - z), 0.00001)};
                const double distance {std::abs(start_z - positions[i]) / reach};
                heights[i] += (thickness - heights[i]) * std::max(0., 1 - distance * distance);
            } else if (positions[i] >= std::min(start_z, z) && positions[i] < std::max(start_z, z)) {
                heights[i] = thickness;
            }
        }
        spline.updateLayerHeights(heights);
        changed = true;
        if (e.LeftUp() || e.RightUp()) {
            dragging = false;
            if (this->HasCapture()) this->ReleaseMouse();
        }
        this->Refresh();
    } else if (e.Moving()) {
        this->SetToolTip(wxString::Format(_("%.2f mm thick at Z %.2f mm"), spline.getLayerHeightAt(z), z));
    }
}

void SplineCanvas::draw_curve(wxDC& dc, LayerHeightSpline& what) {
    const int height {this->GetClientSize().y};
    std::vector<wxPoint> points;
    for (int pixel = BORDER; pixel <= height - BORDER; ++pixel) {
        double thickness, z;
        this->from_pixel(wxPoint(0, pixel), thickness, z);
        points.push_back(this->to_pixel(what.getLayerHeightAt(z), z));
    }
    if (points.size() > 1) dc.DrawLines(points.size(), points.data());
}

void SplineCanvas::paint() {
    wxAutoBufferedPaintDC dc(this);
    dc.SetBackground(*wxWHITE_BRUSH);
    dc.Clear();
    // the layers as they will be
    dc.SetPen(wxPen(wxColour(200, 200, 200)));
    double last {0};
    for (const auto z : spline.getInterpolatedLayers()) {
        if (z > object_height + 1e-6) break;
        dc.DrawLine(this->to_pixel(min_height, z), this->to_pixel(z - last, z));
        last = z;
    }
    dc.SetPen(wxPen(wxColour(150, 150, 150), 1, wxPENSTYLE_SHORT_DASH));
    this->draw_curve(dc, before);
    dc.SetPen(wxPen(wxColour(0, 90, 220), 2));
    this->draw_curve(dc, spline);
    dc.SetTextForeground(*wxBLACK);
    const wxSize size {this->GetClientSize()};
    dc.DrawLabel(wxString::Format("%.4g", min_height), wxRect(size), wxALIGN_LEFT | wxALIGN_BOTTOM);
    dc.DrawLabel(wxString::Format("%.4g mm", max_height), wxRect(size), wxALIGN_RIGHT | wxALIGN_BOTTOM);
}

LayerHeightsDialog::LayerHeightsDialog(wxWindow* parent, const ModelObject& object, const DynamicPrintConfig& config) :
    wxDialog(parent, wxID_ANY, _("Layer heights"), wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER)
{
    // the layers slicing would make, from a print of this object alone
    Slic3r::Model alone;
    ModelObject* copy {alone.add_object(object)};
    Slic3r::Print print;
    print.apply_config(config);
    print.auto_assign_extruders(copy);
    print.add_model_object(copy);
    PrintObject* sliced {print.objects.front()};
    sliced->prepare_layer_heights();

    double min_height {0}, max_height {1e6};
    for (const size_t extruder : print.object_extruders()) {
        min_height = std::max(min_height, print.config.min_layer_height.get_at(extruder));
        max_height = std::min(max_height, print.config.max_layer_height.get_at(extruder));
    }

    auto* columns {new wxBoxSizer(wxHORIZONTAL)};
    auto* left {new wxBoxSizer(wxVERTICAL)};
    if (sliced->layer_height_spline.hasData()) {
        canvas = new SplineCanvas(this, sliced->layer_height_spline, min_height, max_height, unscale(sliced->size.z));
        left->Add(canvas, 1, wxEXPAND);
        auto* reset {new wxButton(this, wxID_ANY, _("Reset curve"))};
        reset->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { canvas->reset(); });
        left->Add(reset, 0, wxTOP, 5);
    } else {
        left->Add(new wxStaticText(this, wxID_ANY, _("This object has too few layers for a curve.")));
    }
    columns->Add(left, 1, wxEXPAND | wxALL, 10);

    // ponytail: ranges as lines of text; a grid if that ever gets in the way
    auto* right {new wxBoxSizer(wxVERTICAL)};
    auto* help {new wxStaticText(this, wxID_ANY, _("Height ranges, one per line:\nfrom  to  layer height (mm)\n\n"
        "They replace the standard and adaptive\nheights, not a curve drawn on the left.\n\n"
        "Curve: drag with the left button to bend\nit, with the right to set one thickness\nover a range."))};
    right->Add(help, 0, wxBOTTOM, 5);
    wxString text;
    for (const auto& range : object.layer_height_ranges)
        text << wxString::FromCDouble(range.first.first) << " " << wxString::FromCDouble(range.first.second) << " "
             << wxString::FromCDouble(range.second) << "\n";
    ranges = new wxTextCtrl(this, wxID_ANY, text, wxDefaultPosition, wxSize(220, 120), wxTE_MULTILINE);
    right->Add(ranges, 1, wxEXPAND);
    columns->Add(right, 0, wxEXPAND | wxTOP | wxRIGHT | wxBOTTOM, 10);

    auto* sizer {new wxBoxSizer(wxVERTICAL)};
    sizer->Add(columns, 1, wxEXPAND);
    sizer->Add(this->CreateButtonSizer(wxOK | wxCANCEL), 0, wxALIGN_RIGHT | wxRIGHT | wxBOTTOM, 10);
    this->SetSizerAndFit(sizer);
    this->Bind(wxEVT_BUTTON, [this](wxCommandEvent& e) { if (this->parse_ranges()) e.Skip(); }, wxID_OK);
}

bool LayerHeightsDialog::parse_ranges() {
    parsed.clear();
    std::istringstream lines(std::string(ranges->GetValue().ToUTF8().data()));
    std::string line;
    while (std::getline(lines, line)) {
        if (line.find_first_not_of(" \t\r") == std::string::npos) continue;
        std::istringstream fields(line);
        fields.imbue(std::locale::classic());  // a dot as the decimal point
        double from, to, height;
        std::string rest;
        if (!(fields >> from >> to >> height) || (fields >> rest) || from < 0 || to <= from || height <= 0) {
            show_error(this, wxString::Format(_("Not a height range: %s"), wxString::FromUTF8(line.c_str())));
            return false;
        }
        parsed[{from, to}] = height;
    }
    return true;
}

void LayerHeightsDialog::apply(ModelObject& object) const {
    object.layer_height_ranges = parsed;
    if (canvas != nullptr && canvas->changed) object.layer_height_spline = canvas->spline;
}

}} // namespace Slic3r::GUI
