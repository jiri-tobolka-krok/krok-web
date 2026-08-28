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

## ⚠️ Web je zatím schovaný před vyhledávači

Každá stránka má v hlavičce:

```html
<meta name="robots" content="noindex, nofollow">
```

Dokud tam ten tag je, Google ani Seznam web nezaindexují. **Před spuštěním ostré
verze ho musíš odstranit ze všech souborů naráz:**

```bash
perl -0pi -e 's|<!-- POZOR.*?-->\n<meta name="robots"[^>]*>\n||s' *.html tools/new-page.sh
```

`robots.txt` tu záměrně není — u GitHub Pages *project* stránek (`.github.io/krok-web/`)
ho roboti stejně nečtou, protože platí jen `robots.txt` z kořene domény. Jakmile web
poběží na vlastní doméně `skolakrok.cz`, dává smysl `robots.txt` doplnit.

## Co udělat před spuštěním ostré verze

Seznam věcí, které se záměrně odkládají na konec. Pořadí odpovídá tomu,
v jakém se to má dělat.

**1. Čisté URL bez `.html`**
GitHub Pages nemá Apache, takže mod_rewrite ani `.htaccess` nefungují.
Řeší se adresářovou strukturou: `zapis.html` → `zapis/index.html`, které
server servíruje na `/zapis`. Znamená to přepsat všechny vnitřní odkazy
a přepnout cesty k assetům na kořenové (`/assets/…`) — ty fungují z libovolné
hloubky, ale až ve chvíli, kdy web běží na vlastní doméně, ne na
`github.io/krok-web/`. Proto až po napojení domény.

**2. Rozhodnout osud starých wixových adres**
GitHub Pages neumí 301 přesměrování. Staré adresy (`/nas-tym`,
`/zapis-prestupy`, `/kontakty`) po přechodu ztratí svou pozici ve
vyhledávačích a nedá se to přesměrovat. Buď to přijmeme (homepage, která
drží většinu hodnoty, si adresu zachová), nebo nové stránky pojmenujeme
podle starých. **Rozhodnout dřív, než přibudou další stránky.**

**3. Odstranit `noindex`** ze všech souborů — viz sekce výše.

**4. Self-hostovat fonty** do `assets/fonts/` místo načítání z Google Fonts.

**5. Doplnit** `robots.txt`, `sitemap.xml`, kanonické odkazy, Open Graph
obrázky a strukturovaná data (schema.org `School`).

**6. Zapéct černobílý převod fotek** do souborů místo CSS filtru:
`sips --matchTo "/System/Library/ColorSync/Profiles/Generic Gray Gamma 2.2 Profile.icc"`

**7. Vyplnit všechny žluté placeholdery** — v kódu se hledají jako
`class="todo"`. Žádný nesmí zůstat.
