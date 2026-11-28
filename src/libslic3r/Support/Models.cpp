#include "Support/Models.hpp"

#include <algorithm>
#include <cmath>

#include "Support/TreeModel.hpp"

namespace Slic3r { namespace Support {

namespace {

std::unique_ptr<Model>
make_tree(const PrintObjectConfig &config, double width)
{
    // the command line does not hold these to their limits
    const double angle {std::min(60.0, std::max(0.0, config.support_material_tree_angle.value))};

    MergingGrowth::Settings growth;
    growth.slope = std::tan(angle * PI / 180);
    growth.tip_radius = 1.5 * width;
    growth.max_radius = std::max(growth.tip_radius, config.support_material_tree_branch_diameter.value / 2);

    TreeModel::Settings tree;
    tree.gap = width;
    tree.slope = growth.slope;
    tree.tip_radius = growth.tip_radius;
    tree.tip_spacing = std::max(1.0, config.support_material_tree_tip_spacing.value);
    tree.sliver = width / 4;

    return std::make_unique<TreeModel>(tree, std::make_unique<GridTips>(tree.tip_spacing),
        std::make_unique<MergingGrowth>(growth));
}

} // namespace

std::unique_ptr<Model>
make_model(const PrintObjectConfig &config, double extrusion_width)
{
    switch (config.support_material_style.value) {
        case smsTree: return make_tree(config, extrusion_width);
        case smsNormal: break;
    }
    return nullptr;
}

}}
