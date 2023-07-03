;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package auto-rename-tag
  :hook (html-mode . auto-rename-tag-mode))

(use-package typescript-mode)

(use-package svelte-mode)

(provide 'pg-web)
