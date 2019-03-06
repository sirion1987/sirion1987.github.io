---
layout: post
author: sirion
published: true
cover_image: https://images.unsplash.com/photo-1520813461521-08fbb9dbd04f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=395&q=80
preview: Una breve raccolta di risorse online per creare un template in Jekyll
title: Jekyll, GitHub page e altri animali fantastici
tags: jekyll github-page
---

Durante la costruzione di questo blog ho trovato alcune risorse utili
che mi hanno permesso di risolvere alcuni problemi. Questo sito è
ospitato su [GitHub Pages](https://pages.github.com/) e dunque è soggetto
ad alcune limitazioni, come ad esempio l'uso di alcuni plugin.

## Dipendenze per Pages GitHub

Prima di inserire un plugin all'interno del file `_conf` assicuratevi
che quest'ultimo sia supportato da Pages GitHub. In questo
[link](https://pages.github.com/versions/) troverai la lista completa.


## Le pagine GitHub e i plugin di Jekyll

Cosa fare quando abbiamo bisogno di plugin che non sono supportati da Pages
GitHub? Ad esempio, durante la costruzione di questo blog mi sono imbattuto
con `jekyll-tagging`, utile per poter etichettare gli articoli.

Come si può saltare questo ostacolo? L'idea principale è questa: quando
si effettua una build si genera un sito html pronto all'uso sotto la
cartella `_site`. Dunque è sufficiente inizializzare il branch master
su quest'ultima e creare un un branch per la cartella principale. In
questo modo sul branch master sarà presente sempre la build e sul
branch il codice sorgente.

Per ulteriori dettagli vi rimando a questo [link](https://www.drewsilcock.co.uk/custom-jekyll-plugins)
che spiega in ogni dettaglio la procudura descritta in precedenza.

## Plugin Jekyll

 * Tagging
   * [https://github.com/pattex/jekyll-tagging](https://github.com/pattex/jekyll-tagging)

## Forzare l'esecuzione di una build

```
$ curl \
   -u <user>:<development_access_token> \
   -X POST https://api.github.com/repos/<github_user>/<pages>.github.io/pages/builds \
   -H "Accept: application/vnd.github.mister-fantastic-preview+json"
```

## Kramdown

 * [Riferimenti](https://kramdown.gettalong.org/quickref.html)
 * [Come evidenziare la sintassi con Rouge](https://bnhr.xyz/2017/03/25/add-syntax-highlighting-to-your-jekyll-site-with-rouge.html)

## LaTeX

Volete inserire formule matematiche o altri oggetti meravigliosi?

  * [https://docs.mathjax.org/en/latest/start.html](https://docs.mathjax.org/en/latest/start.html)
