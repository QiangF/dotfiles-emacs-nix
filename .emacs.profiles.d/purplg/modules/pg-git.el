;;; --- -*- lexical-binding: t; -*-

(use-package magit
  :straight t
  :defer t
  :init
  (pg/leader
   "g" '(:wk "git")
   "g g" #'(magit-status :wk "status")))

(use-package git-gutter
  :straight t
  :hook (prog-mode . git-gutter-mode))

(provide 'pg-git)
