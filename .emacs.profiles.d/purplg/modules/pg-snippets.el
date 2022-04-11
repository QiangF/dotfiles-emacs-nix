;;; --- -*- lexical-binding: t; -*-

(use-package yasnippet
  :straight t
  :defer t
  :init
  (add-hook 'org-mode-hook #'yas-minor-mode)
  :config
  (push (expand-file-name "snippets" pg/config-dir) yas-snippet-dirs))

(use-package yasnippet-snippets
  :straight t
  :after yasnippet)

(provide 'pg-snippets)
