// What the plater does to its objects: load, remove, copies, transforms, split, export,
// reload and undo. objects[i] (what the GUI keeps) belongs to model->objects[i] (what is
// sliced); every operation ends in on_model_change(), which records it for undo.
#include <cmath>
#include <memory>

#include <wx/filedlg.h>
#include <wx/filename.h>
#include <wx/numdlg.h>
#include <wx/textdlg.h>

#include "Plater.hpp"
#include "ProgressStatusBar.hpp"
#include "MainFrame.hpp"
#include "Dialogs/AnglePicker.hpp"
#include "Dialogs/ObjectCutDialog.hpp"
#include "Dialogs/ObjectFaceDialog.hpp"
#include "Dialogs/LayerHeightsDialog.hpp"
#include "PresetChooser.hpp"
#include "BoundingBox.hpp"
#include "Geometry.hpp"
#include "IO.hpp"
#include "misc_ui.hpp"
#include "Settings.hpp"

namespace Slic3r { namespace GUI {

namespace {

// ponytail: undo keeps whole copies of the plate (meshes included); per-operation
// inverses if the memory ever matters
constexpr size_t HISTORY_LIMIT {30};

const char* const AXIS_NAMES[] {"X", "Y", "Z"};

/// How to reload an object with parts and modifiers of its own (the Perl GUI's
/// ReloadDialog); false when cancelled.
bool ask_reload_options(wxWindow* parent, Settings& settings, ReloadBehavior& behavior, bool& preserve) {
    wxDialog dialog(parent, wxID_ANY, _("Reload options"));
    const wxString choices[] {_("Reload all linked files"), _("Reload main file, copy added parts & modifiers"),
        _("Reload main file, discard added parts & modifiers")};
    auto* choice {new wxChoice(&dialog, wxID_ANY, wxDefaultPosition, wxDefaultSize, 3, choices)};
    choice->SetSelection(static_cast<int>(behavior));
    auto* keep {new wxCheckBox(&dialog, wxID_ANY, _("Preserve transformations"))};
    keep->SetValue(preserve);
    auto* hide {new wxCheckBox(&dialog, wxID_ANY, _("Don't ask again"))};
    auto* sizer {new wxBoxSizer(wxVERTICAL)};
    sizer->Add(new wxStaticText(&dialog, wxID_ANY, _("Handling of additional parts and modifiers:")), 0, wxALL, 10);
    sizer->Add(choice, 0, wxEXPAND | wxLEFT | wxRIGHT | wxBOTTOM, 10);
    sizer->Add(new wxStaticText(&dialog, wxID_ANY, _("Handling of transformations made inside Slic3r:")), 0, wxALL, 10);
    sizer->Add(keep, 0, wxLEFT | wxRIGHT | wxBOTTOM, 10);
    auto* bottom {new wxBoxSizer(wxHORIZONTAL)};
    bottom->Add(hide, 1, wxALIGN_CENTER_VERTICAL | wxALL, 10);
    bottom->Add(dialog.CreateButtonSizer(wxOK | wxCANCEL), 0, wxALL, 10);
    sizer->Add(bottom, 0, wxEXPAND);
    dialog.SetSizerAndFit(sizer);
    if (dialog.ShowModal() != wxID_OK) return false;
    behavior = static_cast<ReloadBehavior>(choice->GetSelection());
    preserve = keep->GetValue();
    settings.reload = behavior;
    settings.reload_preserve_trafo = preserve;
    if (hide->GetValue()) settings.hide_reload_dialog = true;
    settings.save_settings();
    return true;
}

/// Replace the volumes of `object` by those of `source` (the file's object, read again),
/// keeping each one's settings and, when asked, transformations; what was added to the
/// object is read again, copied or dropped. True when some volume had no counterpart.
bool reload_volumes(ModelObject& object, const ModelObject& source, const std::string& input,
        ReloadBehavior behavior, bool preserve) {
    Slic3r::Model fresh;
    ModelObject* made {fresh.add_object(object, false)};  // instances and settings, no volumes
    bool unmatched {false};
    size_t old {0};
    const size_t old_count {object.volumes.size()};
    for (const auto* volume : source.volumes) {
        ModelVolume* added {made->add_volume(*volume)};
        if (old < old_count && object.volumes[old]->input_file == input) {
            if (preserve) added->apply_transformation(object.volumes[old]->trafo);
            added->config = object.volumes[old]->config;
            added->modifier = object.volumes[old]->modifier;
            ++old;
        } else {
            // the file has more volumes now
            if (preserve) added->apply_transformation(object.get_trafo_obj());
            if (old_count > 0) added->config = object.volumes.front()->config;
            unmatched = true;
        }
    }
    while (old < old_count && object.volumes[old]->input_file == input) { ++old; unmatched = true; }  // it has fewer
    if (behavior == ReloadBehavior::discard) old = old_count;
    auto ends_with = [](const std::string& name, const std::string& end) {
        return name.size() >= end.size() && name.compare(name.size() - end.size(), end.size(), end) == 0;
    };
    // a name saying what happened: replaces the other note
    auto renamed = [&ends_with](std::string name, const std::string& note, const std::string& other) {
        if (ends_with(name, other)) name.erase(name.size() - other.size());
        if (!ends_with(name, note)) name += note;
        return name;
    };
    for (; old < old_count; ++old) {
        const ModelVolume* volume {object.volumes[old]};
        if (behavior == ReloadBehavior::copy) {
            ModelVolume* added {made->add_volume(*volume)};
            added->name = renamed(added->name, " - copied", " - no link to path");
            continue;
        }
        // read it again from its own file
        bool read {false};
        if (!volume->input_file.empty()) {
            try {
                const Slic3r::Model other {Slic3r::Model::read_from_file(volume->input_file)};
                if (volume->input_file_obj_idx >= 0 && volume->input_file_obj_idx < static_cast<int>(other.objects.size())) {
                    const ModelObject* from {other.objects[volume->input_file_obj_idx]};
                    if (volume->input_file_vol_idx >= 0 && volume->input_file_vol_idx < static_cast<int>(from->volumes.size())) {
                        ModelVolume* added {made->add_volume(*from->volumes[volume->input_file_vol_idx])};
                        if (preserve) added->apply_transformation(volume->trafo);
                        added->name = volume->name;
                        added->input_file = volume->input_file;
                        added->input_file_obj_idx = volume->input_file_obj_idx;
                        added->input_file_vol_idx = volume->input_file_vol_idx;
                        added->config = volume->config;
                        added->modifier = volume->modifier;
                        read = true;
                    }
                }
            } catch (std::exception&) {}
        }
        if (!read) {  // the old mesh
            ModelVolume* added {made->add_volume(*volume)};
            added->input_file.clear();
            added->name = renamed(added->name, " - no link to path", " - copied");
            unmatched = true;
        }
    }
    const TransformationMatrix trafo {object.get_trafo_obj()};
    object.clear_volumes();
    for (const auto* volume : made->volumes) object.add_volume(*volume);
    object.set_trafo_obj(preserve ? trafo : TransformationMatrix());
    return unmatched;
}

/// Ask for a number; false when cancelled or not a number.
bool ask_number(wxWindow* parent, const wxString& question, const wxString& title, double value, double& out) {
    wxTextEntryDialog dialog(parent, question, title, wxString::Format("%g", value));
    if (dialog.ShowModal() != wxID_OK) return false;
    wxString text {dialog.GetValue()};
    text.Trim().Trim(false);
    if (text.EndsWith("%")) text.RemoveLast();
    return text.ToCDouble(&out) || text.ToDouble(&out);
}

} // namespace

// ---- state, undo ----

int Plater::selected_index() const {
    for (size_t i = 0; i < this->objects.size(); ++i)
        if (this->objects[i].selected) return static_cast<int>(i);
    return -1;
}

ModelObject* Plater::selected_model_object() {
    const int idx {this->selected_index()};
    return idx < 0 ? nullptr : this->model->objects.at(idx);
}

void Plater::commit() {
    if (!this->history.empty()) this->history.resize(this->history_pos + 1);  // drops what could be redone
    this->history.push_back({std::make_shared<Slic3r::Model>(*this->model), this->objects});
    if (this->history.size() > HISTORY_LIMIT) this->history.erase(this->history.begin());
    this->history_pos = this->history.size() - 1;
}

void Plater::restore(size_t position) {
    const int selected {this->selected_index()};
    const PlaterState& state {this->history.at(position)};
    // object by object: assigning a whole Model leaves the objects pointing at the temporary
    this->model->clear_objects();
    this->model->clear_materials();
    for (const auto& material : state.model->materials) this->model->add_material(material.first, *material.second);
    for (const auto* object : state.model->objects) this->model->add_object(*object);
    this->objects = state.objects;
    for (auto& object : this->objects) {
        object.selected = false;
        object.selected_instance = -1;
    }
    if (selected >= 0 && selected < static_cast<int>(this->objects.size())) {
        this->objects[selected].selected = true;
        this->objects[selected].selected_instance = 0;
    }
    this->history_pos = position;
    this->refresh_model();
}

void Plater::undo() {
    if (this->history_pos == 0) {
        GetFrame()->statusbar->SetStatusText(_("Nothing to undo."));
        return;
    }
    this->restore(this->history_pos - 1);
}

void Plater::redo() {
    if (this->history_pos + 1 >= this->history.size()) {
        GetFrame()->statusbar->SetStatusText(_("Nothing to redo."));
        return;
    }
    this->restore(this->history_pos + 1);
}

void Plater::on_model_change(bool force_autocenter) {
    if (force_autocenter || ui_settings->autocenter)
        this->model->center_instances_around_point(this->bed_centerf());
    this->commit();
    this->refresh_model();
}

void Plater::refresh_model() {
    // reload the select submenu (if already initialized)
    auto* menu {this->GetFrame()->plater_select_menu};
    if (menu != nullptr) {
        while (menu->GetMenuItemCount() > 0) menu->Destroy(menu->FindItemByPosition(0));
        for (size_t idx = 0; idx < this->objects.size(); ++idx) {
            wxString name {wxString::FromUTF8(this->objects[idx].name.c_str())};
            const auto copies {this->model->objects.at(idx)->instances.size()};
            if (copies > 1) name << " (" << copies << "x)";
            wxMenuItem* item {append_menu_item(menu, name, _("Select object."),
                    [this, idx](wxCommandEvent&) { this->select_object(static_cast<ObjIdx>(idx)); this->refresh_canvases(); },
                    wxID_ANY, "", "", wxITEM_CHECK)};
            item->Check(this->objects[idx].selected);
        }
    }
    this->object_list_changed();
    this->refresh_canvases();
    this->invalidate_slices();
}

// ---- loading ----

std::vector<int> Plater::load_model_objects(ModelObject* model_object) {
    return this->load_model_objects(ModelObjectPtrs {model_object});
}

std::vector<int> Plater::load_model_objects(ModelObjectPtrs model_objects) {
    const auto bed {BoundingBoxf(this->config->get<ConfigOptionPoints>("bed_shape").values)};
    bool need_arrange {false};
    std::vector<int> loaded;

    for (const auto* source : model_objects) {
        ModelObject* object {this->model->add_object(*source)};
        object->repair();

        PlaterObject entry;
        entry.name = source->name.empty()
            ? wxFileName(wxString::FromUTF8(source->input_file.c_str())).GetName().ToUTF8().data()
            : source->name;
        entry.input_file = source->input_file;
        this->objects.push_back(entry);
        loaded.push_back(static_cast<int>(this->objects.size()) - 1);

        if (object->instances.empty()) {
            if (ui_settings->autocenter) {
                need_arrange = true;
                object->center_around_origin();
                object->add_instance();
                object->instances.back()->offset = this->bed_centerf();
            } else {
                if (ui_settings->autoalignz) object->align_to_ground();
                object->add_instance();
            }
        } else if (ui_settings->autoalignz) {
            object->align_to_ground();
        }

        // more than five times the bed: probably another unit, scale it down
        const auto size {object->bounding_box().size()};
        const double ratio {std::max(size.x / bed.size().x, size.y / bed.size().y)};
        if (ratio > 5) {
            for (auto* instance : object->instances) instance->scaling_factor = 1 / ratio;
            object->invalidate_bounding_box();
            this->scaled_down = true;
        }
        this->print->auto_assign_extruders(object);
        this->make_thumbnail(loaded.back());
    }
    if (need_arrange) this->model->arrange_objects(this->config->config().min_object_distance(), &bed);
    return loaded;
}

void Plater::add_tin() {
    const auto files {open_model(this, wxTheApp->GetTopWindow())};
    if (files.empty()) return;
    const long offset {wxGetNumberFromUser("",
        _("Enter the minimum thickness in mm (i.e. the offset from the lowest point):"), _("2.5D TIN"), 5, 0, 1000000, this)};
    if (offset < 0) return;
    this->refresh_config();
    for (const auto& file : files) {
        try {
            Slic3r::Model loaded {Slic3r::Model::read_from_file(file.ToUTF8().data())};
            if (loaded.objects.empty() || loaded.looks_like_multipart_object() || loaded.objects.front()->volumes.empty()) {
                show_error(this, _("Multi-part models cannot be opened as 2.5D TIN files. Please load a single continuous mesh."));
                continue;
            }
            ModelObject* object {loaded.objects.front()};
            object->volumes.front()->mesh.extrude_tin(offset);
            this->load_model_objects(object);
        } catch (std::exception& e) {
            show_error(this, wxString::FromUTF8(e.what()));
        }
    }
    this->on_model_change();
}

// ---- plate ----

void Plater::arrange() {
    if (this->objects.empty()) {
        GetFrame()->statusbar->SetStatusText(_("Nothing to arrange."));
        return;
    }
    const BoundingBoxf bed {this->config->get<ConfigOptionPoints>("bed_shape").values};
    const bool success {this->model->arrange_objects(this->config->config().min_object_distance(), &bed)};
    GetFrame()->statusbar->SetStatusText(success ? _("Objects were arranged.") : _("Arrange failed."));
    this->on_model_change(true);
}

void Plater::remove() { this->remove(this->selected_index()); }

void Plater::remove(int obj_idx) {
    if (obj_idx < 0 || obj_idx >= static_cast<int>(this->objects.size())) return;
    this->model->delete_object(obj_idx);
    this->objects.erase(this->objects.begin() + obj_idx);
    this->select_object();
    this->on_model_change();
}

void Plater::reset() {
    if (this->objects.empty()) return;
    this->objects.clear();
    this->model->clear_objects();
    this->select_object();
    this->on_model_change();
}

void Plater::select_next() {
    if (this->objects.empty()) return;
    this->select_object(static_cast<ObjIdx>((this->selected_index() + 1) % this->objects.size()));
    this->refresh_canvases();
}

void Plater::select_prev() {
    if (this->objects.empty()) return;
    const int count {static_cast<int>(this->objects.size())};
    const int idx {this->selected_index()};
    this->select_object(static_cast<ObjIdx>(idx <= 0 ? count - 1 : idx - 1));
    this->refresh_canvases();
}

// ---- copies ----

void Plater::increase(size_t copies) {
    ModelObject* object {this->selected_model_object()};
    if (object == nullptr) return;
    for (size_t i = 0; i < copies; ++i) {
        ModelInstance* instance {object->add_instance(*object->instances.back())};
        instance->offset.x += 10;
        instance->offset.y += 10;
    }
    object->invalidate_bounding_box();
    if (ui_settings->autocenter) this->arrange();
    else this->on_model_change();
}

void Plater::decrease(size_t copies) {
    ModelObject* object {this->selected_model_object()};
    if (object == nullptr) return;
    if (object->instances.size() <= copies) {
        this->remove();
        return;
    }
    for (size_t i = 0; i < copies; ++i) object->delete_last_instance();
    object->invalidate_bounding_box();
    this->on_model_change();
}

void Plater::set_number_of_copies() {
    const ModelObject* object {this->selected_model_object()};
    if (object == nullptr) return;
    const long count {static_cast<long>(object->instances.size())};
    const long copies {wxGetNumberFromUser("", _("Enter the number of copies of the selected object:"),
        _("Copies"), count, 0, 1000, this)};
    if (copies < 0) return;  // cancelled
    if (copies > count) this->increase(copies - count);
    else if (copies < count) this->decrease(count - copies);
}

void Plater::center_selected_object_on_bed() {
    ModelObject* object {this->selected_model_object()};
    if (object == nullptr) return;
    const auto bb {object->bounding_box()};
    const Pointf shift(this->bed_centerf().x - bb.min.x - bb.size().x / 2,
                       this->bed_centerf().y - bb.min.y - bb.size().y / 2);
    for (auto* instance : object->instances) instance->offset.translate(shift);
    object->invalidate_bounding_box();
    this->commit();  // not on_model_change(): autocenter would move the whole plate
    this->refresh_model();
}

// ---- transforms ----

void Plater::rotate(Axis axis) {
    const ModelObject* object {this->selected_model_object()};
    if (object == nullptr) return;
    // around Z the dialog shows and takes the object's angle; around X and Y a turn by
    const double current {axis == Z ? Geometry::rad2deg(object->instances.front()->rotation) : 0};
    AnglePicker<1000> picker(this, wxString::Format(_("Rotate around %s axis"), AXIS_NAMES[axis]), current);
    if (picker.ShowModal() != wxID_OK) return;
    this->rotate(picker.angle() - current, axis);
}

void Plater::rotate(double angle, Axis axis) {
    const int idx {this->selected_index()};
    if (idx < 0 || angle == 0) return;
    ModelObject* object {this->model->objects.at(idx)};
    if (axis == Z) {
        for (auto* instance : object->instances) instance->rotation += Geometry::deg2rad(angle);
        this->objects[idx].transform_thumbnail(this->model, idx);
    } else {
        // X and Y turn the mesh, after the instance's own Z rotation and scale
        object->transform_by_instance(*object->instances.front(), true);
        object->rotate(Geometry::deg2rad(angle), axis);
        object->align_to_ground();
        this->make_thumbnail(idx);
    }
    object->invalidate_bounding_box();
    this->on_model_change();
}

void Plater::mirror(Axis axis) {
    const int idx {this->selected_index()};
    if (idx < 0) return;
    ModelObject* object {this->model->objects.at(idx)};
    object->transform_by_instance(*object->instances.front(), true);
    object->mirror(axis);
    object->align_to_ground();
    this->make_thumbnail(idx);
    this->on_model_change();
}

void Plater::changescale(int axis, bool to_size) {
    const int idx {this->selected_index()};
    if (idx < 0) return;
    ModelObject* object {this->model->objects.at(idx)};
    const Sizef3 size {object->instance_bounding_box(0).size()};
    const double factor_now {object->instances.front()->scaling_factor};
    const double along[] {size.x, size.y, size.z};
    const double current {axis < 0 ? std::max(size.x, std::max(size.y, size.z)) : along[axis]};
    const wxString title {axis < 0 ? wxString(_("Scale")) : wxString::Format(_("Scale along %s"), AXIS_NAMES[axis])};

    double factor {1};  // relative to now
    double value {0};
    if (to_size) {
        if (!ask_number(this, _("Enter the new size for the selected object (mm):"), title, current, value) || value <= 0) return;
        factor = value / current;
    } else {
        const double shown {axis < 0 ? factor_now * 100 : 100};
        if (!ask_number(this, _("Enter the scale % for the selected object:"), title, shown, value) || value <= 0) return;
        factor = value / shown;
    }

    if (axis < 0) {
        t_layer_height_ranges ranges;
        for (const auto& range : object->layer_height_ranges)
            ranges[{range.first.first * factor, range.first.second * factor}] = range.second;
        object->layer_height_ranges = ranges;
        for (auto* instance : object->instances) instance->scaling_factor = factor_now * factor;
        this->objects[idx].transform_thumbnail(this->model, idx);
    } else {
        object->transform_by_instance(*object->instances.front(), true);
        Pointf3 versor(1, 1, 1);
        (axis == X ? versor.x : axis == Y ? versor.y : versor.z) = factor;
        object->scale(versor);
        object->align_to_ground();
        this->make_thumbnail(idx);
    }
    object->invalidate_bounding_box();
    this->on_model_change();
}

void Plater::split_object() {
    const int idx {this->selected_index()};
    if (idx < 0) return;
    if (this->model->objects.at(idx)->volumes.size() > 1) {
        show_error(this, _("The selected object can't be split because it contains more than one volume/material."));
        return;
    }
    // split() adds the parts to the object's model: work on a copy
    Slic3r::Model copy(*this->model);
    ModelObjectPtrs parts;
    copy.objects.at(idx)->split(&parts);
    if (parts.size() <= 1) {
        show_error(this, _("The selected object couldn't be split because it contains only one part."));
        return;
    }
    for (auto* part : parts) {
        for (size_t i = 1; i < part->instances.size(); ++i)
            part->instances[i]->offset.translate(i * 10, i * 10);
        part->center_around_origin();
    }
    this->model->delete_object(idx);
    this->objects.erase(this->objects.begin() + idx);
    this->select_object();
    // all at once and with their instances: arranging would lose their positions
    this->load_model_objects(parts);
    this->on_model_change();
}

void Plater::object_cut_dialog() {
    const int idx {this->selected_index()};
    if (idx < 0) return;
    // the cut is made on the object as it stands on the plate (rotation and scale applied)
    Slic3r::Model work(*this->model);
    ModelObject* object {work.objects.at(idx)};
    object->transform_by_instance(*object->instances.front(), true);

    ObjectCutDialog dialog(this, object);
    if (dialog.ShowModal() != wxID_OK) return;
    const CutOptions options {dialog.options()};
    if (options.grid.x > 0) {
        this->cut_by_grid(idx, *object, options.grid);
        return;
    }

    Slic3r::Model halves;
    const auto bb {object->instance_bounding_box(0)};
    object->cut(options.axis, options.at(bb), &halves);
    ModelObject* upper {halves.objects.at(0)};
    ModelObject* lower {halves.objects.at(1)};
    ModelObjectPtrs keep;
    if (options.keep_lower && !lower->volumes.empty()) {
        if (options.rotate_lower && options.axis == Z) lower->rotate(PI, X);
        lower->center_around_origin();
        keep.push_back(lower);
    }
    if (options.keep_upper && !upper->volumes.empty()) {
        upper->center_around_origin();
        keep.push_back(upper);
    }
    if (keep.empty()) return;
    this->model->delete_object(idx);
    this->objects.erase(this->objects.begin() + idx);
    this->select_object();
    for (const int i : this->load_model_objects(keep)) this->objects[i].input_file.clear();  // not the file any more
    this->arrange();
}

void Plater::cut_by_grid(int idx, const ModelObject& object, const Pointf& grid) {
    wxBusyCursor busy;
    TriangleMesh mesh {object.raw_mesh()};
    mesh.repair();
    const Pointf3 center {mesh.bounding_box().center()};
    const Pointf place {object.instances.front()->offset};
    Slic3r::Model tiles;
    for (TriangleMesh* part : mesh.cut_by_grid(grid)) {
        std::unique_ptr<TriangleMesh> tile {part};
        if (tile->facets_count() == 0) continue;  // nothing of the object in this field
        ModelObject* piece {tiles.add_object()};
        piece->name = object.name + " (" + std::to_string(tiles.objects.size()) + ")";
        piece->add_volume(*tile)->name = piece->name;
        piece->center_around_origin();
        // where it was, moved 5 mm away from its neighbours (as the Perl GUI)
        const Pointf at(-piece->origin_translation().x, -piece->origin_translation().y);
        ModelInstance* instance {piece->add_instance()};
        instance->offset = Pointf(
            place.x + at.x + 5 * std::ceil((at.x - center.x) / grid.x),
            place.y + at.y + 5 * std::ceil((at.y - center.y) / grid.y));
    }
    if (tiles.objects.empty()) return;
    this->model->delete_object(idx);
    this->objects.erase(this->objects.begin() + idx);
    this->select_object();
    for (const int i : this->load_model_objects(tiles.objects)) this->objects[i].input_file.clear();
    this->on_model_change();
}

void Plater::rotate_face() {
    const int idx {this->selected_index()};
    if (idx < 0) return;
    // the face is chosen on the object as it stands on the plate
    Slic3r::Model work(*this->model);
    ModelObject* shown {work.objects.at(idx)};
    shown->transform_by_instance(*shown->instances.front(), true);
    ObjectFaceDialog dialog(this, *shown);
    if (dialog.ShowModal() != wxID_OK) return;

    ModelObject* object {this->model->objects.at(idx)};
    object->transform_by_instance(*object->instances.front(), true);
    object->rotate(dialog.normal(), dialog.target());
    object->align_to_ground();
    this->make_thumbnail(idx);
    this->on_model_change();
}

void Plater::layer_heights_dialog() {
    ModelObject* object {this->selected_model_object()};
    if (object == nullptr) return;
    this->refresh_config();
    LayerHeightsDialog dialog(this, *object, this->full_config().config());
    if (dialog.ShowModal() != wxID_OK) return;
    dialog.apply(*object);
    this->on_model_change();
}

// ---- files ----

wxString Plater::ask_export_file(const wxString& format, const wxString& extension, const wxString& wildcard) {
    wxFileName file;
    if (!this->objects.empty() && !this->objects.front().input_file.empty())
        file = wxFileName(wxString::FromUTF8(this->objects.front().input_file.c_str()));
    else
        file = wxFileName(ui_settings->skein_directory, "object");
    file.SetExt(extension);
    wxFileDialog dialog(this, wxString::Format(_("Save %s file as:"), format), file.GetPath(), file.GetFullName(),
        wildcard, wxFD_SAVE | wxFD_OVERWRITE_PROMPT);
    return dialog.ShowModal() == wxID_OK ? dialog.GetPath() : wxString();
}

void Plater::export_model(const Slic3r::Model& what, IO::ExportFormat format) {
    const wxString name {format == IO::STL ? "STL" : format == IO::AMF ? "AMF" : "3MF"};
    const std::string& wildcard {format == IO::STL ? STL_MODEL_WILDCARD : format == IO::AMF ? AMF_MODEL_WILDCARD : TMF_MODEL_WILDCARD};
    const wxString file {this->ask_export_file(name, format == IO::STL ? "stl" : format == IO::AMF ? "amf" : "3mf", wildcard)};
    if (file.IsEmpty()) return;
    bool written {false};
    try {
        written = IO::write_model.at(format)(what, file.ToUTF8().data());
    } catch (std::exception& e) {
        show_error(this, wxString::FromUTF8(e.what()));
        return;
    }
    GetFrame()->statusbar->SetStatusText(wxString::Format(written ? _("%s file exported to %s") : _("Writing the %s file %s failed"), name, file));
}

void Plater::export_plate(IO::ExportFormat format) {
    if (this->objects.empty()) {
        GetFrame()->statusbar->SetStatusText(_("Nothing to export."));
        return;
    }
    this->export_model(*this->model, format);
}

void Plater::export_object(IO::ExportFormat format) {
    const ModelObject* object {this->selected_model_object()};
    if (object == nullptr) return;
    Slic3r::Model single;
    single.add_object(*object);
    this->export_model(single, format);
}

void Plater::reload_from_disk() {
    const int idx {this->selected_index()};
    if (idx < 0) return;
    const std::string input {this->objects[idx].input_file};
    if (input.empty()) {
        show_error(this, _("The selected object couldn't be reloaded because it isn't referenced to its input file any more. This is the case after performing operations like cut or split."));
        return;
    }
    if (!wxFileExists(wxString::FromUTF8(input.c_str()))) {
        show_error(this, _("The selected object couldn't be reloaded because the file doesn't exist anymore on the disk."));
        return;
    }
    ReloadBehavior behavior {ui_settings->reload};
    bool preserve {ui_settings->reload_preserve_trafo};
    if (!ui_settings->hide_reload_dialog && !ask_reload_options(this, *ui_settings, behavior, preserve)) return;

    ModelObject* object {this->model->objects.at(idx)};
    // which object of the file this one is
    int source_idx {-1};
    for (const auto* volume : object->volumes)
        if (volume->input_file == input) { source_idx = volume->input_file_obj_idx; break; }
    Slic3r::Model file;
    try {
        file = Slic3r::Model::read_from_file(input);
    } catch (std::exception& e) {
        show_error(this, wxString::FromUTF8(e.what()));
        return;
    }
    if (source_idx < 0 || source_idx >= static_cast<int>(file.objects.size())) {
        show_error(this, _("The selected object couldn't be reloaded because the new file doesn't contain the object."));
        return;
    }
    ModelObject* source {file.objects[source_idx]};
    source->repair();
    for (size_t i = 0; i < source->volumes.size(); ++i) {
        source->volumes[i]->input_file = input;
        source->volumes[i]->input_file_obj_idx = source_idx;
        source->volumes[i]->input_file_vol_idx = i;
    }
    source->center_around_origin();  // as when it was loaded
    const bool unmatched {reload_volumes(*object, *source, input, behavior, preserve)};
    object->center_around_origin();
    object->repair();
    object->invalidate_bounding_box();
    this->make_thumbnail(idx);
    this->on_model_change();
    if (unmatched)
        show_info(this, _("At least 1 volume couldn't be matched between the original object and the reloaded one."), _("Reload"));
}

} } // Namespace Slic3r::GUI
