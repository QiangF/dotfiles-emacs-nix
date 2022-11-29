;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package nov
  :mode ("\\.epub\\'" . nov-mode)
  :straight t)

(provide 'pg-epub)
