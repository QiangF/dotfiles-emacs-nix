;;; --- -*- lexical-binding: t; -*-

(set-font-face "Fira Code Retina-10")

(use-package tramp
  :config
  (setq tramp-default-method "ssh"))

(require 'pg-hass)

(provide 'pg-desktop)
