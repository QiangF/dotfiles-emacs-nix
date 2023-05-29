;;; --- -*- lexical-binding: t; -*-

(use-package magit
  :defer t
  :init
  (evil-define-key* 'normal 'global
    (kbd "<leader> g g") #'("status" . magit-status)
    (kbd "<leader> g b") #'("blame" . magit-blame)
    (kbd "<leader> g w") #'("worktree" . magit-worktree))

  :config
  (evil-define-key nil magit-status-mode-map
    (kbd "SPC") nil)

  (evil-define-key nil magit-diff-mode-map
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

(use-package smerge-mode
  :elpaca nil
  :after evil
  :config
  (define-key smerge-mode-map (kbd "C-c C-c") #'smerge-keep-current)
  (evil-define-key 'normal 'smerge-mode-map
    (kbd "C-j") #'smerge-next
    (kbd "C-k") #'smerge-prev))

(provide 'pg-git)
