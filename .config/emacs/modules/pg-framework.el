;;; --- -*- lexical-binding: t; -*-
(require 'pg-font)

(set-font-face "JetBrainsMono Nerd Font-16")

(display-battery-mode 1)

(when (network-lookup-address-info "homeassistant.lan")
  (require 'pg-hass))

(provide 'pg-framework)
