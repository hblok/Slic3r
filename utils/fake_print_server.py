#!/usr/bin/env python3
"""A stand-in for an OctoPrint server in the GUI tests: logs each request to a file.

Usage: fake_print_server.py PORT LOGFILE
"""
import http.server
import sys

log = open(sys.argv[2], "ab", buffering=0)


class Handler(http.server.BaseHTTPRequestHandler):
    def answer(self, code, body):
        self.send_response(code)
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        log.write(f"GET {self.path} key={self.headers.get('X-Api-Key')}\n".encode())
        self.answer(200, b'{"files": [{"name": "other.gcode"}]}')

    def do_POST(self):
        data = self.rfile.read(int(self.headers["Content-Length"]))
        log.write(f"POST {self.path} key={self.headers.get('X-Api-Key')}\n".encode())
        log.write(data + b"\n")
        self.answer(201, b"{}")


http.server.HTTPServer(("127.0.0.1", int(sys.argv[1])), Handler).serve_forever()
