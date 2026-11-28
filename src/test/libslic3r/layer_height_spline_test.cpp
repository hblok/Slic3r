#include <gtest/gtest.h>

#include <vector>

#include "LayerHeightSpline.hpp"

using namespace Slic3r;

namespace {

/// Ten layers of 0.2 mm on an object of 2 mm, as the slicer hands them over.
LayerHeightSpline even_layers() {
    LayerHeightSpline spline;
    spline.setObjectHeight(2.0);
    std::vector<coordf_t> layers;
    for (int i = 1; i <= 10; ++i) layers.push_back(0.2 * i);
    EXPECT_TRUE(spline.setLayers(layers));
    return spline;
}

} // namespace

TEST(LayerHeightSpline, IsEmptyUntilItHasLayers) {
    LayerHeightSpline spline;
    EXPECT_FALSE(spline.hasData());
    EXPECT_TRUE(spline.getInterpolatedLayers().empty());
}

TEST(LayerHeightSpline, KeepsEvenLayers) {
    LayerHeightSpline spline {even_layers()};
    EXPECT_TRUE(spline.hasData());
    EXPECT_TRUE(spline.layersUpdated());
    EXPECT_NEAR(spline.getLayerHeightAt(1.0), 0.2, 1e-6);
    const std::vector<coordf_t> layers {spline.getInterpolatedLayers()};
    ASSERT_GE(layers.size(), 10u);
    for (size_t i = 0; i < 10; ++i) EXPECT_NEAR(layers[i], 0.2 * (i + 1), 1e-6) << "layer " << i;
}

TEST(LayerHeightSpline, FollowsNewHeights) {
    LayerHeightSpline spline {even_layers()};
    EXPECT_TRUE(spline.updateLayerHeights(std::vector<coordf_t>(10, 0.1)));
    EXPECT_TRUE(spline.layerHeightsUpdated());
    EXPECT_NEAR(spline.getLayerHeightAt(1.0), 0.1, 1e-6);
}

TEST(LayerHeightSpline, RefusesTheWrongNumberOfHeights) {
    LayerHeightSpline spline {even_layers()};
    EXPECT_FALSE(spline.updateLayerHeights({0.1, 0.1}));
    EXPECT_NEAR(spline.getLayerHeightAt(1.0), 0.2, 1e-6);
}

TEST(LayerHeightSpline, CopiesAndClears) {
    LayerHeightSpline spline {even_layers()};
    LayerHeightSpline copy {spline};
    spline.clear();
    EXPECT_FALSE(spline.hasData());
    EXPECT_TRUE(copy.hasData());
    EXPECT_NEAR(copy.getLayerHeightAt(1.0), 0.2, 1e-6);
}
