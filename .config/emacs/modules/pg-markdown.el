;;; --- -*- lexical-binding: t; -*-

(use-package markdown-mode
  :init
  (add-hook 'markdown-mode-hook
            (lambda ()
              (setq visual-fill-column-center-text t)
              (setq visual-fill-column-fringes-outside-margins nil)
              (visual-fill-column-mode t))))

(provide 'pg-markdown)
