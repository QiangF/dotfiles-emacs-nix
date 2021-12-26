;;; --- -*- lexical-binding: t; -*-

(use-package magit
  :straight t
  :config
  (pg/leader
   "g" '(:wk "git")
   "g g" #'(magit-status :wk "status")))

(use-package git-gutter
  :straight t
  :hook prog-mode
  :config
  (hook! 'prog-mode-hook #'git-gutter-mode))

(provide 'pg-git)
