#include <gtest/gtest.h>

#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <unistd.h>

#include <string>
#include <thread>

#include "octoprint.hpp"

using namespace Slic3r::GUI;

namespace {

/// A print server that takes one request, keeps it and answers `status`.
struct Server {
    int listener {socket(AF_INET, SOCK_STREAM, 0)};
    int port {0};
    std::string request;
    std::thread thread;
    explicit Server(const std::string& status) {
        sockaddr_in address {};
        address.sin_family = AF_INET;
        address.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
        socklen_t length {sizeof(address)};
        bind(listener, reinterpret_cast<sockaddr*>(&address), length);
        listen(listener, 1);
        getsockname(listener, reinterpret_cast<sockaddr*>(&address), &length);
        port = ntohs(address.sin_port);
        thread = std::thread([this, status]() {
            const int client {accept(listener, nullptr, nullptr)};
            char buffer[4096];
            // the headers, then as much as Content-Length says
            for (ssize_t got; (got = read(client, buffer, sizeof(buffer))) > 0; ) {
                request.append(buffer, got);
                const size_t body {request.find("\r\n\r\n")};
                if (body == std::string::npos) continue;
                const size_t header {request.find("Content-Length: ")};
                const size_t expected {header == std::string::npos ? 0 : std::stoul(request.substr(header + 16))};
                if (request.size() - body - 4 >= expected) break;
            }
            const std::string answer {"HTTP/1.1 " + status + "\r\nContent-Length: 2\r\nConnection: close\r\n\r\nok"};
            if (write(client, answer.data(), answer.size()) < 0) request.clear();
            close(client);
        });
    }
    std::string host() const { return "127.0.0.1:" + std::to_string(port); }
    void done() { thread.join(); close(listener); }
};

} // namespace

TEST(OctoPrint, UploadsTheGcodeWithTheKey) {
    Server server("201 Created");
    const HttpAnswer answer {upload_octoprint(server.host(), "KEY123", "part.gcode", "G28\n", true)};
    server.done();
    EXPECT_TRUE(answer.ok()) << answer.status;
    EXPECT_EQ(server.request.find("POST /api/files/local"), 0u) << server.request;
    EXPECT_NE(server.request.find("KEY123"), std::string::npos);
    EXPECT_NE(server.request.find("filename=\"part.gcode\""), std::string::npos);
    EXPECT_NE(server.request.find("G28\n"), std::string::npos);
}

TEST(OctoPrint, SaysWhatWentWrong) {
    Server server("404 Not Found");
    const HttpAnswer answer {http_request(server.host(), "/nothing")};
    server.done();
    EXPECT_FALSE(answer.ok());
    EXPECT_EQ(answer.status_text(), "HTTP 404");
    EXPECT_EQ(http_request("", "/").status_text(), "no connection");
}
