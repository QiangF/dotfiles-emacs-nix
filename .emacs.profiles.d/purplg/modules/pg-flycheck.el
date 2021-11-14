;;; --- -*- lexical-binding: t; -*-

(require 'pg-straight)
(require 'pg-lsp)

(use-package flycheck
  :straight t
  :config
  (hook! 'lsp-mode-hook #'flycheck-mode))

(provide 'pg-flycheck)
