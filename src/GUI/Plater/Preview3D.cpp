#include "Preview3D.hpp"
#include "Layer.hpp"
#include "misc_ui.hpp"

namespace Slic3r { namespace GUI {

void PreviewScene3D::loaded(const Slic3r::Print* print, double height) {
    shown_level = 0;
    content_bb = BoundingBoxf3();
    if (print != nullptr) {
        set_bed_shape(Slic3r::Polygon::new_scale(print->config.bed_shape.values).points);
        const BoundingBox bb {print->total_bounding_box()};
        content_bb.merge(Pointf3(unscale(bb.min.x), unscale(bb.min.y), 0));
        content_bb.merge(Pointf3(unscale(bb.max.x), unscale(bb.max.y), height));
    }
    dirty = true;  // fit the view again (unless the user moved it)
}

void PreviewScene3D::show(size_t level) {
    shown_level = level;
    Refresh();
}

void PreviewScene3D::after_render() {
    glEnableClientState(GL_VERTEX_ARRAY);
    glEnableClientState(GL_NORMAL_ARRAY);
    glCullFace(GL_BACK);
    for (size_t i = 0; i < toolpaths.size(); ++i) {
        const auto& group {toolpaths[i]};
        if (shown_level >= group.quads_end.size()) continue;
        glColor3ub(group.colour.Red(), group.colour.Green(), group.colour.Blue());
        auto draw = [](GLenum mode, const GLVertexArray& vertices, size_t floats) {
            if (floats == 0) return;
            glVertexPointer(3, GL_FLOAT, 0, vertices.verts.data());
            glNormalPointer(GL_FLOAT, 0, vertices.norms.data());
            glDrawArrays(mode, 0, floats / 3);
        };
        draw(GL_QUADS, group.quads, group.quads_end[shown_level]);
        draw(GL_TRIANGLES, group.triangles, group.triangles_end[shown_level]);
    }
    glDisableClientState(GL_NORMAL_ARRAY);
    glDisableClientState(GL_VERTEX_ARRAY);
}

Preview3D::Preview3D(wxWindow* parent) : PreviewPanel(parent), canvas(new PreviewScene3D(this)) {
    this->attach(canvas);
}

void Preview3D::load() {
    // by role, or (preference) by the filament of the extruder that prints it
    std::vector<wxColour> colours;
    const bool by_extruder {ui_settings->color_toolpaths_by == PathColor::extruder && print != nullptr};
    if (by_extruder)
        for (const auto& text : print->config.filament_colour.values) {
            wxColour colour;
            if (!colour.Set(wxString::FromUTF8(text.c_str()))) colour = ui_settings->color->COLOR_PARTS();
            colours.push_back(colour);
        }
    if (colours.empty())
        colours = {ui_settings->color->COLOR_PARTS(), ui_settings->color->COLOR_INFILL(), ui_settings->color->COLOR_SUPPORT()};
    canvas->toolpaths.assign(colours.size(), {});
    for (size_t i = 0; i < colours.size(); ++i) canvas->toolpaths[i].colour = colours[i];
    double height {0};
    for (size_t level = 0; level < level_count(); ++level) {
        const double z {layers_at(level).front().second->print_z};
        height = z;
        this->visit_level(level, [this, z, by_extruder](PreviewRole role, const std::vector<const ExtrusionPath*>& paths,
                bool closed, const Point& shift, int extruder) {
            Lines lines;
            std::vector<double> widths, heights;
            for (const auto* path : paths) {
                Polyline polyline {path->polyline};
                polyline.remove_duplicate_points();  // the vertex code refuses empty lines
                polyline.translate(shift.x, shift.y);
                for (const auto& line : polyline.lines()) {
                    lines.push_back(line);
                    widths.push_back(path->width);
                    heights.push_back(path->height);
                }
            }
            const size_t group {by_extruder ? static_cast<size_t>(std::max(extruder, 1) - 1) % canvas->toolpaths.size()
                : role == PreviewRole::Infill ? 1u : role == PreviewRole::Support ? 2u : 0u};
            auto& out {canvas->toolpaths[group]};
            _3DScene::_extrusionentity_to_verts_do(lines, widths, heights, closed, z, shift, &out.quads, &out.triangles);
        });
        for (auto& group : canvas->toolpaths) {
            group.quads_end.push_back(group.quads.verts.size());
            group.triangles_end.push_back(group.triangles.verts.size());
        }
    }
    canvas->loaded(print.get(), height);
}

} } // Namespace Slic3r::GUI
