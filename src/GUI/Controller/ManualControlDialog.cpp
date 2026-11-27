// The Perl GUI's Controller/ManualControlDialog.pm.
#include "Controller/ManualControlDialog.hpp"

#include "Controller/PrinterPanel.hpp"
#include "Dialogs/BedShapeDialog.hpp"
#include "GCodeWriter.hpp"
#include "misc_ui.hpp"

namespace Slic3r { namespace GUI {

ManualControlDialog::ManualControlDialog(PrinterPanel* parent, const DynamicPrintConfig& config, GCodeSender& sender,
        ManualSettings& settings) :
    wxDialog(parent, wxID_ANY, _("Manual Control"), wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER),
    _panel(parent), _config(config), _sender(sender), _settings(settings)
{
    auto button = [this](wxSizer* sizer, const wxString& label, const wxString& icon, bool bold, std::function<void()> action) {
        auto* out {new wxButton(this, wxID_ANY, label, wxDefaultPosition, wxDefaultSize, wxBU_EXACTFIT)};
        out->SetFont(bold ? ui_settings->small_bold_font() : ui_settings->small_font());
        out->SetBitmap(wxBitmap(var(icon), wxBITMAP_TYPE_PNG));
        out->Bind(wxEVT_BUTTON, [action](wxCommandEvent&) { action(); });
        sizer->Add(out, 1, wxEXPAND);
    };
    // one column or row of moves: three steps, home, three steps back
    auto axis = [this, &button](char name, wxOrientation orientation, const wxString& up, const wxString& down) {
        auto* sizer {new wxBoxSizer(orientation)};
        const bool vertical {orientation == wxVERTICAL};
        const double steps[] {10, 1, 0.1};
        auto move = [this, &button, sizer, name](double distance, const wxString& icon) {
            button(sizer, wxString::Format("%+g", distance), icon, false, [this, name, distance]() { this->_move_by(name, distance); });
        };
        for (const double step : steps) move(vertical ? step : -step, vertical ? up : down);
        button(sizer, wxString(wxChar(name)), "house.png", true, [this, name]() { this->_home(name); });
        for (int i = 2; i >= 0; --i) move(vertical ? -steps[i] : steps[i], vertical ? down : up);
        return sizer;
    };
    auto* bed {new wxFlexGridSizer(3, 1, 1)};
    bed->AddGrowableCol(1, 1);
    bed->AddGrowableRow(0, 1);
    bed->Add(axis('Y', wxVERTICAL, "arrow_up.png", "arrow_down.png"), 1, wxEXPAND);
    this->_bed = new Bed2D(this);
    this->_bed->set_shape(config.has("bed_shape") ? config.opt<ConfigOptionPoints>("bed_shape")->values
        : std::vector<Pointf>{Pointf(0, 0), Pointf(200, 0), Pointf(200, 200), Pointf(0, 200)});
    this->_bed->on_move = [this](const Pointf& at) {
        if (!(this->_x_homed && this->_y_homed)) {
            show_error(this, _("Please home both X and Y before moving."));
            return;
        }
        this->_sender.purge_queue(true);  // drop the moves still waiting: smoother
        this->_move_to(at.x, at.y);
    };
    bed->Add(this->_bed, 1, wxEXPAND | wxRIGHT, 3);
    bed->Add(axis('Z', wxVERTICAL, "arrow_up.png", "arrow_down.png"), 1, wxEXPAND);
    button(bed, "XYZ", "house.png", true, [this]() { this->_home('\0'); });
    bed->Add(axis('X', wxHORIZONTAL, "arrow_right.png", "arrow_left.png"), 1, wxEXPAND);

    auto* motion {new wxStaticBoxSizer(wxHORIZONTAL, this, _("Manual motion settings"))};
    auto speed = [this, motion](const wxString& label, double& value) {
        motion->Add(new wxStaticText(motion->GetStaticBox(), wxID_ANY, label), 0, wxALIGN_CENTER_VERTICAL | wxALL, 4);
        auto* field {new wxTextCtrl(motion->GetStaticBox(), wxID_ANY, wxString::Format("%g", value), wxDefaultPosition, wxSize(70, -1))};
        field->Bind(wxEVT_TEXT, [field, &value](wxCommandEvent&) {
            double typed {0};
            if (field->GetValue().ToDouble(&typed) && typed > 0) value = typed;
        });
        motion->Add(field, 0, wxALL, 4);
    };
    speed(_("Speed (mm/s) X/Y:"), settings.xy_speed);
    speed(_("Z:"), settings.z_speed);

    auto* left {new wxBoxSizer(wxVERTICAL)};
    left->Add(bed, 1, wxEXPAND | wxALL, 10);
    left->Add(motion, 0, wxEXPAND | wxALL, 10);

    auto* temperature {new wxStaticBoxSizer(wxVERTICAL, this, _("Temperature"))};
    auto heat = [this, temperature](const wxString& label, wxString& value, bool is_bed) {
        auto* row {new wxBoxSizer(wxHORIZONTAL)};
        wxWindow* inside {temperature->GetStaticBox()};
        row->Add(new wxStaticText(inside, wxID_ANY, label, wxDefaultPosition, wxSize(70, -1)), 0, wxALIGN_CENTER_VERTICAL);
        auto* field {new wxTextCtrl(inside, wxID_ANY, value, wxDefaultPosition, wxSize(70, -1))};
        field->Bind(wxEVT_TEXT, [field, &value](wxCommandEvent&) { value = field->GetValue(); });
        row->Add(field, 0, wxALIGN_CENTER_VERTICAL);
        row->Add(new wxStaticText(inside, wxID_ANY, wxString::FromUTF8("\xc2\xb0""C")), 0, wxALIGN_CENTER_VERTICAL | wxLEFT | wxRIGHT, 4);
        auto* set {new wxButton(inside, wxID_ANY, _("Set"), wxDefaultPosition, wxDefaultSize, wxBU_EXACTFIT)};
        set->SetBitmap(wxBitmap(var("tick.png"), wxBITMAP_TYPE_PNG));
        set->Bind(wxEVT_BUTTON, [this, field, is_bed](wxCommandEvent&) { this->_set_temperature(field->GetValue(), is_bed); });
        row->Add(set);
        temperature->Add(row, 0, wxALL, 4);
    };
    heat(_("Extruder:"), settings.temperature, false);
    heat(_("Bed:"), settings.bed_temperature, true);

    auto* manual {new wxStaticBoxSizer(wxVERTICAL, this, _("Send manual command"))};
    auto* row {new wxBoxSizer(wxHORIZONTAL)};
    auto* command {new wxTextCtrl(manual->GetStaticBox(), wxID_ANY, "", wxDefaultPosition, wxDefaultSize, wxTE_PROCESS_ENTER)};
    auto* send {new wxButton(manual->GetStaticBox(), wxID_ANY, _("Send"), wxDefaultPosition, wxDefaultSize, wxBU_EXACTFIT)};
    send->SetBitmap(wxBitmap(var("cog_go.png"), wxBITMAP_TYPE_PNG));
    auto do_send = [this, command]() {
        if (command->GetValue().IsEmpty()) return;
        this->_command(command->GetValue().ToUTF8().data());
        command->Clear();
    };
    send->Bind(wxEVT_BUTTON, [do_send](wxCommandEvent&) { do_send(); });
    command->Bind(wxEVT_TEXT_ENTER, [do_send](wxCommandEvent&) { do_send(); });
    row->Add(command, 1, wxEXPAND);
    row->Add(send, 0, wxLEFT, 5);
    manual->Add(row, 0, wxEXPAND | wxTOP, 5);

    auto* right {new wxBoxSizer(wxVERTICAL)};
    right->Add(temperature, 0, wxEXPAND | wxALL, 10);
    right->Add(manual, 0, wxEXPAND | wxALL, 10);

    auto* columns {new wxBoxSizer(wxHORIZONTAL)};
    columns->Add(left, 1, wxEXPAND | wxRIGHT, 10);
    columns->Add(right, 0, wxEXPAND);
    auto* sizer {new wxBoxSizer(wxVERTICAL)};
    sizer->Add(columns, 1, wxEXPAND);
    sizer->Add(this->CreateButtonSizer(wxCLOSE), 0, wxALIGN_RIGHT | wxALL, 10);
    this->SetSizerAndFit(sizer);
    this->SetEscapeId(wxID_CLOSE);
}

/// Through the priority queue, and into the log.
void ManualControlDialog::_command(const std::string& line) {
    this->_panel->append_to_log(">> " + wxString::FromUTF8(line.c_str()) + "\n");
    this->_sender.send(line, true);
}

void ManualControlDialog::_move_to(double x, double y) {
    this->_sender.send("G90", true);  // absolute positioning
    this->_sender.send(wxString::Format("G1 X%.1f Y%.1f F%d", x, y, static_cast<int>(this->_settings.xy_speed * 60)).ToStdString(), true);
    this->_x = x;
    this->_y = y;
    this->_have_position = true;
    this->_bed->set_position(Pointf(x, y));
}

void ManualControlDialog::_move_by(char axis, double distance) {
    const double speed {axis == 'Z' ? this->_settings.z_speed : this->_settings.xy_speed};
    this->_sender.send("G91", true);  // relative positioning
    this->_sender.send(wxString::Format("G1 %c%.1f F%d", axis, distance, static_cast<int>(speed * 60)).ToStdString(), true);
    this->_sender.send("G90", true);
    if (this->_have_position && axis != 'Z') {
        (axis == 'X' ? this->_x : this->_y) += distance;
        this->_bed->set_position(Pointf(this->_x, this->_y));
    }
}

void ManualControlDialog::_home(char axis) {
    this->_sender.send(axis == '\0' ? std::string("G28") : std::string("G28 ") + axis, true);
    this->_have_position = false;
    this->_bed->clear_position();
    if (axis == 'X' || axis == '\0') this->_x_homed = true;
    if (axis == 'Y' || axis == '\0') this->_y_homed = true;
}

void ManualControlDialog::_set_temperature(const wxString& text, bool bed) {
    long value {0};
    if (!text.ToLong(&value) || value < 0) {
        show_error(this, bed ? _("Invalid bed temperature.") : _("Invalid temperature."));
        return;
    }
    GCodeWriter writer;
    PrintConfig print;
    print.apply(this->_config, true);
    writer.apply_print_config(print);
    std::string command {bed ? writer.set_bed_temperature(value) : writer.set_temperature(value)};
    while (!command.empty() && command.back() == '\n') command.pop_back();
    if (!command.empty()) this->_command(command);
}

}} // namespace Slic3r::GUI
