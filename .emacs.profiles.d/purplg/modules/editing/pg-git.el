(require 'pg-straight)

(use-package magit
  :straight t
  :config
  (pg/leader
    "g" '(:which-key "git")
    "g g" #'(magit-status :which-key "status")))

(use-package git-gutter
  :straight t
  :config
  (hook! 'prog-mode-hook #'git-gutter-mode))

(provide 'pg-git)
