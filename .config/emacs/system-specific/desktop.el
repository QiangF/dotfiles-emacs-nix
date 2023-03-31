;;; --- -*- lexical-binding: t; -*-
(require 'pg-font)

(set-font-face "JetBrainsMono-10")

(require 'pg-tramp)

(when (network-lookup-address-info "homeassistant.lan")
  (require 'pg-hass))

(when (daemonp)
  (pg/load-file "daemon.el"
                (expand-file-name "system-specific/" pg/config-dir)))

(provide 'pg-desktop)
