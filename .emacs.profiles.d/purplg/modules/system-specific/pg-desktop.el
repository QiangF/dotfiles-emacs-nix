;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)

(use-package tramp
  :straight t
  :config
  (setq tramp-default-method "ssh"))

(require 'pg-hass)

(provide 'pg-desktop)
