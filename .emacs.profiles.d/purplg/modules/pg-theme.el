;;; --- -*- lexical-binding: t; -*-

(defvar current-theme nil)

(defun set-theme (theme-name)
  (setq current-theme theme-name)
  (load-theme current-theme t))

(use-package doom-themes
  :straight t
  :init
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)
  (set-theme 'doom-molokai))
(provide 'pg-theme)
