(require 'pg-straight)

(use-package page-break-lines
  :defer t
  :straight t
  :config
  (global-page-break-lines-mode))

(provide 'pg-visual-page-breaks)
