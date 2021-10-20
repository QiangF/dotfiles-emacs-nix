;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)

(use-package tramp
  :straight t
  :config
  (setq tramp-default-method "ssh"))

;; Dev
(use-package hass
  :straight '(:local-repo "~/code/elisp/hass")
  :init (use-package request :straight t)
        (use-package websocket :straight t)
        (setq hass-host "homeassistant")
        (setq hass-insecure t)
        (setq hass-apikey (auth-source-pass-get 'secret "home/hass/emacs-apikey"))
        (hass-setup))

;; Prod
(use-package hass
  :disabled
  :straight t
  :init (setq hass-url "http://homeassistant:8123")
        (setq hass-apikey (auth-source-pass-get 'secret "home/hass/emacs-apikey"))
        (hass-setup))

(provide 'pg-desktop)
