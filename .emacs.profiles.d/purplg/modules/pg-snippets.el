;;; --- -*- lexical-binding: t; -*-
(require 'pg-straight)

(use-package yasnippet-snippets
  :straight t)

(use-package yasnippet
  :after yasnippet-snippets
  :straight t
  :config
  (push (expand-file-name "snippets" pg/config-dir) yas-snippet-dirs)
  (yas-global-mode 1))

(provide 'pg-snippets)
