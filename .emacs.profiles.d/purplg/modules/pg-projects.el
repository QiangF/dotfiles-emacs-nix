;;; --- -*- lexical-binding: t; -*-
(require 'pg-keybinds)

(use-package treemacs
  :straight t
  :defer t
  :init
  (pg/leader
   "o p" #'treemacs)

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
  :defer t
  :config
  (treemacs-load-theme "all-the-icons"))

(use-package project
  :init
  (setq project-switch-commands 'project-find-file)
  :config
  (pg/leader
   "p f" #'(project-find-file :wk "file")
   "f p" #'(project-find-file :wk "file")
   "p d" #'(project-forget-project :wk "delete")
   "p p" #'(project-switch-project :wk "open")))

(use-package project
  :after dashboard
  :init
  (setq dashboard-projects-backend 'project-el))

(provide 'pg-projects)
