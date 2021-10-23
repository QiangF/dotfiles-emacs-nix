;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)

(setq font-face "FiraCode Nerd Font Mono-12")

(display-battery-mode 1)

(require 'pg-hass)

(use-package nix-mode
  :straight t)

(provide 'pg-framework)
