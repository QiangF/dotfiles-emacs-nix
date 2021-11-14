;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package nov
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(provide 'pg-epub)
