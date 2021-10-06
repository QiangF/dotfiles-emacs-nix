;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)

(setq font-face "Fira Code Retina-12")

(display-battery-mode 1)

(use-package hass
  :straight t
  :init
  (setq hass-url "http://homeassistant:8123"
        hass-apikey (auth-source-pass-get 'secret "home/hass/emacs-apikey"))
  (hass-setup))

(provide 'pg-framework)
