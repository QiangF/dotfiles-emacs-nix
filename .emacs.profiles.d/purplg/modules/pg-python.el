;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)
(require 'pg-treesitter)

(use-package python :after corfu
  :hook (python-mode . corfu-mode))

(use-package python :after tree-sitter
  :hook (python-mode . tree-sitter-mode))

(use-package python :after eglot
  :hook (python-mode . eglot-ensure))

(use-package pyvenv
 :straight t
 :after python
 :init
 (setenv "WORKON_HOME" "/home/purplg/code/python/.venv"))

(provide 'pg-python)
