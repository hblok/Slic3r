#ifndef PROJECTORSCREEN_HPP
#define PROJECTORSCREEN_HPP

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif

#include "ExPolygon.hpp"
#include "PrintConfig.hpp"
#include "SLAPrint.hpp"

namespace Slic3r { namespace GUI {

/// The projection's settings, kept in DLP.ini in the data directory.
struct ProjectorSettings {
    int display {0};
    bool show_bed {true}, invert_y {false};
    double zoom {100};                       ///< percent of the size that fills the screen
    double exposure_time {2}, bottom_exposure_time {7}, settle_time {1.5};  ///< seconds
    int bottom_layers {3};
    double z_lift {5}, z_lift_speed {8};     ///< mm, mm/s
    double offset_x {0}, offset_y {0};       ///< mm
    void load(const wxString& file);
    void save(const wxString& file) const;
};

/// The window shown by the projector: black, with the bed's grid and one layer in white.
class ProjectorScreen : public wxFrame {
public:
    ProjectorScreen();
    /// What to draw from; null pointers leave the screen black.
    void set_source(const SLAPrint* print, const std::vector<Pointf>& bed, const ProjectorSettings* settings);
    /// Cover the chosen display.
    void reposition();
    /// A layer, or -1 for none (the bed, when shown).
    void project(int layer);
    int layer() const { return this->_layer; }
private:
    const SLAPrint* _print {nullptr};
    const ProjectorSettings* _settings {nullptr};
    std::vector<Pointf> _bed {};
    int _layer {-1};
    wxWindow* _canvas {nullptr};
    void _paint();
};

}} // namespace Slic3r::GUI
#endif
