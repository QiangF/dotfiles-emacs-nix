;;; --- -*- lexical-binding: t; -*-

(use-package modus-themes
  :bind ("<f5>" . modus-themes-toggle)
  :config
  (advice-add 'modus-themes-toggle
              :after
              (lambda (&rest _) (setq current-theme (modus-themes--current-theme)))))

(use-package org-modern
  :straight t
  :after modus-themes
  :hook (org-mode . org-modern-mode))

(use-package doom-themes
  :disabled
  :straight t
  :init
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)
  (set-theme 'doom-molokai))

(provide 'pg-theme)
