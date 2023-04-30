;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package undo-tree
  :init
  (setq undo-tree-auto-save-history nil)
  (with-eval-after-load 'evil
    (add-hook 'evil-local-mode-hook #'turn-on-undo-tree-mode)))

(provide 'pg-undo)
