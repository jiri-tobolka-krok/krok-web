# Web ZŠ Krok

Statický web Základní školy Krok (Hradec Králové), nasazovaný na GitHub Pages.

**Stav:** první skica homepage. Podstránky jsou zatím prázdné kostry.

## Jak je to postavené

Čisté HTML + jeden CSS soubor. **Žádný build, žádné npm, žádné závislosti.**
Push do `main` = web je za pár desítek sekund živý. Za tři roky to půjde
otevřít a upravit úplně stejně jako dnes.

```
index.html            homepage
o-skole.html          ┐
jak-ucime.html        │
den-ve-skole.html     │
zapis.html            │ podstránky podle mapy webu
skolne.html           │
tym.html              │
aktuality.html        │
kariera.html          │
kontakt.html          │
dokumenty.html        ┘
404.html              chybová stránka (GitHub Pages ji použije sám)

assets/css/site.css   veškeré styly webu
assets/img/           fotky
assets/logo/          podklady od designera (zatím prázdné — viz README uvnitř)

tools/new-page.sh     vygeneruje novou podstránku se sdílenou hlavičkou a patičkou
tools/build-preview.sh sestaví jednosouborový náhled

.nojekyll             vypíná Jekyll na GitHub Pages (servíruje soubory tak, jak jsou)
```

## Pozor: hlavička a patička jsou v každém souboru zvlášť

To je daň za nulové závislosti. Když se mění navigace nebo patička, musí se to
projet přes všechny `*.html` najednou (`sed -i '' ...`), ne ručně po jednom.

## Co je zatím vymyšlené a čeká na potvrzení

- **Termín dne otevřených dveří** na homepage (8. 10. 2026) je smyšlený placeholder
- Citace rodiče a tři aktuality jsou placeholdery
- Značkové barvy v `:root` jsou odečtené z fotky loga — nahradit hodnotami z manuálu
- Logo je dočasně poskládané z fontu, ne skutečné SVG

## Fonty

Zatím se načítají z Google Fonts. **Před spuštěním self-hostovat** do `assets/fonts/` —
načítání z Google Fonts posílá IP návštěvníků do USA a je to u českých školních webů
zbytečné GDPR riziko.
