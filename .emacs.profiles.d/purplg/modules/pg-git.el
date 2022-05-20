;;; --- -*- lexical-binding: t; -*-

(use-package magit
  :straight t
  :defer t
  :init
  (pg/leader
   "g" '(:wk "git")
   "g g" #'(magit-status :wk "status")
   "g b" #'(magit-blame :wk "blame")))

(use-package git-gutter
  :straight t
  :hook (prog-mode . git-gutter-mode))

(provide 'pg-git)
