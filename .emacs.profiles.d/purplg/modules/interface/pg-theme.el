;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)

(defvar current-theme nil)

(defun set-theme (theme-name)
  (setq current-theme theme-name)
  (load-theme current-theme t))

;; Default theme
(set-theme 'wombat)

(use-package doom-themes
  :straight t
  :config
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)

  (set-theme 'doom-dracula))

(provide 'pg-theme)
