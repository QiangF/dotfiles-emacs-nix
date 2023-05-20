;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package eglot
  :init
  (setq eglot-stay-out-of '(eldoc))
  (add-hook 'eglot-managed-mode-hook #'corfu-mode)
  :config
  (evil-define-key* 'normal eglot-mode-map
    (kbd "<leader> c a") #'("execute action" . eglot-code-actions)
    (kbd "<leader> c r") #'("rename" . eglot-rename)))

(provide 'pg-lsp)
