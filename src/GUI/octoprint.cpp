#include "octoprint.hpp"

#include <memory>

#include <wx/mstream.h>
#include <wx/protocol/http.h>
#include <wx/socket.h>

namespace Slic3r { namespace GUI {

wxString HttpAnswer::status_text() const {
    return this->status == 0 ? wxString(_("no connection")) : wxString::Format("HTTP %d", this->status);
}

HttpAnswer http_request(const std::string& host, const std::string& path, const std::string& api_key,
        const std::string& body, const std::string& content_type, int timeout) {
    HttpAnswer answer {0, ""};
    wxString name {wxString::FromUTF8(host.c_str())};
    long port {80};
    if (name.StartsWith("http://")) name = name.Mid(7);
    while (name.EndsWith("/")) name.RemoveLast();
    if (name.AfterLast(':') != name && name.AfterLast(':').ToLong(&port)) name = name.BeforeLast(':');
    else port = 80;
    if (name.IsEmpty()) return answer;

    wxBusyCursor busy;
    wxHTTP http;
    http.SetFlags(wxSOCKET_BLOCK);  // no events handled meanwhile: nothing changes under us
    http.SetTimeout(timeout);
    if (!api_key.empty()) http.SetHeader("X-Api-Key", wxString::FromUTF8(api_key.c_str()));
    if (!body.empty()) {
        wxMemoryBuffer data;
        data.AppendData(body.data(), body.size());
        http.SetPostBuffer(wxString::FromUTF8(content_type.c_str()), data);
    }
    wxIPV4address address;
    if (!address.Hostname(name)) return answer;
    address.Service(static_cast<unsigned short>(port));
    if (!http.Connect(address, true)) return answer;
    std::unique_ptr<wxInputStream> in {http.GetInputStream(wxString::FromUTF8(path.c_str()))};
    answer.status = http.GetResponse();
    if (in != nullptr) {
        char buffer[4096];
        while (in->CanRead()) {
            in->Read(buffer, sizeof buffer);
            if (in->LastRead() == 0) break;
            answer.body.append(buffer, in->LastRead());
        }
    }
    return answer;
}

}} // namespace Slic3r::GUI
