;;; --- -*- lexical-binding: t; -*-

(use-package magit
  :straight t
  :init
  (pg/leader
   "g" '(:wk "git")
   "g g" #'(magit-status :wk "status")))

(use-package git-gutter
  :straight t
  :init
  (add-hook 'prog-mode-hook #'git-gutter-mode))

(provide 'pg-git)
