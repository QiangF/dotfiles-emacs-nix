;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package undo-tree
  :init
  (add-hook 'text-mode-hook #'turn-on-undo-tree-mode)
  (add-hook 'prog-mode-hook #'turn-on-undo-tree-mode)
  (add-hook 'conf-mode-hook #'turn-on-undo-tree-mode)
  (let ((undo-dir (expand-file-name "undo" user-emacs-directory)))
    (unless (f-directory-p undo-dir) (make-directory undo-dir))
    (setq undo-tree-history-directory-alist `(("." . ,undo-dir)))))

(provide 'pg-undo)
