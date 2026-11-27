#include "OptionsGroup/OptionControl.hpp"

#include <algorithm>

#include <wx/arrstr.h>

namespace Slic3r { namespace GUI {

wxString option_name(const std::string& opt_key) {
    const ConfigOptionDef& def {print_config_def.get(opt_key)};
    return wxString::FromUTF8((!def.full_label.empty() ? def.full_label : !def.label.empty() ? def.label : opt_key).c_str());
}

OptionControl make_option_control(wxWindow* parent, const std::string& opt_key,
    std::function<DynamicPrintConfig&()> config, std::function<void()> changed)
{
    const ConfigOptionDef& def {print_config_def.get(opt_key)};
    // false: the value was not understood
    auto store = [config, opt_key](const std::string& value) {
        try {
            return config().set_deserialize(opt_key, value);
        } catch (std::exception&) {
            return false;
        }
    };

    if (def.type == coBool) {
        auto* check {new wxCheckBox(parent, wxID_ANY, "")};
        check->Bind(wxEVT_CHECKBOX, [check, store, changed](wxCommandEvent&) {
            if (store(check->GetValue() ? "1" : "0")) changed();
        });
        return {check, [check, config, opt_key]() { check->SetValue(config().serialize(opt_key) == "1"); }};
    }
    if (def.type == coEnum) {
        const std::vector<std::string> values {def.enum_values};
        wxArrayString labels;
        for (size_t i = 0; i < values.size(); ++i)
            labels.Add(wxString::FromUTF8((i < def.enum_labels.size() ? def.enum_labels[i] : values[i]).c_str()));
        auto* choice {new wxChoice(parent, wxID_ANY, wxDefaultPosition, wxDefaultSize, labels)};
        choice->Bind(wxEVT_CHOICE, [choice, values, store, changed](wxCommandEvent&) {
            const int selected {choice->GetSelection()};
            if (selected >= 0 && store(values[selected])) changed();
        });
        return {choice, [choice, values, config, opt_key]() {
            const auto it {std::find(values.begin(), values.end(), config().serialize(opt_key))};
            choice->SetSelection(it == values.end() ? wxNOT_FOUND : static_cast<int>(it - values.begin()));
        }};
    }
    // text: raw for (multi-line) strings and lists of strings, else the option's own
    // text form, which is also parsed back
    const bool multiline {def.multiline};
    auto* text {new wxTextCtrl(parent, wxID_ANY, "", wxDefaultPosition,
        wxSize(multiline ? 400 : 150, multiline ? std::max(def.height, 60) : -1),
        multiline ? wxTE_MULTILINE : wxTE_PROCESS_ENTER)};
    const ConfigOptionType type {def.type};
    auto get = [config, opt_key, type]() -> wxString {
        if (type == coString)
            return wxString::FromUTF8(config().opt<ConfigOptionString>(opt_key, true)->value.c_str());
        if (type == coStrings) {
            wxString out;
            for (const auto& v : config().opt<ConfigOptionStrings>(opt_key, true)->values)
                out << (out.empty() ? "" : "\n") << wxString::FromUTF8(v.c_str());
            return out;
        }
        return wxString::FromUTF8(config().serialize(opt_key).c_str());
    };
    auto commit = [config, opt_key, text, get, type, store, changed]() {
        const wxString value {text->GetValue()};
        if (value == get()) return;
        if (type == coString) {
            config().opt<ConfigOptionString>(opt_key, true)->value = value.ToUTF8().data();
        } else if (type == coStrings) {
            auto& values {config().opt<ConfigOptionStrings>(opt_key, true)->values};
            values.clear();
            for (const auto& line : wxSplit(value, '\n', 0))
                if (!line.IsEmpty()) values.push_back(line.ToUTF8().data());
        } else if (!store(value.ToUTF8().data())) {
            wxBell();
            text->ChangeValue(get());  // refused: back to the stored value
            return;
        }
        changed();
    };
    text->Bind(wxEVT_KILL_FOCUS, [commit](wxFocusEvent& e) { commit(); e.Skip(); });
    if (!multiline) text->Bind(wxEVT_TEXT_ENTER, [commit](wxCommandEvent&) { commit(); });
    return {text, [text, get]() { text->ChangeValue(get()); }};
}

}} // namespace Slic3r::GUI
