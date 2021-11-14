;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)
(require 'pg-font)

(set-font-face "FiraCode Nerd Font Mono-12")

(display-battery-mode 1)

(require 'pg-hass)

(use-package nix-mode
  :straight t)

(provide 'pg-framework)
