#ifndef PREVIEW3D_HPP
#define PREVIEW3D_HPP

#include <array>

#include "PreviewPanel.hpp"
#include "Scene3D.hpp"

namespace Slic3r { namespace GUI {

/// The toolpaths as solid extrusions, drawn up to a chosen level.
class PreviewScene3D : public Scene3D {
public:
    explicit PreviewScene3D(wxWindow* parent) : Scene3D(parent, wxDefaultSize) {}

    /// All extrusions of one colour, lowest level first.
    struct Toolpaths {
        GLVertexArray quads, triangles;
        /// per level: the number of floats up to and including that level
        std::vector<size_t> quads_end, triangles_end;
    };
    std::array<Toolpaths, 3> toolpaths;  ///< perimeters (and skirt), infill, support

    /// Takes the bed from the print and fits the view to it; call after filling toolpaths.
    void loaded(const Slic3r::Print* print, double height);
    void show(size_t level);
protected:
    void after_render() override;
private:
    size_t shown_level {0};
};

class Preview3D : public PreviewPanel {
public:
    explicit Preview3D(wxWindow* parent);
protected:
    void load() override;
    void show_level(size_t level) override { canvas->show(level); }
private:
    PreviewScene3D* canvas;
};

} } // Namespace Slic3r::GUI
#endif
