;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package nov
  :defer t
  :straight t
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(provide 'pg-epub)
