;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)
(require 'pg-keybinds)

(use-package nov
  :mode ("\\.epub\\'" . nov-mode))

(provide 'pg-epub)
