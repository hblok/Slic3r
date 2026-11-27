#include "OptionsGroup/OptionControl.hpp"

#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <limits>

#include <wx/arrstr.h>
#include <wx/clrpicker.h>
#include <wx/combobox.h>
#include <wx/slider.h>
#include <wx/spinctrl.h>

#include "misc_ui.hpp"

namespace Slic3r { namespace GUI {

wxString option_name(const std::string& opt_key) {
    const ConfigOptionDef& def {print_config_def.get(opt_key)};
    return wxString::FromUTF8((!def.full_label.empty() ? def.full_label : !def.label.empty() ? def.label : opt_key).c_str());
}

namespace {

bool is_number(const std::string& text) {
    const char* begin {text.c_str()};
    char* end {nullptr};
    std::strtod(begin, &end);
    if (end == begin) return false;
    while (*end == ' ' || *end == '%') ++end;
    return *end == '\0';
}

/// Make `values` long enough to hold element i: the new ones as the last.
template <class T>
void extend(std::vector<T>& values, size_t i, T fallback) {
    while (values.size() <= i) values.push_back(values.empty() ? fallback : T(values.back()));
}

} // namespace

std::string option_text(DynamicPrintConfig& config, const std::string& opt_key, int index) {
    const ConfigOptionType type {print_config_def.get(opt_key).type};
    const ConfigOption* option {config.option(opt_key, true)};
    if (type == coString) return static_cast<const ConfigOptionString*>(option)->value;
    if (type == coStrings) {
        const auto& values {static_cast<const ConfigOptionStrings*>(option)->values};
        if (index >= 0) return values.empty() ? std::string() : values[std::min<size_t>(index, values.size() - 1)];
        std::string out;
        for (const auto& value : values) out += (out.empty() ? "" : "\n") + value;
        return out;
    }
    if (index < 0) return option->serialize();
    const auto list {static_cast<const ConfigOptionVectorBase*>(dynamic_cast<const ConfigOptionVectorBase*>(option))};
    if (list == nullptr) return option->serialize();
    if (type == coPoints) {
        const auto& points {static_cast<const ConfigOptionPoints*>(option)->values};
        if (points.empty()) return "0x0";
        const Pointf& p {points[std::min<size_t>(index, points.size() - 1)]};
        return wxString::Format("%gx%g", p.x, p.y).ToStdString();
    }
    const auto texts {list->vserialize()};
    return texts.empty() ? std::string() : texts[std::min<size_t>(index, texts.size() - 1)];
}

bool set_option_text(DynamicPrintConfig& config, const std::string& opt_key, const std::string& text, int index) {
    const ConfigOptionType type {print_config_def.get(opt_key).type};
    ConfigOption* option {config.option(opt_key, true)};
    try {
        if (type == coString) {
            static_cast<ConfigOptionString*>(option)->value = text;
            return true;
        }
        if (type == coStrings) {
            auto& values {static_cast<ConfigOptionStrings*>(option)->values};
            if (index >= 0) {
                extend(values, index, std::string());
                values[index] = text;
                return true;
            }
            values.clear();
            for (const auto& line : wxSplit(wxString::FromUTF8(text.c_str()), '\n', 0))
                if (!line.IsEmpty()) values.push_back(line.ToUTF8().data());
            return true;
        }
        // numbers: the option types read what they can and ignore the rest, so check
        if (type == coFloat || type == coInt || type == coPercent || type == coFloatOrPercent
                || (index >= 0 && (type == coFloats || type == coInts))) {
            if (!is_number(text)) return false;
        }
        // without the sign a percentage would be read as a fraction (legacy files)
        if (type == coPercent && text.find('%') == std::string::npos)
            return config.set_deserialize(opt_key, text + "%");
        if (index < 0) return config.set_deserialize(opt_key, text);
        if (type == coFloats) {
            auto& values {static_cast<ConfigOptionFloats*>(option)->values};
            extend(values, index, 0.0);
            values[index] = std::strtod(text.c_str(), nullptr);
        } else if (type == coInts) {
            auto& values {static_cast<ConfigOptionInts*>(option)->values};
            extend(values, index, 0);
            values[index] = static_cast<int>(std::strtol(text.c_str(), nullptr, 10));
        } else if (type == coBools) {
            auto& values {static_cast<ConfigOptionBools*>(option)->values};
            extend(values, index, false);
            values[index] = text == "1";
        } else if (type == coPoints) {
            const size_t x {text.find('x')};
            if (x == std::string::npos || !is_number(text.substr(0, x)) || !is_number(text.substr(x + 1))) return false;
            auto& values {static_cast<ConfigOptionPoints*>(option)->values};
            extend(values, index, Pointf());
            values[index] = Pointf(std::strtod(text.c_str(), nullptr), std::strtod(text.c_str() + x + 1, nullptr));
        } else {
            return config.set_deserialize(opt_key, text);
        }
        return true;
    } catch (std::exception&) {
        return false;
    }
}

void resize_option(DynamicPrintConfig& config, const std::string& opt_key, size_t count) {
    ConfigOption* option {config.option(opt_key, true)};
    auto resize = [count](auto& values, auto fallback) {
        if (values.size() > count) values.resize(count);
        else if (count > 0) extend(values, count - 1, decltype(fallback)(fallback));
    };
    if (auto* o = dynamic_cast<ConfigOptionFloats*>(option)) resize(o->values, 0.0);
    else if (auto* o = dynamic_cast<ConfigOptionInts*>(option)) resize(o->values, 0);
    else if (auto* o = dynamic_cast<ConfigOptionBools*>(option)) resize(o->values, false);
    else if (auto* o = dynamic_cast<ConfigOptionPoints*>(option)) resize(o->values, Pointf());
    else if (auto* o = dynamic_cast<ConfigOptionStrings*>(option)) resize(o->values, std::string());
}

void commit_pending_edit() {
    if (wxWindow* focused {wxWindow::FindFocus()}) {
        wxFocusEvent left(wxEVT_KILL_FOCUS, focused->GetId());
        focused->ProcessWindowEvent(left);
    }
}

namespace {

/// What every kind of control needs; copied into the event handlers.
struct Field {
    std::string key;
    std::function<DynamicPrintConfig&()> config;
    std::function<void()> changed;
    int index;
    std::string text() const { return option_text(config(), key, index); }
    /// false: refused
    bool store(const std::string& value) const {
        const std::string before {text()};
        if (value == before) return true;
        if (!set_option_text(config(), key, value, index)) return false;
        if (text() != before) changed();
        return true;
    }
};

/// Store what a text field holds when it loses the focus or Enter is pressed; refresh()
/// afterwards shows the stored form (or the old value, when refused).
void commit_on_leave(wxWindow* control, bool enter, std::function<void()> commit) {
    control->Bind(wxEVT_KILL_FOCUS, [commit](wxFocusEvent& e) { commit(); e.Skip(); });
    if (enter) control->Bind(wxEVT_TEXT_ENTER, [commit](wxCommandEvent&) { commit(); });
}

OptionControl checkbox(wxWindow* parent, const Field& field) {
    auto* check {new wxCheckBox(parent, wxID_ANY, "")};
    check->Bind(wxEVT_CHECKBOX, [check, field](wxCommandEvent&) { field.store(check->GetValue() ? "1" : "0"); });
    return {check, [check, field]() { check->SetValue(field.text() == "1"); }};
}

OptionControl choice(wxWindow* parent, const Field& field, const ConfigOptionDef& def) {
    const std::vector<std::string> values {def.enum_values};
    wxArrayString labels;
    for (size_t i = 0; i < values.size(); ++i)
        labels.Add(wxString::FromUTF8((i < def.enum_labels.size() ? def.enum_labels[i] : values[i]).c_str()));
    auto* control {new wxChoice(parent, wxID_ANY, wxDefaultPosition, wxDefaultSize, labels)};
    control->Bind(wxEVT_CHOICE, [control, values, field](wxCommandEvent&) {
        const int selected {control->GetSelection()};
        if (selected >= 0) field.store(values[selected]);
    });
    return {control, [control, values, field]() {
        const auto it {std::find(values.begin(), values.end(), field.text())};
        control->SetSelection(it == values.end() ? wxNOT_FOUND : static_cast<int>(it - values.begin()));
    }};
}

/// A number (or text) with suggestions: "open" enums and the serial port.
OptionControl combo(wxWindow* parent, const Field& field, const ConfigOptionDef& def, int width) {
    std::vector<std::string> values {def.enum_values}, labels {def.enum_labels};
    if (def.gui_type == "select_open")
        for (const auto& port : scan_serial_ports()) values.push_back(port.ToUTF8().data());
    if (labels.empty()) labels = values;
    wxArrayString items;
    for (const auto& label : labels) items.Add(wxString::FromUTF8(label.c_str()));
    auto* control {new wxComboBox(parent, wxID_ANY, "", wxDefaultPosition, wxSize(width > 0 ? width : 150, -1), items, wxTE_PROCESS_ENTER)};
    const bool show_value {def.gui_flags.find("show_value") != std::string::npos};
    const bool percent {def.type == coPercent};
    auto same = [percent](std::string a, std::string b) {
        if (percent) {
            if (!a.empty() && a.back() == '%') a.pop_back();
            if (!b.empty() && b.back() == '%') b.pop_back();
        }
        return a == b;
    };
    auto refresh = [control, field, values, labels, show_value, same]() {
        const std::string value {field.text()};
        std::string shown {value};
        if (!show_value)
            for (size_t i = 0; i < labels.size(); ++i)
                if (same(i < values.size() ? values[i] : std::to_string(i), value)) { shown = labels[i]; break; }
        control->ChangeValue(wxString::FromUTF8(shown.c_str()));
    };
    auto commit = [control, field, values, labels, refresh]() {
        std::string value {control->GetValue().ToUTF8().data()};
        // a label of the list stands for its value (or its position)
        for (size_t i = 0; i < labels.size(); ++i)
            if (labels[i] == value) { value = i < values.size() ? values[i] : std::to_string(i); break; }
        if (!field.store(value)) { wxBell(); refresh(); }
    };
    control->Bind(wxEVT_COMBOBOX, [commit, refresh](wxCommandEvent&) { commit(); refresh(); });
    commit_on_leave(control, true, commit);
    return {control, refresh};
}

OptionControl spin(wxWindow* parent, const Field& field, const ConfigOptionDef& def) {
    const int low {def.min == std::numeric_limits<int>::min() ? 0 : def.min};
    auto* control {new wxSpinCtrl(parent, wxID_ANY, "", wxDefaultPosition, wxDefaultSize,
        wxSP_ARROW_KEYS | wxTE_PROCESS_ENTER, low, def.max)};
    // room for the digits and both buttons, whatever the range allows
    control->SetMinSize(wxSize(130, -1));
    control->SetSize(wxSize(130, -1));
    auto commit = [control, field]() { field.store(std::to_string(control->GetValue())); };
    control->Bind(wxEVT_SPINCTRL, [commit](wxSpinEvent&) { commit(); });
    commit_on_leave(control, true, commit);
    return {control, [control, field]() { control->SetValue(std::atoi(field.text().c_str())); }};
}

OptionControl slider(wxWindow* parent, const Field& field, const ConfigOptionDef& def, int width) {
    const int low {def.min == std::numeric_limits<int>::min() ? 0 : def.min};
    const int high {def.max == std::numeric_limits<int>::max() ? 100 : def.max};
    auto* panel {new wxPanel(parent)};
    auto* bar {new wxSlider(panel, wxID_ANY, low, low, high, wxDefaultPosition, wxSize(width > 0 ? width : 200, -1))};
    auto* text {new wxTextCtrl(panel, wxID_ANY, "", wxDefaultPosition, wxSize(60, -1), wxTE_PROCESS_ENTER)};
    auto* sizer {new wxBoxSizer(wxHORIZONTAL)};
    sizer->Add(bar, 1, wxALIGN_CENTER_VERTICAL);
    sizer->Add(text, 0, wxALIGN_CENTER_VERTICAL);
    panel->SetSizer(sizer);
    auto refresh = [bar, text, field]() {
        const double value {std::atof(field.text().c_str())};
        bar->SetValue(static_cast<int>(std::lround(value)));
        text->ChangeValue(wxString::Format("%g", value));
    };
    bar->Bind(wxEVT_SLIDER, [bar, field, refresh](wxCommandEvent&) { field.store(std::to_string(bar->GetValue())); refresh(); });
    auto commit = [text, field, refresh]() {
        if (!field.store(text->GetValue().ToUTF8().data())) wxBell();
        refresh();
    };
    commit_on_leave(text, true, commit);
    return {panel, refresh};
}

OptionControl colour(wxWindow* parent, const Field& field) {
    auto* control {new wxColourPickerCtrl(parent, wxID_ANY)};
    control->Bind(wxEVT_COLOURPICKER_CHANGED, [control, field](wxColourPickerEvent&) {
        field.store(control->GetColour().GetAsString(wxC2S_HTML_SYNTAX).ToStdString());
    });
    return {control, [control, field]() {
        wxColour value;
        if (!value.Set(wxString::FromUTF8(field.text().c_str()))) value = *wxWHITE;
        control->SetColour(value);
    }};
}

/// "XxY", as the elements of a list of points are written, in two fields.
OptionControl point(wxWindow* parent, const Field& field) {
    auto* panel {new wxPanel(parent)};
    auto* sizer {new wxBoxSizer(wxHORIZONTAL)};
    wxTextCtrl* parts[2];
    for (int i = 0; i < 2; ++i) {
        sizer->Add(new wxStaticText(panel, wxID_ANY, i == 0 ? "x:" : "  y:"), 0, wxALIGN_CENTER_VERTICAL);
        parts[i] = new wxTextCtrl(panel, wxID_ANY, "", wxDefaultPosition, wxSize(60, -1), wxTE_PROCESS_ENTER);
        sizer->Add(parts[i], 0, wxALIGN_CENTER_VERTICAL);
    }
    panel->SetSizer(sizer);
    wxTextCtrl* x {parts[0]};
    wxTextCtrl* y {parts[1]};
    auto refresh = [x, y, field]() {
        const std::string value {field.text()};
        const size_t at {value.find('x')};
        x->ChangeValue(value.substr(0, at));
        y->ChangeValue(at == std::string::npos ? "" : value.substr(at + 1));
    };
    auto commit = [x, y, field, refresh]() {
        if (!field.store((x->GetValue() + "x" + y->GetValue()).ToStdString())) { wxBell(); refresh(); }
    };
    commit_on_leave(x, true, commit);
    commit_on_leave(y, true, commit);
    return {panel, refresh};
}

/// The option's own text form, which is also parsed back; strings as they are.
OptionControl text_field(wxWindow* parent, const Field& field, const ConfigOptionDef& def, int width, int height) {
    const bool multiline {def.multiline || height > 0};
    auto* control {new wxTextCtrl(parent, wxID_ANY, "", wxDefaultPosition,
        wxSize(width > 0 ? width : multiline ? 400 : 100, multiline ? std::max(height > 0 ? height : def.height, 60) : -1),
        multiline ? wxTE_MULTILINE : wxTE_PROCESS_ENTER)};
    auto refresh = [control, field]() {
        const wxString value {wxString::FromUTF8(field.text().c_str())};
        if (control->GetValue() != value) control->ChangeValue(value);
    };
    auto commit = [control, field, refresh]() {
        if (!field.store(control->GetValue().ToUTF8().data())) { wxBell(); refresh(); }
    };
    commit_on_leave(control, !multiline, commit);
    return {control, refresh};
}

} // namespace

OptionControl make_option_control(wxWindow* parent, const std::string& opt_key,
    std::function<DynamicPrintConfig&()> config, std::function<void()> changed, int index, int width, int height)
{
    const ConfigOptionDef& def {print_config_def.get(opt_key)};
    const Field field {opt_key, config, changed, index};
    if (width <= 0) width = def.width;
    if (height <= 0) height = def.height;
    if (def.type == coBool || (def.type == coBools && index >= 0)) return checkbox(parent, field);
    if (def.type == coEnum) return choice(parent, field, def);
    if (def.gui_type == "color") return colour(parent, field);
    if (def.gui_type == "slider") return slider(parent, field, def, width);
    if (!def.gui_type.empty()) return combo(parent, field, def, width);
    if (def.type == coInt || (def.type == coInts && index >= 0)) return spin(parent, field, def);
    if (def.type == coPoints && index >= 0) return point(parent, field);
    return text_field(parent, field, def, width, height);
}

}} // namespace Slic3r::GUI
