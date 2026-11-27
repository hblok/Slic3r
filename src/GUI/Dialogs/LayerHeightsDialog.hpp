#ifndef LAYERHEIGHTSDIALOG_HPP
#define LAYERHEIGHTSDIALOG_HPP

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif

#include <vector>

#include "LayerHeightSpline.hpp"
#include "Model.hpp"
#include "PrintConfig.hpp"

namespace Slic3r { namespace GUI {

/// The layer height over the object's height as a curve to drag: height up, thickness to
/// the right. Left drag bends the curve around the starting point, right drag sets one
/// thickness over the dragged range (as the Perl GUI).
class SplineCanvas : public wxPanel {
public:
    SplineCanvas(wxWindow* parent, const LayerHeightSpline& spline, double min_height, double max_height, double object_height);
    LayerHeightSpline spline;   ///< with what has been drawn so far
    bool changed {false};
    /// Back to the heights slicing would choose.
    void reset();
private:
    LayerHeightSpline before;               ///< as the dialog was opened, drawn for reference
    const std::vector<coordf_t> positions;  ///< the Z of the layers the curve is made of
    std::vector<coordf_t> heights;          ///< the thickness at each of them
    const double min_height, max_height, object_height;
    bool dragging {false};
    double start_z {0};
    std::vector<coordf_t> at_start;         ///< heights when the drag began

    void paint();
    void drag(const wxMouseEvent& e);
    /// Canvas pixels of a (thickness, Z) and back, both limited to the plot.
    wxPoint to_pixel(double thickness, double z) const;
    void from_pixel(const wxPoint& at, double& thickness, double& z) const;
    void draw_curve(wxDC& dc, LayerHeightSpline& what);
};

/// Draw the object's layer heights and set height ranges.
class LayerHeightsDialog : public wxDialog {
public:
    LayerHeightsDialog(wxWindow* parent, const ModelObject& object, const DynamicPrintConfig& config);
    /// Put what was changed into the object.
    void apply(ModelObject& object) const;
private:
    SplineCanvas* canvas {nullptr};
    wxTextCtrl* ranges;
    t_layer_height_ranges parsed;
    /// The ranges' text into `parsed`; false (after saying why) when it is not valid.
    bool parse_ranges();
};

}} // namespace Slic3r::GUI
#endif // LAYERHEIGHTSDIALOG_HPP
