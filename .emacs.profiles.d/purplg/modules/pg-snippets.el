;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package tempel
  :straight t
  :init
  (setq tempel-path (expand-file-name "templates" pg/config-dir))
  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))
  (add-hook 'fundamental-mode 'tempel-setup-capf)
  (general-define-key
    :states 'insert
    "M-<tab>" #'tempel-expand
    "M-S-<tab>" #'tempel-complete
    "C-j" #'tempel-next
    "C-k" #'tempel-previous))

(provide 'pg-snippets)
