---
layout: post
author: sirion
published: true
cover_image: https://images.unsplash.com/photo-1512418490979-92798cec1380?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=395&q=80
title: Rails, Webpacker & React
tags: rails webpacker react
---

Per poter creare un'applicazione React è necessario includere
all'interno del progetto la libreria `Webpacker`. L'obiettivo di
Webpacker è quello di semplificare l'utilizzo del pre-processore
JavaScript e del bundler webpack all'interno di Rails. E' possible
utilizzarlo in concomitanza con l'asset pipeline di Rails.

### Installazione[^1] e configurazione[^2] di Webpack

Per includere la libreria nel `Gemfile` è sufficiente eseguire il
comando `bundle add webpacker`. Successivamente possiamo installare
webpacker con

```bash
bundle exec rails webpacker:install

    create config/webpacker.yml
Copying webpack core config
    create config/webpack
    create config/webpack/development.js
    create config/webpack/environment.js
    create config/webpack/production.js
    create config/webpack/test.js
Creating JavaScript app source directory
    create app/javascript
    create app/javascript/packs/application.js
Copying binstubs
    exist  bin
    create bin/webpack
    create bin/webpack-dev-server
```

Al termine dell'operazione, avremo:

* un file di configurazione `webpacker.yml`;
* le configurazioni dei vari ambienti di sviluppo (development, production e test);
* creazione di una directory `app/javascript/packs` con all'interno il file `application.js`;
* alcuni eseguibili all'interno di `bin`.

### In azione

Per prima cosa dobbiamo creare un nuovo controller con un'azione, ad
esempio, `pages#home` con il comando:

```bash
$ rails generate controller pages home
```

Successivamente configuriamo il router di Rails impostanto __url di default__:

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

Questo comando include il file pre-buildato `application-{hash}.js`
all'interno della nostro layout. Per poter buildare i vari file
JavaScript presenti all'interno della cartella `app/javascript/packs`
è necessario eseguire il comando `bin/webpack-dev-server`.

Lanciando il comando `bin/webpack-dev-server` e
`bundle exec rails server`, se la configurazione è andata a buon fine,
dovremmo vedere nella console del browser il messaggio "Hello World
from Webpacker".


![Check](/assets/images/reails-e-webpacker-1.png){:.has-image-centered}

### Configurazione di React

Per poter utilizzare installare e configurare React è sufficiente
lanciare:

```bash
$ bundle exec rails webpacker:install:react

Copying babel.config.js to app root directory
    force  babel.config.js
Copying react example entry file to app/javascript/packs
    create  app/javascript/packs/hello_react.jsx
Updating webpack paths to include .jsx file extension
    insert  config/webpacker.yml
Installing all react dependencies
    run yarn add \
        react react-dom \
        @babel/preset-react \
        prop-types \
        babel-plugin-transform-react-remove-prop-types from "."
```

Dopo l'installazione verrà creato un file di default `hello_react.jsx`
nella cartella `app/javascript/packs/`.

```jsx
import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const Hello = props => (
  <div>Hello {props.name}!</div>
)

Hello.defaultProps = {
  name: 'David'
}

Hello.propTypes = {
  name: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Hello name="React" />,
    document.body.appendChild(document.createElement('div')),
  )
})
```

Ed all'interno della vista `home` aggiungiamo il nuovo "pack":

```ruby
# app/views/pages/home.html.erb

...
<%= javascript_pack_tag 'hello_react' %>
...
```

![Check](/assets/images/reails-e-webpacker-2.png){:.has-image-centered}


### Compilazione degli asset di webpack

E' possibile fornire gli asset generati da webpack in due modalità:

* __Statico__: utilizziamo il comando `bundle exec rails assets:precompile`.
  In questo modo la build sarà fornita nella directory `public/packs/js`.

* __Dinamico__: utilizzando l'eseguibile: `bin/webpack-dev-server`. In
  questa modalità sarà eseguito un server (raggiungibile all'indirizzo
  http://localhost:3035/) che fornirà i file senza salvarli su disco.
  In questa modalità è possibile usufruire dell'hot reload.

Se non fosse disponibile né il server né la cartella `public/packs`
verranno in ogni caso compilati gli asset.

```bash
Processing by PagesController#home as HTML
  Rendering pages/home.html.erb within layouts/application
  Rendered pages/home.html.erb within layouts/application (0.5ms)
[Webpacker] Compiling…
[Webpacker] Compiled all packs in /home/sirion1987/Work/Off/prova1/public/packs
```


# Note

[^1]: [Install Webpacker](https://github.com/rails/webpacker#installation).
[^2]: [Config Webpacker](https://github.com/rails/webpacker#webpack-configuration)
