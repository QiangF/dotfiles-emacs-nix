;;; --- -*- lexical-binding: t; -*-

(use-package vimrc-mode
  :straight t
  :init
  (add-to-list 'auto-mode-alist '("\\.vim\\(rc\\)?\\'" . vimrc-mode)))

(provide 'pg-vim)
