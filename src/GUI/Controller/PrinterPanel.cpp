// The Perl GUI's Controller/PrinterPanel.pm.
#include "Controller/PrinterPanel.hpp"

#include <algorithm>
#include <fstream>

#include <wx/filename.h>

#include "GCodeTimeEstimator.hpp"
#include "GUI.hpp"
#include "misc_ui.hpp"

namespace Slic3r { namespace GUI {

namespace {

wxString timestamp() { return wxDateTime::Now().Format("%H:%M:%S"); }

wxButton* icon_button(wxWindow* parent, const wxString& label, const wxString& icon) {
    auto* button {new wxButton(parent, wxID_ANY, label)};
    button->SetFont(ui_settings->small_font());
    button->SetBitmap(wxBitmap(var(icon), wxBITMAP_TYPE_PNG));
    return button;
}

} // namespace

PrinterPanel::PrinterPanel(wxWindow* parent, const wxString& printer_name, const DynamicPrintConfig& config) :
    wxPanel(parent, wxID_ANY, wxDefaultPosition, wxSize(500, 250)), _name(printer_name), _config(config),
    _status_timer(this), _temperature_timer(this)
{
    auto* box {new wxStaticBoxSizer(wxHORIZONTAL, this, "")};
    wxWindow* inside {box->GetStaticBox()};
    auto* left {new wxBoxSizer(wxVERTICAL)};
    {
        auto* title {new wxStaticText(inside, wxID_ANY, this->_name, wxDefaultPosition, wxSize(220, -1))};
        wxFont font {title->GetFont()};
        font.SetPointSize(20);
        title->SetFont(font);
        left->Add(title, 0, wxEXPAND);
    }
    {
        auto* grid {new wxFlexGridSizer(2, 1, 5)};
        auto label = [inside, grid](const wxString& text) {
            auto* out {new wxStaticText(inside, wxID_ANY, text)};
            out->SetFont(ui_settings->small_font());
            grid->Add(out, 0, wxALIGN_CENTER_VERTICAL);
        };
        auto value = [&config](const char* key) {
            return config.has(key) ? wxString::FromUTF8(config.serialize(key).c_str()) : wxString();
        };
        label(_("Port:"));
        auto* port {new wxBoxSizer(wxHORIZONTAL)};
        this->_port = new wxComboBox(inside, wxID_ANY, value("serial_port"), wxDefaultPosition, wxSize(150, -1));
        this->_scan_ports();
        this->_rescan = new wxBitmapButton(inside, wxID_ANY, wxBitmap(var("arrow_rotate_clockwise.png"), wxBITMAP_TYPE_PNG),
            wxDefaultPosition, wxDefaultSize, wxBORDER_NONE);
        this->_rescan->SetToolTip(_("Rescan serial ports"));
        this->_rescan->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->_scan_ports(); });
        port->Add(this->_port, 0, wxALIGN_CENTER_VERTICAL);
        port->Add(this->_rescan, 0, wxALIGN_CENTER_VERTICAL);
        grid->Add(port);
        label(_("Speed:"));
        auto* speed {new wxBoxSizer(wxHORIZONTAL)};
        const wxString speeds[] {"57600", "115200", "250000"};
        this->_speed = new wxComboBox(inside, wxID_ANY, value("serial_speed"), wxDefaultPosition, wxSize(110, -1), 3, speeds);
        this->_disconnect = icon_button(inside, _("Disconnect"), "delete.png");
        this->_disconnect->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->disconnect(); });
        speed->Add(this->_speed, 0, wxALIGN_CENTER_VERTICAL);
        speed->Add(this->_disconnect, 0, wxLEFT, 5);
        grid->Add(speed);
        left->Add(grid, 0, wxEXPAND | wxTOP, 5);
    }
    this->_connect = new wxButton(inside, wxID_ANY, _("Connect to printer"), wxDefaultPosition, wxSize(-1, 40));
    this->_connect->SetBitmap(wxBitmap(var("arrow_up.png"), wxBITMAP_TYPE_PNG));
    this->_connect->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->connect(); });
    left->Add(this->_connect, 0, wxTOP, 15);
    this->_gauge = new wxGauge(inside, wxID_ANY, 100);
    this->_gauge->Hide();
    left->Add(this->_gauge, 0, wxEXPAND | wxTOP, 15);
    this->_status = new wxStaticText(inside, wxID_ANY, "", wxDefaultPosition, wxSize(200, -1));
    left->Add(this->_status, 1, wxEXPAND | wxTOP, 15);
    this->_manual_control = icon_button(inside, _("Manual control"), "cog.png");
    this->_manual_control->Hide();
    this->_manual_control->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) {
        ManualControlDialog dialog(this, this->_config, *this->_sender, this->_manual);
        dialog.ShowModal();
    });
    left->Add(this->_manual_control, 0, wxTOP, 15);
    {
        this->_temperatures = new wxPanel(inside);
        auto* sizer {new wxBoxSizer(wxHORIZONTAL)};
        auto field = [this, sizer](const wxString& text) {
            auto* label {new wxStaticText(this->_temperatures, wxID_ANY, text)};
            label->SetFont(ui_settings->small_font());
            sizer->Add(label, 0, wxALIGN_CENTER_VERTICAL | wxRIGHT, 3);
            auto* value {new wxStaticText(this->_temperatures, wxID_ANY, "")};
            value->SetFont(ui_settings->small_bold_font());
            value->SetForegroundColour(*wxRED);
            sizer->Add(value, 1, wxALIGN_CENTER_VERTICAL);
            return value;
        };
        this->_temperature = field(_("Temperature:"));
        this->_bed_temperature = field(_("Bed:"));
        this->_temperatures->SetSizer(sizer);
        this->_temperatures->Hide();
        left->Add(this->_temperatures, 0, wxEXPAND | wxTOP | wxBOTTOM, 4);
    }

    auto* queue {new wxBoxSizer(wxVERTICAL)};
    queue->Add(new wxStaticText(inside, wxID_ANY, _("Queue:")), 0, wxEXPAND);
    this->_jobs_panel = new wxScrolledWindow(inside, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxVSCROLL | wxBORDER_NONE);
    this->_jobs_panel->SetScrollRate(0, ui_settings->scroll_step());
    this->_jobs_panel->SetSizer(new wxBoxSizer(wxVERTICAL));
    queue->Add(this->_jobs_panel, 1, wxEXPAND);

    auto* log {new wxBoxSizer(wxVERTICAL)};
    log->Add(new wxStaticText(inside, wxID_ANY, _("Log:")), 0, wxEXPAND);
    this->_log = new wxTextCtrl(inside, wxID_ANY, "", wxDefaultPosition, wxSize(200, -1), wxTE_MULTILINE | wxTE_READONLY | wxBORDER_NONE);
    this->_log->SetFont(ui_settings->small_font());
    log->Add(this->_log, 1, wxEXPAND);

    box->Add(left, 0, wxEXPAND);
    box->Add(queue, 2, wxEXPAND);
    box->Add(log, 1, wxEXPAND | wxLEFT, 15);
    this->SetSizer(box);
    this->SetMinSize(wxSize(-1, 330));

    this->Bind(wxEVT_TIMER, [this](wxTimerEvent&) { this->_poll(); }, this->_status_timer.GetId());
    this->Bind(wxEVT_TIMER, [this](wxTimerEvent&) {
        if (this->_sender != nullptr) this->_sender->send("M105", true);  // through the priority queue
    }, this->_temperature_timer.GetId());
    this->_update_connection_controls();
}

PrinterPanel::~PrinterPanel() {
    this->_status_timer.Stop();
    this->_temperature_timer.Stop();
}

void PrinterPanel::append_to_log(const wxString& text) {
    this->_log->AppendText(text);
}

void PrinterPanel::_scan_ports() {
    const wxString current {this->_port->GetValue()};
    this->_port->Clear();
    for (const auto& port : scan_serial_ports()) this->_port->Append(port);
    this->_port->ChangeValue(current);
}

void PrinterPanel::_update_connection_controls() {
    const bool connected {this->is_connected()};
    const bool idle {this->_printing == nullptr || this->_printing->paused};
    this->_connect->Show(!connected);
    this->_disconnect->Show(connected && idle);
    this->_manual_control->Show(connected);
    this->_manual_control->Enable(connected && idle);
    this->_port->Enable(!connected);
    this->_speed->Enable(!connected);
    this->_rescan->Enable(!connected);
    this->Layout();
}

void PrinterPanel::_set_status(const wxString& status) {
    this->_status->SetLabel(status);
    this->_status->Wrap(std::max(this->_status->GetSize().x, 200));
    this->Layout();
}

void PrinterPanel::connect() {
    if (this->is_connected()) return;
    this->_set_status(_("Connecting..."));
    this->Update();
    const std::string port {this->_port->GetValue().ToUTF8().data()};
    long speed {0};
    this->_speed->GetValue().ToLong(&speed);
    bool connected {false};
    {
        wxBusyCursor busy;
        this->_sender.reset(new GCodeSender());
        try {
            connected = speed > 0 && this->_sender->connect(port, speed) && this->_sender->wait_connected();
        } catch (std::exception&) {
            connected = false;
        }
    }
    if (connected) {
        this->_set_status(_("Printer is online. You can now start printing from the queue on the right."));
        this->_status_timer.Start(1000);
        this->_temperature_timer.Start(5000);
        this->_sender->send("M105", true);  // without waiting for the timer
        // the printer preset remembers the connection
        for (auto& preset : SLIC3RAPP->presets.at(get_preset(preset_t::Printer))) {
            if (preset.name != this->_name) continue;
            this->_config.set_deserialize("serial_port", port);
            this->_config.set_deserialize("serial_speed", std::to_string(speed));
            for (const char* key : {"serial_port", "serial_speed"}) {
                preset.load_config();
                preset.set_dirty(this->_config, key);
                preset.save_option(key);
            }
        }
    } else {
        this->_sender.reset();
        this->_set_status(_("Connection failed. Check serial port and speed."));
    }
    this->_update_connection_controls();
    this->_reload_jobs();
}

void PrinterPanel::disconnect() {
    this->_status_timer.Stop();
    this->_temperature_timer.Stop();
    if (this->_sender == nullptr) return;
    if (this->_printing != nullptr) this->_printing->printing = this->_printing->paused = false;
    this->_printing.reset();
    this->_gauge->Hide();
    this->_temperatures->Hide();
    this->_sender->disconnect();
    this->_sender.reset();
    this->_set_status("");
    this->_update_connection_controls();
    this->_reload_jobs();
}

void PrinterPanel::_poll() {
    if (this->_sender == nullptr) return;
    if (this->_printing != nullptr) {
        const int left {static_cast<int>(this->_sender->queue_size())};
        this->_gauge->SetValue(std::max(this->_gauge->GetRange() - left, 0));
        if (left == 0) this->_print_completed();
    }
    for (const auto& line : this->_sender->purge_log()) this->append_to_log(wxString::FromUTF8(line.c_str()) + "\n");
    const std::string temperature {this->_sender->getT()};
    if (!temperature.empty()) {
        const std::string bed {this->_sender->getB()};
        this->_temperature->SetLabel(wxString::FromUTF8(temperature.c_str()) + wxString::FromUTF8("\xc2\xb0""C"));
        this->_bed_temperature->SetLabel(bed.empty() ? wxString("n.a.")
            : wxString::FromUTF8(bed.c_str()) + wxString::FromUTF8("\xc2\xb0""C"));
        if (!this->_temperatures->IsShown()) this->_temperatures->Show();
        this->Layout();
    }
    if (this->_printing != nullptr && !this->_printing->paused) {  // the name blinks
        this->_blink = !this->_blink;
        for (auto* child : this->_jobs_panel->GetChildren())
            if (auto* name = child->FindWindow("printing")) name->SetForegroundColour(this->_blink ? wxColour(0, 190, 0) : *wxBLACK);
        this->_jobs_panel->Refresh();
    }
}

void PrinterPanel::load_print_job(const std::string& gcode_file, const std::map<std::string, float>& filament) {
    auto job {std::make_shared<PrintJob>()};
    job->gcode_file = gcode_file;
    job->filament = filament;
    GCodeTimeEstimator estimator(this->_config.has("machine_acceleration")
        ? this->_config.opt<ConfigOptionFloat>("machine_acceleration")->value : 0);
    estimator.parse_file(gcode_file);
    job->duration = estimator.time;
    this->_jobs.push_back(job);
    this->_reload_jobs();
}

void PrinterPanel::_reload_jobs() {
    this->CallAfter([this]() {
        // not yet printed first, each by the time it was queued
        std::stable_sort(this->_jobs.begin(), this->_jobs.end(), [](const auto& a, const auto& b) {
            return a->printed != b->printed ? !a->printed : a->queued < b->queued;
        });
        wxSizer* sizer {this->_jobs_panel->GetSizer()};
        sizer->Clear(true);
        for (const auto& job : this->_jobs) sizer->Add(this->_job_panel(job), 0, wxEXPAND | wxBOTTOM, 5);
        this->_jobs_panel->Layout();
        this->_jobs_panel->FitInside();
        this->Layout();
    });
}

wxWindow* PrinterPanel::_job_panel(const std::shared_ptr<PrintJob>& job) {
    auto* panel {new wxPanel(this->_jobs_panel, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxBORDER_SIMPLE)};
    panel->SetBackgroundColour(wxSystemSettings::GetColour(wxSYS_COLOUR_LISTBOX));
    const wxColour grey(160, 160, 160);
    auto* left {new wxBoxSizer(wxVERTICAL)};
    auto* name {new wxStaticText(panel, wxID_ANY, wxFileName(wxString::FromUTF8(job->gcode_file.c_str())).GetFullName(),
        wxDefaultPosition, wxDefaultSize, 0, job->printing ? "printing" : "job")};
    wxFont font {name->GetFont()};
    name->SetFont(font.Bold());
    if (job->printed) name->SetForegroundColour(grey);
    name->SetToolTip(_("Queued on ") + wxDateTime(job->queued).Format());
    left->Add(name, 0, wxEXPAND);
    wxString stats;
    for (const auto& filament : job->filament)
        stats << wxString::FromUTF8(filament.first.c_str()) << wxString::Format(" (%.2fm)\n", filament.second / 1000.);
    const int time {static_cast<int>(job->duration)};
    stats << wxString::Format(_("Estimated time: %d hours and %d minutes"), time / 3600, time / 60 % 60);
    auto* details {new wxStaticText(panel, wxID_ANY, stats)};
    details->SetFont(ui_settings->small_font());
    if (job->printed && !job->printing) details->SetForegroundColour(grey);
    left->Add(details, 0, wxEXPAND | wxTOP, 6);

    auto* buttons {new wxBoxSizer(wxVERTICAL)};
    auto add = [panel, buttons](const wxString& label, const wxString& icon, std::function<void()> action) {
        auto* button {icon_button(panel, label, icon)};
        button->Bind(wxEVT_BUTTON, [button, action](wxCommandEvent&) { button->CallAfter(action); });
        buttons->Add(button, 0, wxBOTTOM, 2);
    };
    // the actions run on this panel: the job panels are rebuilt by them
    if (!job->printing)
        add(_("Delete"), "delete.png", [this, job]() {
            if (wxMessageBox(_("Are you sure you want to delete this print job?"), _("Delete Job"), wxYES_NO | wxICON_QUESTION, this) != wxYES) return;
            this->CallAfter([this, job]() {
                this->_jobs.erase(std::remove(this->_jobs.begin(), this->_jobs.end(), job), this->_jobs.end());
                this->_reload_jobs();
            });
        });
    if (!job->printing && this->is_connected() && this->_printing == nullptr)
        add(job->printed ? _("Print Again") : _("Print This"), "control_play.png",
            [this, job]() { this->CallAfter([this, job]() { this->_print(job); }); });
    if (job->printing && !job->paused)
        add(_("Pause"), "control_pause.png", [this, job]() {
            this->CallAfter([this, job]() {
                if (this->_sender == nullptr) return;
                this->_sender->pause_queue();
                job->paused = true;
                this->_gauge->Disable();
                this->_set_status(_("Print is paused. Click on Resume to continue."));
                this->_update_connection_controls();
                this->_reload_jobs();
            });
        });
    if (job->printing && job->paused)
        add(_("Resume"), "control_play.png", [this, job]() {
            this->CallAfter([this, job]() {
                if (this->_sender == nullptr) return;
                this->_sender->resume_queue();
                job->paused = false;
                this->_gauge->Enable();
                this->_set_status(_("Printing..."));
                this->_update_connection_controls();
                this->_reload_jobs();
            });
        });
    if (job->printing)
        add(_("Abort"), "control_stop.png", [this, job]() {
            this->CallAfter([this, job]() {
                if (this->_sender == nullptr) return;
                this->_sender->purge_queue();
                this->_printing.reset();
                job->printing = job->paused = false;
                this->_gauge->Hide();
                this->_set_status(_("Print was aborted."));
                this->append_to_log(_("Print aborted at ") + timestamp() + "\n");
                this->_update_connection_controls();
                this->_reload_jobs();
            });
        });
    auto* sizer {new wxBoxSizer(wxHORIZONTAL)};
    sizer->Add(left, 1, wxEXPAND | wxALL, 6);
    sizer->Add(buttons, 0, wxEXPAND | wxALL, 6);
    panel->SetSizer(sizer);
    return panel;
}

void PrinterPanel::_print(const std::shared_ptr<PrintJob>& job) {
    if (this->_sender == nullptr || this->_printing != nullptr) return;
    std::ifstream in(job->gcode_file);
    if (!in) {
        show_error(this, _("Cannot read ") + wxString::FromUTF8(job->gcode_file.c_str()));
        return;
    }
    std::vector<std::string> lines;
    for (std::string line; std::getline(in, line); ) lines.push_back(line);
    this->_printing = job;
    job->printing = true;
    this->_sender->send(lines);
    this->_gauge->SetRange(std::max<int>(lines.size(), 1));
    this->_gauge->SetValue(0);
    this->_gauge->Enable();
    this->_gauge->Show();
    this->_set_status(_("Printing..."));
    this->append_to_log("=====\n");
    this->append_to_log(_("Printing ") + wxFileName(wxString::FromUTF8(job->gcode_file.c_str())).GetFullName() + "\n");
    this->append_to_log(_("Print started at ") + timestamp() + "\n");
    this->_update_connection_controls();
    this->_reload_jobs();
}

void PrinterPanel::_print_completed() {
    const std::shared_ptr<PrintJob> job {this->_printing};
    this->_printing.reset();
    job->printing = false;
    job->printed = true;
    this->_gauge->Hide();
    this->_set_status(_("Print completed."));
    this->append_to_log(_("Print completed at ") + timestamp() + "\n");
    this->_update_connection_controls();
    this->_reload_jobs();
}

}} // namespace Slic3r::GUI
