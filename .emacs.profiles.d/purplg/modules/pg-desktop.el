;;; --- -*- lexical-binding: t; -*-

(use-package tramp
  :config
  (setq tramp-default-method "ssh"))

(require 'pg-hass)

(provide 'pg-desktop)
