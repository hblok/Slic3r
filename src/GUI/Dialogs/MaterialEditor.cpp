#include "Dialogs/PresetEditor.hpp"
namespace Slic3r { namespace GUI {

MaterialEditor::MaterialEditor(wxWindow* parent, t_config_option_keys options) : 
    PresetEditor(parent, options) {
    
    this->config = Slic3r::Config::new_from_defaults(this->my_options());
    this->_build();
    this->load_presets();
    }

void MaterialEditor::_update(const std::string& opt_key) {
}

void MaterialEditor::_on_preset_loaded() {
}

void MaterialEditor::_build() {
    this->build_pages();
}
}} // namespace Slic3r::GUI
