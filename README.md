# Web ZŠ Krok

Statický web Základní školy Krok (Hradec Králové), nasazovaný na GitHub Pages.

**Stav:** web běží na https://www.skolakrok.cz (spuštěno 27. 9. 2026).

## Jak je to postavené

Čisté HTML + jeden CSS soubor. **Žádný build, žádné npm, žádné závislosti.**
Push do `main` = web je za pár desítek sekund živý. Za tři roky to půjde
otevřít a upravit úplně stejně jako dnes.

```
index.html            homepage (jediná stránka v kořeni)
404.html              chybová stránka (GitHub Pages ji použije sám)
CNAME                 vlastní doména – vytvořil GitHub, neupravovat ručně
robots.txt            indexaci povolujeme celou, odkazuje na sitemapu
sitemap.xml           ruční seznam stránek; při přidání stránky doplnit řádek

o-skole/index.html    ┐
jak-ucime/index.html  │
den-ve-skole/…        │ podstránky – každá ve vlastní složce,
zapis/…               │ servírují se na adrese bez .html
skolne/…              │ (zapis/index.html → skolakrok.cz/zapis)
tym/…                 │
aktuality/…           │
kariera/…             │
kontakt/…             │
dokumenty/…           │
predskolacci/…        │
zasady-ochrany-udaju/ ┘
en/index.html         anglická jednostránka

nas-tym/, kontakty/, pedagog-1-stupen/ a dalších 22 složek
                      přesměrování ze starých wixových adres; každé nese
                      v komentáři, co to byla za stránku a proč vede tam,
                      kam vede. Obsahují jen meta refresh + canonical.

assets/css/site.css   veškeré styly webu
assets/fonts/         Inter, hostujeme si ho sami (viz komentář v site.css)
assets/img/           fotky
assets/logo/          podklady od designera
assets/dokumenty/     PDF ke stažení

tools/new-page.sh     vygeneruje novou podstránku ve vlastní složce
tools/nahled-server.py místní náhled: python3 tools/nahled-server.py
tools/build-preview.sh sestaví jednosouborový náhled

.nojekyll             vypíná Jekyll na GitHub Pages
```

## Odkazy jsou relativní, ne od kořene

Z podstránky se odkazuje `../tym/` a `../assets/…`, z homepage `tym/`.
Díky tomu web funguje na vlastní doméně i na `github.io/krok-web/` bez
jediné změny. **Nepoužívej cesty začínající `/`** – fungovaly by jen na
ostré doméně a náhled by se rozbil. Jediná výjimka jsou přesměrovací
stránky, ty míří na `/tym/` schválně: existují jen kvůli staré doméně.

## Pozor: hlavička a patička jsou v každém souboru zvlášť

To je daň za nulové závislosti. Když se mění navigace nebo patička, musí se to
projet přes všechny `*.html` najednou (`sed -i '' ...`), ne ručně po jednom.

## Co je zatím vymyšlené a čeká na potvrzení

- **Termín dne otevřených dveří** na homepage (8. 10. 2026) je smyšlený placeholder
- Citace rodiče a tři aktuality jsou placeholdery
- Značkové barvy v `:root` jsou odečtené z fotky loga — nahradit hodnotami z manuálu
- Logo je dočasně poskládané z fontu, ne skutečné SVG

## Fonty

Inter si hostujeme sami v `assets/fonts/`. Je to variabilní font, takže jeden
soubor na subset pokrývá všechny váhy. Jiné písmo web nepoužívá – tak ho dodal
grafik. Postup aktualizace je v komentáři nad `@font-face` v `site.css`.

## Co zbývá

**Obsah**
- Fotografie: Zuzana Polívková, Melissa Farka (i medailonky), Magda Fejglová,
  Daniela Kykalová. Do té doby mají monogram.
- Rozhodnout o vnitřním řádu družiny a školní jídelny ze starého webu.
- Citace rodiče a tři aktuality na homepage – připravené, ale schované
  v HTML komentáři. Zapnou se odebráním komentáře.
- Datum účinnosti v zásadách ochrany údajů.
- `jak-ucime`: věta o struktuře předmětů uvádí dvakrát rok 2027, zkontrolovat.
- Fotka vchodu do budovy na Kontaktu (vedle prohlídky ze Street View).

**Technika**
- Kanonické odkazy a Open Graph obrázky pro sdílení na sítích.
- Strukturovaná data schema.org `School` – adresa, telefon, otevírací doba.
- Doménu přidat do Google Search Console a nahrát sitemapu.
- Zápis: tlačítko rezervace je připravené, ale skryté. 30. 11. 2026 v 10:00
  stačí doplnit adresu do odkazu a odebrat třídu `zavreno`.
- Nechat zásady ochrany údajů projít někým znalým.
- Doména vyprší **13. 11. 2026**, registrátor Active24.

## Staré stránky, které zanikají

Z původního webu se nepřenášejí: *Inspirují nás*, *Výchovný poradce*,
*Skautská klubovna K. Šimka* a *Rezervační systém*. Všechny mají
přesměrování na nejbližší smysluplnou stránku.
