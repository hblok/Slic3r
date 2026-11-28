#include <gtest/gtest.h>

#include <functional>
#include <sstream>
#include <string>
#include <vector>

#include "Log.hpp"

using namespace Slic3r;

namespace {

using Action = std::function<void(_Log&)>;
using Lines = std::vector<std::string>;

const std::string fatal_line {"Topic  FERR: This\n"}, error_line {"Topic   ERR: This\n"},
    warn_line {"Topic  WARN: This\n"}, info_line {"Topic  INFO: This\n"}, debug_line {"Topic DEBUG: This\n"};

/// What a new logger, set up by `setup`, writes for `call`.
std::string written(const Action& setup, const Action& call) {
    std::stringstream out;
    const std::unique_ptr<_Log> logger {_Log::make_log(out)};
    setup(*logger);
    call(*logger);
    return out.str();
}

void everything(_Log& log) {
    log.set_level(log_t::DEBUG);
    log.set_inclusive(true);
}

/// The same message at each level: fatal error, error, warning, info, debug.
Lines each_level(const Action& setup) {
    return {
        written(setup, [](_Log& log) { log.fatal_error("Topic", "This"); }),
        written(setup, [](_Log& log) { log.error("Topic", "This"); }),
        written(setup, [](_Log& log) { log.warn("Topic", "This"); }),
        written(setup, [](_Log& log) { log.info("Topic", "This"); }),
        written(setup, [](_Log& log) { log.debug("Topic", "This"); }),
    };
}

/// A level and all that are more severe.
Action up_to(log_t level) {
    return [level](_Log& log) {
        log.set_inclusive(true);
        log.set_level(level);
    };
}

/// These levels and no others.
Action only(const std::vector<log_t>& levels) {
    return [levels](_Log& log) {
        log.set_inclusive(false);
        log.clear_level(log_t::ALL);
        for (const log_t level : levels) log.set_level(level);
    };
}

/// The log of one message for each of three topics when only `wanted` ones are let through.
std::string by_topic(const std::vector<std::string>& wanted) {
    return written(
        [&wanted](_Log& log) {
            log.set_inclusive(true);
            log.set_level(log_t::ALL);
            for (const auto& topic : wanted) log.add_topic(topic);
        },
        [](_Log& log) {
            log.debug("t1") << "TEXT FOR T1 ";
            log.debug("t2") << "TEXT FOR T2 ";
            log.debug("t3") << "TEXT FOR T3";
        });
}

} // namespace

TEST(Log, Strings) {
    EXPECT_EQ(written(everything, [](_Log& log) { log.fatal_error("Topic", "This"); }), fatal_line);
    EXPECT_EQ(written(everything, [](_Log& log) { log.error("Topic", "This"); }), error_line);
    EXPECT_EQ(written(everything, [](_Log& log) { log.warn("Topic", "This"); }), warn_line);
    EXPECT_EQ(written(everything, [](_Log& log) { log.info("Topic", "This"); }), info_line);
    EXPECT_EQ(written(everything, [](_Log& log) { log.debug("Topic", "This"); }), debug_line);
    EXPECT_EQ(written(everything, [](_Log& log) { log.raw("This"); }), "This\n");
}

TEST(Log, WideStrings) {
    EXPECT_EQ(written(everything, [](_Log& log) { log.fatal_error("Topic", L"This"); }), fatal_line);
    EXPECT_EQ(written(everything, [](_Log& log) { log.error("Topic", L"This"); }), error_line);
    EXPECT_EQ(written(everything, [](_Log& log) { log.warn("Topic", L"This"); }), warn_line);
    EXPECT_EQ(written(everything, [](_Log& log) { log.info("Topic", L"This"); }), info_line);
    EXPECT_EQ(written(everything, [](_Log& log) { log.debug("Topic", L"This"); }), debug_line);
    EXPECT_EQ(written(everything, [](_Log& log) { log.raw(L"This"); }), "This\n");
}

TEST(Log, Streams) {
    EXPECT_EQ(written(everything, [](_Log& log) { log.fatal_error("Topic") << "This"; }), "Topic  FERR: This");
    EXPECT_EQ(written(everything, [](_Log& log) { log.error("Topic") << "This"; }), "Topic   ERR: This");
    EXPECT_EQ(written(everything, [](_Log& log) { log.warn("Topic") << "This"; }), "Topic  WARN: This");
    EXPECT_EQ(written(everything, [](_Log& log) { log.info("Topic") << "This"; }), "Topic  INFO: This");
    EXPECT_EQ(written(everything, [](_Log& log) { log.debug("Topic") << "This"; }), "Topic DEBUG: This");
    EXPECT_EQ(written(everything, [](_Log& log) { log.raw() << "This"; }), "This");
}

TEST(Log, InclusiveLevels) {
    const Action fatal_only {[](_Log& log) {
        log.clear_level(log_t::FERR);
        log.set_inclusive(true);
        log.set_level(log_t::FERR);
    }};
    EXPECT_EQ(each_level(fatal_only), (Lines{fatal_line, "", "", "", ""}));
    EXPECT_EQ(each_level(up_to(log_t::ERR)), (Lines{fatal_line, error_line, "", "", ""}));
    EXPECT_EQ(each_level(up_to(log_t::WARN)), (Lines{fatal_line, error_line, warn_line, "", ""}));
    EXPECT_EQ(each_level(up_to(log_t::INFO)), (Lines{fatal_line, error_line, warn_line, info_line, ""}));
    EXPECT_EQ(each_level(up_to(log_t::DEBUG)), (Lines{fatal_line, error_line, warn_line, info_line, debug_line}));
}

TEST(Log, ChosenLevels) {
    EXPECT_EQ(each_level(only({log_t::FERR})), (Lines{fatal_line, "", "", "", ""}));
    EXPECT_EQ(each_level(only({log_t::WARN})), (Lines{"", "", warn_line, "", ""}));
    EXPECT_EQ(each_level(only({log_t::INFO})), (Lines{"", "", "", info_line, ""}));
    EXPECT_EQ(each_level(only({log_t::DEBUG})), (Lines{"", "", "", "", debug_line}));
    EXPECT_EQ(each_level(only({log_t::DEBUG, log_t::ERR})), (Lines{"", error_line, "", "", debug_line}));
    EXPECT_EQ(each_level(only({log_t::INFO, log_t::WARN})), (Lines{"", "", warn_line, info_line, ""}));
}

TEST(Log, Topics) {
    EXPECT_EQ(by_topic({"t1"}), "t1 DEBUG: TEXT FOR T1 ");
    EXPECT_EQ(by_topic({"t2"}), "t2 DEBUG: TEXT FOR T2 ");
    EXPECT_EQ(by_topic({"t3"}), "t3 DEBUG: TEXT FOR T3");
    EXPECT_EQ(by_topic({"t2", "t3"}), "t2 DEBUG: TEXT FOR T2 t3 DEBUG: TEXT FOR T3");
}
