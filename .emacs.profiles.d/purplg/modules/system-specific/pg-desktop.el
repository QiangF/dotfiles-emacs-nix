(require 'pg-straight)

(use-package tramp
  :straight t
  :config
  (setq tramp-default-method "ssh"))

(use-package request
  :straight t)
(use-package websocket
  :straight t)

(use-package hass
  :disabled
  :straight '(:local-repo "~/code/elisp/hass")
  :init
  (setq hass-host "homeassistant"
        hass-insecure t
        hass-apikey (auth-source-pass-get 'secret "home/hass/emacs-apikey")))

(provide 'pg-desktop)
