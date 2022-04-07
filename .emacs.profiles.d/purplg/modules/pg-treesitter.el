;;; --- -*- lexical-binding: t; -*-

(use-package tree-sitter
  :if (string= "x86_64" (car (split-string system-configuration "-")))
  :straight t)

(use-package tree-sitter-langs
  :straight t
  :after tree-sitter
  :config
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(provide 'pg-treesitter)
