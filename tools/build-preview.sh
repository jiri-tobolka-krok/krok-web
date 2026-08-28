#!/bin/bash
# Sestaví jednosouborovou verzi stránky pro náhled (artifact).
# Použití: tools/build-preview.sh index.html > dist/nahled.html
set -euo pipefail
cd "$(dirname "$0")/.."
src="${1:-index.html}"
awk -v css="assets/css/site.css" '
  /^<link rel="stylesheet" href="assets\/css\/site.css">$/ {
    print "<style>"; while ((getline line < css) > 0) print line; print "</style>"; next
  }
  /^<!DOCTYPE html>$|^<html lang="cs">$|^<head>$|^<\/head>$|^<body>$|^<\/body>$|^<\/html>$/ { next }
  /^<meta charset=|^<meta name="viewport"|^<meta name="description"/ { next }
  { print }
' "$src"
