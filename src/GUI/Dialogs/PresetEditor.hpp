#ifndef PRESETEDITOR_HPP
#define PRESETEDITOR_HPP

// stdlib
#include <string>
#include <functional>
#include <initializer_list>
#include <map>

// Libslic3r
#include "libslic3r.h"
#include "ConfigBase.hpp"
#include "Config.hpp"

// GUI
#include "misc_ui.hpp"
#include "Preset.hpp"
#include "OptionsGroup/OptionControl.hpp"

// Wx
#include <wx/treectrl.h>
#include <wx/imaglist.h>
#include <wx/panel.h>
#include <wx/scrolwin.h>
#include <wx/checklst.h>
#include <wx/spinctrl.h>
#include <wx/statbox.h>

using namespace std::string_literals;
namespace Slic3r { namespace GUI {

class PresetPage;
class OverridePanel;

/// A titled box of option rows on a page.
struct OptionRows {
    PresetPage* page;
    wxWindow* parent;           ///< the box: the parent of the rows' controls
    wxStaticBoxSizer* box;
    wxFlexGridSizer* grid;
    int label_width;            ///< 0: no labels, the controls span the box
};

/// Ask for the name to save a preset under; empty when cancelled or not usable.
wxString ask_preset_name(wxWindow* parent, const wxString& question, const wxString& suggestion);

/// Write a preset file; false (after telling the user) when that fails.
bool write_preset(wxWindow* parent, preset_t group, DynamicPrintConfig config, const wxString& name);

class PresetEditor : public wxPanel {

public: 
    /// Member function to retrieve a list of options 
    /// that this preset governs. Subclasses should 
    /// call their own static method.
    virtual t_config_option_keys my_options() = 0;
    static t_config_option_keys options() { return t_config_option_keys {}; }

    static t_config_option_keys overridable_options() { return t_config_option_keys {}; };
    static t_config_option_keys overriding_options() { return t_config_option_keys {}; };

    virtual t_config_option_keys my_overridable_options() = 0;
    virtual t_config_option_keys my_overriding_options() = 0;

    wxSizer* sizer() { return _sizer; };
    PresetEditor(wxWindow* parent, t_config_option_keys options = {});
    PresetEditor() : PresetEditor(nullptr, {}) {};

    /// Called after a preset was selected here (the plater follows) or saved.
    std::function<void (wxString, preset_t)> on_select_preset {nullptr};

    /// Perform a preset selection and possibly trigger the _on_select_preset 
    /// method.
    void select_preset(int id, bool force = false);
    void select_preset_by_name(const wxString& name, bool force = false);
    
    /// Delete the selected preset's file (after asking).
    void delete_preset();
    
    /// Read the app's (reloaded) preset list again, keeping the selection by name.
    /// (After App::load_presets the old Preset objects are gone: only the name is kept.)
    void reload_list() { const wxString name {this->_preset_name};
        this->_preset = nullptr; this->load_presets(); if (!name.IsEmpty()) this->select_preset_by_name(name, true); }

    /// Which of the plater's choosers for this group the editor follows (materials of
    /// several extruders).
    size_t chooser_index {0};
    /// Asked before another preset replaces a modified one; false: stay with it.
    std::function<bool (const wxString& name)> confirm_leave {nullptr};

    /// The configuration the plater slices with, where a new override starts.
    std::function<DynamicPrintConfig()> plater_config {nullptr};

    void save_preset();
    std::function<void (wxString, preset_t)> on_save_preset {nullptr};
    std::function<void (std::string)> on_value_change {nullptr};

    config_ptr config;
    /// A new, empty page at the end of the tree.
    PresetPage* add_options_page(const wxString& _title, const wxString& _icon = "");

    virtual wxString title() = 0;
    virtual std::string name() = 0;
    virtual preset_t type() = 0; 
    virtual int typeId() = 0; 
protected:
    // Main sizer
    wxSizer* _sizer {nullptr};
    wxString presets;
    wxImageList* _icons {nullptr};
    wxTreeCtrl* _treectrl {nullptr};
    wxBitmapButton* _btn_save_preset {nullptr}; 
    wxBitmapButton* _btn_delete_preset {nullptr};
    wxChoice* _presets_choice {nullptr};
    int _iconcount {-1};

    /// Vector of PresetPage pointers; trust wxWidgets RTTI to avoid leaks
    std::vector<PresetPage*> _pages {};
    std::vector<wxTreeItemId> _page_items {};
    
    const unsigned int left_col_width {150};
    /// Rebuild the tree from the pages, keeping the selected one.
    void update_tree();
    void load_presets();

    /// A box with a title on a page.
    OptionRows add_group(PresetPage* page, const wxString& title, int label_width = 200);
    /// One row for one option: label, control by its type, unit.
    void add_option(OptionRows& rows, const std::string& opt_key, int index = -1, int width = -1, int height = -1);
    /// Several options in one row, each with its short label.
    void add_line(OptionRows& rows, const wxString& label, std::initializer_list<const char*> opt_keys, int index = -1);
    /// A row with anything else; the controls' parent is rows.parent.
    void add_widget(OptionRows& rows, const wxString& label, wxSizer* widget);
    /// A control for an option, kept up to date and known to the rules.
    wxWindow* add_control(OptionRows& rows, const std::string& opt_key, int index = -1, int width = -1, int height = -1);
    /// A small button with an icon.
    wxButton* make_button(wxWindow* parent, const wxString& label, const wxString& icon, std::function<void()> action);
    void remove_page(PresetPage* page);
    void add_compatible_printers(OptionRows& rows);
    void reload_compatible_printers();

    /// The preset being edited (an element of the app's preset list) and its name, which
    /// survives a reload of that list.
    Preset* _preset {nullptr};
    wxString _preset_name {};
    /// A value was changed in a control: into the preset's unsaved state.
    void _changed(const std::string& opt_key);
    /// Show this->config in every control, enable them by the rules.
    void refresh_all();
    /// Each option's control, by key, or key#index for one extruder's value.
    struct Control { OptionControl control; PresetPage* page; };
    std::map<std::string, Control> _controls {};
    bool _resolving {false};
    /// Enable the options that matter with the current values (Dialogs/PresetRules.cpp).
    void apply_rules();
    /// Ask about combinations that do not work after `changed` ("": a preset was loaded)
    /// and change this->config accordingly. True when it did.
    bool resolve_conflicts(const std::string& changed);
    bool _support_asked {false};  ///< the support question has had its answer

    virtual void _build() = 0;
    /// Called after every load and change, for the widgets that are not options.
    virtual void _update() {}
    /// Called when a preset's values are in this->config, before the controls show them.
    virtual void _on_preset_loaded() {}

    void set_tooltips() { 
        this->_btn_save_preset->SetToolTip(wxString(_("Save current ")) + this->title());
        this->_btn_delete_preset->SetToolTip(_("Delete this preset."));
    }

    /// This method is called:
    ///  - upon first initialization;
    ///  - whenever user selects a preset from the dropdown;
    ///  - whenever select_preset() or select_preset_by_name() are called.
    void _on_select_preset(bool force = false);

    virtual const std::string LogChannel() = 0; //< Which log these messages should go to.

private:
    wxCheckBox* _compatible_all {nullptr};
    wxButton* _compatible_set {nullptr};
    bool _compatible_choosing {false};  ///< "All" unticked, no printers chosen yet
    void _show_page(const PresetPage* page);
    bool _updating_tree {false};
};

class PrintEditor : public PresetEditor {
public:

    PrintEditor(wxWindow* parent, t_config_option_keys options = {});
    PrintEditor() : PrintEditor(nullptr, {}) {};

    wxString title() override { return _("Print Settings"); }
    std::string name() override { return "print"s; }

    preset_t type() override  { return preset_t::Print; }; 
    int typeId() override  { return static_cast<int>(preset_t::Print); }; 

    t_config_option_keys my_overridable_options() override { return PresetEditor::overridable_options(); };
    static t_config_option_keys overridable_options() { return PresetEditor::overridable_options(); };

    t_config_option_keys my_overriding_options() override { return PresetEditor::overriding_options(); };
    static t_config_option_keys overriding_options() { return PresetEditor::overriding_options(); };

    /// Static method to retrieve list of options that this preset governs.
    static t_config_option_keys options() {
        return t_config_option_keys
        {
            "layer_height"s, "first_layer_height"s,
            "adaptive_slicing"s, "adaptive_slicing_quality"s, "match_horizontal_surfaces"s,
            "perimeters"s, "spiral_vase"s, "min_shell_thickness"s, "min_top_bottom_shell_thickness"s,
            "fuzzy_skin"s, "fuzzy_skin_thickness"s, "fuzzy_skin_point_dist"s,
            "ironing"s, "ironing_flowrate"s, "ironing_spacing"s,
            "support_material_pillar_size"s, "support_material_pillar_spacing"s, "label_printed_objects"s,
            "top_solid_layers"s, "bottom_solid_layers"s,
            "extra_perimeters"s, "avoid_crossing_perimeters"s, "thin_walls"s, "overhangs"s,
            "seam_position"s, "external_perimeters_first"s,
            "fill_density"s, "fill_pattern"s, "top_infill_pattern"s, "bottom_infill_pattern"s, "fill_gaps"s,
            "infill_every_layers"s, "infill_only_where_needed"s,
            "solid_infill_every_layers"s, "fill_angle"s, "solid_infill_below_area"s, ""s,
            "only_retract_when_crossing_perimeters"s, "infill_first"s,
            "max_print_speed"s, "max_volumetric_speed"s,
            "perimeter_speed"s, "small_perimeter_speed"s, "external_perimeter_speed"s, "infill_speed"s, ""s,
            "solid_infill_speed"s, "top_solid_infill_speed"s, "support_material_speed"s,
            "support_material_interface_speed"s, "bridge_speed"s, "gap_fill_speed"s,
            "travel_speed"s,
            "first_layer_speed"s,
            "perimeter_acceleration"s, "infill_acceleration"s, "bridge_acceleration"s,
            "first_layer_acceleration"s, "default_acceleration"s,
            "skirts"s, "skirt_distance"s, "skirt_height"s, "min_skirt_length"s,
            "brim_connections_width"s, "brim_ears"s, "brim_ears_max_angle"s, "brim_width"s, "interior_brim_width"s,
            "support_material"s, "support_material_threshold"s, "support_material_max_layers"s, "support_material_enforce_layers"s,
            "raft_layers"s,
            "support_material_pattern"s, "support_material_spacing"s, "support_material_angle"s, ""s,
            "support_material_interface_layers"s, "support_material_interface_spacing"s,
            "support_material_contact_distance"s, "support_material_buildplate_only"s, "dont_support_bridges"s,
            "notes"s,
            "complete_objects"s, "extruder_clearance_radius"s, "extruder_clearance_height"s,
            "gcode_comments"s, "output_filename_format"s,
            "post_process"s,
            "perimeter_extruder"s, "infill_extruder"s, "solid_infill_extruder"s,
            "support_material_extruder"s, "support_material_interface_extruder"s,
            "ooze_prevention"s, "standby_temperature_delta"s,
            "interface_shells"s, "regions_overlap"s,
            "extrusion_width"s, "first_layer_extrusion_width"s, "perimeter_extrusion_width"s, ""s,
            "external_perimeter_extrusion_width"s, "infill_extrusion_width"s, "solid_infill_extrusion_width"s,
            "top_infill_extrusion_width"s, "support_material_extrusion_width"s,
            "support_material_interface_extrusion_width"s, "infill_overlap"s, "bridge_flow_ratio"s,
            "xy_size_compensation"s, "resolution"s, "shortcuts"s, "compatible_printers"s,
            "print_settings_id"s
        };
    }

    t_config_option_keys my_options() override { return PrintEditor::options(); }

protected:
    void _update() override;
    void _build() override;
    const std::string LogChannel() override {return "PrintEditor"s; } //< Which log these messages should go to.
private:
    wxCheckListBox* _shortcuts {nullptr};
    t_config_option_keys _shortcut_keys {};  ///< the entries of _shortcuts
};

class PrinterEditor : public PresetEditor {
public:
    PrinterEditor(wxWindow* parent, t_config_option_keys options = {});
    PrinterEditor() : PrinterEditor(nullptr, {}) {};

    wxString title() override { return _("Printer Settings"); }
    std::string name() override { return "printer"s; }
    preset_t type() override  { return preset_t::Printer; }; 
    int typeId() override  { return static_cast<int>(preset_t::Printer); }; 

    static t_config_option_keys overridable_options() { return t_config_option_keys 
    {
        "pressure_advance"s,
        "retract_length"s, "retract_lift"s, "retract_speed"s, "retract_restart_extra"s,
        "retract_before_travel"s, "retract_layer_change"s, "wipe"s
    }; };
    static t_config_option_keys overriding_options() { return PresetEditor::overriding_options(); };

    t_config_option_keys my_overridable_options() override { return PrinterEditor::overridable_options(); };
    t_config_option_keys my_overriding_options() override { return PrinterEditor::overriding_options(); };

    
    static t_config_option_keys options() {
        return t_config_option_keys
        {
            "bed_shape"s, "z_offset"s, "z_steps_per_mm"s, "has_heatbed"s,
            "machine_acceleration"s, "fan_percentage"s, "gcode_flavor"s, "use_relative_e_distances"s,
            "serial_port"s, "serial_speed"s,
            "host_type"s, "print_host"s, "octoprint_apikey"s,
            "use_firmware_retraction"s, "pressure_advance"s, "vibration_limit"s,
            "use_volumetric_e"s,
            "start_gcode"s, "end_gcode"s, "before_layer_gcode"s, "layer_gcode"s, "toolchange_gcode"s, "between_objects_gcode"s,
            "nozzle_diameter"s, "extruder_offset"s, "min_layer_height"s, "max_layer_height"s,
            "retract_length"s, "retract_lift"s, "retract_speed"s, "retract_restart_extra"s, "retract_before_travel"s, "retract_layer_change"s, "wipe"s,
            "retract_length_toolchange"s, "retract_restart_extra_toolchange"s, "retract_lift_above"s, "retract_lift_below"s,
            "printer_settings_id"s,
            "printer_notes"s,
            "use_set_and_wait_bed"s, "use_set_and_wait_extruder"s
        };
    }
    
    t_config_option_keys my_options() override { return PrinterEditor::options(); }

    /// The options that have one value for each extruder.
    static t_config_option_keys extruder_options() {
        return t_config_option_keys {
            "nozzle_diameter"s, "min_layer_height"s, "max_layer_height"s, "extruder_offset"s,
            "retract_length"s, "retract_lift"s, "retract_lift_above"s, "retract_lift_below"s, "retract_speed"s,
            "retract_restart_extra"s, "retract_before_travel"s, "wipe"s, "retract_layer_change"s,
            "retract_length_toolchange"s, "retract_restart_extra_toolchange"s
        };
    }
    size_t extruder_count() const;
protected:
    void _update() override;
    void _build() override;
    void _on_preset_loaded() override;
    const std::string LogChannel() override {return "PrinterEditor"s;} //< Which log these messages should go to.
private:
    wxSpinCtrl* _extruders {nullptr};
    std::vector<PresetPage*> _extruder_pages {};
    wxButton* _serial_test {nullptr};
    wxButton* _host_browse {nullptr};
    wxButton* _host_test {nullptr};
    void _set_extruder_count(size_t count);
    void _build_extruder_pages(size_t count);
    void _test_serial();
    void _test_octoprint();
    void _browse_octoprint();
};

class MaterialEditor : public PresetEditor {
public:

    wxString title() override { return _("Material Settings"); }
    std::string name() override { return "material"s; }
    preset_t type() override  { return preset_t::Material; }; 
    int typeId() override  { return static_cast<int>(preset_t::Material); }; 
    MaterialEditor(wxWindow* parent, t_config_option_keys options = {});
    MaterialEditor() : MaterialEditor(nullptr, {}) {};
    
    t_config_option_keys my_overridable_options() override { return PresetEditor::overridable_options(); };
    t_config_option_keys my_overriding_options() override { return PrinterEditor::overridable_options(); };

    static t_config_option_keys overriding_options() { return PrinterEditor::overridable_options(); };
    static t_config_option_keys overridable_options() { return PresetEditor::overridable_options(); };

    static t_config_option_keys options() {
        return t_config_option_keys
        {
            "filament_colour"s, "filament_diameter"s, "filament_notes"s, "filament_max_volumetric_speed"s, "extrusion_multiplier"s, "filament_density"s, "filament_cost"s,
            "temperature"s, "first_layer_temperature"s, "bed_temperature"s, "first_layer_bed_temperature"s,
            "fan_always_on"s, "cooling"s, "compatible_printers"s,
            "min_fan_speed"s, "max_fan_speed"s, "bridge_fan_speed"s, "disable_fan_first_layers"s,
            "fan_below_layer_time"s, "slowdown_below_layer_time"s, "min_print_speed"s,
            "start_filament_gcode"s, "end_filament_gcode"s,
            "filament_settings_id"s
        };
    }
    
    t_config_option_keys my_options() override { return MaterialEditor::options(); }
protected:
    void _update() override;
    void _build() override;
    const std::string LogChannel() override {return "MaterialEditor"s;} //< Which log these messages should go to.
private:
    wxStaticText* _cooling_description {nullptr};
    OverridePanel* _overrides {nullptr};
};




class PresetPage : public wxScrolledWindow {
public:
    PresetPage(wxWindow* parent, wxString _title, int _iconID) : 
        wxScrolledWindow(parent, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL),
        title(_title), iconID(_iconID) {
            this->vsizer = new wxBoxSizer(wxVERTICAL);
            this->SetSizer(this->vsizer);
            this->SetScrollRate(ui_settings->scroll_step(), ui_settings->scroll_step());
        }
    wxSizer* sizer() { return this->vsizer; }
    const wxString& get_title() const { return this->title; }
    int icon() const { return this->iconID; }
protected:
    wxSizer* vsizer {nullptr};
    wxString title {""};
    int iconID {0};
};

}} // namespace Slic3r::GUI
#endif // PRESETEDITOR_HPP
