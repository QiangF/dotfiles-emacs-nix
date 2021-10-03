(require 'pg-straight)
(require 'pg-keybinds)

(use-package treemacs
  :demand t
  :straight t
  :init
  (pg/leader
    "o p" 'treemacs)

  :config
  (treemacs-resize-icons 16)
  (treemacs-set-width 30)
  :general
  (:states 'normal
   :keymaps 'treemacs-mode-map
   "C-j" #'treemacs-next-neighbour
   "C-k" #'treemacs-previous-neighbour
   "M-j" #'treemacs-move-project-down
   "M-k" #'treemacs-move-project-up))

(use-package treemacs-all-the-icons
  :straight t
  :after treemacs
  :config
  (treemacs-load-theme "all-the-icons"))

(use-package projectile
  :straight t
  :config
  (pg/leader
    "p f" #'(projectile-find-file :which-key "file")
    "p a" #'(projectile-add-known-project :which-key "add")
    "p d" #'(projectile-remove-known-project :which-key "remove")
    "p p" #'(projectile-switch-project :which-key "open"))
  (projectile-mode +1))

(provide 'pg-projects)
