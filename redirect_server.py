#!/usr/bin/env python3

import sys
from http.server import HTTPServer, BaseHTTPRequestHandler

if len(sys.argv)-1 != 2:
    print("Usage: {} <port_number> <url>".format(sys.argv[0]))
    sys.exit()

class Redirect(BaseHTTPRequestHandler):
    req_count = 0
    def do_GET(self):
        if Redirect.req_count is not None and Redirect.req_count == 0:
            Redirect.req_count += 1
            self.send_response(204)
            self.end_headers()
            return
        self.send_response(302)
        self.send_header('Location', sys.argv[2])
        self.end_headers()

HTTPServer(("", int(sys.argv[1])), Redirect).serve_forever()
