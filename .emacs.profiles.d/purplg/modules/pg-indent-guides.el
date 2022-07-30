;;; --- -*- lexical-binding: t; -*-

(use-package highlight-indent-guides
  :straight t
  :hook (prog-mode . highlight-indent-guides-mode)
  :init
  (setq highlight-indent-guides-method 'fill)
  (setq highlight-indent-guides-responsive nil))

(provide 'pg-indent-guides)
