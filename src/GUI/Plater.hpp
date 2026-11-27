#ifndef PLATER_HPP
#define PLATER_HPP
#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif

#include <wx/notebook.h>
#include <wx/toolbar.h>
#include <wx/menu.h>
#include <wx/bmpcbox.h>

#include <atomic>
#include <thread>

#include "libslic3r.h"
#include "Model.hpp"
#include "Print.hpp"
#include "IO.hpp"
#include "Config.hpp"
#include "misc_ui.hpp"

#include "Preset.hpp"

#include "Plater/PlaterObject.hpp"
#include "Plater/Plate2D.hpp"
#include "Plater/Plate3D.hpp"
#include "Plater/Preview2D.hpp"
#include "Plater/Preview3D.hpp"
#include "Plater/PreviewDLP.hpp"
#include "Plater/PresetChooser.hpp"
#include "PrintConfig.hpp"

#include "Settings.hpp"

#include "MainFrame.hpp"

namespace Slic3r { namespace GUI {

class PresetChooser; // forward dec
enum class Zoom {
    In, Out
};

using ObjIdx = unsigned int;
using ObjRef = std::vector<PlaterObject>::iterator;

/// One run of the slicer, in the background: its own copy of the plater's model and its
/// own Print, so the plater stays usable.
struct SliceJob {
    explicit SliceJob(const Slic3r::Model& plater_model) : model(plater_model) {}
    Slic3r::Model model;
    Slic3r::Print print;        ///< points into model (declared after it, destroyed first)
    unsigned long revision {0}; ///< the plater's, when the job was made
    std::string output_file;    ///< file to write; empty: slice only, for the preview
    bool svg {false};           ///< write the slices as SVG, not G-code
    bool for_plate {true};      ///< false: a quick slice of a file, not what the preview shows
    /// Where the exported G-code goes next.
    enum class Then { Nothing, Send, Print };
    Then then {Then::Nothing};
    bool send_start {false};    ///< start printing after sending
};

class PlaterObject;
class OverridePanel;
class Plate2D;
class MainFrame;

/// Struct to group object info text fields together
struct info_fields {
    wxChoice* choice {nullptr};
    wxStaticText* copies {nullptr};
    wxStaticText* size {nullptr};
    wxStaticText* volume {nullptr};
    wxStaticText* facets {nullptr};
    wxStaticText* materials {nullptr};
    wxStaticText* manifold {nullptr};
    wxStaticBitmap* manifold_warning_icon {nullptr};
};

/// Extension of wxPanel class to handle the main plater.
/// 2D, 3D, preview, etc tabs.
class Plater : public wxPanel 
{
public:
    Plater(wxWindow* parent, const wxString& title);
    ~Plater();

    /// User-level function called through external interface.
    /// Pops file dialog.
    void add();
    /// Open a surface (2.5D TIN mesh) and give it a thickness.
    void add_tin();

    // What the menus and the toolbar do (Plater/ObjectOperations.cpp). Most act on the
    // selected object.
    void remove();
    void remove(int obj_idx);
    /// Clear plate.
    void reset();
    /// Arrange models via a simple packing mechanism based on bounding boxes.
    void arrange();
    void increase(size_t copies = 1);
    void decrease(size_t copies = 1);
    void set_number_of_copies();
    void center_selected_object_on_bed();
    /// Rotate by an angle in degrees.
    void rotate(double angle, Axis axis = Z);
    /// Rotate by an angle the user picks.
    void rotate(Axis axis);
    void mirror(Axis axis);
    /// Scale along an axis (-1: uniformly), by a percentage or to a size the user enters.
    void changescale(int axis = -1, bool to_size = false);
    void split_object();
    void object_cut_dialog();
    /// Turn the selected object so that a chosen face lies parallel to a plane.
    void rotate_face();
    /// Draw the selected object's layer heights and set height ranges.
    void layer_heights_dialog();
    void reload_from_disk();
    void export_plate(IO::ExportFormat format);
    void export_object(IO::ExportFormat format);
    void undo();
    void redo();
    void select_next();
    void select_prev();
    void zoom(Zoom dir);
    /// What the colours of the 3D preview mean.
    void color_toolpaths_by(PathColor by);
    /// One of the standard views of the 3D plater and preview: yaw and pitch in degrees.
    void select_view(float phi, float theta);

    /// Before closing: ask to save or discard each modified preset. False: stay open.
    bool prompt_unsaved_changes();
    /// Before the preset `name` is left for another: when it is modified, ask to save or
    /// discard the changes. False: stay with it.
    bool confirm_leave(preset_t group, const wxString& name);

    /// Create menu for object.
    wxMenu* object_menu();

    /// Slice with the selected presets and write G-code: to the --output file when one
    /// was given on the command line, else where a file dialog says.
    void export_gcode();
    
    /// Load model files (from the command line or a drop) into the plater.
    void load_files(const std::vector<std::string>& files);

    void show_preset_editor(preset_t preset, unsigned int idx);
    /// Slice now, if background processing was just switched on.
    void start_background_processing() { this->update_preview(); }

    // The File menu and the wizard (Plater/FileMenu.cpp)
    void config_wizard();
    /// `file`: empty to ask for one.
    void load_config_file(const wxString& file = "");
    /// Print options given on the command line: on top of the presets until another print
    /// preset is chosen (they show with the shortcuts).
    void set_overrides(const DynamicPrintConfig& overrides);
    /// Export the G-code to a temporary file and upload it to the print server; without
    /// asking about the name and the options when `skip_dialog`.
    void send_to_printer(bool skip_dialog);
    void export_config();
    void import_config_from_gcode();
    /// `file`: empty to ask for one. `only_with_id`: of the bundle's presets those that
    /// carry an id (the bundle shipped beside the program).
    void load_config_bundle(const wxString& file = "", bool only_with_id = false);
    void export_config_bundle();
    /// Slice a file without putting it on the plate. save_as: ask where to write;
    /// again: the file of the last quick slice.
    void quick_slice(bool save_as, bool again = false, bool svg = false);
    void repair_stl();
private:
    std::shared_ptr<Slic3r::Print> print {std::make_shared<Print>(Slic3r::Print())};
    std::shared_ptr<Slic3r::Model> model {std::make_shared<Model>(Slic3r::Model())};

    std::shared_ptr<Slic3r::Config> config { Slic3r::Config::new_from_defaults(
        {"bed_shape", "complete_objects", "extruder_clearance_radius", "skirts", "skirt_distance", 
        "brim_width", "serial_port", "serial_speed", "host_type", "print_host", "octoprint_apikey",
        "shortcuts", "filament_colour", "duplicate_distance"})};

    bool processed {false};

    std::vector<PlaterObject> objects {}; //< Main object vector.

    /// The plate after each change, for undo and redo.
    struct PlaterState {
        std::shared_ptr<Slic3r::Model> model;
        std::vector<PlaterObject> objects;
    };
    std::vector<PlaterState> history;
    size_t history_pos {0};     ///< the state the plate is in
    void commit();
    void restore(size_t position);
    /// -1: nothing selected
    int selected_index() const;
    ModelObject* selected_model_object();
    wxString ask_export_file(const wxString& format, const wxString& extension, const wxString& wildcard);
    void export_model(const Slic3r::Model& what, IO::ExportFormat format);
    /// Show the model as it is now: menus, info box, canvases; drops the sliced result.
    void refresh_model();

    wxNotebook* preview_notebook {new wxNotebook(this, wxID_ANY, wxDefaultPosition, wxSize(335,335), wxNB_BOTTOM)};
    wxBoxSizer* right_sizer {new wxBoxSizer(wxVERTICAL)};

    wxToolBar* htoolbar {nullptr}; //< toolbar for non-MSW platforms.
    std::vector<int> _rotate_tools {}; //< the optional 90° rotation tools
    wxBoxSizer* btoolbar {nullptr}; //< button-based toolbar for Windows

    Plate2D* canvas2D {nullptr}; //< 2D plater canvas
    Plate3D* canvas3D {nullptr}; //< 3D plater canvas

    Preview2D* preview2D {nullptr}; //< 2D Preview 
    Preview3D* preview3D {nullptr}; //< 3D Preview 

    PreviewDLP* previewDLP {nullptr}; //< DLP/SLA Preview canvas

    wxStaticBoxSizer* object_info_size {nullptr};
    wxButton* btn_export_gcode {nullptr};
    wxButton* btn_export_stl {nullptr};
    wxButton* btn_print {nullptr};  ///< shown when the printer has a serial port
    wxButton* btn_send {nullptr};   ///< shown when the printer has a print server
    wxStaticBoxSizer* print_info_sizer {nullptr};
    wxStaticText* print_info_filament {nullptr};
    wxStaticText* print_info_cost {nullptr};
    wxStaticText* print_info_time {nullptr};
    /// The summary of the last export; hidden once the plate or the settings change.
    void show_print_summary(const Slic3r::Print* print);
    DynamicPrintConfig _overrides {};
    /// The selected presets and the command line's overrides on top.
    Slic3r::Config full_config();
    /// Write the G-code of the plate to `output_file`, then send or print it.
    void export_to(std::shared_ptr<SliceJob> job, const std::string& output_file);
    void upload(const std::string& file, bool start);
    
    /// Background slicing: one SliceJob at a time runs on this thread.
    std::thread slicing_thread;
    std::atomic<bool> cancel_slicing {false};
    std::shared_ptr<SliceJob> running;  ///< null when nothing is slicing
    std::shared_ptr<SliceJob> sliced;   ///< the last job that still matches the plater
    bool export_pending {false};        ///< export once the running preview job has ended
    unsigned long revision {0};         ///< counts changes of the model or the settings
    unsigned long failed_revision {static_cast<unsigned long>(-1)}; ///< do not slice this one again by itself
    /// A job for this model with the selected presets. Throws if the print is not valid.
    std::shared_ptr<SliceJob> make_job(const Slic3r::Model& what);
    wxString quick_slice_input, quick_slice_output;
    /// Select a configuration file as the print, material and printer preset.
    /// Replace an object by the tiles of a grid; `object` has its transforms applied.
    void cut_by_grid(int idx, const ModelObject& object, const Pointf& grid);
    void select_external_config(const wxString& file);
    void run_job(std::shared_ptr<SliceJob> job);
    /// Back on the GUI thread when the background job has ended.
    void on_job_done(std::shared_ptr<SliceJob> job, const std::string& error, bool cancelled);
    /// The model or the settings changed: the sliced result is stale.
    void invalidate_slices();
    /// Slice for the preview, if a preview tab is selected (or background processing is
    /// on) and there is no result.
    void update_preview();
    
    /// Take the plater's own settings (bed shape, ...) from the selected presets.
    void refresh_config();

    /// Handles the actual load of the file from the dialog handoff.
    std::vector<int> load_file(const std::string file);

    const std::string LogChannel {"GUI_Plater"}; //< Which log these messages should go to.

    /// Populate the PlaterObject vector.
    std::vector<int> load_model_objects(ModelObject* model_object);
    std::vector<int> load_model_objects(ModelObjectPtrs model_objects);

    bool scaled_down {false};
    bool outside_bounds {false};

    /// Method to get the top-level window and cast it as a MainFrame.
    MainFrame* GetFrame();

    void select_object(ObjRef obj_idx);
    void select_object(ObjIdx obj_idx);

    /// Overload to unselect objects
    void select_object();
    
    /// Get the center of the configured bed's bounding box.
    Slic3r::Pointf bed_centerf() {
        const auto& bed_shape { Slic3r::Polygon::new_scale(this->config->get<ConfigOptionPoints>("bed_shape").values) };
        const auto& bed_center {BoundingBox(bed_shape).center()};
        return Slic3r::Pointf::new_unscale(bed_center);
    }

    /// Build thumbnails for the models
    void make_thumbnail(size_t idx);

    /// Complete thumbnail transformation and refresh canvases  
    void on_thumbnail_made(size_t idx); 

    /// Issue a repaint event to all of the canvasses.
    void refresh_canvases();

    /// Action to take when selection changes. Update platers, etc.
    void selection_changed();

    /// Run everything that needs to happen when models change.
    void on_model_change(bool force_autocenter = false);

    /// Searches the object vector for the first selected object and returns an iterator to it.
    ObjRef selected_object();

    /// Create and launch dialog for object settings.
    void object_settings_dialog();

    /// Instantiate the toolbar 
    void build_toolbar();

    /// Open a menu to configure the layer heights.
    void object_layers_dialog();

    /// Process a change in the object list.
    void object_list_changed();

    /// Struct containing various object info fields.
    info_fields object_info;

    PresetChooser* _presets;
    /// Below the choosers: the print preset's shortcut settings and the ones changed.
    wxScrolledWindow* _shortcuts_window {nullptr};
    OverridePanel* _shortcuts {nullptr};
    DynamicPrintConfig _shortcut_config {};
    std::string _shortcut_preset_name {};
    /// Show the selected print preset's shortcuts.
    void update_shortcuts();
    void shortcut_changed(const std::string& opt_key);
    Preset* selected_print_preset();

    void load_presets();
    /// Ask whether to save or discard a modified preset's changes, and do it; false:
    /// cancelled (or saving failed).
    bool ask_to_save(Preset& preset);
    /// Read the presets from the data directory again, into every list.
    void reload_presets();

};


template <typename T>
static void add_info_field(wxWindow* parent, T*& field, wxString name, wxGridSizer* sizer) {
    name << ":";
    auto* text {new wxStaticText(parent, wxID_ANY, name, wxDefaultPosition, wxDefaultSize, wxALIGN_LEFT)};
    text->SetFont(ui_settings->small_font());
    sizer->Add(text, 0);

    field = new wxStaticText(parent, wxID_ANY, "", wxDefaultPosition, wxDefaultSize, wxALIGN_LEFT);
    field->SetFont(ui_settings->small_font());
    sizer->Add(field, 0);
}

} } // Namespace Slic3r::GUI

#endif  // PLATER_HPP
