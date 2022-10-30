;;; --- -*- lexical-binding: t; -*-
(require 'pg-font)

(set-font-face "JetBrainsMono-10")

(require 'pg-tramp)

(when (network-lookup-address-info "homeassistant.lan")
  (require 'pg-hass))

(provide 'pg-desktop)
