#ifndef slic3r_Support_Model_hpp_
#define slic3r_Support_Model_hpp_

#include <vector>

#include "Polygon.hpp"

namespace Slic3r { namespace Support {

/// One support layer as a support model sees it.
struct Slab {
    double z {0};       ///< print height of its top, mm
    double height {0};  ///< mm
    Polygons object;    ///< the model's outline within this height
    Polygons roof;      ///< contact and interface areas on this layer: what has to be held
};

/// A way of building up to the roofs from below. Overhang detection, interface layers and
/// toolpaths are SupportMaterial's; a model only decides what stands under them.
class Model {
public:
    virtual ~Model() = default;
    /// The areas to print as support base: one entry per slab, in the same order (bottom
    /// first). Areas reaching into the model are cut away afterwards.
    virtual std::vector<Polygons> base(const std::vector<Slab> &slabs) const = 0;
};

}}

#endif
