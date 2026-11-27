// The Perl GUI's Projector.pm and SLAPrintOptions.pm.
#include "Projector/Projector.hpp"

#include <algorithm>
#include <sstream>

#include <wx/combobox.h>
#include <wx/display.h>
#include <wx/filedlg.h>
#include <wx/power.h>
#include <wx/progdlg.h>

#include "OptionsGroup/OptionControl.hpp"
#include "PlaceholderParser.hpp"
#include "misc_ui.hpp"

namespace Slic3r { namespace GUI {

namespace {

/// A titled box with rows of "label: control".
struct Group {
    wxStaticBoxSizer* box;
    wxFlexGridSizer* grid;
    Group(wxWindow* parent, wxSizer* into, const wxString& title) :
        box(new wxStaticBoxSizer(wxVERTICAL, parent, title)), grid(new wxFlexGridSizer(2, 4, 8))
    {
        grid->AddGrowableCol(1, 1);
        box->Add(grid, 0, wxEXPAND | wxALL, 5);
        into->Add(box, 0, wxEXPAND | wxLEFT | wxRIGHT | wxBOTTOM, 10);
    }
    wxWindow* parent() const { return box->GetStaticBox(); }
    void add(const wxString& label, wxWindow* control) {
        grid->Add(new wxStaticText(parent(), wxID_ANY, label + ":", wxDefaultPosition, wxSize(160, -1)), 0, wxALIGN_CENTER_VERTICAL);
        grid->Add(control, 0, wxALIGN_CENTER_VERTICAL);
    }
    void add(const wxString& label, wxSizer* controls) {
        grid->Add(new wxStaticText(parent(), wxID_ANY, label + ":", wxDefaultPosition, wxSize(160, -1)), 0, wxALIGN_CENTER_VERTICAL);
        grid->Add(controls, 0, wxALIGN_CENTER_VERTICAL);
    }
    wxWindow* option(DynamicPrintConfig& config, const std::string& key, const wxString& label = "", const wxString& tooltip = "",
            int width = -1, int height = -1) {
        const OptionControl control {make_option_control(parent(), key,
            [&config]() -> DynamicPrintConfig& { return config; }, []() {}, -1, width, height)};
        control.refresh();
        control.window->SetToolTip(tooltip.IsEmpty() ? wxString::FromUTF8(print_config_def.get(key).tooltip.c_str()) : tooltip);
        add(label.IsEmpty() ? option_name(key) : label, control.window);
        return control.window;
    }
};

double number(const DynamicPrintConfig& config, const char* key) { return std::atof(config.serialize(key).c_str()); }

} // namespace

bool ask_sla_options(wxWindow* parent, const DynamicPrintConfig& config, DynamicPrintConfig& sla) {
    SLAPrintConfig defaults;
    sla.clear();
    for (const auto& key : defaults.keys()) {
        if (key == "threads") continue;
        sla.set_deserialize(key, config.has(key) ? config.serialize(key) : defaults.serialize(key));
    }
    // widths the print presets leave at "automatic"
    const std::pair<const char*, const char*> widths[] {
        {"infill_extrusion_width", "0.5"}, {"support_material_extrusion_width", "1"}, {"perimeter_extrusion_width", "1"}};
    for (const auto& width : widths)
        if (number(sla, width.first) == 0) sla.set_deserialize(width.first, width.second);

    wxDialog dialog(parent, wxID_ANY, _("SLA/DLP Print"));
    auto* sizer {new wxBoxSizer(wxVERTICAL)};
    {
        Group layers(&dialog, sizer, _("Layers"));
        layers.option(sla, "layer_height");
        layers.option(sla, "first_layer_height");
        Group infill(&dialog, sizer, _("Infill"));
        infill.option(sla, "fill_density");
        infill.option(sla, "fill_pattern");
        infill.option(sla, "perimeter_extrusion_width", _("Shell thickness (mm)"),
            _("Thickness of the external shell (both horizontal and vertical)."));
        infill.option(sla, "infill_extrusion_width", _("Infill thickness (mm)"), _("Thickness of the infill lines."));
        infill.option(sla, "fill_angle");
        Group raft(&dialog, sizer, _("Raft"));
        raft.option(sla, "raft_layers");
        raft.option(sla, "raft_offset");
        Group support(&dialog, sizer, _("Support Material"));
        support.option(sla, "support_material");
        support.option(sla, "support_material_spacing", _("Pillars spacing (mm)"),
            _("Max spacing between support material pillars."));
        support.option(sla, "support_material_extrusion_width", _("Pillars diameter (mm)"),
            _("Diameter of the cylindrical support pillars. 0.4mm and higher is supported."));
    }
    sizer->Add(dialog.CreateButtonSizer(wxOK | wxCANCEL), 0, wxALIGN_RIGHT | wxALL, 10);
    dialog.SetSizerAndFit(sizer);
    dialog.Bind(wxEVT_BUTTON, [&dialog, &sla](wxCommandEvent& e) {
        commit_pending_edit();
        const bool hollow {number(sla, "fill_density") < 100};
        if (hollow && number(sla, "perimeter_extrusion_width") == 0)
            show_error(&dialog, _("Invalid shell thickness (must be greater than 0)."));
        else if (hollow && number(sla, "infill_extrusion_width") == 0)
            show_error(&dialog, _("Invalid infill thickness (must be greater than 0)."));
        else if (number(sla, "layer_height") <= 0)
            show_error(&dialog, _("Invalid layer height."));
        else
            e.Skip();
    }, wxID_OK);
    return dialog.ShowModal() == wxID_OK;
}

namespace {
/// Kept between openings of the dialog when the user leaves the screen black.
ProjectorScreen* screen {nullptr};
}

ProjectorDialog::ProjectorDialog(const Slic3r::Model& model, const DynamicPrintConfig& config, const wxString& datadir) :
    wxDialog(nullptr, wxID_ANY, _("Projector for DLP"), wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER),
    _config(config), _ini(datadir + "/DLP.ini"), _print(&model), _timer(this)
{
    this->_settings.load(this->_ini);
    this->_print.config.apply(this->_config, true);
    {
        wxProgressDialog progress(_(L"Slicing…"), _(L"Processing layers…"), 100, nullptr);
        progress.Pulse();
        try {
            this->_print.slice();
        } catch (std::exception& e) {
            this->_print.layers.clear();
            show_error(nullptr, wxString::FromUTF8(e.what()));
        }
    }

    auto* sizer {new wxBoxSizer(wxVERTICAL)};
    {
        Group serial(this, sizer, _("USB/Serial connection"));
        auto* row {new wxBoxSizer(wxHORIZONTAL)};
        const auto config_of = [this]() -> DynamicPrintConfig& { return this->_config; };
        const OptionControl port {make_option_control(serial.parent(), "serial_port", config_of, []() {}, -1, 160)};
        const OptionControl speed {make_option_control(serial.parent(), "serial_speed", config_of, []() {}, -1, 110)};
        port.refresh();
        speed.refresh();
        auto* rescan {new wxBitmapButton(serial.parent(), wxID_ANY, wxBitmap(var("arrow_rotate_clockwise.png"), wxBITMAP_TYPE_PNG),
            wxDefaultPosition, wxDefaultSize, wxBORDER_NONE)};
        rescan->SetToolTip(_("Rescan serial ports"));
        rescan->Bind(wxEVT_BUTTON, [port](wxCommandEvent&) {
            if (auto* ports = dynamic_cast<wxComboBox*>(port.window)) {
                ports->Clear();
                for (const auto& name : scan_serial_ports()) ports->Append(name);
                port.refresh();
            }
        });
        auto* test {new wxButton(serial.parent(), wxID_ANY, _("Test"))};
        test->SetBitmap(wxBitmap(var("wrench.png"), wxBITMAP_TYPE_PNG));
        test->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) {
            if (this->_connect()) {
                this->_sender.reset();
                show_info(this, _("Connection to printer works correctly."), _("Success!"));
            }
        });
        row->Add(port.window, 0, wxALIGN_CENTER_VERTICAL);
        row->Add(rescan, 0, wxALIGN_CENTER_VERTICAL);
        row->Add(speed.window, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, 4);
        row->Add(test, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, 4);
        serial.add(_("Serial port"), row);
        this->_groups.push_back(serial.parent());

        Group gcode(this, sizer, _("G-code"));
        gcode.option(this->_config, "start_gcode", "", "", 400, 60);
        gcode.option(this->_config, "end_gcode", "", "", 400, 60);
        this->_groups.push_back(gcode.parent());

        ProjectorSettings& settings {this->_settings};
        auto field = [this](wxWindow* parent, double& value, std::function<void()> after = nullptr) {
            auto* text {new wxTextCtrl(parent, wxID_ANY, wxString::Format("%g", value), wxDefaultPosition, wxSize(60, -1))};
            text->Bind(wxEVT_TEXT, [this, text, &value](wxCommandEvent&) {
                double typed;
                if (!text->GetValue().ToDouble(&typed)) return;
                value = typed;
                this->_settings_changed();
            });
            return text;
        };
        auto check = [this](wxWindow* parent, const wxString& label, bool& value) {
            auto* box {new wxCheckBox(parent, wxID_ANY, label)};
            box->SetValue(value);
            box->Bind(wxEVT_CHECKBOX, [this, box, &value](wxCommandEvent&) { value = box->GetValue(); this->_settings_changed(); });
            return box;
        };
        auto labelled = [](wxWindow* parent, wxSizer* line, const wxString& label, wxWindow* control, const wxString& unit = "") {
            line->Add(new wxStaticText(parent, wxID_ANY, label), 0, wxALIGN_CENTER_VERTICAL | wxRIGHT, 3);
            line->Add(control, 0, wxALIGN_CENTER_VERTICAL);
            if (!unit.IsEmpty()) line->Add(new wxStaticText(parent, wxID_ANY, unit), 0, wxALIGN_CENTER_VERTICAL | wxLEFT, 3);
            line->AddSpacer(10);
        };

        Group projection(this, sizer, _("Projection"));
        {
            auto* line {new wxBoxSizer(wxHORIZONTAL)};
            wxWindow* parent {projection.parent()};
            auto* display {new wxChoice(parent, wxID_ANY)};
            for (unsigned int i = 0; i < wxDisplay::GetCount(); ++i) display->Append(wxString::Format("%u", i));
            display->SetSelection(settings.display < static_cast<int>(display->GetCount()) ? settings.display : 0);
            display->Bind(wxEVT_CHOICE, [this, display](wxCommandEvent&) {
                this->_settings.display = display->GetSelection();
                this->_settings_changed();
            });
            labelled(parent, line, _("Display"), display);
            labelled(parent, line, _("Zoom %"), field(parent, settings.zoom));
            labelled(parent, line, _("Offset x"), field(parent, settings.offset_x));
            labelled(parent, line, "y", field(parent, settings.offset_y));
            line->Add(check(parent, _("Invert Y"), settings.invert_y), 0, wxALIGN_CENTER_VERTICAL);
            projection.add(_("Screen"), line);
            projection.add(_("Show bed"), check(parent, "", settings.show_bed));
        }
        this->_groups.push_back(projection.parent());

        Group print(this, sizer, _("Print"));
        {
            wxWindow* parent {print.parent()};
            auto* times {new wxBoxSizer(wxHORIZONTAL)};
            labelled(parent, times, _("Bottom exposure"), field(parent, settings.bottom_exposure_time));
            labelled(parent, times, _("Exposure"), field(parent, settings.exposure_time));
            labelled(parent, times, _("Settle"), field(parent, settings.settle_time));
            print.add(_("Time (seconds)"), times);
            auto* layers {new wxSpinCtrl(parent, wxID_ANY, "", wxDefaultPosition, wxSize(130, -1), wxSP_ARROW_KEYS, 0, 10000,
                settings.bottom_layers)};
            layers->Bind(wxEVT_SPINCTRL, [this, layers](wxSpinEvent&) {
                this->_settings.bottom_layers = layers->GetValue();
                this->_settings_changed();
            });
            print.add(_("Bottom layers"), layers);
            auto* lift {new wxBoxSizer(wxHORIZONTAL)};
            labelled(parent, lift, _("Distance"), field(parent, settings.z_lift), "mm");
            labelled(parent, lift, _("Speed"), field(parent, settings.z_lift_speed), "mm/s");
            print.add(_("Z Lift"), lift);
        }
        this->_groups.push_back(print.parent());
    }

    auto* controls {new wxBoxSizer(wxHORIZONTAL)};
    auto button = [this, controls](const wxString& label, const wxString& icon, std::function<void()> action) {
        auto* out {new wxButton(this, wxID_ANY, label)};
        out->SetBitmap(wxBitmap(var(icon), wxBITMAP_TYPE_PNG));
        out->Bind(wxEVT_BUTTON, [action](wxCommandEvent&) { action(); });
        controls->Add(out);
        return out;
    };
    this->_manual_control = button(_("Manual Control"), "cog.png", [this]() {
        if (!this->_connect()) return;
        ManualControlDialog dialog(this, this->_config, *this->_sender, this->_manual, nullptr);
        dialog.ShowModal();
        this->_sender.reset();
    });
    this->_print_button = button(_("Print"), "control_play.png", [this]() { this->_start(); });
    this->_stop = button(_("Stop/Black"), "control_stop.png", [this]() { this->_stop_print(); });
    controls->Add(new wxStaticText(this, wxID_ANY, _("Layer:")), 0, wxALIGN_CENTER_VERTICAL | wxLEFT, 10);
    const int last {std::max(this->layer_count() - 1, 0)};
    this->_layer_spin = new wxSpinCtrl(this, wxID_ANY, "0", wxDefaultPosition, wxSize(130, -1), wxSP_ARROW_KEYS, 0, last, 0);
    this->_layer_slider = new wxSlider(this, wxID_ANY, 0, 0, std::max(last, 1));
    this->_layer_spin->Bind(wxEVT_SPINCTRL, [this](wxSpinEvent&) {
        this->_layer_slider->SetValue(this->_layer_spin->GetValue());
        this->_project(this->_layer_spin->GetValue());
    });
    this->_layer_slider->Bind(wxEVT_SLIDER, [this](wxCommandEvent&) {
        this->_layer_spin->SetValue(this->_layer_slider->GetValue());
        this->_project(this->_layer_slider->GetValue());
    });
    controls->Add(this->_layer_spin);
    controls->Add(this->_layer_slider, 1);
    sizer->Add(controls, 0, wxEXPAND | wxLEFT | wxRIGHT | wxBOTTOM, 10);
    this->_status = new wxStaticText(this, wxID_ANY, "");
    sizer->Add(this->_status, 0, wxEXPAND | wxLEFT | wxRIGHT | wxBOTTOM, 10);
    auto* bottom {new wxBoxSizer(wxHORIZONTAL)};
    auto* svg {new wxButton(this, wxID_ANY, _(L"Export SVG…"))};
    svg->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->_export_svg(); });
    auto* close {new wxButton(this, wxID_ANY, _("Close"))};
    close->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->_close(); });
    close->SetDefault();
    bottom->Add(svg);
    bottom->AddStretchSpacer(1);
    bottom->Add(close);
    sizer->Add(bottom, 0, wxEXPAND | wxLEFT | wxRIGHT | wxBOTTOM, 10);
    this->SetSizerAndFit(sizer);
    this->Bind(wxEVT_CLOSE_WINDOW, [this](wxCloseEvent&) { this->_close(); });
    this->Bind(wxEVT_TIMER, [this](wxTimerEvent&) {
        const std::function<void()> next {this->_next};
        this->_next = nullptr;
        if (next) next();
    });

    // no screen saver while the projector is in use
    wxPowerResource::Acquire(wxPOWER_RESOURCE_SCREEN, "Slic3r DLP projector");
    if (screen == nullptr) screen = new ProjectorScreen();
    screen->set_source(&this->_print, this->_config.opt<ConfigOptionPoints>("bed_shape", true)->values, &this->_settings);
    screen->reposition();
    screen->Show();
    this->_update_buttons();
    this->_show_print_time();
}

ProjectorDialog::~ProjectorDialog() {
    this->_timer.Stop();
    this->_sender.reset();
    wxPowerResource::Release(wxPOWER_RESOURCE_SCREEN);
}

void ProjectorDialog::_settings_changed() {
    this->_settings.save(this->_ini);
    if (screen != nullptr) screen->reposition();
    this->_show_print_time();
}

void ProjectorDialog::_delay(double seconds, std::function<void()> then) {
    this->_next = then;
    this->_timer.StartOnce(std::max(1, static_cast<int>(seconds * 1000)));
}

bool ProjectorDialog::_connect() {
    commit_pending_edit();
    wxBusyCursor busy;
    this->_sender.reset(new GCodeSender());
    bool connected {false};
    try {
        const int speed {static_cast<int>(number(this->_config, "serial_speed"))};
        connected = speed > 0 && this->_sender->connect(option_text(this->_config, "serial_port"), speed)
            && this->_sender->wait_connected();
    } catch (std::exception&) {
        connected = false;
    }
    if (!connected) {
        this->_sender.reset();
        show_error(this, _("Connection failed. Check serial port and speed."));
    }
    return connected;
}

namespace {
/// The lines of the custom G-code option `key`, [placeholders] filled in, without the
/// comment lines.
std::vector<std::string> gcode_lines(DynamicPrintConfig& config, const std::string& key) {
    PlaceholderParser placeholders;
    placeholders.apply_config(config);
    std::vector<std::string> lines;
    std::istringstream in(placeholders.process(option_text(config, key)));
    for (std::string line; std::getline(in, line); )
        if (!line.empty() && line[0] != ';') lines.push_back(line);
    return lines;
}
}

void ProjectorDialog::_start() {
    if (this->layer_count() == 0 || !this->_connect()) return;
    this->_printing = true;
    this->_layer = -1;
    this->_update_buttons();
    this->_set_status("");
    // the printer needs a moment after the connection; then the start G-code
    this->_delay(4, [this]() {
        for (const auto& line : gcode_lines(this->_config, "start_gcode")) this->_sender->send(line, true);
        this->_sender->send("G90", true);
        this->_delay(5, [this]() {
            screen->project(-1);  // start with black
            this->_delay(this->_settings.settle_time, [this]() { this->_next_layer(); });
        });
    });
}

void ProjectorDialog::_next_layer() {
    ++this->_layer;
    if (this->_layer >= this->layer_count()) {
        // the end G-code goes out before the connection is closed
        this->_sender->send(gcode_lines(this->_config, "end_gcode"));
        this->_finish();
        return;
    }
    this->_layer_spin->SetValue(this->_layer);
    this->_layer_slider->SetValue(this->_layer);
    const double z {this->_print.layers[this->_layer].print_z};
    const int left {static_cast<int>(this->_remaining_time())};
    this->_set_status(wxString::Format(_("Printing layer %d/%d (z = %.2f); %d minutes and %d seconds left"),
        this->_layer, this->layer_count(), z, left / 60, left % 60));
    const double at {z + number(this->_config, "z_offset")};
    const int speed {static_cast<int>(this->_settings.z_lift_speed * 60)};
    if (this->_settings.z_lift != 0)
        this->_sender->send(wxString::Format("G1 Z%.5f F%d", at + this->_settings.z_lift, speed).ToStdString(), true);
    this->_sender->send(wxString::Format("G1 Z%.5f F%d", at, speed).ToStdString(), true);
    // ponytail: waits the settle time, not for the printer to finish the move (as Perl)
    this->_delay(this->_settings.settle_time, [this]() {
        screen->project(this->_layer);
        const double exposure {this->_layer < this->_settings.bottom_layers
            ? this->_settings.bottom_exposure_time : this->_settings.exposure_time};
        this->_delay(exposure, [this]() {
            screen->project(-1);
            this->_next_layer();
        });
    });
}

void ProjectorDialog::_finish() {
    if (this->_sender != nullptr && this->_sender->queue_size() > 0) {
        this->_delay(0.5, [this]() { this->_finish(); });
        return;
    }
    this->_delay(1, [this]() {
        this->_stop_print();
        wxBell();
    });
}

void ProjectorDialog::_stop_print() {
    this->_timer.Stop();
    this->_next = nullptr;
    this->_sender.reset();
    this->_printing = false;
    if (screen != nullptr) screen->project(-1);
    this->_update_buttons();
    this->_set_status("");
}

void ProjectorDialog::_project(int layer) {
    if (screen != nullptr) screen->project(layer < this->layer_count() ? layer : -1);
    this->_update_buttons();
}

void ProjectorDialog::_update_buttons() {
    const bool projecting {screen != nullptr && screen->layer() >= 0};
    this->_manual_control->Show(!this->_printing);
    this->_print_button->Show(!this->_printing && !projecting);
    this->_stop->Show(this->_printing || projecting);
    this->_layer_spin->Enable(!this->_printing);
    this->_layer_slider->Enable(!this->_printing);
    for (auto* group : this->_groups) group->Enable(!this->_printing);
    this->Layout();
}

void ProjectorDialog::_set_status(const wxString& text) {
    this->_status->SetLabel(text);
    this->Layout();
}

double ProjectorDialog::_remaining_time() const {
    const int remaining {this->layer_count() - this->_layer};
    const int bottom {std::max(this->_settings.bottom_layers - std::max(this->_layer, 0), 0)};
    return bottom * this->_settings.bottom_exposure_time + (remaining - bottom) * this->_settings.exposure_time
        + remaining * this->_settings.settle_time;
}

void ProjectorDialog::_show_print_time() {
    if (this->_status == nullptr) return;
    const double time {this->_settings.bottom_layers * this->_settings.bottom_exposure_time
        + (this->layer_count() - this->_settings.bottom_layers) * this->_settings.exposure_time
        + this->layer_count() * this->_settings.settle_time};
    double volume {0};  // mm3
    double below {0};
    for (const auto& layer : this->_print.layers) {
        for (const auto& slice : layer.slices.expolygons) volume += unscale(unscale(slice.area())) * (layer.print_z - below);
        below = layer.print_z;
    }
    const int seconds {static_cast<int>(time)};
    this->_set_status(wxString::Format(_("Estimated print time: %d minutes and %d seconds - %.2f liters"),
        seconds / 60, seconds % 60, volume / 1000 / 1000));
}

void ProjectorDialog::_export_svg() {
    wxFileDialog dialog(this, _("Save SVG file as:"), ui_settings->last_output_path, "print.svg",
        wxString(FILE_WILDCARDS.at("svg")), wxFD_SAVE | wxFD_OVERWRITE_PROMPT);
    if (dialog.ShowModal() != wxID_OK) return;
    try {
        this->_print.write_svg(dialog.GetPath().ToUTF8().data());
        this->_set_status(_("SVG file exported to ") + dialog.GetPath());
    } catch (std::exception& e) {
        show_error(this, wxString::FromUTF8(e.what()));
    }
}

void ProjectorDialog::_close() {
    bool keep {false};
    if (screen != nullptr) {
        // the screen on another display than this dialog may stay, black
        const int display {this->_settings.display < static_cast<int>(wxDisplay::GetCount()) ? this->_settings.display : 0};
        if (!wxDisplay(display).GetGeometry().Contains(this->GetScreenPosition()))
            keep = wxMessageBox(_("Do you want to keep the black screen open?"), _("Black screen"),
                wxYES_NO | wxICON_QUESTION, this) == wxYES;
    }
    this->_stop_print();
    if (screen != nullptr) {
        screen->set_source(nullptr, {}, nullptr);
        if (!keep) {
            screen->Destroy();
            screen = nullptr;
        }
    }
    this->EndModal(wxID_OK);
}

void close_projector_screen() {
    if (screen != nullptr) screen->Destroy();
    screen = nullptr;
}

}} // namespace Slic3r::GUI
