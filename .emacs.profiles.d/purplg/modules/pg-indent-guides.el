;;; --- -*- lexical-binding: t; -*-

(use-package highlight-indent-guides
  :straight t
  :init
  (setq highlight-indent-guides-method 'column)
  (setq highlight-indent-guides-responsive 'top)
  (add-hook 'prog-mode-hookd #'highlight-indent-guides-mode))

(provide 'pg-indent-guides)
