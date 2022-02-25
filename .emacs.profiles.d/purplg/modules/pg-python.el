;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)
(require 'pg-treesitter)

(use-package python
  :config
  (use-package python :after corfu :config (add-hook 'python-mode-hook #'corfu-mode))
  (use-package python :after tree-sitter :config (add-hook 'python-mode-hook #'tree-sitter-mode)))

(use-package python :after eglot
  :config
  (add-to-list 'python-mode-hook 'eglot-ensure)
  (add-to-list 'eglot-server-programs
    `(python-mode . ("pyls" "-v" "--tcp" "--host" "localhost" "--port" :autoport))))

(provide 'pg-python)