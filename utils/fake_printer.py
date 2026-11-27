#!/usr/bin/env python3
"""A stand-in for a printer on a serial port, for the GUI tests: a pseudo terminal that
answers each line as Marlin does and logs what it receives.

Usage: fake_printer.py PORTFILE LOGFILE [DELAY]
PORTFILE gets the port's name; DELAY: seconds before each "ok".
"""
import os
import sys
import time
import tty

delay = float(sys.argv[3]) if len(sys.argv) > 3 else 0

master, slave = os.openpty()
tty.setraw(slave)
log = open(sys.argv[2], "ab", buffering=0)
with open(sys.argv[1], "w") as port:
    port.write(os.ttyname(slave) + "\n")

pending = b""
while True:
    pending += os.read(master, 4096)
    while b"\n" in pending:
        line, pending = pending.split(b"\n", 1)
        log.write(line + b"\n")
        time.sleep(delay)
        if b"M105" in line:
            os.write(master, b"ok T:201.3 /200.0 B:59.8 /60.0\n")
        else:
            os.write(master, b"ok\n")
