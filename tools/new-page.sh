#!/bin/bash
# Vygeneruje novou podstránku se sdílenou hlavičkou a patičkou.
#
# Použití:  tools/new-page.sh <slug> "<title>" "<eyebrow>" "<h1>"
# Příklad:  tools/new-page.sh jidelnicek "Jídelníček | ZŠ Krok Hradec Králové" "Provoz" "Co se vaří"
#
# Vznikne <slug>/index.html, které se servíruje na adrese /<slug>.
# Nezapomeň stránku přidat do sitemap.xml a odkázat na ni z navigace –
# navigace je v každém souboru zvlášť, takže projet všechny naráz skriptem.
set -euo pipefail
cd "$(dirname "$0")/.."
slug="$1"; title="$2"; eyebrow="$3"; h1="$4"

if [ -e "$slug" ]; then echo "chyba: $slug už existuje" >&2; exit 1; fi
mkdir -p "$slug"

{
cat <<HEAD
<!DOCTYPE html>
<html lang="cs">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${title}</title>
<meta name="description" content="DOPLNIT popis pro vyhledávače, 120–155 znaků.">
<link rel="icon" href="../assets/logo/favicon.svg" type="image/svg+xml">
<link rel="icon" href="../assets/logo/favicon.png" type="image/png">
<link rel="apple-touch-icon" href="../assets/logo/apple-touch-icon.png">
<link rel="stylesheet" href="../assets/css/site.css">
</head>
<body>

HEAD
cat tools/_header.part
cat <<MAIN

<main>
  <section class="section">
    <div class="wrap">
      <div class="section-head">
        <p class="eyebrow">${eyebrow}</p>
        <h1>${h1}</h1>
      </div>
      <p class="lead">Obsah téhle stránky připravujeme.</p>
    </div>
  </section>
</main>

MAIN
cat tools/_footer.part
cat <<FOOT

</body>
</html>
FOOT
} > "$slug/index.html"

echo "hotovo: $slug/index.html  →  /$slug"
echo "zbývá: doplnit meta description, přidat do sitemap.xml a do navigace"
