#!/usr/bin/env python3
"""Statický server pro místní náhled webu.

Servíruje složku, ve které leží tenhle soubor o úroveň výš – tedy kořen webu –
a chová se jako GitHub Pages: /zapis přesměruje na /zapis/ a tam podá index.html.
Slouží jen k ověření, že vnitřní odkazy a cesty k assetům sedí.
"""
import http.server, functools, os, sys

KOREN = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 4173

Handler = functools.partial(http.server.SimpleHTTPRequestHandler, directory=KOREN)
http.server.HTTPServer.allow_reuse_address = True
print(f"náhled běží na http://localhost:{PORT} (kořen {KOREN})", flush=True)
http.server.HTTPServer(("127.0.0.1", PORT), Handler).serve_forever()
