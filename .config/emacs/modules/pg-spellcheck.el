;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package jinx
  :hook
  (org-mode . jinx-mode)
  (markdown-mode . jinx-mode)
  :config
  (evil-define-key* 'normal jinx-mode-map
    (kbd "<leader> SPC") #'("spelling" . jinx-correct)))

(provide 'pg-spellcheck)
