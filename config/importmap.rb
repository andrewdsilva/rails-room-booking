# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@popperjs/core', to: 'https://ga.jspm.io/npm:@popperjs/core@2.11.7/lib/index.js'
pin 'bootstrap', to: 'https://ga.jspm.io/npm:bootstrap@5.2.3/dist/js/bootstrap.esm.js'

pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin "@rails/activestorage", to: "activestorage.esm.js"

pin 'dropzone', to: 'https://ga.jspm.io/npm:dropzone@6.0.0-beta.2/dist/dropzone.mjs'
pin 'just-extend', to: 'https://ga.jspm.io/npm:just-extend@5.1.1/index.esm.js' # required by dropzone

pin 'dayjs', to: 'https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.11.8/dayjs.min.js'

pin 'easepick-datetime', to: 'https://cdn.jsdelivr.net/npm/@easepick/datetime@1.2.1/dist/index.umd.min.js'
pin 'easepick-core', to: 'https://cdn.jsdelivr.net/npm/@easepick/core@1.2.1/dist/index.umd.min.js'
pin 'easepick-base-plugin', to: 'https://cdn.jsdelivr.net/npm/@easepick/base-plugin@1.2.1/dist/index.umd.min.js'
pin 'easepick-range-plugin', to: 'https://cdn.jsdelivr.net/npm/@easepick/range-plugin@1.2.1/dist/index.umd.min.js'
pin 'easepick-lock-plugin', to: 'https://cdn.jsdelivr.net/npm/@easepick/lock-plugin@1.2.1/dist/index.umd.min.js'

pin_all_from 'app/javascript/controllers', under: 'controllers'
