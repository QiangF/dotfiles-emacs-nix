;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package eglot
  :init
  (setq eglot-stay-out-of '(eldoc))
  (add-hook 'eglot-managed-mode-hook #'corfu-mode)
  :config
  (evil-define-key* 'normal eglot-mode-map
    (kbd "<leader> c a") #'(eglot-code-actions :wk "execute action")
    (kbd "<leader> c r") #'(eglot-rename :wk "rename")))

(provide 'pg-lsp)
