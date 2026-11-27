#include "Dialogs/PresetEditor.hpp"

#include <algorithm>

namespace Slic3r { namespace GUI {

PrintEditor::PrintEditor(wxWindow* parent, t_config_option_keys options) : 
    PresetEditor(parent, options) {
    
    this->config = Slic3r::Config::new_from_defaults(this->my_options());
    this->_build();
    this->update_tree();
    this->load_presets();
}

// The Perl GUI's pages (PresetEditor::Print::build).
void PrintEditor::_build() {
    {
        auto* page {this->add_options_page(_("Layers and perimeters"), "layers.png")};
        auto layers {this->add_group(page, _("Layer height"))};
        for (const char* key : {"layer_height", "first_layer_height", "adaptive_slicing", "adaptive_slicing_quality",
                "match_horizontal_surfaces"})
            this->add_option(layers, key);
        auto vertical {this->add_group(page, _("Vertical shells"))};
        for (const char* key : {"perimeters", "min_shell_thickness", "spiral_vase"}) this->add_option(vertical, key);
        auto horizontal {this->add_group(page, _("Horizontal shells"))};
        this->add_line(horizontal, _("Solid layers"), {"top_solid_layers", "bottom_solid_layers"});
        this->add_option(horizontal, "min_top_bottom_shell_thickness");
        auto quality {this->add_group(page, _("Quality (slower slicing)"))};
        for (const char* key : {"extra_perimeters", "avoid_crossing_perimeters", "thin_walls", "overhangs"})
            this->add_option(quality, key);
        auto advanced {this->add_group(page, _("Advanced"))};
        for (const char* key : {"seam_position", "external_perimeters_first"}) this->add_option(advanced, key);
        auto fuzzy {this->add_group(page, _("Fuzzy skin"))};
        for (const char* key : {"fuzzy_skin", "fuzzy_skin_thickness", "fuzzy_skin_point_dist"})
            this->add_option(fuzzy, key);
    }
    {
        auto* page {this->add_options_page(_("Infill"), "infill.png")};
        auto infill {this->add_group(page, _("Infill"))};
        this->add_option(infill, "fill_density");
        this->add_option(infill, "fill_pattern", -1, 180);
        this->add_line(infill, _("External infill pattern"), {"top_infill_pattern", "bottom_infill_pattern"});
        auto ironing {this->add_group(page, _("Ironing"))};
        for (const char* key : {"ironing", "ironing_flowrate", "ironing_spacing"}) this->add_option(ironing, key);
        auto reducing {this->add_group(page, _("Reducing printing time"))};
        for (const char* key : {"infill_every_layers", "infill_only_where_needed"}) this->add_option(reducing, key);
        auto advanced {this->add_group(page, _("Advanced"))};
        for (const char* key : {"fill_gaps", "solid_infill_every_layers", "fill_angle", "solid_infill_below_area",
                "only_retract_when_crossing_perimeters", "infill_first"})
            this->add_option(advanced, key);
    }
    {
        auto* page {this->add_options_page(_("Skirt and brim"), "box.png")};
        auto skirt {this->add_group(page, _("Skirt"))};
        for (const char* key : {"skirts", "skirt_distance", "skirt_height", "min_skirt_length"})
            this->add_option(skirt, key);
        auto brim {this->add_group(page, _("Brim"))};
        for (const char* key : {"brim_width", "brim_ears", "brim_ears_max_angle", "interior_brim_width",
                "brim_connections_width"})
            this->add_option(brim, key);
    }
    {
        auto* page {this->add_options_page(_("Support material"), "building.png")};
        auto support {this->add_group(page, _("Support material"))};
        for (const char* key : {"support_material", "support_material_threshold", "support_material_max_layers",
                "support_material_enforce_layers"})
            this->add_option(support, key);
        auto raft {this->add_group(page, _("Raft"))};
        this->add_option(raft, "raft_layers");
        auto options {this->add_group(page, _("Options for support material and raft"))};
        for (const char* key : {"support_material_contact_distance", "support_material_pattern",
                "support_material_spacing", "support_material_angle", "support_material_pillar_size",
                "support_material_pillar_spacing", "support_material_interface_layers",
                "support_material_interface_spacing", "support_material_buildplate_only", "dont_support_bridges"})
            this->add_option(options, key);
    }
    {
        auto* page {this->add_options_page(_("Speed"), "time.png")};
        auto print {this->add_group(page, _("Speed for print moves"))};
        for (const char* key : {"perimeter_speed", "small_perimeter_speed", "external_perimeter_speed",
                "infill_speed", "solid_infill_speed", "top_solid_infill_speed", "gap_fill_speed", "bridge_speed",
                "support_material_speed", "support_material_interface_speed"})
            this->add_option(print, key, -1, 110);
        auto travel {this->add_group(page, _("Speed for non-print moves"))};
        this->add_option(travel, "travel_speed");
        auto modifiers {this->add_group(page, _("Modifiers"))};
        this->add_option(modifiers, "first_layer_speed");
        auto acceleration {this->add_group(page, _("Acceleration control (advanced)"))};
        for (const char* key : {"perimeter_acceleration", "infill_acceleration", "bridge_acceleration",
                "first_layer_acceleration", "default_acceleration"})
            this->add_option(acceleration, key);
        auto autospeed {this->add_group(page, _("Autospeed (advanced)"))};
        for (const char* key : {"max_print_speed", "max_volumetric_speed"}) this->add_option(autospeed, key);
    }
    {
        auto* page {this->add_options_page(_("Multiple extruders"), "funnel.png")};
        auto extruders {this->add_group(page, _("Extruders"))};
        for (const char* key : {"perimeter_extruder", "infill_extruder", "solid_infill_extruder",
                "support_material_extruder", "support_material_interface_extruder"})
            this->add_option(extruders, key);
        auto ooze {this->add_group(page, _("Ooze prevention"))};
        for (const char* key : {"ooze_prevention", "standby_temperature_delta"}) this->add_option(ooze, key);
        auto advanced {this->add_group(page, _("Advanced"))};
        for (const char* key : {"regions_overlap", "interface_shells"}) this->add_option(advanced, key);
    }
    {
        auto* page {this->add_options_page(_("Advanced"), "wand.png")};
        auto width {this->add_group(page, _("Extrusion width"), 180)};
        for (const char* key : {"extrusion_width", "first_layer_extrusion_width", "perimeter_extrusion_width",
                "external_perimeter_extrusion_width", "infill_extrusion_width", "solid_infill_extrusion_width",
                "top_infill_extrusion_width", "support_material_interface_extrusion_width",
                "support_material_extrusion_width"})
            this->add_option(width, key, -1, 110);
        auto overlap {this->add_group(page, _("Overlap"))};
        this->add_option(overlap, "infill_overlap");
        auto flow {this->add_group(page, _("Flow"))};
        this->add_option(flow, "bridge_flow_ratio");
        auto other {this->add_group(page, _("Other"))};
        for (const char* key : {"xy_size_compensation", "resolution"}) this->add_option(other, key);
    }
    {
        auto* page {this->add_options_page(_("Output options"), "page_white_go.png")};
        auto sequential {this->add_group(page, _("Sequential printing"))};
        this->add_option(sequential, "complete_objects");
        this->add_line(sequential, _("Extruder clearance (mm)"), {"extruder_clearance_radius", "extruder_clearance_height"});
        auto output {this->add_group(page, _("Output file"))};
        this->add_option(output, "gcode_comments");
        this->add_option(output, "label_printed_objects");
        this->add_option(output, "output_filename_format", -1, 350);
        auto scripts {this->add_group(page, _("Post-processing scripts"), 0)};
        this->add_option(scripts, "post_process", -1, 400, 60);
    }
    {
        auto* page {this->add_options_page(_("Notes"), "note.png")};
        auto notes {this->add_group(page, _("Notes"), 0)};
        this->add_option(notes, "notes", -1, 400, 250);
    }
    {
        auto* page {this->add_options_page(_("Shortcuts"), "wrench.png")};
        auto preferences {this->add_group(page, _("Profile preferences"))};
        this->add_compatible_printers(preferences);
        auto shortcuts {this->add_group(page, _("Show shortcuts for the following settings"), 0)};
        // "Category > Label", sorted by that
        std::vector<std::pair<wxString, std::string>> entries;
        for (const auto& key : PrintEditor::options()) {
            if (key.empty() || !print_config_def.has(key)) continue;
            const auto& def {print_config_def.get(key)};
            if (def.category.empty()) continue;
            entries.push_back({wxString::FromUTF8(def.category.c_str()) + " > " + option_name(key), key});
        }
        std::sort(entries.begin(), entries.end(),
            [](const auto& a, const auto& b) { return a.first.Cmp(b.first) < 0; });
        wxArrayString labels;
        for (const auto& entry : entries) {
            labels.Add(entry.first);
            this->_shortcut_keys.push_back(entry.second);
        }
        this->_shortcuts = new wxCheckListBox(shortcuts.parent, wxID_ANY, wxDefaultPosition, wxSize(400, 320), labels);
        this->_shortcuts->Bind(wxEVT_CHECKLISTBOX, [this](wxCommandEvent&) {
            auto& values {this->config->config().opt<ConfigOptionStrings>("shortcuts", true)->values};
            values.clear();
            for (size_t i = 0; i < this->_shortcut_keys.size(); ++i)
                if (this->_shortcuts->IsChecked(i)) values.push_back(this->_shortcut_keys[i]);
            this->_changed("shortcuts");
        });
        shortcuts.grid->Add(this->_shortcuts, 0, wxEXPAND);
    }
}

void PrintEditor::_update() {
    this->reload_compatible_printers();
    const auto& values {this->config->config().opt<ConfigOptionStrings>("shortcuts", true)->values};
    for (size_t i = 0; i < this->_shortcut_keys.size(); ++i) {
        const bool on {std::find(values.begin(), values.end(), this->_shortcut_keys[i]) != values.end()};
        if (this->_shortcuts->IsChecked(i) != on) this->_shortcuts->Check(i, on);
    }
}
}} // namespace Slic3r::GUI
