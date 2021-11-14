(require 'pg-straight)

(use-package tree-sitter
  :straight t)

(use-package tree-sitter-langs
  :straight t
  :after tree-sitter
  :config
  (hook! 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(provide 'pg-treesitter)
