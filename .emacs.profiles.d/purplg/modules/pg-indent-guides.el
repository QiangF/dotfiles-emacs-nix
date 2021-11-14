;;; --- -*- lexical-binding: t; -*-

(use-package highlight-indent-guides
  :config
  (setq highlight-indent-guides-method 'column
        highlight-indent-guides-responsive 'top)
  (hook! 'prog-mode-hookd #'highlight-indent-guides-mode))

(provide 'pg-indent-guides)
