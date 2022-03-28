;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)
(require 'pg-treesitter)

(use-package python :after corfu
  :config
  (add-hook 'python-mode-hook #'corfu-mode))

(use-package python :after tree-sitter
  :config
  (add-hook 'python-mode-hook #'tree-sitter-mode))

(use-package python :after eglot
  :config
  (add-hook 'python-mode-hook 'eglot-ensure))

(use-package pyvenv
 :straight t
 :init
 (setenv "WORKON_HOME" "/home/purplg/code/python/.venv"))

(provide 'pg-python)
