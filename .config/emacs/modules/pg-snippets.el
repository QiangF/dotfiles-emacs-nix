;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package tempel
  :init
  (setq tempel-path (expand-file-name "templates" pg/config-dir))
  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))
  (add-hook 'fundamental-mode 'tempel-setup-capf)
  (general-define-key
   :keymap 'tempel-map
    :states 'insert
    "M-<tab>" #'tempel-expand)
  (add-hook 'org-mode-hook #'corfu-mode))

(provide 'pg-snippets)
