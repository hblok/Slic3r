#ifndef LAYERHEIGHTSDIALOG_HPP
#define LAYERHEIGHTSDIALOG_HPP

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif

#include <vector>

#include <wx/slider.h>

#include "LayerHeightSpline.hpp"
#include "Model.hpp"
#include "PrintConfig.hpp"
#include "ObjectCutDialog.hpp"

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
    /// Another curve (of the same object), e.g. after a change of the adaptive quality.
    void set_spline(const LayerHeightSpline& other);
    /// Called after the curve has changed.
    std::function<void()> on_change {nullptr};
private:
    LayerHeightSpline before;               ///< as the dialog was opened, drawn for reference
    std::vector<coordf_t> positions;        ///< the Z of the layers the curve is made of
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

/// The object with a line round it at every layer.
class LayersCanvas : public ObjectCanvas {
public:
    LayersCanvas(wxWindow* parent, const ModelObject& object);
    void show_layers(const std::vector<coordf_t>& heights);
protected:
    void after_render() override;
private:
    TriangleMesh mesh;
    std::vector<Pointf3> lines {};
};

/// Draw the object's layer heights and set height ranges.
class LayerHeightsDialog : public wxDialog {
public:
    LayerHeightsDialog(wxWindow* parent, const ModelObject& object, const DynamicPrintConfig& config);
    /// Put what was changed into the object.
    void apply(ModelObject& object) const;
private:
    SplineCanvas* canvas {nullptr};
    LayersCanvas* view {nullptr};
    wxSlider* quality {nullptr};
    int quality_before {0};
    ModelObject* object_copy {nullptr};   ///< in `alone`, for slicing it again
    Slic3r::Model alone {};
    DynamicPrintConfig print_config {};
    /// The curve slicing would make with the current settings.
    LayerHeightSpline sliced_spline(double& min_height, double& max_height, double& height);
    wxTextCtrl* ranges;
    t_layer_height_ranges parsed;
    /// The ranges' text into `parsed`; false (after saying why) when it is not valid.
    bool parse_ranges();
};

}} // namespace Slic3r::GUI
#endif // LAYERHEIGHTSDIALOG_HPP
