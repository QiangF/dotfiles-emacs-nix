;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package undo-tree
  :init
  (dolist (hook '(text-mode-hook
                  prog-mode-hook
                  conf-mode-hook))
    (add-hook hook (lambda () (undo-tree-mode 1))))
  (let ((undo-dir (expand-file-name "undo" user-emacs-directory)))
    (unless (f-directory-p undo-dir) (make-directory undo-dir))
    (setq undo-tree-history-directory-alist `(("." . ,undo-dir)))))

(provide 'pg-undo)
