# server.py
import http.server
import socketserver
import os
import sys

PORT = 8080
if len(sys.argv) < 2:
    print("Usage: python3 server.py <site>")
    exit(1)

site = sys.argv[1]
site_path = os.path.join("sites", site)

if not os.path.isdir(site_path):
    print(f"Site '{site}' not found.")
    exit(1)

os.chdir(site_path)
Handler = http.server.SimpleHTTPRequestHandler
httpd = socketserver.TCPServer(("", PORT), Handler)
print(f"🚀 Serving '{site}' at http://127.0.0.1:{PORT}")
httpd.serve_forever()
