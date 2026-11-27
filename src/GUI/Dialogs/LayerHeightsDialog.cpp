// Layer heights of one object: a curve to drag, and a table of height ranges.
#include "LayerHeightsDialog.hpp"

#include <algorithm>
#include <cmath>
#include <set>
#include <sstream>

#include <wx/dcbuffer.h>

#include "ExPolygon.hpp"
#include "Print.hpp"
#include "TriangleMesh.hpp"
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
    if (on_change) on_change();
}

void SplineCanvas::set_spline(const LayerHeightSpline& other) {
    spline = other;
    before = other;
    positions = spline.getOriginalLayers();
    heights.clear();
    for (const auto z : positions) heights.push_back(spline.getLayerHeightAt(z));
    changed = false;
    this->Refresh();
    if (on_change) on_change();
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
            if (on_change) on_change();
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

LayersCanvas::LayersCanvas(wxWindow* parent, const ModelObject& object) : ObjectCanvas(parent, object), mesh(object.raw_mesh()) {
    bb = mesh.bounding_box();
    const Pointf3 center {bb.center()};
    shift = Pointf3(-center.x, -center.y, -bb.min.z);
    mesh.repair();
    volumes.clear();
    GLVertexArray vertices;
    vertices.load_mesh(mesh);
    volumes.push_back(Volume {ui_settings->color->COLOR_PARTS(), shift, vertices, bb});
}

void LayersCanvas::show_layers(const std::vector<coordf_t>& heights) {
    std::vector<float> at;
    // cut just below each layer's top, where the mesh has a section
    for (const auto z : heights)
        if (z <= bb.size().z + 1e-6) at.push_back(static_cast<float>(bb.min.z + z - 1e-3));
    std::vector<ExPolygons> sections;
    TriangleMesh copy {mesh};
    if (!at.empty()) TriangleMeshSlicer<Z>(&copy).slice(at, &sections);
    lines.clear();
    for (size_t i = 0; i < sections.size(); ++i)
        for (const auto& section : sections[i])
            for (const auto& line : section.lines())
                for (const Point& p : {line.a, line.b}) lines.push_back(Pointf3(unscale(p.x), unscale(p.y), at[i]));
    Refresh();
}

void LayersCanvas::after_render() {
    glDisable(GL_LIGHTING);
    glLineWidth(1);
    glColor3ub(0, 0, 0);
    glBegin(GL_LINES);
    for (const auto& point : lines) glVertex3d(point.x + shift.x, point.y + shift.y, point.z + shift.z);
    glEnd();
    glEnable(GL_LIGHTING);
}

LayerHeightSpline LayerHeightsDialog::sliced_spline(double& min_height, double& max_height, double& height) {
    // the layers slicing would make, from a print of this object alone
    Slic3r::Print print;
    print.apply_config(this->print_config);
    print.auto_assign_extruders(this->object_copy);
    print.add_model_object(this->object_copy);
    PrintObject* sliced {print.objects.front()};
    sliced->prepare_layer_heights();
    min_height = 0;
    max_height = 1e6;
    for (const size_t extruder : print.object_extruders()) {
        min_height = std::max(min_height, print.config.min_layer_height.get_at(extruder));
        max_height = std::min(max_height, print.config.max_layer_height.get_at(extruder));
    }
    height = unscale(sliced->size.z);
    return sliced->layer_height_spline;
}

LayerHeightsDialog::LayerHeightsDialog(wxWindow* parent, const ModelObject& object, const DynamicPrintConfig& config) :
    wxDialog(parent, wxID_ANY, _("Layer heights"), wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER)
{
    this->print_config.apply(config);
    this->object_copy = this->alone.add_object(object);
    double min_height, max_height, height;
    LayerHeightSpline spline {this->sliced_spline(min_height, max_height, height)};

    auto* columns {new wxBoxSizer(wxHORIZONTAL)};
    view = new LayersCanvas(this, object);
    columns->Add(view, 2, wxEXPAND | wxLEFT | wxTOP | wxBOTTOM, 10);
    auto* left {new wxBoxSizer(wxVERTICAL)};
    if (spline.hasData()) {
        canvas = new SplineCanvas(this, spline, min_height, max_height, height);
        left->Add(canvas, 1, wxEXPAND);
        canvas->on_change = [this]() { view->show_layers(canvas->spline.getInterpolatedLayers()); };
        view->show_layers(canvas->spline.getInterpolatedLayers());
        auto* reset {new wxButton(this, wxID_ANY, _("Reset curve"))};
        reset->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { canvas->reset(); });
        left->Add(reset, 0, wxTOP, 5);
        // the quality of adaptive slicing, a setting of this object
        const DynamicPrintConfig& own {object.config};
        auto value = [&own, &config](const std::string& key) {
            return own.has(key) ? own.serialize(key) : config.has(key) ? config.serialize(key) : std::string("0");
        };
        quality_before = std::atoi(value("adaptive_slicing_quality").c_str());
        left->Add(new wxStaticText(this, wxID_ANY, _("Adaptive quality %")), 0, wxTOP, 8);
        quality = new wxSlider(this, wxID_ANY, quality_before, 0, 100, wxDefaultPosition, wxDefaultSize, wxSL_HORIZONTAL | wxSL_LABELS);
        quality->Enable(value("adaptive_slicing") == "1");
        quality->Bind(wxEVT_SLIDER, [this](wxCommandEvent&) {
            const std::string text {std::to_string(quality->GetValue())};
            this->object_copy->config.set_deserialize("adaptive_slicing_quality", text + "%");
            this->object_copy->layer_height_spline = LayerHeightSpline();
            double low, high, tall;
            canvas->set_spline(this->sliced_spline(low, high, tall));
        });
        left->Add(quality, 0, wxEXPAND);
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
    if (quality != nullptr && quality->GetValue() != quality_before) {
        object.config.set_deserialize("adaptive_slicing_quality", std::to_string(quality->GetValue()) + "%");
        object.layer_height_spline = LayerHeightSpline();  // sliced anew with it
    }
    if (canvas != nullptr && canvas->changed) object.layer_height_spline = canvas->spline;
}

}} // namespace Slic3r::GUI
