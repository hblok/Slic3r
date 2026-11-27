#include "octoprint.hpp"

#include <memory>

#include <wx/mstream.h>
#include <wx/protocol/http.h>
#include <wx/socket.h>
#include <wx/datetime.h>
#include <wx/statbox.h>

#include <cctype>

#include "Settings.hpp"

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

HttpAnswer upload_octoprint(const std::string& host, const std::string& api_key, const std::string& name,
        const std::string& gcode, bool print) {
    // a boundary the file can't contain by accident
    const std::string boundary {"----Slic3rUpload7MA4YWxkTrZu0gW"};
    std::string safe {name};
    for (auto& c : safe)
        if (c == '"' || c == '\r' || c == '\n') c = '_';
    std::string body {"--" + boundary + "\r\nContent-Disposition: form-data; name=\"file\"; filename=\"" + safe
        + "\"\r\nContent-Type: application/octet-stream\r\n\r\n" + gcode
        + "\r\n--" + boundary + "\r\nContent-Disposition: form-data; name=\"print\"\r\n\r\n" + (print ? "1" : "0")
        + "\r\n--" + boundary + "--\r\n"};
    return http_request(host, "/api/files/local", api_key, body, "multipart/form-data; boundary=" + boundary, 180);
}

static std::string url_encoded(const std::string& text) {
    std::string out;
    for (const unsigned char c : text) {
        if (isalnum(c) || c == '-' || c == '_' || c == '.') out += c;
        else out += wxString::Format("%%%02X", c).ToStdString();
    }
    return out;
}

HttpAnswer upload_duet(const std::string& host, const std::string& name, const std::string& gcode, bool print) {
    const wxString time {wxDateTime::Now().Format("%Y-%m-%dT%H:%M:%S")};
    HttpAnswer answer {http_request(host, "/rr_upload?name=0:/gcodes/" + url_encoded(name) + "&time=" + time.ToStdString(),
        "", gcode, "application/octet-stream", 180)};
    if (answer.ok() && print) answer = http_request(host, "/rr_gcode?gcode=M32%20" + url_encoded(name));
    return answer;
}

bool ask_upload_options(wxWindow* parent, Settings& settings, wxString& name) {
    wxDialog dialog(parent, wxID_ANY, _("Send to Server"));
    auto* box {new wxStaticBoxSizer(wxVERTICAL, &dialog, _("Send to Server"))};
    auto* grid {new wxFlexGridSizer(2, 6, 10)};
    wxWindow* inside {box->GetStaticBox()};
    auto* file {new wxTextCtrl(inside, wxID_ANY, name, wxDefaultPosition, wxSize(300, -1))};
    auto* overwrite {new wxCheckBox(inside, wxID_ANY, "")};
    overwrite->SetValue(settings.octoprint_overwrite);
    overwrite->SetToolTip(_("If selected, any existing file with the same name will be overwritten without confirmation."));
    auto* start {new wxCheckBox(inside, wxID_ANY, "")};
    start->SetValue(settings.octoprint_start);
    start->SetToolTip(_("If selected, print will start after the upload."));
    const std::pair<wxString, wxWindow*> rows[] {
        {_("File name"), file}, {_("Overwrite existing file"), overwrite}, {_("Start print"), start}};
    for (const auto& row : rows) {
        grid->Add(new wxStaticText(inside, wxID_ANY, row.first + ":"), 0, wxALIGN_CENTER_VERTICAL);
        grid->Add(row.second);
    }
    box->Add(grid, 0, wxALL, 5);
    auto* sizer {new wxBoxSizer(wxVERTICAL)};
    sizer->Add(box, 0, wxEXPAND | wxALL, 10);
    sizer->Add(dialog.CreateButtonSizer(wxOK | wxCANCEL), 0, wxALIGN_RIGHT | wxALL, 10);
    dialog.SetSizerAndFit(sizer);
    if (dialog.ShowModal() != wxID_OK) return false;
    name = file->GetValue();
    settings.octoprint_overwrite = overwrite->GetValue();
    settings.octoprint_start = start->GetValue();
    settings.save_settings();
    return true;
}

}} // namespace Slic3r::GUI
