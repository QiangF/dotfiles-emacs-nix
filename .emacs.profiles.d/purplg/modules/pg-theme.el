;;; --- -*- lexical-binding: t; -*-

(defvar current-theme nil)

(defun set-theme (theme-name)
  (setq current-theme theme-name)
  (load-theme current-theme t))

(use-package modus-themes
  :bind ("<f5>" . modus-themes-toggle)
  :straight t
  :init
  (setq modus-themes-italic-constructs t)
  (setq modus-themes-bold-constructs t)
  (setq modus-themes-region '(bg-only))
  (setq modus-themes-syntax '(green-strings))
  (setq modus-themes-paren-match '(bold intense))
  (setq modus-themes-mode-line '(borderless accented))
  (setq modus-themes-prompts '(intense bold))
  (setq modus-themes-org-blocks 'gray-background)
  (setq modus-themes-completions '((popup . (accented intense))))
  (set-theme 'modus-vivendi)
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
