;;; --- -*- lexical-binding: t; -*-

(require 'pg-straight)

(use-package magit
  :straight t
  :config
  (pg/leader
   "g" '(:wk "git")
   "g g" #'(magit-status :wk "status")))

(use-package git-gutter
  :straight t
  :config
  (hook! 'prog-mode-hook #'git-gutter-mode))

(provide 'pg-git)
