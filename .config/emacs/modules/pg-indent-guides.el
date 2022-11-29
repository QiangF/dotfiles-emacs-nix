;;; --- -*- lexical-binding: t; -*-

(use-package highlight-indent-guides
  :straight t
  :hook (prog-mode . highlight-indent-guides-mode)
  :init
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-responsive t))

(provide 'pg-indent-guides)
