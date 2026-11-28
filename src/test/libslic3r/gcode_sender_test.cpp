#include <gtest/gtest.h>

#include <fcntl.h>
#include <poll.h>
#include <stdlib.h>
#include <unistd.h>

#include <string>

#include "GCodeSender.hpp"

using namespace Slic3r;

namespace {

/// The printer's end of a serial line: the other side of a pseudo terminal.
struct Printer {
    int fd {posix_openpt(O_RDWR | O_NOCTTY)};
    std::string port;
    Printer() {
        if (fd >= 0 && grantpt(fd) == 0 && unlockpt(fd) == 0) port = ptsname(fd);
    }
    ~Printer() { if (fd >= 0) close(fd); }

    /// The next line from the sender; empty if none comes in time.
    std::string line(int wait_ms = 5000) {
        std::string out;
        pollfd ready {fd, POLLIN, 0};
        for (char c; poll(&ready, 1, wait_ms) == 1 && read(fd, &c, 1) == 1; ) {
            if (c == '\n') return out;
            out += c;
        }
        return "";
    }
    void say(const std::string& text) {
        const std::string out {text + "\n"};
        ASSERT_EQ(write(fd, out.data(), out.size()), static_cast<ssize_t>(out.size()));
    }
};

/// A line as it goes over the wire: number, command and the XOR of both.
std::string framed(int number, const std::string& command) {
    const std::string line {"N" + std::to_string(number) + " " + command};
    int sum {0};
    for (const char c : line) sum ^= c;
    return line + "*" + std::to_string(sum);
}

} // namespace

TEST(GCodeSender, RefusesAPortThatIsNotThere) {
    GCodeSender sender;
    EXPECT_FALSE(sender.connect("/nonexistent/port", 115200));
    EXPECT_TRUE(sender.error_status());
}

TEST(GCodeSender, TalksToAPrinter) {
    Printer printer;
    if (printer.port.empty()) GTEST_SKIP() << "no pseudo terminals here";
    GCodeSender sender;
    ASSERT_TRUE(sender.connect(printer.port, 115200));  // takes some seconds: it resets the board

    EXPECT_EQ(printer.line(), framed(1, "M105"));
    EXPECT_FALSE(sender.is_connected());
    printer.say("ok T:200.5 /200.0 B:60.0 /60.0");
    ASSERT_TRUE(sender.wait_connected(5));

    // comments are not sent, and the next line waits for the "ok"
    sender.send("G28 ; home");
    sender.send("G1 X10");
    EXPECT_EQ(printer.line(), framed(2, "G28"));
    EXPECT_EQ(printer.line(300), "");
    printer.say("ok");
    EXPECT_EQ(printer.line(), framed(3, "G1 X10"));
    EXPECT_EQ(sender.getT(), "200.5");
    EXPECT_EQ(sender.getB(), "60.0");

    // a paused queue holds back ordinary lines, not urgent ones
    sender.pause_queue();
    sender.send("G1 X20");
    sender.send("M117 now", true);
    printer.say("ok");
    EXPECT_EQ(printer.line(), framed(4, "M117 now"));
    printer.say("echo:something to log");
    printer.say("ok");
    EXPECT_EQ(printer.line(300), "");
    EXPECT_EQ(sender.queue_size(), 1u);
    sender.resume_queue();
    EXPECT_EQ(printer.line(), framed(5, "G1 X20"));
    EXPECT_EQ(sender.purge_log(), std::vector<std::string>{"echo:something to log"});

    sender.disconnect();
    EXPECT_FALSE(sender.is_connected());
}
