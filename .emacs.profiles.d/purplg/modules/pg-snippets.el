;;; --- -*- lexical-binding: t; -*-

(use-package yasnippet-snippets)

(use-package yasnippet
  :after yasnippet-snippets
  :config
  (push (expand-file-name "snippets" pg/config-dir) yas-snippet-dirs)
  (yas-global-mode 1))

(provide 'pg-snippets)
