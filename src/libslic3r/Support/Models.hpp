#ifndef slic3r_Support_Models_hpp_
#define slic3r_Support_Models_hpp_

#include <memory>

#include "PrintConfig.hpp"
#include "Support/Model.hpp"

namespace Slic3r { namespace Support {

/// The model for the configured support style; null for the normal style, which
/// SupportMaterial builds itself. `extrusion_width`: that of the support, mm.
/// A new model: a value of support_material_style and a case here.
std::unique_ptr<Model> make_model(const PrintObjectConfig &config, double extrusion_width);

}}

#endif
