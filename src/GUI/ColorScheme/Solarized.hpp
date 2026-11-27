#ifndef SOLARIZED_HPP
#define SOLARIZED_HPP
#include <wx/colour.h>

#include "ColorScheme/ColorSchemeBase.hpp"

namespace Slic3r { namespace GUI {

/// S O L A R I Z E
/// http://ethanschoonover.com/solarized
///
/// The Perl GUI's "getSolarized" scheme (ColorScheme.pm).
class Solarized : public ColorScheme {
public:
    const std::string name() const { return "Solarized"; }
    const bool SOLID_BACKGROUNDCOLOR() const { return true; }
    const wxColour SELECTED_COLOR() const { return wxColour(211, 54, 130); }
    const wxColour HOVER_COLOR() const { return wxColour(109, 114, 197); }
    const wxColour TOP_COLOR() const { return wxColour(254, 247, 228); }
    const wxColour BOTTOM_COLOR() const { return wxColour(254, 247, 228); }
    const wxColour BACKGROUND_COLOR() const { return wxColour(254, 247, 228); }
    const wxColour GRID_COLOR() const { return wxColour(147, 161, 161, 102); }
    const wxColour GROUND_COLOR() const { return wxColour(238, 232, 213, 102); }
    const wxColour COLOR_CUTPLANE() const { return wxColour(147, 161, 161, 127); }
    const wxColour COLOR_PARTS() const { return wxColour(230, 230, 230); }
    const wxColour COLOR_INFILL() const { return wxColour(238, 232, 213); }
    const wxColour COLOR_SUPPORT() const { return wxColour(0, 0, 0); }
    const wxColour COLOR_UNKNOWN() const { return wxColour(43, 161, 153); }
    const wxColour BED_COLOR() const { return wxColour(238, 232, 213); }
    const wxColour BED_GRID() const { return wxColour(147, 161, 161); }
    const wxColour BED_SELECTED() const { return wxColour(181, 137, 0); }
    const wxColour BED_OBJECTS() const { return wxColour(230, 230, 230); }
    const wxColour BED_INSTANCE() const { return wxColour(211, 54, 130); }
    const wxColour BED_DRAGGED() const { return wxColour(43, 161, 153); }
    const wxColour BED_CENTER() const { return wxColour(147, 161, 161); }
    const wxColour BED_SKIRT() const { return wxColour(89, 110, 117); }
    const wxColour BED_CLEARANCE() const { return wxColour(39, 140, 211); }
    const wxColour BACKGROUND255() const { return wxColour(254, 247, 228); }
    const wxColour TOOL_DARK() const { return wxColour(89, 110, 117); }
    const wxColour TOOL_SUPPORT() const { return wxColour(134, 153, 0); }
    const wxColour TOOL_INFILL() const { return wxColour(147, 161, 161); }
    const wxColour TOOL_STEPPERIM() const { return wxColour(43, 161, 153); }
    const wxColour TOOL_SHADE() const { return wxColour(238, 232, 213); }
    const wxColour TOOL_COLOR() const { return wxColour(39, 140, 211); }
    const wxColour SPLINE_L_PEN() const { return wxColour(89, 110, 117); }
    const wxColour SPLINE_O_PEN() const { return wxColour(147, 161, 161); }
    const wxColour SPLINE_I_PEN() const { return wxColour(211, 54, 130); }
    const wxColour SPLINE_R_PEN() const { return wxColour(109, 114, 197); }
    const wxColour BED_DARK() const { return wxColour(89, 110, 117); }
};
}} // namespace Slic3r::GUI


#endif // SOLARIZED_HPP
