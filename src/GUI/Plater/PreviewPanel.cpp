#include "PreviewPanel.hpp"

#include <algorithm>
#include <map>

#include "ExtrusionEntityCollection.hpp"
#include "Layer.hpp"

namespace Slic3r { namespace GUI {

namespace {

/// `solid`: the extruder of solid infill, where it differs.
void visit_entity(const ExtrusionEntity& entity, PreviewRole role, const Point& shift, const PreviewPanel::Visitor& visit,
        int extruder, int solid = 0) {
    if (entity.is_collection()) {
        for (const auto* child : static_cast<const ExtrusionEntityCollection&>(entity).entities)
            visit_entity(*child, role, shift, visit, extruder, solid);
    } else if (entity.is_loop()) {
        std::vector<const ExtrusionPath*> paths;
        for (const auto& path : static_cast<const ExtrusionLoop&>(entity).paths) paths.push_back(&path);
        visit(role, paths, true, shift, extruder);
    } else if (const auto* path = dynamic_cast<const ExtrusionPath*>(&entity)) {
        visit(role, {path}, false, shift, solid > 0 && path->is_solid_infill() ? solid : extruder);
    }
}

} // namespace

PreviewPanel::PreviewPanel(wxWindow* parent) :
    wxPanel(parent, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL)
{
    // a non-zero maximum: GTK refuses an empty range
    slider = new wxSlider(this, wxID_ANY, 0, 0, 1, wxDefaultPosition, wxDefaultSize, wxVERTICAL | wxSL_INVERSE);
    z_label = new wxStaticText(this, wxID_ANY, "", wxDefaultPosition, wxSize(40, -1), wxALIGN_CENTRE_HORIZONTAL);
    slider->Bind(wxEVT_SLIDER, [this](wxCommandEvent&) { this->select_level(slider->GetValue()); });
    // U and D (or the arrows) go a layer up and down, as in the Perl GUI
    this->Bind(wxEVT_CHAR_HOOK, [this](wxKeyEvent& e) {
        const int key {e.GetKeyCode()};
        const int step {key == 'U' || key == WXK_UP ? 1 : key == 'D' || key == WXK_DOWN ? -1 : 0};
        const int value {slider->GetValue() + step};
        if (step == 0 || levels.empty()) {
            e.Skip();
        } else if (value >= 0 && value < static_cast<int>(levels.size())) {
            slider->SetValue(value);
            this->select_level(value);
        }
    });
    slider->Hide();
}

void PreviewPanel::attach(wxWindow* canvas) {
    auto* vsizer {new wxBoxSizer(wxVERTICAL)};
    vsizer->Add(slider, 1, wxALL | wxEXPAND, 3);
    vsizer->Add(z_label, 0, wxALL | wxEXPAND, 3);
    auto* sizer {new wxBoxSizer(wxHORIZONTAL)};
    sizer->Add(canvas, 1, wxEXPAND, 0);
    sizer->Add(vsizer, 0, wxTOP | wxBOTTOM | wxEXPAND, 5);
    this->SetSizer(sizer);
}

void PreviewPanel::set_print(std::shared_ptr<Slic3r::Print> new_print) {
    if (new_print == this->print) return;

    // keep the height the slider was at; the top stays the top
    const bool at_top {levels.empty() || slider->GetValue() >= static_cast<int>(levels.size()) - 1};
    const double old_z {at_top ? 0 : levels.at(slider->GetValue()).z};

    this->print = new_print;
    levels.clear();
    if (print != nullptr) {
        // heights that differ by rounding only are one level
        std::map<long long, Level> by_height;
        auto add = [&by_height](const PrintObject* object, const Layer* layer) {
            auto& level {by_height[std::llround(layer->print_z * 1e5)]};
            level.z = layer->print_z;
            level.layers.emplace_back(object, layer);
        };
        for (const auto* object : print->objects) {
            for (const auto* layer : object->layers) add(object, layer);
            for (const auto* layer : object->support_layers) add(object, layer);
        }
        for (auto& level : by_height) levels.push_back(std::move(level.second));
    }

    this->load();

    if (levels.empty()) {
        slider->Hide();
        z_label->SetLabel("");
        this->show_level(0);
        return;
    }
    const int top {static_cast<int>(levels.size()) - 1};
    int value {top};
    if (!at_top) {
        value = 0;
        while (value < top && levels.at(value).z < old_z - 1e-5) ++value;
    }
    slider->SetRange(0, std::max(top, 1));
    slider->SetValue(value);
    slider->Show();
    this->Layout();
    this->select_level(value);
}

void PreviewPanel::reload() {
    this->load();
    if (!levels.empty()) this->select_level(slider->GetValue());
}

void PreviewPanel::select_level(size_t level) {
    if (levels.empty()) return;
    level = std::min(level, levels.size() - 1);
    z_label->SetLabel(wxString::Format("%.2f", levels.at(level).z));
    this->show_level(level);
}

void PreviewPanel::visit_level(size_t level, const Visitor& visit) const {
    if (print == nullptr || level >= levels.size()) return;
    // skirt and brim are stored once, in print coordinates, and printed on the first layers
    const int brim_extruder {print->regions.empty() ? 1 : static_cast<int>(print->brim_extruder())};
    if (level == 0) visit_entity(print->brim, PreviewRole::Skirt, Point(0, 0), visit, brim_extruder);
    size_t skirt_levels {static_cast<size_t>(std::max(0, print->config.skirt_height.value))};
    if (print->config.brim_width > 0) skirt_levels = std::max(skirt_levels, size_t(1));
    if (print->has_infinite_skirt() || level < skirt_levels)
        visit_entity(print->skirt, PreviewRole::Skirt, Point(0, 0), visit, brim_extruder);

    for (const auto& entry : levels.at(level).layers) {
        const Layer* layer {entry.second};
        const PrintObjectConfig& object {entry.first->config};
        for (const auto& shift : entry.first->_shifted_copies) {
            for (auto* region : layer->regions) {
                const PrintRegionConfig& config {region->region()->config};
                visit_entity(region->perimeters, PreviewRole::Perimeter, shift, visit, config.perimeter_extruder);
                visit_entity(region->fills, PreviewRole::Infill, shift, visit, config.infill_extruder,
                    config.solid_infill_extruder);
            }
            if (const auto* support = dynamic_cast<const SupportLayer*>(layer)) {
                visit_entity(support->support_fills, PreviewRole::Support, shift, visit, object.support_material_extruder);
                visit_entity(support->support_interface_fills, PreviewRole::Support, shift, visit,
                    object.support_material_interface_extruder);
            }
        }
    }
}

} } // Namespace Slic3r::GUI
