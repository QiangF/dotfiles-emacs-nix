;;; --- -*- lexical-binding: t; -*-

(use-package yasnippet
  :straight t
  :after yasnippet-snippets
  :config
  (push (expand-file-name "snippets" pg/config-dir) yas-snippet-dirs)
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :straight t)

(provide 'pg-snippets)
