# Logo

`krok-logo.png` — 560 × 141 px, barevná varianta pro hlavičku.
Bílé pozadí, ne průhledné.

`krok-logo-inverzni.png` — 560 × 140 px, bílá kresba na černém pozadí,
pro patičku a jiné tmavé podklady. Černé pozadí se v CSS sráží pomocí
`mix-blend-mode: screen`, takže obdélník kolem loga není vidět —
funguje to na jakémkoli tmavém podkladu bez nutnosti průhledného PNG.

## Až přijde finální verze od grafika

Ideálně **SVG**. Postup:

1. Uložit jako `krok-logo.svg`
2. V `assets/css/site.css` nic neměnit — výšku loga drží `.logo-img`,
   ne rozměry souboru
3. Ve všech `*.html` a v `tools/_header.part` / `tools/_footer.part`
   přepsat cestu a rozměry:

```bash
sed -i '' 's|krok-logo.png" width="560" height="141"|krok-logo.svg"|g' *.html tools/_*.part
```

## Ikony

`favicon.png` — 512 × 512, vyříznuté modré **K** z loga
`apple-touch-icon.png` — 180 × 180, totéž pro přidání na plochu telefonu
`znacka-k-modre.png` — 302 × 302, samotné K pro sociální sítě
`znacka-k-purpurove.png` — 284 × 284, purpurová varianta téhož

Modré K je zvolené proto, že modrá je dominantní barvou webu.
Záměna za purpurové je kopie souboru:

```bash
sips -Z 512 assets/logo/znacka-k-purpurove.png --out assets/logo/favicon.png
sips -Z 180 assets/logo/znacka-k-purpurove.png --out assets/logo/apple-touch-icon.png
```

Obě značky mají **bílé pozadí**. Pro avatar na sítích to většinou stačí,
protože sítě podkládají profilovky bílou. Až přijde SVG, hodila by se
i varianta s barevným pozadím a bílým K — ta je na malých kruhových
avatarech výraznější.

## Na co si dát pozor

Současný soubor má **bílé pozadí**, ne průhledné. V patičce proto sedí
na bílé podložce (`.footer .logo-img`). Jakmile bude logo průhledné
a bude existovat i inverzní varianta pro tmavý podklad, podložka
v patičce může zmizet.

Hodilo by se ještě:

- `krok-logo-inverzni.svg` — pro tmavé podklady
- `krok-znacka.svg` — samotná značka bez textu, pro favicon a sociální sítě
- `manual.pdf` — grafický manuál s přesnými barvami a ochrannou zónou
