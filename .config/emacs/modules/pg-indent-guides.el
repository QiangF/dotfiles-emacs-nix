;;; --- -*- lexical-binding: t; -*-

(require 'pg-package)

(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :init
  (setq highlight-indent-guides-method 'column)
  (setq highlight-indent-guides-responsive 'top))

(provide 'pg-indent-guides)
