#include "Dialogs/PresetEditor.hpp"
namespace Slic3r { namespace GUI {

PrinterEditor::PrinterEditor(wxWindow* parent, t_config_option_keys options) : 
    PresetEditor(parent, options) {
    
    this->config = Slic3r::Config::new_from_defaults(this->my_options());
    this->_build();
    this->load_presets();
    }

void PrinterEditor::_update(const std::string& opt_key) {
}

void PrinterEditor::_on_preset_loaded() {
}

void PrinterEditor::_build() {
    this->build_pages();
}
}} // namespace Slic3r::GUI
