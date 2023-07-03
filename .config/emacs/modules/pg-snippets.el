;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)
(require 'pg-keybinds)

(use-package tempel
  :init
  (setq tempel-path (expand-file-name "templates" pg/config-dir))
  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))
  (add-hook 'fundamental-mode 'tempel-setup-capf)

  :config
  (evil-define-key* 'insert 'global
   (kbd "S-<return>") #'tempel-expand)
  (evil-define-key '(normal insert) tempel-map
   (kbd "<tab>") #'tempel-next)
  (add-hook 'org-mode-hook #'corfu-mode))

(use-package gitignore-templates
  :init
  (setq gitignore-templates-api 'github))

(provide 'pg-snippets)
