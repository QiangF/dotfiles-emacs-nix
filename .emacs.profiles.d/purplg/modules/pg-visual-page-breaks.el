;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package page-break-lines
  :straight t
  :init
  (add-hook 'emacs-lisp-mode-hook #'page-break-lines-mode)
  (pg/leader
    :states 'normal
    "i s" #'((lambda () (quoted-insert) :wk ""))))

(provide 'pg-visual-page-breaks)
