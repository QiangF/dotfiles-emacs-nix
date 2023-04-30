;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package helpful
  :init
  (evil-define-key* 'normal 'global
    (kbd "<leader> h f") #'("function" . helpful-callable)
    (kbd "<leader> h v") #'("variable" . helpful-variable)
    (kbd "<leader> h m") #'("macro" . helpful-macro)
    (kbd "<leader> h V") #'("value" . apropos-value)
    (kbd "<leader> h .") #'("this" . helpful-at-point)
    (kbd "<leader> h k") #'("key" . helpful-key)))

(provide 'pg-help)
