;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)

(setq font-face "FiraCode Nerd Font Mono")

(display-battery-mode 1)

(use-package hass
  :straight t
  :init
  (setq hass-url "http://homeassistant:8123")
  (setq hass-apikey (auth-source-pass-get 'secret "home/hass/emacs-apikey"))
  (hass-setup))

(provide 'pg-framework)
