#ifndef BEDSHAPEDIALOG_HPP
#define BEDSHAPEDIALOG_HPP

#include <vector>

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif
#include <wx/choicebk.h>
#include <wx/spinctrl.h>

#include "Point.hpp"

namespace Slic3r { namespace GUI {

/// The print bed as drawn in the bed shape dialog (and the manual control of a printer):
/// outline, 1 cm grid, axes and origin; optionally a position that can be set by a click.
class Bed2D : public wxPanel {
public:
    explicit Bed2D(wxWindow* parent);
    void set_shape(const std::vector<Pointf>& shape) { this->_shape = shape; this->Refresh(); }
    const std::vector<Pointf>& shape() const { return this->_shape; }
    /// Mark a position (in bed coordinates).
    void set_position(const Pointf& position) { this->_position = position; this->_has_position = true; this->Refresh(); }
    /// Set: the bed can be clicked and dragged on.
    std::function<void(const Pointf&)> on_move {nullptr};
private:
    std::vector<Pointf> _shape {};
    Pointf _position {};
    bool _has_position {false};
    double _scale {1};
    Pointf _shift {};
    wxPoint _to_pixels(const Pointf& point) const;
    void _repaint();
};

/// Choose the bed's shape: a rectangle, a circle, or the outline of a model's projection.
class BedShapeDialog : public wxDialog {
public:
    BedShapeDialog(wxWindow* parent, const std::vector<Pointf>& shape);
    std::vector<Pointf> shape() const { return this->_bed->shape(); }
private:
    wxChoicebook* _book {nullptr};
    wxSpinCtrlDouble* _size[2] {};
    wxSpinCtrlDouble* _origin[2] {};
    wxSpinCtrlDouble* _diameter {nullptr};
    Bed2D* _bed {nullptr};
    void _set_shape(const std::vector<Pointf>& shape);
    void _update_shape();
    void _load_model();
};

}} // namespace Slic3r::GUI
#endif
