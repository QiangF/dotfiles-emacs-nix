;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package eglot
  :init
  (setq eglot-stay-out-of '(eldoc))
  (pg/leader
    :keymaps 'eglot-mode-map
    "c a" #'(eglot-code-actions :wk "execute action")
    "c r" #'(eglot-rename :wk "rename"))
  (add-hook 'eglot-managed-mode-hook #'corfu-mode))

(provide 'pg-lsp)
