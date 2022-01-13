;;; --- -*- lexical-binding: t; -*-

(use-package page-break-lines
  :straight t
  :init
  (add-hook 'emacs-lisp-mode-hook #'page-break-lines-mode))

(provide 'pg-visual-page-breaks)
