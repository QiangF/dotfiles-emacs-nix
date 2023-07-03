;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package jinx
  :hook
  (org-mode . jinx-mode)
  (markdown-mode . jinx-mode))

(provide 'pg-spellcheck)
