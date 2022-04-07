;;; --- -*- lexical-binding: t; -*-

(use-package yasnippet-snippets
  :straight t
  :after yasnippet)

(use-package yasnippet
  :straight t
  :hook prog-mode-hook
  :config
  (push (expand-file-name "snippets" pg/config-dir) yas-snippet-dirs)
  (yas-global-mode 1))

(provide 'pg-snippets)
