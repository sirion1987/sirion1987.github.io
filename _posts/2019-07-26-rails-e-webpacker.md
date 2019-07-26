---
layout: post
author: sirion
published: true
cover_image: https://images.unsplash.com/photo-1512418490979-92798cec1380?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=395&q=80
title: Rails & Webpacker & React
tags: rails webpacker react
---

Per poter creare un'applicazione React è necessario includere all'interno del progetto la libreria
`Webpacker`. L'obiettivo di Webpacker è quello di semplificare l'utilizzo del pre-processore JavaScript e del bundler webpack all'interno di Rails. E' possible utilizzarlo in concomitanza con l'asset pipeline di Rails.

### Installazione[^1] e configurazione[^2] di Webpack

Per includere la libreria nel `Gemfile` è sufficiente eseguire il comando `bundle add webpacker`.
Successivamente possiamo installare webpacker con `bundle exec rails webpacker:install`. Verrà configurato:

* un file di configurazione `webpacker.yml`;
* le configurazioni dei vari ambienti di sviluppo (development, production e test);
* creazione di una directory `app/javascript/packs` con all'interno il file `application.js`;
* alcuni eseguibili all'interno di `bin`.

### In azione

Per prima cosa dobbiamo creare un nuovo controller con un'azione, ad esempio, `pages#home` con
il comando `rails generate controller pages home`. Successivamente configuriamo il router di Rails impostanto url di default:

```ruby
#config/routes

...
root to:"pages#home"
...
```

Modifichiamo l'application layout:

```ruby
# app/views/layouts/application.html.erb

...
<%= javascript_pack_tag ’application’ %>
...
```

Questo comando include il file pre-buildato `application-{hash}.js` all'interno della nostro layout.
Per poter buildare i vari file JavaScript presenti all'interno della cartella `app/javascript/packs` è necessario eseguire il comando `bin/webpack-dev-server`.

Lanciando il comando `bin/webpack-dev-server` e `bundle exec rails server`, se la configurazione è andata a buon fine, dovremmo vedere nella console del browser il messaggio "Hello World from Webpacker".


![](./img/1.png)

# Note

[^1]: [Install Webpacker](https://github.com/rails/webpacker#installation).
[^2]: [Config Webpacker](https://github.com/rails/webpacker#webpack-configuration)
