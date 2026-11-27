#include "Controller.hpp"

#include <algorithm>

#include "Controller/PrinterPanel.hpp"
#include "GUI.hpp"
#include "misc_ui.hpp"

namespace Slic3r { namespace GUI {

Controller::Controller(wxWindow* parent, const wxString& title) :
    wxScrolledWindow(parent, wxID_ANY, wxDefaultPosition, wxSize(600, 350), wxTAB_TRAVERSAL, title)
{
    this->SetScrollRate(0, ui_settings->scroll_step());
    this->_sizer = new wxBoxSizer(wxVERTICAL);
    this->_no_printers = new wxStaticText(this, wxID_ANY, _("No printers were configured for USB/serial control."));
    this->_sizer->Add(this->_no_printers, 0, wxTOP | wxLEFT, 30);
    this->_add = new wxBitmapButton(this, wxID_ANY, wxBitmap(var("add.png"), wxBITMAP_TYPE_PNG),
        wxDefaultPosition, wxDefaultSize, wxBORDER_NONE);
    this->_add->SetToolTip(_(L"Add printer…"));
    this->_add->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->_add_menu(); });
    this->_sizer->Add(this->_add, 0, wxTOP | wxLEFT, 10);
    this->SetSizer(this->_sizer);
}

std::map<wxString, DynamicPrintConfig> Controller::_printers() const {
    std::map<wxString, DynamicPrintConfig> printers;
    for (auto& preset : SLIC3RAPP->presets.at(get_preset(preset_t::Printer))) {
        const Slic3r::Config config {preset.dirty_config()};
        if (config.config().has("serial_port") && !config.config().serialize("serial_port").empty())
            printers[preset.name] = config.config();
    }
    return printers;
}

PrinterPanel* Controller::add_printer(const wxString& name) {
    for (auto* panel : this->_panels)
        if (panel->printer_name() == name) return panel;
    const auto printers {this->_printers()};
    if (printers.count(name) == 0) return nullptr;
    auto* panel {new PrinterPanel(this, name, printers.at(name))};
    this->_panels.push_back(panel);
    this->_sizer->Prepend(panel, 0, wxEXPAND | wxTOP | wxLEFT | wxRIGHT, 10);
    this->Layout();
    this->FitInside();
    return panel;
}

void Controller::activate() {
    const auto printers {this->_printers()};
    // kept: the ones connected or with jobs
    std::vector<wxString> active;
    for (auto* panel : this->_panels)
        if (panel->is_connected() || panel->has_jobs()) active.push_back(panel->printer_name());
    if (!printers.empty()) {
        if (active.empty() && printers.size() <= 2)  // one or two: show them
            for (const auto& printer : printers) active.push_back(printer.first);
        if (active.empty()) {  // those whose port is there
            const auto ports {scan_serial_ports()};
            for (const auto& printer : printers) {
                const wxString port {wxString::FromUTF8(printer.second.serialize("serial_port").c_str())};
                if (std::find(ports.begin(), ports.end(), port) != ports.end()) active.push_back(printer.first);
            }
        }
        if (active.empty()) {  // the one selected in the plater
            const auto& selected {ui_settings->default_presets.at(get_preset(preset_t::Printer))};
            if (!selected.empty() && printers.count(selected.front()) > 0) active.push_back(selected.front());
        }
    }
    auto kept = [&active](PrinterPanel* panel) {
        return std::find(active.begin(), active.end(), panel->printer_name()) != active.end();
    };
    for (auto it = this->_panels.begin(); it != this->_panels.end(); ) {
        if (kept(*it)) {
            // the preset may have changed
            if (printers.count((*it)->printer_name()) > 0) (*it)->set_config(printers.at((*it)->printer_name()));
            ++it;
        } else {
            this->_sizer->Detach(*it);
            (*it)->Destroy();
            it = this->_panels.erase(it);
        }
    }
    for (const auto& name : active) this->add_printer(name);
    this->_no_printers->Show(printers.empty());
    this->_add->Show(std::any_of(printers.begin(), printers.end(), [&](const auto& printer) {
        return std::find(active.begin(), active.end(), printer.first) == active.end();
    }));
    this->Layout();
    this->FitInside();
}

void Controller::_add_menu() {
    wxMenu menu;
    std::vector<wxString> names;
    for (const auto& printer : this->_printers()) {
        if (std::any_of(this->_panels.begin(), this->_panels.end(),
                [&printer](PrinterPanel* panel) { return panel->printer_name() == printer.first; })) continue;
        names.push_back(printer.first);
        menu.Append(wxID_HIGHEST + static_cast<int>(names.size()), printer.first);
    }
    if (names.empty()) return;
    const int chosen {this->_add->GetPopupMenuSelectionFromUser(menu)};
    if (chosen > wxID_HIGHEST && chosen <= wxID_HIGHEST + static_cast<int>(names.size()))
        this->add_printer(names[chosen - wxID_HIGHEST - 1]);
}

bool Controller::printing() const {
    return std::any_of(this->_panels.begin(), this->_panels.end(), [](PrinterPanel* panel) { return panel->printing(); });
}

void Controller::disconnect_all() {
    for (auto* panel : this->_panels) panel->disconnect();
}

}} // namespace Slic3r::GUI
