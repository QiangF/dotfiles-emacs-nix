(require 'pg-straight)

(use-package highlight-indent-guides
  :straight t
  :config
  (setq highlight-indent-guides-method 'column
        highlight-indent-guides-responsive 'top)
  (hook! 'prog-mode-hook #'highlight-indent-guides-mode))

(provide 'pg-indent-guides)
