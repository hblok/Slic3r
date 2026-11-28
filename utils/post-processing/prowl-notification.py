#!/usr/bin/env python3
"""Example post-processing script: a Prowl (https://www.prowlapp.com/) notification when
the G-code is done. Put your API key below.
"""
import os
import sys
import urllib.parse
import urllib.request

API_KEY = ""

data = urllib.parse.urlencode({
    "apikey": API_KEY, "application": "Slic3r", "event": "Slicing Done!",
    "description": "%s was successfully generated" % os.path.basename(sys.argv[1]),
}).encode()
try:
    urllib.request.urlopen("https://api.prowlapp.com/publicapi/add", data, timeout=30)
except OSError as error:
    # the G-code is fine: a failed notification must not fail the export
    print("Error sending Prowl notification: %s" % error, file=sys.stderr)
