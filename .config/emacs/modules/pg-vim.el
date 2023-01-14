;;; --- -*- lexical-binding: t; -*-

(use-package vimrc-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.vim\\(rc\\)?\\'" . vimrc-mode)))

(provide 'pg-vim)
