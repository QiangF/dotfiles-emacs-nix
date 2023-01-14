;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package eglot
  :init
  (with-eval-after-load 'rustic-mode
    (add-hook 'eglot-managed-mode-hook (lambda () (eldoc-mode -1))))

  (pg/leader
    :keymaps 'eglot-mode-map
    "c a" #'(eglot-code-actions :wk "execute action")
    "c r" #'(eglot-rename :wk "rename")))

(provide 'pg-lsp)
