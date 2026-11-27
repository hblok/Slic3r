#include "Dialogs/PresetEditor.hpp"

#include <algorithm>

#include <wx/choicdlg.h>
#include <wx/combobox.h>
#include <wx/utils.h>

#include "Dialogs/BedShapeDialog.hpp"
#include "GCodeSender.hpp"
#include "octoprint.hpp"

namespace Slic3r { namespace GUI {

PrinterEditor::PrinterEditor(wxWindow* parent, t_config_option_keys options) : 
    PresetEditor(parent, options) {
    
    this->config = Slic3r::Config::new_from_defaults(this->my_options());
    this->_build();
    this->update_tree();
    this->load_presets();
}

size_t PrinterEditor::extruder_count() const {
    return this->config->config().opt<ConfigOptionFloats>("nozzle_diameter", true)->values.size();
}

// The Perl GUI's pages (PresetEditor::Printer::build).
void PrinterEditor::_build() {
    {
        auto* page {this->add_options_page(_("General"), "printer_empty.png")};
        auto size {this->add_group(page, _("Size and coordinates"))};
        {
            auto* line {new wxBoxSizer(wxHORIZONTAL)};
            line->Add(this->make_button(size.parent, _(L"Set…"), "cog.png", [this]() {
                BedShapeDialog dialog(this, this->config->config().opt<ConfigOptionPoints>("bed_shape", true)->values);
                if (dialog.ShowModal() != wxID_OK) return;
                this->config->config().opt<ConfigOptionPoints>("bed_shape", true)->values = dialog.shape();
                this->_changed("bed_shape");
            }));
            this->add_widget(size, _("Bed shape"), line);
        }
        this->add_option(size, "z_offset");

        auto capabilities {this->add_group(page, _("Capabilities"))};
        {
            this->_extruders = new wxSpinCtrl(capabilities.parent, wxID_ANY, "1", wxDefaultPosition, wxSize(120, -1),
                wxSP_ARROW_KEYS | wxTE_PROCESS_ENTER, 1, 16, 1);
            this->_extruders->SetToolTip(_("Number of extruders of the printer."));
            auto changed = [this]() {
                // not from within the control's event: pages are rebuilt
                this->CallAfter([this]() { this->_set_extruder_count(this->_extruders->GetValue()); });
            };
            this->_extruders->Bind(wxEVT_SPINCTRL, [changed](wxSpinEvent&) { changed(); });
            this->_extruders->Bind(wxEVT_TEXT_ENTER, [changed](wxCommandEvent&) { changed(); });
            this->_extruders->Bind(wxEVT_KILL_FOCUS, [changed](wxFocusEvent& e) { changed(); e.Skip(); });
            auto* line {new wxBoxSizer(wxHORIZONTAL)};
            line->Add(this->_extruders);
            this->add_widget(capabilities, _("Extruders"), line);
        }
        this->add_option(capabilities, "has_heatbed");

        auto serial {this->add_group(page, _("USB/Serial connection"), 90)};
        {
            auto* line {new wxBoxSizer(wxHORIZONTAL)};
            line->Add(this->add_control(serial, "serial_port", -1, 140), 0, wxALIGN_CENTER_VERTICAL);
            auto* rescan {new wxBitmapButton(serial.parent, wxID_ANY,
                wxBitmap(var("arrow_rotate_clockwise.png"), wxBITMAP_TYPE_PNG), wxDefaultPosition, wxDefaultSize, wxBORDER_NONE)};
            rescan->SetToolTip(_("Rescan serial ports"));
            rescan->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) {
                const auto& entry {this->_controls.at("serial_port")};
                if (auto* ports = dynamic_cast<wxComboBox*>(entry.control.window)) {
                    ports->Clear();
                    for (const auto& port : scan_serial_ports()) ports->Append(port);
                    entry.control.refresh();
                }
            });
            line->Add(rescan, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, 2);
            line->Add(new wxStaticText(serial.parent, wxID_ANY, _("Speed:")), 0, wxALIGN_CENTER_VERTICAL | wxLEFT | wxRIGHT, 4);
            line->Add(this->add_control(serial, "serial_speed", -1, 100), 0, wxALIGN_CENTER_VERTICAL);
            this->_serial_test = this->make_button(serial.parent, _("Test"), "wrench.png", [this]() { this->_test_serial(); });
            line->Add(this->_serial_test, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, 4);
            this->add_widget(serial, _("Serial port"), line);
        }

        auto server {this->add_group(page, _("Print server upload"), 90)};
        this->add_option(server, "host_type");
        {
            auto* line {new wxBoxSizer(wxHORIZONTAL)};
            line->Add(this->add_control(server, "print_host", -1, 200), 0, wxALIGN_CENTER_VERTICAL);
            this->_host_browse = this->make_button(server.parent, _(L"Browse…"), "zoom.png", [this]() { this->_browse_octoprint(); });
            this->_host_test = this->make_button(server.parent, _("Test"), "wrench.png", [this]() { this->_test_octoprint(); });
            line->Add(this->_host_browse, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, 4);
            line->Add(this->_host_test, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, 4);
            this->add_widget(server, _("Host"), line);
        }
        this->add_option(server, "octoprint_apikey", -1, 300);

        auto firmware {this->add_group(page, _("Firmware"))};
        this->add_option(firmware, "gcode_flavor");
        auto advanced {this->add_group(page, _("Advanced"))};
        for (const char* key : {"use_relative_e_distances", "use_firmware_retraction", "use_volumetric_e",
                "pressure_advance", "vibration_limit", "z_steps_per_mm", "machine_acceleration",
                "use_set_and_wait_extruder", "use_set_and_wait_bed", "fan_percentage"})
            this->add_option(advanced, key);
    }
    {
        auto* page {this->add_options_page(_("Custom G-code"), "script.png")};
        const std::pair<wxString, const char*> codes[] {
            {_("Start G-code"), "start_gcode"}, {_("End G-code"), "end_gcode"},
            {_("Before layer change G-code"), "before_layer_gcode"}, {_("After layer change G-code"), "layer_gcode"},
            {_("Tool change G-code"), "toolchange_gcode"},
            {_("Between objects G-code (for sequential printing)"), "between_objects_gcode"}};
        for (const auto& code : codes) {
            auto group {this->add_group(page, code.first, 0)};
            this->add_option(group, code.second, -1, 400, 150);
        }
    }
    {
        auto* page {this->add_options_page(_("Notes"), "note.png")};
        auto notes {this->add_group(page, _("Notes"), 0)};
        this->add_option(notes, "printer_notes", -1, 400, 250);
    }
    this->_build_extruder_pages(1);
}

/// One page for each extruder, after the other pages.
void PrinterEditor::_build_extruder_pages(size_t count) {
    if (count == this->_extruder_pages.size()) return;
    while (this->_extruder_pages.size() > count) {
        this->remove_page(this->_extruder_pages.back());
        this->_extruder_pages.pop_back();
    }
    while (this->_extruder_pages.size() < count) {
        const int i {static_cast<int>(this->_extruder_pages.size())};
        auto* page {this->add_options_page(wxString::Format(_("Extruder %d"), i + 1), "funnel.png")};
        this->_extruder_pages.push_back(page);
        auto size {this->add_group(page, _("Size"))};
        this->add_option(size, "nozzle_diameter", i);
        auto limits {this->add_group(page, _("Layer Height Limits"))};
        for (const char* key : {"min_layer_height", "max_layer_height"}) this->add_option(limits, key, i);
        auto position {this->add_group(page, _("Position (for multi-extruder printers)"))};
        this->add_option(position, "extruder_offset", i);
        auto retraction {this->add_group(page, _("Retraction"))};
        for (const char* key : {"retract_length", "retract_lift"}) this->add_option(retraction, key, i);
        this->add_line(retraction, _("Only lift Z"), {"retract_lift_above", "retract_lift_below"}, i);
        for (const char* key : {"retract_speed", "retract_restart_extra", "retract_before_travel",
                "retract_layer_change", "wipe"})
            this->add_option(retraction, key, i);
        auto disabled {this->add_group(page, _("Retraction when tool is disabled (advanced settings for multi-extruder setups)"))};
        for (const char* key : {"retract_length_toolchange", "retract_restart_extra_toolchange"})
            this->add_option(disabled, key, i);
    }
    this->update_tree();
}

void PrinterEditor::_on_preset_loaded() {
    // as many extruders as the preset has nozzles
    const size_t count {std::max<size_t>(this->extruder_count(), 1)};
    this->_extruders->SetValue(static_cast<int>(count));
    for (const auto& key : PrinterEditor::extruder_options())
        resize_option(this->config->config(), key, count);
    this->_build_extruder_pages(count);
}

void PrinterEditor::_set_extruder_count(size_t count) {
    if (this->config == nullptr || count < 1 || count == this->extruder_count()) return;
    // a new extruder starts with the last one's values
    for (const auto& key : PrinterEditor::extruder_options())
        resize_option(this->config->config(), key, count);
    this->_build_extruder_pages(count);
    this->_changed("extruders_count");
}

void PrinterEditor::_update() {
    DynamicPrintConfig& config {this->config->config()};
    const bool port {config.has("serial_port") && !config.serialize("serial_port").empty()};
    const bool octoprint {config.has("host_type") && config.serialize("host_type") == "octoprint"};
    this->_serial_test->Enable(port && config.serialize("serial_speed") != "0");
    this->_host_browse->Enable(octoprint && has_avahi_browse());
    this->_host_test->Enable(octoprint);
}

void PrinterEditor::_test_serial() {
    DynamicPrintConfig& config {this->config->config()};
    bool connected {false};
    {
        wxBusyCursor busy;
        try {
            GCodeSender sender;
            connected = sender.connect(option_text(config, "serial_port"), std::atoi(config.serialize("serial_speed").c_str()))
                && sender.wait_connected();
            sender.disconnect();
        } catch (std::exception&) {
            connected = false;
        }
    }
    if (connected) show_info(this, _("Connection to printer works correctly."), _("Success!"));
    else show_error(this, _("Connection failed."));
}

void PrinterEditor::_test_octoprint() {
    DynamicPrintConfig& config {this->config->config()};
    const HttpAnswer answer {http_request(option_text(config, "print_host"), "/api/version",
        option_text(config, "octoprint_apikey"))};
    if (answer.ok()) show_info(this, _("Connection to OctoPrint works correctly."), _("Success!"));
    else show_error(this, wxString::Format(
        _("I wasn't able to connect to OctoPrint (%s). Check hostname and OctoPrint version (at least 1.1.0 is required)."),
        answer.status_text()));
}

/// OctoPrint devices announced in the network (Bonjour), as avahi-browse finds them.
void PrinterEditor::_browse_octoprint() {
    wxArrayString lines, errors;
    {
        wxBusyCursor busy;
        wxExecute("avahi-browse --parsable --resolve --terminate _octoprint._tcp", lines, errors,
            wxEXEC_SYNC | wxEXEC_NODISABLE);
    }
    wxArrayString names, hosts;
    for (const auto& line : lines) {
        // =;interface;protocol;name;type;domain;host name;address;port;txt
        const wxArrayString fields = wxSplit(line, ';', 0);
        if (fields.size() < 9 || fields[0] != "=" || fields[2] != "IPv4") continue;
        const wxString host {fields[7] + ":" + fields[8]};
        if (hosts.Index(host) != wxNOT_FOUND) continue;
        names.Add(fields[3] + " (" + host + ")");
        hosts.Add(host);
    }
    if (hosts.empty()) {
        show_info(this, _("No Bonjour device found"), _("Device Browser"));
        return;
    }
    const int chosen {wxGetSingleChoiceIndex(_("Choose an OctoPrint device in your network:"), _("Device Browser"), names, this)};
    if (chosen < 0) return;
    this->config->config().opt<ConfigOptionString>("print_host", true)->value = hosts[chosen].ToUTF8().data();
    this->_changed("print_host");
}
}} // namespace Slic3r::GUI
