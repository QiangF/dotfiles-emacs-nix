;;; --- -*- lexical-binding: t; -*-

(require 'pg-straight)

(use-package outshine
  :straight t
  :config
  (add-hook 'emacs-lisp-mode-hook #'outshine-mode))

(provide 'pg-outshine)
