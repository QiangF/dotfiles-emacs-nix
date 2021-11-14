;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)
(require 'pg-keybinds)

(use-package nov
  :straight t
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(provide 'pg-epub)
