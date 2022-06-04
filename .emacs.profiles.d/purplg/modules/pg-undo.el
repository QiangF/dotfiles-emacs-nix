;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package undo-tree
  :straight t
  :init
  (add-hook 'evil-local-mode-hook #'turn-on-undo-tree-mode)
  (global-undo-tree-mode))

(provide 'pg-undo)
