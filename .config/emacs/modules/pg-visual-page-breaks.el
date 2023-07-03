;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)
(require 'pg-keybinds)

(use-package page-break-lines
  :init
  (dolist (hook '(emacs-lisp-mode-hook
                  help-mode-hook))
    (add-hook hook #'page-break-lines-mode))

  (evil-define-key 'normal 'global
    (kbd "<leader> i s") `(,(lambda () (interactive) (insert ?\f)) :wk "form feed")))


(provide 'pg-visual-page-breaks)
