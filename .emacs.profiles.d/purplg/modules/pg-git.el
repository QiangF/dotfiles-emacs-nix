;;; --- -*- lexical-binding: t; -*-

(use-package magit
  :config
  (pg/leader
   "g" '(:wk "git")
   "g g" #'(magit-status :wk "status")))

(use-package git-gutter
  :config
  (hook! 'prog-mode-hook #'git-gutter-mode))

(provide 'pg-git)
