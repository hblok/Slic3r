#include <fstream>
#include <memory>
#include <climits>
#include <cmath>

#include <wx/progdlg.h>
#include <wx/window.h> 
#include <wx/numdlg.h> 


#include "Plater.hpp"
#include "ProgressStatusBar.hpp"
#include "Log.hpp"
#include "MainFrame.hpp"
#include "BoundingBox.hpp"
#include "Geometry.hpp"
#include "GCodeTimeEstimator.hpp"
#include "GUI.hpp"
#include <wx/filedlg.h>
#include <wx/dnd.h>
#include <wx/filename.h>


namespace Slic3r { namespace GUI {

const auto TB_ADD           {wxNewId()};
const auto TB_REMOVE        {wxNewId()};
const auto TB_RESET         {wxNewId()};
const auto TB_ARRANGE       {wxNewId()};
const auto TB_EXPORT_GCODE  {wxNewId()};
const auto TB_EXPORT_STL    {wxNewId()};
const auto TB_MORE          {wxNewId()};
const auto TB_FEWER         {wxNewId()};
const auto TB_45CW          {wxNewId()};
const auto TB_45CCW         {wxNewId()};
const auto TB_SCALE         {wxNewId()};
const auto TB_SPLIT         {wxNewId()};
const auto TB_CUT           {wxNewId()};
const auto TB_LAYERS        {wxNewId()};
const auto TB_SETTINGS      {wxNewId()};

const auto PROGRESS_BAR_EVENT = wxNewEventType();

Plater::Plater(wxWindow* parent, const wxString& title) : 
    wxPanel(parent, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL, title),
    _presets(new PresetChooser(dynamic_cast<wxWindow*>(this), this->print))
{

    // Set callback for status event for worker threads
    /*
    this->print->set_status_cb([=](std::string percent percent, std::wstring message) {
        wxPostEvent(this, new wxPlThreadEvent(-1, PROGRESS_BAR_EVENT, 
    });
    */
    _presets->load();
    _presets->on_settings = [this](preset_t group) { this->show_preset_editor(group, 0); };
    _presets->on_preset_selected = [this](preset_t group, wxString name) {
        auto& editors {this->GetFrame()->preset_editor_tabs};
        if (editors.count(group) > 0) editors[group]->select_preset_by_name(name, true);
        this->refresh_config();
        this->invalidate_slices();
    };

    // Initialize handlers for canvases
    auto on_select_object {[this](ObjIdx obj_idx) { this->select_object(obj_idx); }};
    auto on_double_click {[this]() { if (this->selected_object() != this->objects.end()) this->object_settings_dialog(); }};
    auto on_right_click {[this](wxPanel* canvas, const wxPoint& pos) 
        {
            auto obj = this->selected_object();
            if (obj == this->objects.end()) return;

            auto menu = this->object_menu();
            canvas->PopupMenu(menu, pos);
            delete menu;
        }};
    auto on_instances_moved {[this]() { this->on_model_change(); }};

    /* 
    # Initialize 3D plater
    if ($Slic3r::GUI::have_OpenGL) {
        $self->{canvas3D} = Slic3r::GUI::Plater::3D->new($self->{preview_notebook}, $self->{objects}, $self->{model}, $self->{config});
        $self->{preview_notebook}->AddPage($self->{canvas3D}, '3D');
        $self->{canvas3D}->set_on_select_object($on_select_object);
        $self->{canvas3D}->set_on_double_click($on_double_click);
        $self->{canvas3D}->set_on_right_click(sub { $on_right_click->($self->{canvas3D}, @_); });
        $self->{canvas3D}->set_on_instances_moved($on_instances_moved);
        $self->{canvas3D}->on_viewport_changed(sub {
            $self->{preview3D}->canvas->set_viewport_from_scene($self->{canvas3D});
        });
    }
    */

    // initialize 2D Preview Canvas
    canvas2D = new Plate2D(preview_notebook, wxDefaultSize, objects, model, config);
    preview_notebook->AddPage(canvas2D, _("2D"));

    this->commit();  // the empty plate, where undo ends

    canvas2D->on_select_object = std::function<void (ObjIdx obj_idx)>(on_select_object);
    canvas2D->on_double_click = std::function<void ()>(on_double_click);
    canvas2D->on_right_click = std::function<void (const wxPoint& pos)>([=](const wxPoint& pos){ on_right_click(canvas2D, pos); });
    canvas2D->on_instances_moved = std::function<void ()>(on_instances_moved);


    canvas3D = new Plate3D(preview_notebook, wxDefaultSize, objects, model, config);
    preview_notebook->AddPage(canvas3D, _("3D"));

    canvas3D->on_select_object = std::function<void (ObjIdx obj_idx)>(on_select_object);
    canvas3D->on_instances_moved = std::function<void ()>(on_instances_moved);
    
    preview3D = new Preview3D(preview_notebook);
    preview_notebook->AddPage(preview3D, _("Preview"));

    preview2D = new Preview2D(preview_notebook);
    preview_notebook->AddPage(preview2D, _("Toolpaths"));

    previewDLP = new PreviewDLP(preview_notebook, wxDefaultSize, objects, model, config);
    preview_notebook->AddPage(previewDLP, _("DLP/SLA"));

    preview_notebook->Bind(wxEVT_NOTEBOOK_PAGE_CHANGED, [this](wxBookCtrlEvent& e) {
        this->failed_revision = static_cast<unsigned long>(-1);  // opening the tab tries again
        this->CallAfter([this]() { this->update_preview(); });
        e.Skip();
    });

    /*
    # Initialize 2D preview canvas
    $self->{canvas} = Slic3r::GUI::Plater::2D->new($self->{preview_notebook}, wxDefaultSize, $self->{objects}, $self->{model}, $self->{config});
    $self->{preview_notebook}->AddPage($self->{canvas}, '2D');
    $self->{canvas}->on_select_object($on_select_object);
    $self->{canvas}->on_double_click($on_double_click);
    $self->{canvas}->on_right_click(sub { $on_right_click->($self->{canvas}, @_); });
    $self->{canvas}->on_instances_moved($on_instances_moved);
    # Initialize 3D toolpaths preview
    $self->{preview3D_page_idx} = -1;
    if ($Slic3r::GUI::have_OpenGL) {
        $self->{preview3D} = Slic3r::GUI::Plater::3DPreview->new($self->{preview_notebook}, $self->{print});
        $self->{preview3D}->canvas->on_viewport_changed(sub {
            $self->{canvas3D}->set_viewport_from_scene($self->{preview3D}->canvas);
        });
        $self->{preview_notebook}->AddPage($self->{preview3D}, 'Preview');
        $self->{preview3D_page_idx} = $self->{preview_notebook}->GetPageCount-1;
    }
    
    # Initialize toolpaths preview
    $self->{toolpaths2D_page_idx} = -1;
    if ($Slic3r::GUI::have_OpenGL) {
        $self->{toolpaths2D} = Slic3r::GUI::Plater::2DToolpaths->new($self->{preview_notebook}, $self->{print});
        $self->{preview_notebook}->AddPage($self->{toolpaths2D}, 'Layers');
        $self->{toolpaths2D_page_idx} = $self->{preview_notebook}->GetPageCount-1;
    }
    
    EVT_NOTEBOOK_PAGE_CHANGED($self, $self->{preview_notebook}, sub {
        wxTheApp->CallAfter(sub {
            my $sel = $self->{preview_notebook}->GetSelection;
            if ($sel == $self->{preview3D_page_idx} || $sel == $self->{toolpaths2D_page_idx}) {
                if (!$Slic3r::GUI::Settings->{_}{background_processing} && !$self->{processed}) {
                    $self->statusbar->SetCancelCallback(sub {
                        $self->stop_background_process;
                        $self->statusbar->SetStatusText("Slicing cancelled");
                        $self->{preview_notebook}->SetSelection(0);

                    });
                    $self->start_background_process;
                } else {
                    $self->{preview3D}->load_print
                        if $sel == $self->{preview3D_page_idx};
                }
            }
        });
    });
    */
    wxStaticBoxSizer* object_info_sizer {nullptr};
    {
        auto* box {new wxStaticBox(this, wxID_ANY, _("Info"))};
        object_info_sizer = new wxStaticBoxSizer(box, wxVERTICAL);
        object_info_sizer->SetMinSize(wxSize(350, -1));
        {
            auto* sizer {new wxBoxSizer(wxHORIZONTAL)};
            object_info_sizer->Add(sizer, 0, wxEXPAND | wxBOTTOM, 5);
            auto* text  {new wxStaticText(this, wxID_ANY, _("Object:"), wxDefaultPosition, wxDefaultSize, wxALIGN_LEFT)};
            text->SetFont(ui_settings->small_font());
            sizer->Add(text, 0, wxALIGN_CENTER_VERTICAL);

            /* We supply a bogus width to wxChoice (sizer will override it and stretch 
             * the control anyway), because if we leave the default (-1) it will stretch
             * too much according to the contents, and this is bad with long file names.
             */
            this->object_info.choice = new wxChoice(this, wxID_ANY, wxDefaultPosition, wxSize(100, -1));
            this->object_info.choice->SetFont(ui_settings->small_font());
            sizer->Add(this->object_info.choice, 1, wxALIGN_CENTER_VERTICAL);

            // Select object on change.
            this->Bind(wxEVT_CHOICE, [this](wxCommandEvent& e) { this->select_object(this->object_info.choice->GetSelection()); this->refresh_canvases();});
                
        }
        
        auto* grid_sizer { new wxFlexGridSizer(3, 4, 5, 5)};
        grid_sizer->SetFlexibleDirection(wxHORIZONTAL);
        grid_sizer->AddGrowableCol(1, 1);
        grid_sizer->AddGrowableCol(3, 1);

        add_info_field(this, this->object_info.copies, _("Copies"), grid_sizer);
        add_info_field(this, this->object_info.size, _("Size"), grid_sizer);
        add_info_field(this, this->object_info.volume, _("Volume"), grid_sizer);
        add_info_field(this, this->object_info.facets, _("Facets"), grid_sizer);
        add_info_field(this, this->object_info.materials, _("Materials"), grid_sizer);
        {
            wxString name {"Manifold:"};
            auto* text {new wxStaticText(this, wxID_ANY, name, wxDefaultPosition, wxDefaultSize, wxALIGN_LEFT)};
            text->SetFont(ui_settings->small_font());
            grid_sizer->Add(text, 0);

            this->object_info.manifold = new wxStaticText(this, wxID_ANY, "", wxDefaultPosition, wxDefaultSize, wxALIGN_LEFT);
            this->object_info.manifold->SetFont(ui_settings->small_font());

            this->object_info.manifold_warning_icon = new wxStaticBitmap(this, wxID_ANY, wxBitmap(var("error.png"), wxBITMAP_TYPE_PNG));
            this->object_info.manifold_warning_icon->Hide();

            auto* h_sizer {new wxBoxSizer(wxHORIZONTAL)};
            h_sizer->Add(this->object_info.manifold_warning_icon, 0);
            h_sizer->Add(this->object_info.manifold, 0);

            grid_sizer->Add(h_sizer, 0, wxEXPAND);
        }

        object_info_sizer->Add(grid_sizer, 0, wxEXPAND);
    }
    this->selection_changed();
    this->canvas2D->update_bed_size();

    // Toolbar
    this->build_toolbar();

    // Finally assemble the sizers into the display.
    
    // export/print/send/export buttons
    auto* buttons_sizer {new wxBoxSizer(wxHORIZONTAL)};
    this->btn_export_gcode = new wxButton(this, wxID_ANY, _(L"Export G-code…"));
    this->btn_export_gcode->SetFont(ui_settings->small_font());
    this->btn_export_gcode->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->export_gcode(); });
    buttons_sizer->AddStretchSpacer(1);
    buttons_sizer->Add(this->btn_export_gcode, 0, 0, 0);

    // right panel sizer
    auto* right_sizer {this->right_sizer};
    right_sizer->Add(this->_presets, 0, wxEXPAND | wxTOP, 10);
    right_sizer->Add(buttons_sizer, 0, wxEXPAND | wxBOTTOM, 5);
//    $right_sizer->Add($self->{settings_override_panel}, 1, wxEXPAND, 5);
    right_sizer->Add(object_info_sizer, 0, wxEXPAND, 0);
//    $right_sizer->Add($object_info_sizer, 0, wxEXPAND, 0);
//    $right_sizer->Add($print_info_sizer, 0, wxEXPAND, 0);
//    $right_sizer->Hide($print_info_sizer);

    auto hsizer {new wxBoxSizer(wxHORIZONTAL)};
    hsizer->Add(this->preview_notebook, 1, wxEXPAND | wxTOP, 1);
    hsizer->Add(right_sizer, 0, wxEXPAND | wxLEFT | wxRIGHT, 3);

    auto sizer {new wxBoxSizer(wxVERTICAL)};
    if (this->htoolbar != nullptr) sizer->Add(this->htoolbar, 0, wxEXPAND, 0);
    if (this->btoolbar != nullptr) sizer->Add(this->btoolbar, 0, wxEXPAND, 0);
    sizer->Add(hsizer, 1, wxEXPAND,0);

    sizer->SetSizeHints(this);
    this->SetSizer(sizer);

    this->selection_changed();

    // files dropped on the plater are loaded
    struct DropTarget : wxFileDropTarget {
        Plater* plater;
        explicit DropTarget(Plater* p) : plater(p) {}
        bool OnDropFiles(wxCoord, wxCoord, const wxArrayString& names) override {
            std::vector<std::string> files;
            for (const auto& name : names) {
                const wxString extension {wxFileName(name).GetExt().Lower()};
                if (extension == "stl" || extension == "obj" || extension == "amf" || extension == "3mf" || extension == "xml")
                    files.push_back(name.ToUTF8().data());
            }
            if (files.empty()) return false;
            // after the drag has ended: loading shows dialogs
            Plater* target {plater};
            target->CallAfter([target, files]() { target->load_files(files); });
            return true;
        }
    };
    this->SetDropTarget(new DropTarget(this));

}
void Plater::add() {
    std::vector<std::string> files;
    for (const auto& file : open_model(this, wxTheApp->GetTopWindow())) files.push_back(file.ToUTF8().data());
    if (!files.empty()) this->load_files(files);
}

void Plater::refresh_config() {
    auto full {std::make_shared<Slic3r::Config>(this->_presets->full_config())};
    // only the keys the presets have: some of the plater's (e.g. shortcuts) are not in a
    // preset loaded from a file, and applying a missing key crashed (null option)
    t_config_option_keys keys;
    for (const auto& key : this->config->config().keys())
        if (full->has(key)) keys.push_back(key);
    this->config->apply(full, keys);
    this->canvas2D->update_bed_size();
    this->canvas3D->update();
}

void Plater::load_files(const std::vector<std::string>& files) {
    this->refresh_config();  // objects are placed on the selected printer's bed
    for (const auto& file : files) this->load_file(file);
    this->on_model_change();
}

std::shared_ptr<SliceJob> Plater::make_job(const Slic3r::Model& what) {
    this->refresh_config();
    const Slic3r::Config config {this->_presets->full_config()};
    auto job {std::make_shared<SliceJob>(what)};
    job->revision = this->revision;
    job->print.apply_config(config.config());
    for (auto* object : job->model.objects) {
        job->print.auto_assign_extruders(object);
        job->print.add_model_object(object);
    }
    job->print.validate();
    return job;
}

void Plater::export_gcode() {
    if (this->objects.empty()) {
        GetFrame()->statusbar->SetStatusText(_("Nothing to export."));
        return;
    }
    // ponytail: an export waits until a running preview has sliced (the button is disabled)
    if (this->running != nullptr) return;

    std::shared_ptr<SliceJob> job;
    try {
        job = this->make_job(*this->model);
    } catch (std::exception& e) {
        show_error(this, e.what());
        return;
    }

    const auto* app {dynamic_cast<App*>(wxTheApp)};
    std::string output_file {app != nullptr ? app->output_file : std::string()};
    if (output_file.empty()) {
        const wxFileName default_file {wxString(job->print.output_filepath(""))};
        wxFileDialog dialog(this, _("Save G-code file as:"), default_file.GetPath(), default_file.GetFullName(),
            _("G-code files (*.gcode)|*.gcode;*.GCODE;*.g;*.ngc|All files|*"), wxFD_SAVE | wxFD_OVERWRITE_PROMPT);
        if (dialog.ShowModal() != wxID_OK) return;
        output_file = dialog.GetPath().ToStdString();
    }
    job->output_file = job->print.output_filepath(output_file);
    this->run_job(job);
}

void Plater::run_job(std::shared_ptr<SliceJob> job) {
    // Progress from the print's status messages. They come between slicing steps, which
    // is also where a cancel takes effect (the exception ends the job).
    struct Cancelled {};
    job->print.status_cb = [this](int percent, const std::string& message) {
        if (this->cancel_slicing) throw Cancelled();
        this->CallAfter([this, percent, message]() {
            GetFrame()->statusbar->SetStatusText(wxString::FromUTF8(message));
            GetFrame()->statusbar->SetProgress(percent);
        });
    };

    if (this->slicing_thread.joinable()) this->slicing_thread.join();  // the last one has ended
    this->running = job;
    this->cancel_slicing = false;
    this->btn_export_gcode->Disable();
    auto* statusbar {GetFrame()->statusbar};
    statusbar->SetStatusText(job->output_file.empty() ? _(L"Slicing…") : _(L"Exporting G-code…"));
    statusbar->SetProgress(1);
    statusbar->SetCancelCallback([this]() { this->cancel_slicing = true; });

    this->slicing_thread = std::thread([this, job]() {
        std::string error;
        bool cancelled {false};
        try {
            if (job->output_file.empty()) {
                job->print.process();
            } else if (job->svg) {
                std::ofstream svg(job->output_file);
                job->print.export_svg(svg);
                svg.close();
                if (!svg) throw std::runtime_error("Failed to write " + job->output_file);
            } else {
                job->print.export_gcode(job->output_file);
            }
        } catch (Cancelled&) {
            cancelled = true;
        } catch (std::exception& e) {
            error = e.what();
        }
        this->CallAfter([this, job, error, cancelled]() {
            this->on_job_done(job, error, cancelled);
        });
    });
}

void Plater::on_job_done(std::shared_ptr<SliceJob> job, const std::string& error, bool cancelled) {
    this->running.reset();
    this->btn_export_gcode->Enable();
    auto* statusbar {GetFrame()->statusbar};
    statusbar->SetCancelCallback(nullptr);
    statusbar->StopBusy();  // hides and resets the progress gauge

    const bool exporting {!job->output_file.empty()};
    const bool current {job->for_plate && job->revision == this->revision};
    // a cancel by the user or an error: do not start over by itself
    if ((cancelled || !error.empty()) && current) this->failed_revision = job->revision;

    if (cancelled) {
        if (exporting) wxRemoveFile(wxString(job->output_file + ".tmp"));  // the export's own temporary file
        statusbar->SetStatusText(exporting ? _("Export cancelled") : _("Slicing cancelled"));
    } else if (!error.empty()) {
        statusbar->SetStatusText(exporting ? _("Export failed") : wxString::FromUTF8(error));
        if (exporting) show_error(this, wxString::FromUTF8(error));
    } else {
        wxString message {_("Sliced")};
        if (exporting) {
            this->processed = true;
            // the plater's print shows the last export's numbers
            this->print->total_used_filament = job->print.total_used_filament;
            this->print->estimated_print_time = job->print.estimated_print_time;
            message.clear();
            message << (job->svg ? _("SVG file exported to ") : _("G-code file exported to ")) << wxString::FromUTF8(job->output_file.c_str());
            if (!job->svg)
                message << wxString::Format(_(" (%.2f m filament, %s)"), job->print.total_used_filament / 1000.,
                    wxString(GCodeTimeEstimator::format_time(job->print.estimated_print_time)));
        }
        statusbar->SetStatusText(message);
        if (current) {
            this->sliced = job;
            const std::shared_ptr<Slic3r::Print> result {job, &job->print};  // keeps the whole job
            this->preview3D->set_print(result);
            this->preview2D->set_print(result);
        }
    }
    this->update_preview();
}

void Plater::invalidate_slices() {
    ++this->revision;
    this->sliced.reset();
    this->preview3D->set_print(nullptr);
    this->preview2D->set_print(nullptr);
    if (this->running != nullptr && this->running->output_file.empty())
        this->cancel_slicing = true;  // on_job_done starts the new one
    else
        this->update_preview();
}

void Plater::update_preview() {
    const wxWindow* page {this->preview_notebook->GetCurrentPage()};
    if (page != this->preview3D && page != this->preview2D) return;
    if (this->running != nullptr || this->sliced != nullptr || this->objects.empty()
        || this->revision == this->failed_revision) return;
    try {
        this->run_job(this->make_job(*this->model));
    } catch (std::exception& e) {
        this->failed_revision = this->revision;
        GetFrame()->statusbar->SetStatusText(wxString::FromUTF8(e.what()));
    }
}

Plater::~Plater() {
    if (this->slicing_thread.joinable()) {
        this->cancel_slicing = true;
        this->slicing_thread.join();
    }
}

std::vector<int> Plater::load_file(const std::string file) {
    
    auto input_file {wxFileName(file)};
    ui_settings->skein_directory = input_file.GetPath();
    ui_settings->save_settings();
    
    Slic3r::Model model;
    bool valid_load {true};

    auto obj_idx {std::vector<int>()};
    auto progress_dialog {new wxProgressDialog(_(L"Loading…"), _(L"Processing input file…"), 100, this, 0)};
    progress_dialog->Pulse();
    //TODO: Add a std::wstring so we can handle non-roman characters as file names.
    try { 
        model = Slic3r::Model::read_from_file(file);
    } catch (std::runtime_error& e) {
        show_error(this, e.what());
        Slic3r::Log::error(LogChannel, LOG_WSTRING(file << " failed to load: " << e.what()));
        valid_load = false;
    }
    Slic3r::Log::info(LogChannel, LOG_WSTRING("load_valid is " << valid_load));

    if (valid_load) {
        if (model.looks_like_multipart_object()) {
            auto dialog {new wxMessageDialog(this, 
            _("This file contains several objects positioned at multiple heights. Instead of considering them as multiple objects, should I consider\n them this file as a single object having multiple parts?\n"), _("Multi-part object detected"), wxICON_WARNING | wxYES | wxNO)};
            if (dialog->ShowModal() == wxID_YES) {
                model.convert_multipart_object();
            }
        } 
        
        for (auto i = 0U; i < model.objects.size(); i++) {
            auto object {model.objects[i]};
            object->input_file = file;
            for (auto j = 0U; j < object->volumes.size(); j++) {
                auto volume {object->volumes.at(j)};
                volume->input_file = file;
                volume->input_file_obj_idx = i;
                volume->input_file_vol_idx = j;
            }
        }
        obj_idx = this->load_model_objects(model.objects);
        for (size_t i = 0; i < obj_idx.size(); ++i)
            this->objects.at(obj_idx[i]).input_file = file;
        GetFrame()->statusbar->SetStatusText(_("Loaded ") + input_file.GetName());

        if (this->scaled_down) {
            GetFrame()->statusbar->SetStatusText(_("Your object appears to be too large, so it was automatically scaled down to fit your print bed."));
        }
        if (this->outside_bounds) {
            GetFrame()->statusbar->SetStatusText(_("Some of your object(s) appear to be outside the print bed. Use the arrange button to correct this."));
        }
    }

    progress_dialog->Destroy();
    return obj_idx;
}



MainFrame* Plater::GetFrame() { return dynamic_cast<MainFrame*>(wxGetTopLevelParent(this)); }

void Plater::make_thumbnail(size_t idx) {
    auto& plater_object {this->objects.at(idx)};
    if (threaded) {
        // spin off a thread to create the thumbnail and post an event when it is done.
    } else {
        plater_object.make_thumbnail(this->model, idx);
        this->on_thumbnail_made(idx);
    }
/*
    my $plater_object = $self->{objects}[$obj_idx];
    $plater_object->thumbnail(Slic3r::ExPolygon::Collection->new);
    my $cb = sub {
        $plater_object->make_thumbnail($self->{model}, $obj_idx);
        
        if ($Slic3r::have_threads) {
            Wx::PostEvent($self, Wx::PlThreadEvent->new(-1, $THUMBNAIL_DONE_EVENT, shared_clone([ $obj_idx ])));
            Slic3r::thread_cleanup();
            threads->exit;
        } else {
            $self->on_thumbnail_made($obj_idx);
        }
    };
    
    @_ = ();
    $Slic3r::have_threads
        ? threads->create(sub { $cb->(); Slic3r::thread_cleanup(); })->detach
        : $cb->();
}
*/
}

void Plater::on_thumbnail_made(size_t idx) {
    this->objects.at(idx).transform_thumbnail(this->model, idx);
    this->refresh_canvases();
}

void Plater::refresh_canvases() {
    if (this->canvas2D != nullptr)
        this->canvas2D->Refresh();
    if (this->canvas3D != nullptr)
        this->canvas3D->update();
    if (this->previewDLP != nullptr)
        this->previewDLP->reload_print();

}

ObjRef Plater::selected_object() {
    Slic3r::Log::info(LogChannel, L"Calling selected_object()");
    auto it {this->objects.begin()};
    for (; it != this->objects.end(); it++)
        if (it->selected) return it;
    Slic3r::Log::info(LogChannel, L"No object selected.");
    return this->objects.end();
}

void Plater::object_settings_dialog() { object_settings_dialog(this->selected_object()); }
void Plater::object_settings_dialog(ObjIdx obj_idx) { object_settings_dialog(this->objects.begin() + obj_idx); }
void Plater::object_settings_dialog(ObjRef obj) {

}

void Plater::select_object(ObjRef obj) {
    for (auto& o : this->objects) {
        o.selected = false;
        o.selected_instance = -1;
    }
    // range check the iterator
    if (obj < this->objects.end() && obj >= this->objects.begin()) {
        obj->selected = true;
        obj->selected_instance = 0;
    }
    this->selection_changed(); // selection_changed(1) in perl
}

void Plater::select_object(ObjIdx obj_idx) {
    // callers pass -1 for "none"
    this->select_object(obj_idx < this->objects.size() ? this->objects.begin() + obj_idx : this->objects.end());
}

void Plater::select_object() {
    this->select_object(this->objects.end());
}

void Plater::selection_changed() {
    // Remove selection in 2D plater
    this->canvas2D->set_selected(-1, -1);
    this->canvas3D->selection_changed();

    auto obj = this->selected_object();
    bool have_sel {obj != this->objects.end()};
    auto* menu {this->GetFrame()->plater_select_menu};
    if (menu != nullptr) {
        for (auto item = menu->GetMenuItems().begin(); item != menu->GetMenuItems().end(); item++) {
            (*item)->Check(false);
        }
        const size_t position = obj - this->objects.begin();
        if (have_sel && position < menu->GetMenuItemCount())  // the menu may not be rebuilt yet
            menu->FindItemByPosition(position)->Check(true);
    }

    if (this->htoolbar != nullptr) {
        for (auto tb : {TB_REMOVE, TB_MORE, TB_FEWER, TB_45CW, TB_45CCW, TB_SCALE, TB_SPLIT, TB_CUT, TB_LAYERS, TB_SETTINGS}) {
            this->htoolbar->EnableTool(tb, have_sel);
        }
    }
    // object info (as the Perl GUI)
    auto& info {this->object_info};
    if (have_sel) {
        const size_t obj_idx = obj - this->objects.begin();
        const ModelObject* model_object {this->model->objects.at(obj_idx)};
        info.choice->SetSelection(obj_idx);
        info.copies->SetLabel(wxString::Format("%zu", model_object->instances.size()));
        const ModelInstance* instance {model_object->instances.front()};
        const Sizef3 size {model_object->instance_bounding_box(0).size()};
        wxString size_string {wxString::Format("%.2f x %.2f x %.2f", size.x, size.y, size.z)};
        if (instance->scaling_factor != 1)
            size_string << wxString::Format(" (%g%%)", instance->scaling_factor * 100);
        info.size->SetLabel(size_string);
        info.materials->SetLabel(wxString::Format("%zu", model_object->materials_count()));
        
        TriangleMesh raw_mesh {model_object->raw_mesh()};
        raw_mesh.repair();  // this calculates number_of_parts
        const auto& stats {raw_mesh.stl.stats};
        info.volume->SetLabel(wxString::Format("%.2f", raw_mesh.volume() * std::pow(instance->scaling_factor, 3)));
        info.facets->SetLabel(wxString::Format("%zu (%d shells)", model_object->facets_count(), stats.number_of_parts));
        const int errors {stats.degenerate_facets + stats.edges_fixed + stats.facets_removed
            + stats.facets_added + stats.facets_reversed + stats.backwards_edges};
        if (errors > 0) {
            const wxString message {wxString::Format(
                "%d degenerate facets, %d edges fixed, %d facets removed, %d facets added, %d facets reversed, %d backwards edges",
                stats.degenerate_facets, stats.edges_fixed, stats.facets_removed, stats.facets_added,
                stats.facets_reversed, stats.backwards_edges)};
            info.manifold->SetLabel(wxString::Format(_("Auto-repaired (%d errors)"), errors));
            info.manifold->SetToolTip(message);
            info.manifold_warning_icon->SetToolTip(message);
            info.manifold_warning_icon->Show();
        } else {
            info.manifold->SetLabel(_("Yes"));
            info.manifold->UnsetToolTip();
            info.manifold_warning_icon->Hide();
        }
    } else {
        info.choice->SetSelection(-1);
        for (auto* field : {info.copies, info.size, info.volume, info.facets, info.materials, info.manifold})
            field->SetLabel("");
        info.manifold->UnsetToolTip();
        info.manifold_warning_icon->Hide();
    }
    this->Layout();
}

void Plater::build_toolbar() {
    wxToolTip::Enable(true);
    auto* toolbar = this->htoolbar = new wxToolBar(this, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxTB_HORIZONTAL | wxTB_TEXT | wxBORDER_SIMPLE | wxTAB_TRAVERSAL);
    toolbar->AddTool(TB_ADD, _(L"Add…"), wxBitmap(var("brick_add.png"), wxBITMAP_TYPE_PNG));
    toolbar->AddTool(TB_REMOVE, _("Delete"), wxBitmap(var("brick_delete.png"), wxBITMAP_TYPE_PNG));
    toolbar->AddTool(TB_RESET, _("Delete All"), wxBitmap(var("cross.png"), wxBITMAP_TYPE_PNG));
    toolbar->AddTool(TB_ARRANGE, _("Arrange"), wxBitmap(var("bricks.png"), wxBITMAP_TYPE_PNG));
    toolbar->AddSeparator();
    toolbar->AddTool(TB_MORE, _("More"), wxBitmap(var("add.png"), wxBITMAP_TYPE_PNG));
    toolbar->AddTool(TB_FEWER, _("Fewer"), wxBitmap(var("delete.png"), wxBITMAP_TYPE_PNG));
    toolbar->AddSeparator();
    toolbar->AddTool(TB_45CCW, _(L"45° ccw"), wxBitmap(var("arrow_rotate_anticlockwise.png"), wxBITMAP_TYPE_PNG));
    toolbar->AddTool(TB_45CW, _(L"45° cw"), wxBitmap(var("arrow_rotate_clockwise.png"), wxBITMAP_TYPE_PNG));
    toolbar->AddTool(TB_SCALE, _(L"Scale…"), wxBitmap(var("arrow_out.png"), wxBITMAP_TYPE_PNG));
    toolbar->AddTool(TB_SPLIT, _("Split"), wxBitmap(var("shape_ungroup.png"), wxBITMAP_TYPE_PNG));
    toolbar->AddTool(TB_CUT, _(L"Cut…"), wxBitmap(var("package.png"), wxBITMAP_TYPE_PNG));
    toolbar->AddSeparator();
    toolbar->AddTool(TB_SETTINGS, _(L"Settings…"), wxBitmap(var("cog.png"), wxBITMAP_TYPE_PNG));
    toolbar->AddTool(TB_LAYERS, _(L"Layer heights…"), wxBitmap(var("variable_layer_height.png"), wxBITMAP_TYPE_PNG));

    toolbar->Realize();


    toolbar->Bind(wxEVT_TOOL, [this](wxCommandEvent &e) { this->add(); }, TB_ADD);
    toolbar->Bind(wxEVT_TOOL, [this](wxCommandEvent &e) { this->remove(); }, TB_REMOVE);
    toolbar->Bind(wxEVT_TOOL, [this](wxCommandEvent &e) { this->reset(); }, TB_RESET);
    toolbar->Bind(wxEVT_TOOL, [this](wxCommandEvent &e) { this->arrange(); }, TB_ARRANGE);
    toolbar->Bind(wxEVT_TOOL, [this](wxCommandEvent &e) { this->increase(); }, TB_MORE);
    toolbar->Bind(wxEVT_TOOL, [this](wxCommandEvent &e) { this->decrease(); }, TB_FEWER);
    toolbar->Bind(wxEVT_TOOL, [this](wxCommandEvent &e) { this->rotate(-45.); }, TB_45CW);
    toolbar->Bind(wxEVT_TOOL, [this](wxCommandEvent &e) { this->rotate(45.); }, TB_45CCW);
    toolbar->Bind(wxEVT_TOOL, [this](wxCommandEvent &e) { this->changescale(); }, TB_SCALE);
    toolbar->Bind(wxEVT_TOOL, [this](wxCommandEvent &e) { this->split_object(); }, TB_SPLIT);
    toolbar->Bind(wxEVT_TOOL, [this](wxCommandEvent &e) { this->object_cut_dialog(); }, TB_CUT);
    toolbar->Bind(wxEVT_TOOL, [this](wxCommandEvent &e) { this->object_layers_dialog(); }, TB_LAYERS);
    toolbar->Bind(wxEVT_TOOL, [this](wxCommandEvent &e) { this->object_settings_dialog(); }, TB_SETTINGS);
}

void Plater::zoom(Zoom dir) {
    const double factor {dir == Zoom::In ? 1.25 : 0.8};
    const wxWindow* page {this->preview_notebook->GetCurrentPage()};
    if (page == this->canvas3D) this->canvas3D->zoom_by(factor);
    else if (page == this->preview3D) this->preview3D->scene().zoom_by(factor);
    else if (page == this->preview2D) this->preview2D->zoom_by(factor);
}

void Plater::select_view(float phi, float theta) {
    this->canvas3D->select_view(phi, theta);
    this->preview3D->scene().select_view(phi, theta);
}

void Plater::object_layers_dialog() {
    //TODO
}

void Plater::object_list_changed() {
    // the object choice in the info box (as the Perl GUI)
    this->object_info.choice->Clear();
    for (const auto& object : this->objects)
        this->object_info.choice->Append(object.name);
    this->selection_changed();
}

wxMenu* Plater::object_menu() {
    auto* menu {new wxMenu()};
    auto item = [menu](const wxString& name, const wxString& help, std::function<void()> action,
            const wxString& icon = "", const wxString& accelerator = "") {
        append_menu_item(menu, name, help, [action](wxCommandEvent&) { action(); }, wxID_ANY, icon, accelerator);
    };
    item(_("Delete"), _("Remove the selected object."), [this]() { this->remove(); }, "brick_delete.png", "Ctrl+Del");
    item(_("Increase copies"), _("Place one more copy of the selected object."), [this]() { this->increase(); }, "add.png", "Ctrl++");
    item(_("Decrease copies"), _("Remove one copy of the selected object."), [this]() { this->decrease(); }, "delete.png", "Ctrl+-");
    item(_(L"Set number of copies…"), _("Change the number of copies of the selected object."), [this]() { this->set_number_of_copies(); }, "textfield.png");
    menu->AppendSeparator();
    item(_("Move to bed center"), _("Center object around bed center."), [this]() { this->center_selected_object_on_bed(); }, "arrow_in.png");
    item(_(L"Rotate 45° clockwise"), _(L"Rotate the selected object by 45° clockwise."), [this]() { this->rotate(-45.); }, "arrow_rotate_clockwise.png");
    item(_(L"Rotate 45° counter-clockwise"), _(L"Rotate the selected object by 45° counter-clockwise."), [this]() { this->rotate(45.); }, "arrow_rotate_anticlockwise.png");

    const wxString bullets[] {"bullet_red.png", "bullet_green.png", "bullet_blue.png"};
    const wxString axes[] {"X", "Y", "Z"};
    auto submenu = [&](const wxString& title, const wxString& help, const wxString& icon, bool uniform,
            const wxString& entry, std::function<void(int)> action) {
        auto* sub {new wxMenu()};
        if (uniform)
            append_menu_item(sub, _(L"Uniformly…"), help, [action](wxCommandEvent&) { action(-1); });
        for (int axis = 0; axis < 3; ++axis)
            append_menu_item(sub, wxString::Format(entry, axes[axis]), help,
                [action, axis](wxCommandEvent&) { action(axis); }, wxID_ANY, bullets[axis]);
        append_submenu(menu, title, help, sub, wxID_ANY, icon);
    };
    submenu(_("Rotate"), _("Rotate the selected object by an arbitrary angle"), "textfield.png", false, _(L"Around %s axis…"),
        [this](int axis) { this->rotate(static_cast<Axis>(axis)); });
    submenu(_("Mirror"), _("Mirror the selected object"), "shape_flip_horizontal.png", false, _("Along %s axis"),
        [this](int axis) { this->mirror(static_cast<Axis>(axis)); });
    submenu(_("Scale"), _("Scale the selected object by a given factor"), "arrow_out.png", true, _(L"Along %s axis…"),
        [this](int axis) { this->changescale(axis, false); });
    submenu(_("Scale to size"), _("Scale the selected object to match a given size"), "arrow_out.png", true, _(L"Along %s axis…"),
        [this](int axis) { this->changescale(axis, true); });

    item(_("Split"), _("Split the selected object into individual parts"), [this]() { this->split_object(); }, "shape_ungroup.png");
    item(_(L"Cut…"), _("Open the 3D cutting tool"), [this]() { this->object_cut_dialog(); }, "package.png");
    menu->AppendSeparator();
    item(_("Reload from Disk"), _("Reload the selected file from Disk"), [this]() { this->reload_from_disk(); }, "arrow_refresh.png");
    item(_(L"Export object as STL…"), _("Export this single object as STL file"), [this]() { this->export_object(IO::STL); }, "brick_go.png");
    item(_(L"Export object and modifiers as AMF…"), _("Export this single object and all associated modifiers as AMF file"), [this]() { this->export_object(IO::AMF); }, "brick_go.png");
    item(_(L"Export object and modifiers as 3MF…"), _("Export this single object and all associated modifiers as 3MF file"), [this]() { this->export_object(IO::TMF); }, "brick_go.png");
    return menu;
}

void Plater::show_preset_editor(preset_t group, unsigned int idx) {
    // one editor per group, as a tab of the main window (as the Perl GUI's default)
    auto* frame {GetFrame()};
    auto& editors {frame->preset_editor_tabs};
    auto* tabs {frame->tabs()};
    if (editors.count(group) > 0) {  // exists: show it (a settings button)
        const int page {tabs->FindPage(editors[group])};
        if (page != wxNOT_FOUND) tabs->SetSelection(page);
        return;
    }
    PresetEditor* editor {nullptr};
    switch (group) {
        case preset_t::Print:    editor = new PrintEditor(tabs); break;
        case preset_t::Material: editor = new MaterialEditor(tabs); break;
        case preset_t::Printer:  editor = new PrinterEditor(tabs); break;
        default: return;
    }
    // choosing a preset in the editor chooses it in the plater too
    editor->on_select_preset = [this](wxString name, preset_t type) {
        this->_presets->select_preset_by_name(name, type, 0);
    };
    // after a save or delete every list is read again
    editor->on_save_preset = [this, frame](wxString name, preset_t type) {
        for (auto& tab : frame->preset_editor_tabs) tab.second->reload_list();
        this->_presets->load();
        if (!name.IsEmpty()) this->_presets->select_preset_by_name(name, type, 0);
        this->invalidate_slices();
    };
    editor->on_value_change = [this](std::string) {
        this->refresh_config();
        this->invalidate_slices();
    };
    editors[group] = editor;
    tabs->AddPage(editor, editor->title());
}


void Plater::load_presets() {
    this->_presets->load();
}

}} // Namespace Slic3r::GUI

