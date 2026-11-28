#ifndef slic3r_Support_TreeModel_hpp_
#define slic3r_Support_TreeModel_hpp_

#include <memory>
#include <vector>

#include "Support/Model.hpp"
#include "Support/TreeGrowth.hpp"
#include "Support/TreeTips.hpp"

namespace Slic3r { namespace Support {

/// Tree supports, from the top down: tips start under whatever of a roof has nothing below
/// it, travel down as the growth says, and print as discs.
class TreeModel : public Model {
public:
    struct Settings {
        double gap {0.5};          ///< between branch and model, mm
        double slope {0.84};       ///< sideways per height; the growth must use the same
        double tip_radius {0.7};   ///< mm
        double tip_spacing {3};    ///< mm: no new tip where a branch passes within half of this
        double foot {1.5};         ///< mm added around branches on the first layer, to hold on
        double sliver {0.1};       ///< mm: undersides thinner than twice this are ignored
    };
    TreeModel(const Settings &settings, std::unique_ptr<TipPlacer> tips, std::unique_ptr<Growth> growth);
    std::vector<Polygons> base(const std::vector<Slab> &slabs) const override;
    bool infill() const override { return false; }  // branches are tubes

private:
    Settings settings;
    std::unique_ptr<TipPlacer> tips;
    std::unique_ptr<Growth> growth;

    void plant(std::vector<Node> &nodes, const std::vector<Slab> &slabs, size_t i, Obstacles &obstacles) const;
};

}}

#endif
