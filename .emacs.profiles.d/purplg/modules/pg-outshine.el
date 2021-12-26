;;; --- -*- lexical-binding: t; -*-

(use-package outshine
  :straight t
  :config
  (add-hook 'emacs-lisp-mode-hook #'outshine-mode))

(provide 'pg-outshine)
