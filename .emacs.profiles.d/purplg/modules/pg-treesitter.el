;;; --- -*- lexical-binding: t; -*-

(use-package tree-sitter)

(use-package tree-sitter-langs
  :after tree-sitter
  :config
  (hook! 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(provide 'pg-treesitter)
