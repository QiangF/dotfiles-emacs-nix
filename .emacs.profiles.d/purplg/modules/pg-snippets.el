;;; --- -*- lexical-binding: t; -*-

(use-package yasnippet
  :disabled
  :straight t
  :defer t
  :init
  (add-hook 'org-mode-hook #'yas-minor-mode)
  :config
  (push (expand-file-name "snippets" pg/config-dir) yas-snippet-dirs))

(use-package yasnippet-snippets
  :disabled
  :straight t
  :after yasnippet)

(use-package tempel
  :straight t
  :init
  (setq tempel-path (expand-file-name "templates" pg/config-dir)))

(provide 'pg-snippets)
