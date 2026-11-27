// Object > Settings: parts, modifiers and per-object settings.
#include "Dialogs/ObjectSettings.hpp"

#include <algorithm>

#include <wx/filename.h>

#include "OptionsGroup/OptionControl.hpp"
#include "misc_ui.hpp"

namespace Slic3r { namespace GUI {

namespace {

/// The settings an object can have of its own; a volume only those of a region.
std::vector<std::string> own_keys(bool whole_object) {
    std::vector<std::string> keys {"extruder"};
    for (const auto& key : PrintRegionConfig().keys()) keys.push_back(key);
    if (whole_object)
        for (const auto& key : PrintObjectConfig().keys()) keys.push_back(key);
    std::sort(keys.begin(), keys.end(), [](const std::string& a, const std::string& b) {
        return option_name(a).CmpNoCase(option_name(b)) < 0;
    });
    return keys;
}

/// Ask for a simple shape and its sizes; false when cancelled.
bool ask_shape(wxWindow* parent, TriangleMesh& mesh, std::string& name, const Sizef3& object_size) {
    wxDialog dialog(parent, wxID_ANY, _("Create Modifier"));
    const wxString shapes[] {_("slab"), _("box"), _("cylinder"), _("sphere")};
    const char* const names[] {"slab", "box", "cylinder", "sphere"};
    // what the three numbers mean for each shape; empty: not used
    const wxString meanings[4][3] {
        {_("Thickness"), "", ""}, {_("Length (X)"), _("Width (Y)"), _("Height (Z)")},
        {_("Radius"), _("Height"), ""}, {_("Radius"), "", ""}};
    auto* shape {new wxChoice(&dialog, wxID_ANY, wxDefaultPosition, wxDefaultSize, 4, shapes)};
    shape->SetSelection(0);
    auto* grid {new wxFlexGridSizer(2, 5, 8)};
    grid->Add(new wxStaticText(&dialog, wxID_ANY, _("Shape")), 0, wxALIGN_CENTER_VERTICAL);
    grid->Add(shape, 0, wxEXPAND);
    wxStaticText* labels[3];
    wxSpinCtrlDouble* sizes[3];
    for (int i = 0; i < 3; ++i) {
        labels[i] = new wxStaticText(&dialog, wxID_ANY, meanings[1][0], wxDefaultPosition, wxSize(90, -1));
        sizes[i] = new wxSpinCtrlDouble(&dialog, wxID_ANY);
        sizes[i]->SetDigits(2);
        sizes[i]->SetRange(0.01, 10000);
        sizes[i]->SetValue(1);
        grid->Add(labels[i], 0, wxALIGN_CENTER_VERTICAL);
        grid->Add(sizes[i], 0, wxEXPAND);
    }
    auto name_fields = [&]() {
        for (int i = 0; i < 3; ++i) {
            const wxString& meaning {meanings[shape->GetSelection()][i]};
            labels[i]->SetLabel(meaning);
            sizes[i]->Enable(!meaning.IsEmpty());
        }
    };
    name_fields();
    shape->Bind(wxEVT_CHOICE, [&](wxCommandEvent&) { name_fields(); });
    auto* sizer {new wxBoxSizer(wxVERTICAL)};
    sizer->Add(grid, 0, wxALL, 10);
    sizer->Add(dialog.CreateButtonSizer(wxOK | wxCANCEL), 0, wxALIGN_RIGHT | wxALL, 10);
    dialog.SetSizerAndFit(sizer);
    if (dialog.ShowModal() != wxID_OK) return false;

    const int chosen {shape->GetSelection()};
    const double a {sizes[0]->GetValue()}, b {sizes[1]->GetValue()}, h {sizes[2]->GetValue()};
    constexpr double ROUND {2 * PI / 90};  // facet angle
    mesh = chosen == 0 ? TriangleMesh::make_cube(object_size.x * 1.5, object_size.y * 1.5, a)
        : chosen == 1 ? TriangleMesh::make_cube(a, b, h)
        : chosen == 2 ? TriangleMesh::make_cylinder(a, b, ROUND)
        : TriangleMesh::make_sphere(a, ROUND);
    mesh.repair();
    name = std::string("modifier-") + names[chosen];
    return true;
}

} // namespace

ObjectSettingsDialog::ObjectSettingsDialog(wxWindow* parent, ModelObject* object, const DynamicPrintConfig& defaults,
        std::function<void()> changed) :
    wxDialog(parent, wxID_ANY, _("Object Settings"), wxDefaultPosition, wxSize(760, 520), wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER),
    object(object), defaults(defaults), changed(changed)
{
    parts = new wxListBox(this, wxID_ANY, wxDefaultPosition, wxSize(260, 200));
    auto* load_part {new wxButton(this, wxID_ANY, _(L"Load part…"))};
    auto* load_modifier {new wxButton(this, wxID_ANY, _(L"Load modifier…"))};
    auto* create {new wxButton(this, wxID_ANY, _(L"Create modifier…"))};
    delete_button = new wxButton(this, wxID_ANY, _("Delete part"));
    auto* left {new wxBoxSizer(wxVERTICAL)};
    left->Add(parts, 1, wxEXPAND);
    left->Add(load_part, 0, wxEXPAND | wxTOP, 5);
    left->Add(load_modifier, 0, wxEXPAND | wxTOP, 5);
    left->Add(create, 0, wxEXPAND | wxTOP, 5);
    left->Add(delete_button, 0, wxEXPAND | wxTOP, 5);
    left->Add(new wxStaticText(this, wxID_ANY, _("Position of the part (X, Y, Z in mm):")), 0, wxTOP, 8);
    auto* at {new wxBoxSizer(wxHORIZONTAL)};
    for (auto*& field : position) {
        field = new wxSpinCtrlDouble(this, wxID_ANY, "", wxDefaultPosition, wxSize(85, -1));
        field->SetDigits(2);
        field->SetRange(-10000, 10000);
        field->Bind(wxEVT_SPINCTRLDOUBLE, [this](wxSpinDoubleEvent&) { this->move_volume(); });
        at->Add(field, 1, wxRIGHT, 2);
    }
    left->Add(at, 0, wxEXPAND);

    add_choice = new wxChoice(this, wxID_ANY);
    settings = new wxScrolledWindow(this, wxID_ANY, wxDefaultPosition, wxSize(400, 250), wxVSCROLL | wxBORDER_SUNKEN);
    settings->SetScrollRate(0, 10);
    auto* right {new wxBoxSizer(wxVERTICAL)};
    auto* add_row {new wxBoxSizer(wxHORIZONTAL)};
    add_row->Add(new wxStaticText(this, wxID_ANY, _("Add setting:")), 0, wxALIGN_CENTER_VERTICAL | wxRIGHT, 5);
    add_row->Add(add_choice, 1);
    right->Add(add_row, 0, wxEXPAND | wxBOTTOM, 5);
    right->Add(settings, 1, wxEXPAND);

    auto* columns {new wxBoxSizer(wxHORIZONTAL)};
    columns->Add(left, 0, wxEXPAND | wxALL, 10);
    columns->Add(right, 1, wxEXPAND | wxTOP | wxBOTTOM | wxRIGHT, 10);
    auto* sizer {new wxBoxSizer(wxVERTICAL)};
    sizer->Add(columns, 1, wxEXPAND);
    auto* close {new wxButton(this, wxID_CANCEL, _("Close"))};
    sizer->Add(close, 0, wxALIGN_RIGHT | wxRIGHT | wxBOTTOM, 10);
    this->SetSizer(sizer);

    parts->Bind(wxEVT_LISTBOX, [this](wxCommandEvent&) { this->show_settings(); });
    load_part->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->load_volumes(false); });
    load_modifier->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->load_volumes(true); });
    delete_button->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->delete_volume(); });
    create->Bind(wxEVT_BUTTON, [this](wxCommandEvent&) { this->create_modifier(); });
    add_choice->Bind(wxEVT_CHOICE, [this](wxCommandEvent&) {
        const int selected {add_choice->GetSelection()};
        if (selected < 0) return;
        const std::string key {addable.at(selected)};
        // starting at the value it has now
        const std::string value {this->defaults.has(key) ? this->defaults.serialize(key)
            : print_config_def.get(key).default_value->serialize()};
        this->selected_config().set_deserialize(key, value);
        this->changed();
        this->CallAfter([this]() { this->show_settings(); });
    });
    this->list_parts(0);
}

DynamicPrintConfig& ObjectSettingsDialog::selected_config() {
    const int selected {parts->GetSelection()};
    return selected <= 0 ? object->config : object->volumes.at(selected - 1)->config;
}

void ObjectSettingsDialog::list_parts(int select) {
    parts->Clear();
    parts->Append(_("Whole object"));
    for (const auto* volume : object->volumes) {
        const wxString name {wxString::FromUTF8(volume->name.c_str())};
        parts->Append(wxString::Format(volume->modifier ? _("Modifier: %s") : _("Part: %s"), name));
    }
    parts->SetSelection(std::min<int>(select, parts->GetCount() - 1));
    this->show_settings();
}

void ObjectSettingsDialog::show_settings() {
    const int selected {std::max(parts->GetSelection(), 0)};
    delete_button->Enable(selected > 0);
    DynamicPrintConfig& config {this->selected_config()};
    const Pointf3 corner {selected > 0 ? object->volumes.at(selected - 1)->bounding_box().min : Pointf3()};
    const double values[] {corner.x, corner.y, corner.z};
    for (int i = 0; i < 3; ++i) {
        position[i]->Enable(selected > 0);
        position[i]->SetValue(values[i]);
    }

    add_choice->Clear();
    addable.clear();
    for (const auto& key : own_keys(selected == 0)) {
        if (config.has(key)) continue;
        addable.push_back(key);
        add_choice->Append(option_name(key));
    }

    settings->DestroyChildren();
    auto* grid {new wxFlexGridSizer(3, 6, 8)};
    grid->AddGrowableCol(1, 1);
    for (const auto& key : config.keys()) {
        if (!print_config_def.has(key)) continue;
        auto* label {new wxStaticText(settings, wxID_ANY, option_name(key) + ":")};
        const OptionControl control {make_option_control(settings, key,
            [this]() -> DynamicPrintConfig& { return this->selected_config(); }, this->changed)};
        control.refresh();
        auto* remove {new wxBitmapButton(settings, wxID_ANY, wxBitmap(var("delete.png"), wxBITMAP_TYPE_PNG))};
        remove->Bind(wxEVT_BUTTON, [this, key](wxCommandEvent&) {
            this->selected_config().erase(key);
            this->changed();
            this->CallAfter([this]() { this->show_settings(); });  // not from the button's own event
        });
        grid->Add(label, 0, wxALIGN_CENTER_VERTICAL | wxALIGN_RIGHT);
        grid->Add(control.window, 0, wxEXPAND);
        grid->Add(remove, 0, wxALIGN_CENTER_VERTICAL);
    }
    auto* padded {new wxBoxSizer(wxVERTICAL)};
    padded->Add(grid, 0, wxEXPAND | wxALL, 8);
    settings->SetSizer(padded);
    settings->FitInside();
    this->Layout();
}

void ObjectSettingsDialog::load_volumes(bool modifier) {
    for (const auto& file : open_model(this, this)) {
        Slic3r::Model loaded;
        try {
            loaded = Slic3r::Model::read_from_file(file.ToUTF8().data());
        } catch (std::exception& e) {
            show_error(this, wxString::FromUTF8(e.what()));
            continue;
        }
        for (size_t o = 0; o < loaded.objects.size(); ++o) {
            for (size_t i = 0; i < loaded.objects[o]->volumes.size(); ++i) {
                ModelVolume* volume {object->add_volume(*loaded.objects[o]->volumes[i])};
                volume->modifier = modifier;
                volume->name = wxFileName(file).GetFullName().ToUTF8().data();
                volume->input_file = file.ToUTF8().data();
                volume->input_file_obj_idx = o;
                volume->input_file_vol_idx = i;
                // moved as the object has been since it was loaded
                volume->apply_transformation(object->get_trafo_obj());
            }
        }
    }
    object->invalidate_bounding_box();
    this->changed();
    this->list_parts(object->volumes.size());
}

void ObjectSettingsDialog::create_modifier() {
    BoundingBoxf3 parts_box;
    for (const auto* volume : object->volumes)
        if (!volume->modifier) parts_box.merge(volume->bounding_box());
    TriangleMesh mesh;
    std::string name;
    if (!ask_shape(this, mesh, name, parts_box.size())) return;
    // in the middle of the printed parts, standing where they stand
    const BoundingBoxf3 shape {mesh.bounding_box()};
    mesh.translate(parts_box.center().x - shape.center().x, parts_box.center().y - shape.center().y,
        parts_box.min.z - shape.min.z);
    ModelVolume* volume {object->add_volume(mesh)};
    volume->modifier = true;
    volume->name = name;
    object->invalidate_bounding_box();
    this->changed();
    this->list_parts(object->volumes.size());
}

void ObjectSettingsDialog::move_volume() {
    const int selected {parts->GetSelection() - 1};
    if (selected < 0 || selected >= static_cast<int>(object->volumes.size())) return;
    ModelVolume* volume {object->volumes[selected]};
    const Pointf3 corner {volume->bounding_box().min};
    const double dx {position[0]->GetValue() - corner.x}, dy {position[1]->GetValue() - corner.y},
        dz {position[2]->GetValue() - corner.z};
    // the fields show two decimals: smaller differences are not a move
    if (std::abs(dx) < 0.005 && std::abs(dy) < 0.005 && std::abs(dz) < 0.005) return;
    volume->translate(dx, dy, dz);
    object->invalidate_bounding_box();
    this->changed();
}

void ObjectSettingsDialog::delete_volume() {
    const int selected {parts->GetSelection() - 1};
    if (selected < 0 || selected >= static_cast<int>(object->volumes.size())) return;
    const auto solid {std::count_if(object->volumes.begin(), object->volumes.end(),
        [](const ModelVolume* v) { return !v->modifier; })};
    if (!object->volumes[selected]->modifier && solid == 1) {
        show_error(this, _("You can't delete the last solid part from this object."));
        return;
    }
    object->delete_volume(selected);
    object->invalidate_bounding_box();
    this->changed();
    this->list_parts(selected);
}

}} // namespace Slic3r::GUI
