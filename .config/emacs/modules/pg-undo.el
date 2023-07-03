;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)
(require 'pg-keybinds)

(use-package undo-tree
  :disabled
  :init
  (setq undo-tree-auto-save-history nil)
  (setq evil-undo-system 'undo-tree)
  (with-eval-after-load 'evil
    (add-hook 'evil-local-mode-hook #'turn-on-undo-tree-mode)))

(use-package vundo
  :config
  (evil-define-key '(normal insert) 'global
    (kbd "C-x u") #'vundo))

(use-package undo-hl
  :elpaca (:host github :repo "casouri/undo-hl")
  :hook
  (text-mode . undo-hl-mode)
  (prog-mode . undo-hl-mode))

(provide 'pg-undo)
