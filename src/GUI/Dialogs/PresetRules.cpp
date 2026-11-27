// The preset editors' rules, from the Perl GUI's _update(): which options make sense
// together with the others, and the questions about combinations that do not work.
#include "Dialogs/PresetEditor.hpp"

#include <cstdlib>

#include <wx/msgdlg.h>

namespace Slic3r { namespace GUI {

namespace {

/// The values the rules look at; an option the preset lacks counts as off.
struct Values {
    const DynamicPrintConfig& config;
    std::string text(const std::string& key) const { return config.has(key) ? config.serialize(key) : std::string(); }
    /// a number, a percentage, or the first extruder's value
    double number(const std::string& key) const { return std::atof(text(key).c_str()); }
    bool on(const std::string& key) const { return number(key) != 0; }
};

} // namespace

void PresetEditor::apply_rules() {
    if (this->config == nullptr) return;
    const Values v {this->config->config()};
    auto enable = [this](std::initializer_list<const char*> keys, bool enabled) {
        for (const char* key : keys)
            if (this->_controls.count(key) > 0) this->_controls.at(key)->Enable(enabled);
    };

    if (this->type() == preset_t::Print) {
        const bool perimeters {v.on("perimeters") || v.on("min_shell_thickness")};
        enable({"extra_perimeters", "thin_walls", "overhangs", "seam_position", "external_perimeters_first",
            "fuzzy_skin", "external_perimeter_extrusion_width", "perimeter_speed", "small_perimeter_speed",
            "external_perimeter_speed"}, perimeters);
        enable({"fuzzy_skin_thickness", "fuzzy_skin_point_dist"}, perimeters && v.on("fuzzy_skin"));
        const bool adaptive {v.on("adaptive_slicing")};
        enable({"adaptive_slicing_quality", "match_horizontal_surfaces"}, adaptive);
        enable({"layer_height"}, !adaptive);
        const bool infill {v.on("fill_density")};
        enable({"fill_pattern", "infill_every_layers", "infill_only_where_needed", "solid_infill_every_layers",
            "solid_infill_below_area", "infill_extruder"}, infill);
        const bool solid {v.on("top_solid_layers") || v.on("bottom_solid_layers") || v.on("min_top_bottom_shell_thickness")};
        enable({"top_infill_pattern", "bottom_infill_pattern", "infill_first", "solid_infill_extruder",
            "solid_infill_extrusion_width", "solid_infill_speed", "ironing"}, solid);
        enable({"ironing_flowrate", "ironing_spacing"}, solid && v.on("ironing"));
        enable({"fill_angle", "infill_extrusion_width", "infill_speed"}, infill || solid);
        enable({"fill_gaps"}, perimeters && infill);
        enable({"gap_fill_speed"}, perimeters && infill && v.on("fill_gaps"));
        const bool top {v.on("top_solid_layers") || v.on("min_top_bottom_shell_thickness")};
        enable({"top_infill_extrusion_width", "top_solid_infill_speed"}, top);
        bool autospeed {false};
        for (const char* speed : {"perimeter_speed", "external_perimeter_speed", "small_perimeter_speed", "infill_speed",
                "solid_infill_speed", "top_solid_infill_speed", "gap_fill_speed", "support_material_speed",
                "support_material_interface_speed"})
            autospeed = autospeed || v.text(speed) == "0";
        enable({"max_print_speed"}, autospeed);
        enable({"perimeter_acceleration", "infill_acceleration", "bridge_acceleration", "first_layer_acceleration"},
            v.on("default_acceleration"));
        const bool skirt {v.on("skirts") || v.on("min_skirt_length")};
        enable({"skirt_distance", "skirt_height"}, skirt);
        const bool brim {v.on("brim_width") || v.on("interior_brim_width") || v.on("brim_connections_width")};
        enable({"perimeter_extruder"}, perimeters || brim);
        enable({"brim_ears"}, brim);
        enable({"brim_ears_max_angle"}, brim && v.on("brim_ears"));
        const bool support {v.on("support_material") || v.on("raft_layers")};
        const bool interface {v.on("support_material_interface_layers")};
        enable({"support_material_threshold", "support_material_pattern", "support_material_spacing",
            "support_material_angle", "support_material_interface_layers", "dont_support_bridges",
            "support_material_extrusion_width", "support_material_interface_extrusion_width",
            "support_material_contact_distance"}, support);
        enable({"support_material_max_layers"}, v.on("support_material"));
        enable({"support_material_pillar_size", "support_material_pillar_spacing"},
            support && v.text("support_material_pattern") == "pillars");
        enable({"support_material_interface_spacing", "support_material_interface_extruder",
            "support_material_interface_speed"}, support && interface);
        enable({"perimeter_extrusion_width"}, perimeters || skirt || brim);
        enable({"support_material_extruder"}, support || skirt);
        enable({"support_material_speed"}, support || brim || skirt);
        enable({"extruder_clearance_radius", "extruder_clearance_height"}, v.on("complete_objects"));
        enable({"standby_temperature_delta"}, v.on("ooze_prevention"));
    } else if (this->type() == preset_t::Material) {
        const bool cooling {v.on("cooling")};
        enable({"max_fan_speed", "fan_below_layer_time", "slowdown_below_layer_time", "min_print_speed"}, cooling);
        enable({"min_fan_speed", "disable_fan_first_layers"}, cooling || v.on("fan_always_on"));
    } else if (this->type() == preset_t::Printer) {
        const bool firmware {v.on("use_firmware_retraction")};
        const bool retraction {v.on("retract_length") || firmware};
        const bool several {v.text("nozzle_diameter").find(',') != std::string::npos};
        enable({"serial_speed"}, !v.text("serial_port").empty());
        enable({"octoprint_apikey"}, !v.text("print_host").empty());
        enable({"toolchange_gcode"}, several);
        enable({"retract_length"}, !firmware);
        enable({"retract_before_travel", "retract_layer_change", "retract_speed"}, retraction);
        enable({"retract_lift", "retract_restart_extra", "wipe"}, retraction && !firmware);
        enable({"retract_lift_above", "retract_lift_below"}, retraction && v.on("retract_lift"));
        enable({"retract_length_toolchange"}, several);
        enable({"retract_restart_extra_toolchange"}, several && v.on("retract_length_toolchange"));
    }
}

void PresetEditor::resolve_conflicts(const std::string& changed) {
    const Values v {this->config->config()};
    auto ask = [this](const wxString& question, const wxString& title) {
        return wxMessageBox(question, title, wxYES_NO | wxICON_WARNING, this) == wxYES;
    };
    auto set = [this](const std::string& key, const std::string& value) {
        if (this->config->has(key)) this->config->set(key, value);
    };
    auto among = [&changed](std::initializer_list<const char*> keys) {
        for (const char* key : keys)
            if (changed == key) return true;
        return false;
    };
    if (this->type() == preset_t::Print) {
        if (among({"spiral_vase", "perimeters", "top_solid_layers", "fill_density", "support_material",
                    "min_shell_thickness", "min_top_bottom_shell_thickness"})
                && v.on("spiral_vase")
                && !(v.number("perimeters") == 1 && !v.on("min_shell_thickness") && !v.on("min_top_bottom_shell_thickness")
                    && !v.on("top_solid_layers") && !v.on("fill_density") && !v.on("support_material"))) {
            if (ask(_("The Spiral Vase mode requires:\n- one perimeter\n- shell thickness to be 0\n- no top solid layers\n- 0% fill density\n- no support material\n\nShall I adjust those settings in order to enable Spiral Vase?"), _("Spiral Vase"))) {
                set("perimeters", "1");
                for (const char* key : {"min_shell_thickness", "min_top_bottom_shell_thickness", "top_solid_layers", "fill_density", "support_material"})
                    set(key, "0");
            } else {
                set("spiral_vase", "0");
            }
        }
        if (changed == "support_material" && v.on("support_material") && !v.on("overhangs")) {
            if (ask(_("Supports work better, if the following feature is enabled:\n- Detect bridging perimeters\n\nShall I adjust those settings for supports?"), _("Support Generator")))
                set("overhangs", "1");
        }
        if (among({"fill_density", "fill_pattern", "top_infill_pattern"}) && v.number("fill_density") == 100) {
            // at full density only the patterns of solid layers work
            const auto& solid {print_config_def.get("top_infill_pattern").enum_values};
            const std::string pattern {v.text("fill_pattern")};
            if (std::find(solid.begin(), solid.end(), pattern) == solid.end()) {
                if (ask(wxString::Format(_("The %s infill pattern is not supposed to work at 100%% density.\n\nShall I switch to rectilinear fill pattern?"), wxString::FromUTF8(pattern.c_str())), _("Infill")))
                    set("fill_pattern", "rectilinear");
                else
                    set("fill_density", "40%");
            }
        }
    } else if (this->type() == preset_t::Printer && v.on("use_firmware_retraction")
            && among({"use_firmware_retraction", "wipe", "retract_lift"})) {
        // lists keep one entry per extruder
        auto zero = [&v](const std::string& key) {
            std::string out {"0"};
            for (const char c : v.text(key))
                if (c == ',') out += ",0";
            return out;
        };
        if (v.on("wipe")) {
            if (ask(_("The Wipe option is not available when using the Firmware Retraction mode.\n\nShall I disable it in order to enable Firmware Retraction?"), _("Firmware Retraction")))
                set("wipe", zero("wipe"));
            else
                set("use_firmware_retraction", "0");
        }
        if (v.on("use_firmware_retraction") && v.on("retract_lift")) {
            if (ask(_("The Z Lift option is not available when using the Firmware Retraction mode.\n\nShall I disable it in order to enable Firmware Retraction?"), _("Firmware Retraction")))
                set("retract_lift", zero("retract_lift"));
            else
                set("use_firmware_retraction", "0");
        }
    }
}

}} // namespace Slic3r::GUI
