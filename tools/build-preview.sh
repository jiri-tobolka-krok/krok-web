#!/bin/bash
# Sestaví jednosouborovou verzi stránky pro náhled (artifact).
# Vloží dovnitř CSS i obrázky, aby soubor fungoval samostatně.
# Použití: tools/build-preview.sh index.html > dist/nahled.html
set -euo pipefail
cd "$(dirname "$0")/.."
python3 - "${1:-index.html}" <<'PY'
import sys, re, base64, os
src = open(sys.argv[1], encoding='utf-8').read()

# CSS dovnitř
css = open('assets/css/site.css', encoding='utf-8').read()
src = src.replace('<link rel="stylesheet" href="assets/css/site.css">',
                  '<style>\n' + css + '\n</style>')

# obrázky jako data URI
typy = {'.png': 'image/png', '.jpg': 'image/jpeg', '.jpeg': 'image/jpeg',
        '.svg': 'image/svg+xml', '.webp': 'image/webp'}
def vloz(m):
    cesta = m.group(1)
    if not os.path.exists(cesta):
        return m.group(0)
    typ = typy.get(os.path.splitext(cesta)[1].lower())
    if not typ:
        return m.group(0)
    data = base64.b64encode(open(cesta, 'rb').read()).decode()
    return f'src="data:{typ};base64,{data}"'
src = re.sub(r'src="(assets/[^"]+)"', vloz, src)

# obal dokumentu pryč — artifact si ho doplní sám
for t in ['<!DOCTYPE html>\n', '<html lang="cs">\n', '<head>\n', '</head>\n',
          '<body>\n', '</body>\n', '</html>\n']:
    src = src.replace(t, '', 1)
src = re.sub(r'<meta charset=[^>]*>\n|<meta name="viewport"[^>]*>\n|<meta name="description"[^>]*>\n',
             '', src, count=3)
sys.stdout.write(src)
PY
