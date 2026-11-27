#ifndef PREVIEWPANEL_HPP
#define PREVIEWPANEL_HPP
#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif

#include <functional>
#include <memory>
#include <vector>

#include "Print.hpp"

namespace Slic3r { namespace GUI {

/// What an extrusion belongs to, for its colour.
enum class PreviewRole { Perimeter, Infill, Support, Skirt };

/// A sliced print seen one height at a time: a canvas and a layer slider. The 3D preview
/// and the 2D toolpaths derive from it.
class PreviewPanel : public wxPanel {
public:
    explicit PreviewPanel(wxWindow* parent);
    /// The print to show, with all its steps done; nullptr shows nothing.
    void set_print(std::shared_ptr<Slic3r::Print> new_print);

    /// One extrusion path or loop (a loop's paths together), in the coordinates of one
    /// copy: add `shift` (scaled) to its points. `extruder` counts from 1.
    using Visitor = std::function<void (PreviewRole, const std::vector<const ExtrusionPath*>&, bool closed, const Point& shift, int extruder)>;

    /// Draw the shown print again (the colours have changed).
    void reload();

protected:
    /// Puts the canvas to the left of the slider (call once, from the constructor).
    void attach(wxWindow* canvas);
    /// The print changed (print may be null).
    virtual void load() = 0;
    /// Show level `level` (an index into levels()).
    virtual void show_level(size_t level) = 0;

    size_t level_count() const { return levels.size(); }
    double level_z(size_t level) const { return levels.at(level).z; }
    /// Everything extruded at a level: object and support layers, skirt and brim.
    void visit_level(size_t level, const Visitor& visit) const;
    /// The object layers (with slices) at a level.
    const std::vector<std::pair<const PrintObject*, const Layer*>>& layers_at(size_t level) const { return levels.at(level).layers; }

    std::shared_ptr<Slic3r::Print> print;

private:
    struct Level {
        double z;
        std::vector<std::pair<const PrintObject*, const Layer*>> layers;
    };
    std::vector<Level> levels;
    wxSlider* slider {nullptr};
    wxStaticText* z_label {nullptr};
    void select_level(size_t level);
};

} } // Namespace Slic3r::GUI
#endif
