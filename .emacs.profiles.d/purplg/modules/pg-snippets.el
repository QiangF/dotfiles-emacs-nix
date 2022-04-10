;;; --- -*- lexical-binding: t; -*-

(use-package yasnippet
  :straight t
  :hook prog-mode-hook org-mode-hook
  :config
  (push (expand-file-name "snippets" pg/config-dir) yas-snippet-dirs)
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :straight t
  :after yasnippet)

(provide 'pg-snippets)
