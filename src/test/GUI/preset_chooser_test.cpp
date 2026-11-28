// From test_preset_chooser.cpp.
#include <gtest/gtest.h>

#include <array>
#include <memory>
#include <string>

#include "Config.hpp"
#include "Plater/PresetChooser.hpp"
#include "Preset.hpp"
#include "Print.hpp"

using namespace Slic3r::GUI;
using namespace std::literals::string_literals;

namespace {

/// the files the tests read (data of the test target)
const std::string testfile_dir {"src/test/inputs/"};

std::array<Presets, preset_types> defaults() {
    std::array<Presets, preset_types> default_presets;
    default_presets[get_preset(preset_t::Print)].push_back(Preset(true, "- default -", preset_t::Print));
    default_presets[get_preset(preset_t::Material)].push_back(Preset(true, "- default -", preset_t::Material));
    default_presets[get_preset(preset_t::Printer)].push_back(Preset(true, "- default -", preset_t::Printer));
    return default_presets;
}

std::array<Presets, preset_types> sample() {
    std::array<Presets, preset_types> preset_list;
    preset_list[get_preset(preset_t::Print)].push_back(Preset(testfile_dir + "test_preset_chooser"s, "print-profile.ini", preset_t::Print));
    preset_list[get_preset(preset_t::Print)].push_back(Preset(true, "- default -", preset_t::Print));

    preset_list[get_preset(preset_t::Material)].push_back(Preset(testfile_dir + "test_preset_chooser"s, "material-profile.ini", preset_t::Material));
    preset_list[get_preset(preset_t::Material)].push_back(Preset(true, "- default -", preset_t::Material));

    preset_list[get_preset(preset_t::Printer)].push_back(Preset(true, "- default -", preset_t::Printer));
    preset_list[get_preset(preset_t::Printer)].push_back(Preset(testfile_dir + "test_preset_chooser"s, "printer-profile.ini", preset_t::Printer));

    return preset_list;
}

std::array<Presets, preset_types> default_compatible_reversion() {
    std::array<Presets, preset_types> preset_list;
    preset_list[get_preset(preset_t::Print)].push_back(Preset(testfile_dir + "test_preset_chooser"s, "print-profile.ini", preset_t::Print));
    preset_list[get_preset(preset_t::Print)].push_back(Preset(true, "- default -", preset_t::Print));

    // set the material to be compatible to printer-profile-2 only
    preset_list[get_preset(preset_t::Material)].push_back(Preset(testfile_dir + "test_preset_chooser"s, "incompat-material-profile.ini", preset_t::Material));
    preset_list[get_preset(preset_t::Material)].push_back(Preset(true, "- default -", preset_t::Material));

    preset_list[get_preset(preset_t::Printer)].push_back(Preset(true, "- default -", preset_t::Printer));
    preset_list[get_preset(preset_t::Printer)].push_back(Preset(testfile_dir + "test_preset_chooser"s, "printer-profile-2.ini", preset_t::Printer));
    preset_list[get_preset(preset_t::Printer)].push_back(Preset(testfile_dir + "test_preset_chooser"s, "printer-profile.ini", preset_t::Printer));

    return preset_list;
}

std::array<Presets, preset_types> compatible_reversion() {
    std::array<Presets, preset_types> preset_list;
    preset_list[get_preset(preset_t::Print)].push_back(Preset(testfile_dir + "test_preset_chooser"s, "print-profile.ini", preset_t::Print));
    preset_list[get_preset(preset_t::Print)].push_back(Preset(true, "- default -", preset_t::Print));

    // set the material to be compatible to printer-profile-2 only
    preset_list[get_preset(preset_t::Material)].push_back(Preset(testfile_dir + "test_preset_chooser"s, "incompat-material-profile.ini", preset_t::Material));
    preset_list[get_preset(preset_t::Material)].push_back(Preset(testfile_dir + "test_preset_chooser"s, "material-profile.ini", preset_t::Material));
    preset_list[get_preset(preset_t::Material)].push_back(Preset(testfile_dir + "test_preset_chooser"s, "other-material-profile.ini", preset_t::Material));
    preset_list[get_preset(preset_t::Material)].push_back(Preset(true, "- default -", preset_t::Material));

    preset_list[get_preset(preset_t::Printer)].push_back(Preset(true, "- default -", preset_t::Printer));
    preset_list[get_preset(preset_t::Printer)].push_back(Preset(testfile_dir + "test_preset_chooser"s, "printer-profile-2.ini", preset_t::Printer));
    preset_list[get_preset(preset_t::Printer)].push_back(Preset(testfile_dir + "test_preset_chooser"s, "printer-profile.ini", preset_t::Printer));

    return preset_list;
}

} // namespace

// PresetChooser changed printer; A PresetChooser with printer-profile selected.; Printer profile is changed to printer-profile-2 via select_preset_by_name
TEST(PresetChooser, ShowsWhatFitsTheChosenPrinter) {
    std::shared_ptr<Print> fake_print {std::make_shared<Print>()};
    Settings default_settings;
    {  // given: A PresetChooser with printer-profile selected.
        Settings test_settings;
        test_settings.default_presets.at(get_preset(preset_t::Printer)).push_back(wxString("printer-profile"));
        auto preset_list {default_compatible_reversion()};
        PresetChooser cut(wxTheApp->GetTopWindow(), fake_print, &test_settings, preset_list);
        cut.load();
        {  // when: Printer profile is changed to printer-profile-2 via select_preset_by_name
            cut.select_preset_by_name("printer-profile-2", preset_t::Printer, 0);
            {  // then: Selected printer profile entry is 'printer-profile-2
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Printer)]) {
                    EXPECT_EQ(chooser->GetString(chooser->GetSelection()), wxString("printer-profile-2"));
                }
            }
            {  // then: Print profile chooser has 1 entry
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Print)]) {
                    EXPECT_EQ(chooser->GetCount(), 1);
                }
            }
            {  // then: Selected print profile entry is 'print-profile
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Print)]) {
                    EXPECT_EQ(chooser->GetString(chooser->GetSelection()), wxString("print-profile"));
                }
            }
            {  // then: Material profile chooser has one entry
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Material)]) {
                    EXPECT_EQ(chooser->GetCount(), 1);
                }
            }
            {  // then: Selected material profile entry is 'material-profile
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Material)]) {
                    EXPECT_EQ(chooser->GetString(chooser->GetSelection()), wxString("incompat-material-profile"));
                }
            }
        }
    }
}

// PresetChooser changed printer; A PresetChooser with printer-profile selected.; Printer profile is changed to printer-profile-2 via combobox event
TEST(PresetChooser, FollowsAChoiceMadeInTheComboBox) {
    std::shared_ptr<Print> fake_print {std::make_shared<Print>()};
    Settings default_settings;
    {  // given: A PresetChooser with printer-profile selected.
        Settings test_settings;
        test_settings.default_presets.at(get_preset(preset_t::Printer)).push_back(wxString("printer-profile"));
        auto preset_list {default_compatible_reversion()};
        PresetChooser cut(wxTheApp->GetTopWindow(), fake_print, &test_settings, preset_list);
        cut.load();
        {  // when: Printer profile is changed to printer-profile-2 via combobox event
            auto* printer_chooser = cut.preset_choosers[get_preset(preset_t::Printer)].at(0);
            printer_chooser->SetSelection(0);

            auto ev {wxCommandEvent(wxEVT_COMBOBOX, printer_chooser->GetId())};
            ev.SetEventObject(printer_chooser);
            printer_chooser->ProcessWindowEvent(ev);
            wxYield();
            wxMilliSleep(150);
            {  // then: Selected printer profile entry is 'printer-profile-2
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Printer)]) {
                    EXPECT_EQ(chooser->GetString(chooser->GetSelection()), wxString("printer-profile-2"));
                }
            }
            {  // then: Print profile chooser has 1 entry
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Print)]) {
                    EXPECT_EQ(chooser->GetCount(), 1);
                }
            }
            {  // then: Selected print profile entry is 'print-profile
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Print)]) {
                    EXPECT_EQ(chooser->GetString(chooser->GetSelection()), wxString("print-profile"));
                }
            }
            {  // then: Material profile chooser has one entry
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Material)]) {
                    EXPECT_EQ(chooser->GetCount(), 1);
                }
            }
            {  // then: Selected material profile entry is 'material-profile
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Material)]) {
                    EXPECT_EQ(chooser->GetString(chooser->GetSelection()), wxString("incompat-material-profile"));
                }
            }
        }
    }
}

// PresetChooser changed printer; A PresetChooser with printer-profile selected and 2+ non-default entries for material .; Printer profile has only 2 compatible materials
TEST(PresetChooser, OffersOnlyCompatibleMaterials) {
    std::shared_ptr<Print> fake_print {std::make_shared<Print>()};
    Settings default_settings;
    {  // given: A PresetChooser with printer-profile selected and 2+ non-default entries for material .
        Settings test_settings;
        test_settings.default_presets.at(get_preset(preset_t::Printer)).push_back(wxString("printer-profile"));
        auto preset_list {compatible_reversion()};
        PresetChooser cut(wxTheApp->GetTopWindow(), fake_print, &test_settings, preset_list);
        cut.load();
        {  // when: Printer profile has only 2 compatible materials
            {  // then: Material profile chooser has two entries
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Material)]) {
                    EXPECT_EQ(chooser->GetCount(), 2);
                }
            }
            {  // then: incompat-material-profile is not in the chooser
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Material)]) {
                    EXPECT_EQ(chooser->FindString("incompat-material-profile"), wxNOT_FOUND);
                }
            }
        }
    }
}

// PresetChooser changed printer; A PresetChooser with printer-profile selected and 2+ non-default entries for material .; Printer profile is changed to printer-profile-2 via select_preset_by_name
TEST(PresetChooser, ShowsOtherMaterialsForAnotherPrinter) {
    std::shared_ptr<Print> fake_print {std::make_shared<Print>()};
    Settings default_settings;
    {  // given: A PresetChooser with printer-profile selected and 2+ non-default entries for material .
        Settings test_settings;
        test_settings.default_presets.at(get_preset(preset_t::Printer)).push_back(wxString("printer-profile"));
        auto preset_list {compatible_reversion()};
        PresetChooser cut(wxTheApp->GetTopWindow(), fake_print, &test_settings, preset_list);
        cut.load();
        {  // when: Printer profile is changed to printer-profile-2 via select_preset_by_name
            cut.select_preset_by_name("printer-profile-2", preset_t::Printer, 0);
            {  // then: Selected printer profile entry is 'printer-profile-2
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Printer)]) {
                    EXPECT_EQ(chooser->GetString(chooser->GetSelection()), wxString("printer-profile-2"));
                }
            }
            {  // then: Print profile chooser has 1 entry
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Print)]) {
                    EXPECT_EQ(chooser->GetCount(), 1);
                }
            }
            {  // then: Selected print profile entry is 'print-profile
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Print)]) {
                    EXPECT_EQ(chooser->GetString(chooser->GetSelection()), wxString("print-profile"));
                }
            }
            {  // then: Material profile chooser has one entry
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Material)]) {
                    EXPECT_EQ(chooser->GetCount(), 3);
                }
            }
        }
    }
}

// PresetChooser Preset loading; A PresetChooser object.; load() is called with only default presets
TEST(PresetChooser, ShowsTheDefaultPresetsWhenThereAreNoOthers) {
    std::shared_ptr<Print> fake_print {std::make_shared<Print>()};
    Settings default_settings;
    auto& settings_presets = default_settings.default_presets;
    {  // given: A PresetChooser object.
        {  // when: load() is called with only default presets
            auto preset_list {defaults()};
            PresetChooser cut(wxTheApp->GetTopWindow(), fake_print, &default_settings, preset_list);
            cut.load();
            {  // then: Number of preset choosers created is 3
                ASSERT_EQ(cut.preset_choosers.size(), 3u);
            }
            {  // then: Each profile chooser has 1 entry
                for (auto chooser_list : cut.preset_choosers) {
                    ASSERT_EQ(chooser_list.size(), 1u);
                    for (auto* chooser : chooser_list) {
                        EXPECT_EQ(chooser->GetCount(), 1);
                    }
                }
            }
            {  // then: Selection mapping table has 3 profile entries, all named '- default -
                for (const auto& group : { preset_t::Print, preset_t::Material, preset_t::Printer }) {
                    EXPECT_EQ(cut._chooser_names()[get_preset(group)].at(0), wxString("- default -"));
                }
            }
        }
    }
}

// PresetChooser Preset loading; A PresetChooser object.; load is called with non-default presets and default presets
TEST(PresetChooser, HidesTheDefaultsWhenThereArePresetsAndRemembersTheChoice) {
    std::shared_ptr<Print> fake_print {std::make_shared<Print>()};
    Settings default_settings;
    auto& settings_presets = default_settings.default_presets;
    {  // given: A PresetChooser object.
        {  // when: load is called with non-default presets and default presets
            auto preset_list {sample()};
            PresetChooser cut(wxTheApp->GetTopWindow(), fake_print, &default_settings, preset_list);
            cut.load();
            {  // then: Number of preset choosers created is 3
                ASSERT_EQ(cut.preset_choosers.size(), 3u);
            }
            {  // then: Each profile chooser has 1 entry
                for (auto chooser_list : cut.preset_choosers) {
                    ASSERT_EQ(chooser_list.size(), 1u);
                    for (auto* chooser : chooser_list) {
                        EXPECT_EQ(chooser->GetCount(), 1);
                    }
                }
            }
            {  // then: Selection mapping table has 3 profile entries, none named '- default -
                for (const auto& group : { preset_t::Print, preset_t::Material, preset_t::Printer }) {
                    EXPECT_NE(cut._chooser_names()[get_preset(group)].at(0), wxString("- default -"));
                }
            }
            {  // then: Settings are updated to match selected.
                EXPECT_EQ(settings_presets[get_preset(preset_t::Print)].at(0), wxString("print-profile"));
                EXPECT_EQ(settings_presets[get_preset(preset_t::Printer)].at(0), wxString("printer-profile"));
                EXPECT_EQ(settings_presets[get_preset(preset_t::Material)].at(0), wxString("material-profile"));
            }
        }
    }
}

// PresetChooser Preset loading; A PresetChooser object and a Settings indicating that print-profile is the default option.; load is called with non-default presets and default presets and the material is listed with an incompatible printer
TEST(PresetChooser, StartsWithThePrinterOfTheSettings) {
    std::shared_ptr<Print> fake_print {std::make_shared<Print>()};
    Settings default_settings;
    auto& settings_presets = default_settings.default_presets;
    {  // given: A PresetChooser object and a Settings indicating that print-profile is the default option.
        Settings test_settings;
        test_settings.default_presets.at(get_preset(preset_t::Printer)).push_back(wxString("printer-profile"));
        auto preset_list {default_compatible_reversion()};
        PresetChooser cut(wxTheApp->GetTopWindow(), fake_print, &test_settings, preset_list);
        {  // when: load is called with non-default presets and default presets and the material is listed with an incompatible printer
            cut.load();
            {  // then: Number of preset choosers created is 3
                ASSERT_EQ(cut.preset_choosers.size(), 3u);
            }
            {  // then: Print profile chooser has 1 entry
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Print)]) {
                    EXPECT_EQ(chooser->GetCount(), 1);
                }
            }
            {  // then: Printer profile chooser has 2 entries
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Printer)]) {
                    EXPECT_EQ(chooser->GetCount(), 2);
                }
            }
            {  // then: Material profile chooser has one entry
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Material)]) {
                    EXPECT_EQ(chooser->GetCount(), 1);
                }
            }
            {  // then: Selected printer profile entry is 'printer-profile
                for (auto* chooser : cut.preset_choosers[get_preset(preset_t::Printer)]) {
                    EXPECT_EQ(chooser->GetString(chooser->GetSelection()), wxString("printer-profile"));
                }
            }
            {  // then: Print profile entry has one entry named 'print-profile
                EXPECT_EQ(cut._chooser_names()[get_preset(preset_t::Print)].at(0), wxString("print-profile"));
            }
            {  // then: Printer profile entry has an entry named 'printer-profile
                EXPECT_EQ(cut._chooser_names()[get_preset(preset_t::Printer)].at(1), wxString("printer-profile"));
            }
            {  // then: Printer profile entry has an entry named 'printer-profile
                EXPECT_EQ(cut._chooser_names()[get_preset(preset_t::Printer)].at(0), wxString("printer-profile-2"));
            }
            {  // then: Material profile entry has one entry named '- default -
                EXPECT_EQ(cut._chooser_names()[get_preset(preset_t::Material)].at(0), wxString("- default -"));
            }
        }
    }
}
