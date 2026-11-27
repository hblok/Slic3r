#ifndef PREVIEW2D_HPP
#define PREVIEW2D_HPP

#include "PreviewPanel.hpp"

namespace Slic3r { namespace GUI {

/// One level's toolpaths seen from above, as thin lines over the slices. The wheel zooms,
/// dragging moves, a double click fits the print again.
class Preview2D : public PreviewPanel {
public:
    explicit Preview2D(wxWindow* parent);
    void zoom_by(double factor) { zoom *= factor; pan = {pan.m_x * factor, pan.m_y * factor}; canvas->Refresh(); }
protected:
    void load() override { canvas->Refresh(); }
    void show_level(size_t level) override;
private:
    wxPanel* canvas;
    size_t level {0};
    double zoom {1};
    wxPoint2DDouble pan {0, 0};  ///< pixels from the canvas center to the print's center
    wxPoint drag_from;
    void paint();
};

} } // Namespace Slic3r::GUI
#endif
