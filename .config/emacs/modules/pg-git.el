;;; --- -*- lexical-binding: t; -*-

(use-package magit
  :defer t
  :init
  (evil-define-key* 'normal 'global
    (kbd "<leader> g g") #'("status" . magit-status)
    (kbd "<leader> g b") #'("blame" . magit-blame)
    (kbd "<leader> g w") #'("worktree" . magit-worktree))

  :config
  (define-key nil magit-status-mode-map
    (kbd "SPC") nil))

(use-package magit-todos
  :init
  (magit-todos-mode))

(use-package git-gutter
  :disabled
  :hook (prog-mode . git-gutter-mode))

(use-package diff-hl
  :hook
  (prog-mode . diff-hl-mode)
  (prog-mode . diff-hl-flydiff-mode)
  (prog-mode . diff-hl-show-hunk-mouse-mode)
  (window-state-change . diff-hl-update))

(use-package blamer
  :init
  (evil-define-key* 'normal 'global
    (kbd "<leader> t b") #'("blame" . blamer-mode)))

(use-package magit-delta
  :if (executable-find "delta")
  :hook (magit-mode . magit-delta-mode))

(provide 'pg-git)
