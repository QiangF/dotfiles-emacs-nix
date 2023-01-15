;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)
(require 'pg-treesitter)

(with-eval-after-load 'corfu
  (add-hook 'python-mode-hook #'corfu-mode)
  (add-hook 'python-ts-mode-hook #'corfu-mode))

(with-eval-after-load 'tree-sitter
  (add-hook 'python-mode-hook #'tree-sitter-mode))

(with-eval-after-load 'eglot
  (dolist (mode '(python-mode
                  python-ts-mode))
    (add-to-list 'eglot-server-programs `(,mode . ("jedi-language-server"))))

  (dolist (hook '(python-mode-hook
                  python-ts-mode-hook))
    (add-hook hook #'eglot-ensure)))

(with-eval-after-load 'lsp-mode
  (add-hook 'python-mode-hook #'lsp)
  (add-hook 'python-ts-mode-hook #'lsp))

(provide 'pg-python)
