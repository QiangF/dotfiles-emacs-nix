;;; --- -*- lexical-binding: t; -*-
(require 'pg-aliases)
(require 'pg-font)

(set-font-face "JetBrainsMono-10")

(require 'pg-tramp)

(when (network-lookup-address-info "homeassistant.lan")
  (require 'pg-hass))

(when (daemonp)
  (pg/try-load-file (file-name-concat "system-specific/" "daemon.el")))

(provide 'pg-desktop)
