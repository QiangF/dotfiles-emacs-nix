;;; --- -*- lexical-binding: t; -*-

(use-package magit
  :straight t
  :defer t
  :init
  (pg/leader
    "g" '(:wk "git")
    "g g" #'(magit-status :wk "status")
    "g b" #'(magit-blame :wk "blame")
    "g w" #'(magit-worktree :wk "worktree")))


(use-package git-gutter
  :disabled
  :straight t
  :hook (prog-mode . git-gutter-mode))

(use-package diff-hl
  :straight t
  :hook
  (prog-mode . diff-hl-mode)
  (prog-mode . diff-hl-flydiff-mode)
  (prog-mode . diff-hl-show-hunk-mouse-mode))

(provide 'pg-git)
