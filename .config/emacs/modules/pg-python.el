;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)
(require 'pg-treesitter)

(with-eval-after-load 'corfu
  (add-hook 'python-mode-hook #'corfu-mode)
  (add-hook 'python-ts-mode-hook #'corfu-mode))

(with-eval-after-load 'tree-sitter
  (add-hook 'python-mode-hook #'tree-sitter-mode))

(with-eval-after-load 'eglot
  (add-hook 'python-mode-hook #'eglot-ensure)
  (add-hook 'python-ts-mode-hook #'eglot-ensure)
  (add-to-list 'eglot-server-programs '(python-ts-mode . ("jedi-language-server"))))

(with-eval-after-load 'lsp-mode
  (add-hook 'python-mode-hook #'lsp)
  (add-hook 'python-ts-mode-hook #'lsp))

(use-package pyvenv
 :straight t
 :after python
 :init
 (setenv "WORKON_HOME" "/home/purplg/code/python/.venv"))

(provide 'pg-python)
