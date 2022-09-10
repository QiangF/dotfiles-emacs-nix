;;; --- -*- lexical-binding: t; -*-

(use-package auto-rename-tag
  :straight t
  :hook (html-mode . auto-rename-tag-mode))

(use-package typescript-mode
  :straight t)

(use-package svelte-mode
  :straight t)

(provide 'pg-web)
