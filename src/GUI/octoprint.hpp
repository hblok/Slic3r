#ifndef OCTOPRINT_HPP
#define OCTOPRINT_HPP

#include <string>

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif

namespace Slic3r { namespace GUI {

/// The answer of a print server: the HTTP status (0: no connection) and the body.
struct HttpAnswer {
    int status;
    std::string body;
    bool ok() const { return status >= 200 && status < 300; }
    /// "404" or "no connection", for a message
    wxString status_text() const;
};

/// A request to a print server (OctoPrint, Duet) over plain HTTP, as the Perl GUI's.
/// `host`: "name" or "name:port". With a `body` it is a POST of that content type.
HttpAnswer http_request(const std::string& host, const std::string& path, const std::string& api_key = "",
    const std::string& body = "", const std::string& content_type = "", int timeout = 10);

}} // namespace Slic3r::GUI
#endif
