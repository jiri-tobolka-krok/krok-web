#!/bin/bash
# Vygeneruje novou podstránku se sdílenou hlavičkou a patičkou.
# Použití:  tools/new-page.sh <soubor.html> "<title>" "<eyebrow>" "<h1>"
set -euo pipefail
cd "$(dirname "$0")/.."
file="$1"; title="$2"; eyebrow="$3"; h1="$4"

{
cat <<HEAD
<!DOCTYPE html>
<html lang="cs">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- POZOR: před spuštěním ostrého webu SMAZAT — blokuje indexaci ve vyhledávačích -->
<meta name="robots" content="noindex, nofollow">
<title>${title}</title>
<link rel="icon" href="assets/logo/favicon.png" type="image/png">
<link rel="apple-touch-icon" href="assets/logo/apple-touch-icon.png">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Poppins:wght@800&display=swap">
<link rel="stylesheet" href="assets/css/site.css">
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
      <p class="lead">Obsah téhle stránky připravujeme. Struktura webu už stojí, texty a fotky doplníme.</p>
    </div>
  </section>
</main>

MAIN
cat tools/_footer.part
cat <<FOOT

</body>
</html>
FOOT
} > "$file"
echo "vytvořeno: $file"
