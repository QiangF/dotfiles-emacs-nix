;;; --- -*- lexical-binding: t; -*-
(require 'pg-lsp)

(use-package flycheck
  :config
  (hook! 'lsp-mode-hook #'flycheck-mode))

(provide 'pg-flycheck)
